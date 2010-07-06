=begin Rdoc
*revisions*
  | Initial File | Scott Shanks | 06/17/10 |

*Description*
  Contains module overrides specific to the V4 Cooling projects
  This file is no longer used and is scheduled to be removed.

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


end
