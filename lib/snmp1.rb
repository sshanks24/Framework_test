
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
          #if str.match(/\d{4}/) or str.match(/\w\.\d*/) #TODO - Cleanup certain values in the walk...
           # a << str.split('::')[1]
          #else
            a << str
          #end
        end
        a << value.split(':')[0].strip  #This should be the type (e.g STRING)
        end
      end
    return a
  end

end
