@@strXML=''
@@color_count=0
@@flag=true
@@xml_hash=Hash.new
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: AdvertiserXmlBuilder	
	#Purpose: To generate the xml code. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 13-Oct-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class AdminXml
    begin
         # This hash is used to get the value of month in english
        @@getsymbol={"&"=>"%26","%"=>"%25"}
        #this method is used to construct xml structure for piechart
          def generate_piechartXML(*args)
              begin
                @color_hash=Hash.new
                @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"7FFFD4","9"=>"0377CA","10"=>"15C2F7"}
                if @@flag==true
                    @@strXML = "<chart decimals='2' defaultAnimation='0'  use3DLighting='0' showPlotBorder='1' showShadow='0' plotGradientColor='0' showLabels='1' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='0'   baseFontSize='12' isSliced='1' enableSmartLabels='1'  bgColor='FFFFFF' showBorder='0' plotBorderThickness='0'  startingAngle='80' canvasBorderColor ='cccccc' canvasBorderAlpha='0' canvasBorderThickness='0' showPercentageValues='1' pieRadious='100'>" 
                    @@flag=false
                  end
                colour=@color_hash["#{@@color_count}"]
                limit =  15
                args[0]=(args[0]=='' || args[0]==nil) ? 'could not detect' : args[0]
                @@strXML=@@strXML+ "<set label='#{args[0]!=nil ? (truncate(args[0].split("'")[0].to_s,limit)).gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end : 'NA' }' value='#{args[1].to_s}' color='#{(args[0].to_s=='Others') ? '000000' : colour.to_s}' />"
                @@color_count+=1
              rescue Exception=>e
                puts "DEBUGGER :: ERROR :: in AdminXmlBuilder Component under generate_piechartXML method. The Error is #{e.to_s}"
              end
          end
          def truncate(*args)
                    begin
                    i=args[0]
                    limit=args[1].to_i
                          if i.split("").size > limit
                              k=0
                              s=''
                              for j in i.split("")
                              if k.to_i<limit
                                  s=s+j
                              end
                              k+=1
                              end
                              return s=s+'..'
                          else
                              return i
                          end
                    rescue Exception=>e
                          puts "DEBUG :: ERROR :: AdminXMLBuilder Component > truncate . Exception is #{e.to_s}"
                          return i
                    end
              end
     rescue Exception=>e
        puts "ERROR :: in ReportGenerator Component and the error is :: #{e.to_s}"
    end
end   #class ends here
