
=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Module_Name*
  Snmp

*Description*
  Snmp methods - this is a wrapper for NetSNMP

*Variables*
  ip      = ip address
  com_str = community string
  mib     = management information base
  oid     = object id
  type    = value type
  val     = value
=end


#TODO snmp_set is broken
module  Snmp

  #get SNMP value through system command
  def snmp_get(ip,com_str,mib,oid)
    command = 'snmpget -v2c -c'<< com_str << ' ' << ip << ' ' << mib << '::' << oid
    puts "get command=#{command}"
    # Convert return oid to array and extract value from 4th element[3]
    snmp_data = `#{command}`.to_s.split(/ /)[3]
    return snmp_data
  end

  #set SNMP value through system command
  def snmp_set(ip,com_str,mib,oid,type,val)
  end

  #Performs an snmpwalk, parses each line of output and returns as an array in
  #the format: OID, Value, Type, OID, Value, Type,...
  def snmp_walk(ip=@test_site,com_str=@community_string,version='2c',oid='.1')
    command = "snmpwalk -v #{version} -c #{com_str} #{ip} #{oid}"
    snmp_data = `#{command}`.to_s
    
    a = Array.new
    snmp_data.each_line do |line|
      if line =~ /No more variables/ then next; end;
      a << line.split('=')[0].strip # This should be the oid
      line.split('=')[1].each do |value|
        value.split(': ')[1].strip.each do |str| #This should be the value + any relavent units
          case value.split(':')[0].strip #This case statement parses the units according to type.
          when /string/i then a << str << ""
          when /oid/i then a << str << ""
          #This mess below probably deserves an explanation...
          #We are parsing the value + unit string by ' ', add the first piece to
          #the array we will return, and re-combine the remainder of what we
          #parsed to add to the array as one string.
          #There is probably a cleaner way of doing this... but it works for now
          #e.g. 320 .1 degrees celsius
          # a << 320 << .1 + ' ' + 'degrees' + ' ' + celsius + ' '
          when /integer/i then a << str.split(' ')[0] << str.split(' ')[1..str.split(' ').length-1].collect {|x| x + " "}.to_s
          when /gauge32/i then a << str.split(' ')[0] << str.split(' ')[1..str.split(' ').length-1].collect {|x| x + " "}.to_s
          else a << str << ""
          end
        end
        a << value.split(':')[0].strip  #This should be the type (e.g STRING)
      end
      end
    return a
  end

end
