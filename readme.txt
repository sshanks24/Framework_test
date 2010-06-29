28 June 2010

Incorporated Scott's work on driver script (mon_gather_data_points) into existing framework.

Most of the changes made:

== Generic.rb == 
class variable @row_ptr added to generic and defined an initialize method.
@row_ptr is used in writing to result spreadsheet.

== Navigate8.rb ==
Changed 'tab' abstraction.  Navigation images in the v4 cooling project are not in a frame.

== V4cooling.rb ==
Navigation methods specific to the V4 Cooling project.  This needs to be merged with Navigate??

== setup29.rb ==
Modified support method to left justify support table in result spreadsheet.

== mon_gather_data_points(.rb|.xls) ==
Driver for gathering http datapoints