=begin rdoc
*Revisions*
  | Initial File | Scott Shanks | 06/17/10 |

*Test_Script_Name*
  mon_gather_data_points

*Test_Case_Number*
  multiple

*Description*
  Gather all datapoints and write to a spreadsheet

*Variable_Definitions*

=end

$:.unshift File.dirname(__FILE__).chomp('driver')<<'lib' # add library to path
s = Time.now
require 'generic'
require 'V4cooling'

begin
  puts" \n Executing: #{(__FILE__)}\n\n" # print current filename
  g = Generic.new
  roe = ARGV[1].to_i
  excel = g.setup(__FILE__)
  wb,ws = excel[0][1,2]
  rows = excel[1][1]

  $ie.speed = :zippy
  ws = wb.Worksheets('Data')
  
  # Meat goes here...
  g.monitor.click

  g.count_frames
  g.expand_folderplus
  g.expand_folderplus  # For multiple levels
  g.populate_links_array
  g.links_array[1].each do |link_text|
    # Skipping the first link - it causes problems
    if link_text != 'Liebert DS' and link_text != ''
      puts "Trying link: #{link_text}"
      $ie.frame(:index, 2).link(:text, link_text).click
      sleep(2)
      g.table_to_ss(3,ws,link_text)
    end
  end

  f = Time.now  #finish time
rescue Exception => e
  f = Time.now  #finish time
  puts" \n\n **********\n\n #{$@ } \n\n #{e} \n\n ***"
  error_present=$@.to_s

ensure #this section is executed even if script goes in error
  if(error_present == nil)
    # If roe > 0, script is called from controller
    # If roe = 0, script is being ran independently
    g.tear_down_d(excel[0],s,f,roe)
    if roe == 0
      $ie.close
    end
  else
    puts" There were errors in the script"
    status = "script in error"
    wb.save
    wb.close
  end
end
