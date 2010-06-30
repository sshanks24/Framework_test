=begin rdoc
*Revisions*
  | Initial File | Scott Shanks | 06/17/10 |

*Test_Script_Name*
  get_http_pages

*Test_Case_Number*
  700.010.20.110

*Description*
  Given an ip address return all hyperlinks on the site.

*Variable_Definitions*

=end

$:.unshift File.dirname(__FILE__).sub('Tools','lib') #add lib to load path
require 'watir'
require 'stringio'
require 'navigate8'
require 'V4cooling'

include Nav

class String
  def HostName
	  matches = scan(/^(?:https?:\/\/)?([^\/]*)/)
	  if matches.length > 0 && matches[0].length > 0
		 return matches[0][0].downcase
	  else
		  return ""
	  end
  end
  def IsSubDomain( hostName)
	thisHostName = self.HostName
	if thisHostName.slice(0..3) == "www."
		thisHostName = thisHostName.slice(4..-1)
	end
	if thisHostName == hostName ||
	  (hostName.length > thisHostName.length &&
	   hostName.slice( -thisHostName.length ..-1) == thisHostName)
		return true
	end
	return false
  end
  def Protocol
	  matches = scan(/^(https?:\/\/)/)
	  if matches.length > 0 && matches[0].length > 0
		  return matches[0][0].downcase
	  else
		  return "http://"
	  end
  end
  def Path
	  if scan(/^(https?:\/\/)/).length > 0
		matches = scan(/^https?:\/\/[^\/]+\/([^#]+)$/)
	  else
		matches = scan(/^[^\/]+\/([^#]+)$/)
          end
	  if matches != nil && matches.length == 1 && matches[0].length == 1
		  return matches[0][0].downcase
	  else
		  return ""
	  end
  end
  def CanonicalUrl
	  return self.Protocol + self.HostName + "/" + self.Path
  end
end

class LMG_Http
  MAX_NO_PAGES = 20
  include Nav
  def initialize(ip_addr,browser='IE')
    @ip_addr = ip_addr
    case browser
    when 'IE' then @browser = Watir::IE.new;
    else puts "#{browser} is not a supported browser type"; #Raise exeption here  
    end

    self.go
    self.define_frames
    self.define_links
  end
  def click_nav_links
    @frames.each_value do |value|
      #puts value
      @browser.frame(value).links.each do |link|
        link_list = redirect {puts link}
        link_list.each_line do |x|
          if x =~ /^inner/
            @browser.frame(value).link(:text, x.split(':')[1].strip).click
          end
        end
      end
    end
  end #Doesn't quite work
  # Look at each link on the page and decide if it needs to be visited
  def visit_all_pages
    url = @ip_addr.CanonicalUrl
    urlsVisited = Array.new;  urlsToVisit = Array.new( 1, url )
    # Start accessing pages
    while urlsToVisit.length > 0 && urlsVisited.length < MAX_NO_PAGES

      nextUrl= urlsToVisit.pop
      puts "Loading " + nextUrl + "...";   $stdout.flush

      @browser.goto(nextUrl)			# get WATIR to load URL
      urlsVisited.push( nextUrl)	# store this URL in the list that has been visited

      begin
        # Look at each link on the page and decide if it needs to be visited
        @browser.links().each() do |link|

          linkUrl = link.href.CanonicalUrl
          # if the url has already been accessed or if it is a download or if it from a different domain
          if !url.IsSubDomain( linkUrl.HostName ) ||
              linkUrl.Path.include?( ".exe" ) || linkUrl.Path.include?(".zip") || linkUrl.Path.include?(".csv") ||
              linkUrl.Path.include?( ".pdf" ) || linkUrl.Path.include?( ".png" ) ||
              urlsToVisit.find{ |aUrl| aUrl == linkUrl}  != nil ||
              urlsVisited.find{ |aUrl| aUrl == linkUrl}  != nil
            # Don't add this URL to the list
            next
          end
          # Add this URL to the list
          urlsToVisit.push(linkUrl)
        end
      rescue
        puts "Failed to find links in " + nextUrl + " " + $!;  $stdout.flush
      end

    end
  end #TODO - Doesn't  work
  def close
    @browser.close
  end

  :private
  
  def go
    @browser.goto(@ip_addr)
  end
  def define_frames
    @frames = Hash.new
    frames = redirect {@browser.show_frames}
    frames.each_line do |x|
      if x =~ /^frame/
        @frames.store(x.split(/ /)[3],x.split(/ /)[5]).chomp!
      end
    end
    @frames.delete_if {|key, value| value == "" }
    puts @frames.inspect
  end
  def define_links
    @links = Hash.new
    @frames.each_value do |value|
      #puts value
      @browser.frame(value).links.each do |link|
        @browser.frame(value)
        link_list = redirect {puts link}
        link_list.each_line do |x|
          if x =~ /^id/
            @id = x.split(':')[1].strip
          end
          if x =~/^inner text/
            @inner_text = x.split(':')[1].strip
            @links.store(@id,@inner_text)
          end
        end
      end
    end
    #puts @links.inspect # Debug
  end
end

$browser = Watir::IE.attach(:url, "http://126.4.202.95/")

#$browser.frame(:index,3).tables.each do |table|
#  if table.row_count > 1
#    for i in 2..table.row_count
#      puts table[i][2].text + ' ' + table[i][3].text
#    end
#  end
#end

#$browser.show_frames
#$browser.frame(:name, frame_name).text_fields.each { |t| puts t.to_s }
#$browser.frame(:name, frame_name).spans.each { |s| puts s.to_s }
$browser.frame(:index, 2).images.each { |l| puts l.src }
#$browser.frame(:name, frame_name).select_lists.each { |s| puts s.to_s }
#$browser.frame(:name, frame_name).labels.each { |l| puts l.to_s }

#$browser.text_fields.each { |t| puts t.to_s }
#$browser.spans.each { |s| puts s.to_s }
#$browser.show_tables
#$browser.links.each { |l| puts l.to_s }
#$browser.select_lists.each { |s| puts s.to_s }
#$browser.labels.each { |l| puts l.to_s }





