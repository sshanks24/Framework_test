=begin Rdoc
*revisions*
  | Initial File | Scott Shanks | 06/17/10 |

*Description*
  Contains module overrides specific to the V4 Cooling projects

*Variable_Definitions*

=end

module Nav
  # - monitor tab link
  def monitor; $ie.image(:name, 'imgMonitor'); end
  # - control tab link
  def control; $ie.image(:id, 'imgControl'); end
  # - config tab link
  def config; $ie.image(:id, 'imgConfigure'); end
  # - event log tab link
  def evtlog; $ie.image(:id, 'imgEventLog'); end
  # - support tab link
  def supp; $ie.image(:id, 'imgSupport'); end

  # - Support table iterator
  def supprt;$ie.frame(:index, 3).table(:index, 2).to_a .compact;end

  #Liebert CrV
  def liebert_crv; $ie.frame(:index,2).link(:id, 'reporthome'); end
  #Active Events
  def active_events; $ie.frame(:index,2).span(:id, 'reportActiveEvents'); end
  #Air Temperature
  def air_temperature; $ie.frame(:index,2).link(:id, 'report163840'); end
  #Humidity
  def humidity; $ie.frame(:index,2).link(:id, 'report163860'); end
  #Fans
  def fans; $ie.frame(:index,2).link(:id, 'report163900'); end
  #remote Sensors+
  def remote_sensors_plus; $ie.frame(:index,2).image(:id, '1639100Plus'); end
  #remote Sensors 1
  def remote_sensors_1; $ie.frame(:index,2).link(:text, 'Remote Sensors [1]'); end
  #remote Sensors 2
  def remote_sensors_2; $ie.frame(:index,2).link(:id, 'report163911'); end
  #remote Sensors 3
  def remote_sensors_3; $ie.frame(:index,2).link(:id, 'report163912'); end
  #remote Sensors 4
  def remote_sensors_4; $ie.frame(:index,2).link(:id, 'report163913'); end
  #remote Sensors 5
  def remote_sensors_5; $ie.frame(:index,2).link(:id, 'report163914'); end
  #remote Sensors 6
  def remote_sensors_6; $ie.frame(:index,2).link(:id, 'report163915'); end
  #remote Sensors 7
  def remote_sensors_7; $ie.frame(:index,2).link(:id, 'report163916'); end
  #remote Sensors 8
  def remote_sensors_8; $ie.frame(:index,2).link(:id, 'report163917'); end
  #remote Sensors 9
  def remote_sensors_9; $ie.frame(:index,2).link(:id, 'report163918'); end
  #remote Sensors 10
  def remote_sensors_10; $ie.frame(:index,2).link(:id, 'report163919'); end
  #Compressor
  def compressor; $ie.frame(:index,2).link(:id, 'report163880'); end
  #reheater
  def reheater; $ie.frame(:index,2).link(:id, 'report163920'); end
  #Condenser
  def condenser; $ie.frame(:index,2).link(:id, 'report163930'); end
  #Chilled Water
  def chilled_water; $ie.frame(:index,2).link(:id, 'report163950'); end
  #System Info
  def system_info; $ie.frame(:index,2).link(:id, 'report163940'); end
  #System Operations
  def system_operations; $ie.frame(:index,2).link(:id, 'report163980'); end
  #Event Configuration
  def event_configuration; $ie.frame(:index,2).link(:id, 'report163990'); end
  #System Events
  def system_events; $ie.frame(:index,2).link(:id, 'report164000'); end
  #Asset Management
  def asset_management; $ie.frame(:index,2).link(:id, 'report163960'); end
  #Time
  def time; $ie.frame(:index,2).link(:id, 'report164010'); end

end
