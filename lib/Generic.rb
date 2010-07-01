=begin rdoc
*Revisions*
  | Change                                               | Name        | Date  |

*Class_Name*
  Generic

*Description*
  This class (Generic) inherits from Generic_parent which is contained in Generic(xx).rb 
	When Generic(xx) changes only the require statement in this file needs to be updated

  Lmg_test\ruby\dd.mm.yyyy  [Core Framework]
    |
    |__lib 
    |__controller
    |__driver
    |__result


=end


$:.unshift File.dirname(__FILE__) unless
$:.include? File.dirname(__FILE__)

require 'Generic48' # Put the latest version of Generic(xx).rb here

class Generic < Generic_parent
  attr_accessor :links_array
  attr_reader :num_frames, :row_ptr

  def initialize
     @num_frames = 0
     @row_ptr = 2 #Start righting at row 2
     @links_array = Array.new
  end
 
end


