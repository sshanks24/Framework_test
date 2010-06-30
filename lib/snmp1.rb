
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
    command = 'snmpset -v2c -c'<< com_str << ' ' << ip << ' ' << mib << '::' << oid <<' '<<type <<' '<< val
    puts "set command = #{command}"
  end

end
