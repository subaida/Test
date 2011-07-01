#~ @strXML=''
#~ @@color_count=0
#~ @@flag=true
#~ @@xml_hash=Hash.new
@@objMem=AnalyticsAdminEngine.new()
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
        #~ @@getsymbol={"&"=>"%26","%"=>"%25"}
        #this method is used to construct xml structure for piechart
          def self.generateCampaignPerformancePiechartXML(*args)
             begin
                @getsymbol={"&"=>"%26","%"=>"%25"}
                @recordset=args[0]
                @column2=args[1]
                @limit=args[2]
                @column3=args[3]
               @flag=true
               #~ @camp_names =Array.new
               @@objMem.set_campaign_detail
              @camp_name=@@objMem.campaign_names()
                 #~ @column4=recordset['campaign_id']
               count=0
              othersValue=0.00
              if @recordset.size !=0  #main If conditons starts here
                  for recordset in @recordset 
                  @column4=@camp_name[recordset['campaign_id']]
                   #Check whether publisher request click or impression or revenuereport
                       i=1
                      if args[3]!='imp vs clicks'
                         count+=1
                          if (count.to_i<=@limit.to_i)
                              begin
                                        args[0] = @column4
                                        args[1] = recordset[@column2=='amount_spent' ? 'amt_spent' : @column2]
                                       args[3] = @column2
                                        @color_hash=Hash.new
                                        @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"7FFFD4","9"=>"0377CA","10"=>"15C2F7"}
                                        if @flag==true
                                            @strXML = "<chart decimals='2' defaultAnimation='0'  use3DLighting='0' showPlotBorder='1' showShadow='0' plotGradientColor='0' showLabels='1' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='0'   baseFontSize='12' isSliced='1' enableSmartLabels='1'  bgColor='FFFFFF' showBorder='0' plotBorderThickness='0'  startingAngle='80' canvasBorderColor ='cccccc' canvasBorderAlpha='0' canvasBorderThickness='0' showPercentageValues='1' pieRadious='100'>" 
                                            @strXML = "<chart decimals='2' yAxisName='#{args[3].to_s=='ecpm' ? 'eCPM' : (args[3].to_s).upcase}'  divLineColor='CCCCCC' numDivLines='2' alternateHGridColor='FFFFFF' anchorBorderColor='FFFFFF' defaultAnimation='0' use3DLighting='0' alternateVGridColor='FFFFFF' showPlotBorder='0' showShadow='0' plotGradientColor='' showLabels='1' chartTopMargin='10' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='10' showValues='0' canvasBorderColor ='FFFFFF' formatNumberScale='0' canvasBorderAlpha='0' canvasBorderThickness='0' pieRadious='100'  baseFontSize='12' showBorder='0' plotBorderThickness='0'   bgColor='FFFFFF'  showPercentageValues='1' > " if args[3]=='ctr' 
                                            @flag=false
                                          end
                                        colour=@color_hash["#{@@color_count}"]
                                         limit = (args[3]=='ctr' || args[3]=='ecpm') ? 10 : 15
                                        args[0]=(args[0]=='' || args[0]==nil) ? 'could not detect' : args[0]
                                        @strXML=@strXML+ "<set label='#{args[0]!=nil ? (AdminXml.truncate(args[0].split("'")[0].to_s,limit)).gsub(/([&%])/) do|s| @getsymbol["#{s}"] end : 'NA' }' value='#{args[1].to_s}' color='#{(args[0].to_s=='Others') ? '000000' : colour.to_s}' />" if args[3]!='ctr' 
                                        @strXML+="<set label='#{args[0].to_s.gsub(/([&%])/) do|s| @getsymbol["#{s}"] end}' value='#{args[1].to_s}'  color='176D94'/>" if args[3]=='ctr' || args[3]=='ecpm'
                                        @@color_count+=1
                                  rescue Exception=>e
                                    puts "DEBUGGER :: ERROR :: in AdminXmlBuilder Component under generate_piechartXML method. The Error is #{e.to_s}"
                                  end
                              
                          else
                              othersValue+=recordset[@column2=='amount_spent' ? 'amt_spent' : @column2].to_f
                              if (@recordset.size.to_i==count.to_i)
                              begin
                                    args[0]='Others'
                                    args[1]=othersValue
                                     args[3] =  @column2
                                    @color_hash=Hash.new
                                    @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"7FFFD4","9"=>"0377CA","10"=>"15C2F7"}
                                    if @flag==true
                                        @strXML = "<chart decimals='2' defaultAnimation='0'  use3DLighting='0' showPlotBorder='1' showShadow='0' plotGradientColor='0' showLabels='1' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='0'   baseFontSize='12' isSliced='1' enableSmartLabels='1'  bgColor='FFFFFF' showBorder='0' plotBorderThickness='0'  startingAngle='80' canvasBorderColor ='cccccc' canvasBorderAlpha='0' canvasBorderThickness='0' showPercentageValues='1' pieRadious='100'>" 
                                        @strXML = "<chart decimals='2' yAxisName='#{args[3].to_s=='ecpm' ? 'eCPM' : (args[3].to_s).upcase}'  divLineColor='CCCCCC' numDivLines='2' alternateHGridColor='FFFFFF' anchorBorderColor='FFFFFF' defaultAnimation='0' use3DLighting='0' alternateVGridColor='FFFFFF' showPlotBorder='0' showShadow='0' plotGradientColor='' showLabels='1' chartTopMargin='10' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='10' showValues='0' canvasBorderColor ='FFFFFF' formatNumberScale='0' canvasBorderAlpha='0' canvasBorderThickness='0' pieRadious='100'  baseFontSize='12' showBorder='0' plotBorderThickness='0'   bgColor='FFFFFF'  showPercentageValues='1' > " if args[3]=='ctr' 
                                       @flag=false
                                      end
                                    colour=@color_hash["#{@@color_count}"]
                                     limit = (args[3]=='ctr' || args[3]=='ecpm') ? 10 : 15
                                    args[0]=(args[0]=='' || args[0]==nil) ? 'could not detect' : args[0]
                                    @strXML=@strXML+ "<set label='#{args[0]!=nil ? (AdminXml.truncate(args[0].split("'")[0].to_s,limit)).gsub(/([&%])/) do|s| @getsymbol["#{s}"] end : 'NA' }' value='#{args[1].to_s}' color='#{(args[0].to_s=='Others') ? '000000' : colour.to_s}' />" if args[3]!='ctr' 
                                    @strXML+="<set label='#{args[0].to_s.gsub(/([&%])/) do|s| @getsymbol["#{s}"] end}' value='#{args[1].to_s}'  color='176D94'/>" if args[3]=='ctr' || args[3]=='ecpm'
                                    @@color_count+=1
                              rescue Exception=>e
                                puts "DEBUGGER :: ERROR :: in AdminXmlBuilder Component under generate_piechartXML method. The Error is #{e.to_s}"
                              end
                              #~ @@objXmlBuilder.generate_piechartXML('Others',othersValue)
                              end
                            end
                            i+=1
                     end
                  end #for loop ends here
                  @strXML = @strXML + "</chart>" 
                  end #main If ends here
                  #reinitialize flag, str variable and counters to construct next chart
                  @flag=true   
                  @@color_count=0 
                  @returnstrXML=@strXML
                  @strXML=''  
                  @xml_hash=nil
                  @xml_hash={:xml_string=>@returnstrXML }
                  return @xml_hash
                rescue Exception=>e
                   puts "DEBUGGER :: ERROR :: in admin_xml_builder under generate_query method. The error is #{e.to_s}"
                end
              end
              
          def self.truncate(*args)
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
