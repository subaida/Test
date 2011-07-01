/* --------- /javascripts/analytic-datepicker.js --------- */ 

var datePickerDivID="datepicker";var iFrameDivID="datepickeriframe";var calendarMonth=new Array('Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec');var dayArrayShort=new Array('Su','Mo','Tu','We','Th','Fr','Sa');var dayArrayMed=new Array('Sun','Mon','Tue','Wed','Thu','Fri','Sat');var dayArrayLong=new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');var monthArrayShort=new Array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');var monthArrayMed=new Array('Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec');var monthArrayLong=new Array('January','February','March','April','May','June','July','August','September','October','November','December');var defaultDateSeparator="/";var defaultDateFormat="mdy"
var dateSeparator=defaultDateSeparator;var dateFormat=defaultDateFormat;function displayDatePicker(dateFieldName,displayBelowThisObject,dtFormat,dtSep)
{var targetDateField=document.getElementsByName(dateFieldName).item(0);if(!displayBelowThisObject)
displayBelowThisObject=targetDateField;if(dtSep)
dateSeparator=dtSep;else
dateSeparator=defaultDateSeparator;if(dtFormat)
dateFormat=dtFormat;else
dateFormat=defaultDateFormat;var x=displayBelowThisObject.offsetLeft;var y=displayBelowThisObject.offsetTop+displayBelowThisObject.offsetHeight;var parent=displayBelowThisObject;while(parent.offsetParent){parent=parent.offsetParent;x+=parent.offsetLeft;y+=parent.offsetTop;}
drawDatePicker(targetDateField,x,y);}
function drawDatePicker(targetDateField,x,y)
{var dt=getFieldDate(targetDateField.value);if(!document.getElementById(datePickerDivID)){var newNode=document.createElement("div");newNode.setAttribute("id",datePickerDivID);newNode.setAttribute("class","dpDiv");newNode.setAttribute("style","visibility: hidden;");document.body.appendChild(newNode);}
var pickerDiv=document.getElementById(datePickerDivID);pickerDiv.style.position="absolute";pickerDiv.style.left=x+"px";pickerDiv.style.top=y+"px";pickerDiv.style.visibility=(pickerDiv.style.visibility=="visible"?"hidden":"visible");pickerDiv.style.display=(pickerDiv.style.display=="block"?"none":"block");pickerDiv.style.zIndex=10000;var hai=new Date();refreshDatePicker(targetDateField.name,hai.getFullYear(),hai.getMonth(),hai.getDate());}
function refreshDatePicker(dateFieldName,year,month,day)
{var thisDay=new Date();if((month>=0)&&(year>0)){thisDay=new Date(year,month,1);}else{day=thisDay.getDate();thisDay.setDate(1);}
var crlf="\r\n";var TABLE="<table cols=7 class='dpTable'>"+crlf;var xTABLE="</table>"+crlf;var TR="<tr class='dpTR'>";var TR_title="<tr class='dpTitleTR'>";var TR_days="<tr class='dpDayTR'>";var TR_todaybutton="<tr class='dpTodayButtonTR'>";var xTR="</tr>"+crlf;var TD="<td class='dpTD' onMouseOut='this.className=\"dpTD\";' onMouseOver=' this.className=\"dpTDHover\";' ";var TD_title="<td colspan=5 class='dpTitleTD'>";var TD_buttons="<td class='dpButtonTD'>";var TD_todaybutton="<td colspan=7 class='dpTodayButtonTD'>";var TD_days="<td class='dpDayTD'>";var TD_selected="<td class='dpDayHighlightTD' onMouseOut='this.className=\"dpDayHighlightTD\";' onMouseOver='this.className=\"dpTDHover\";' ";var xTD="</td>"+crlf;var DIV_title="<div class='dpTitleText'>";var DIV_selected="<div class='dpDayHighlight'>";var xDIV="</div>";var html=TABLE;html+=TR_title;html+=TD_buttons+getButtonCode(dateFieldName,thisDay,-1,"&lt;")+xTD;html+=TD_title+DIV_title+monthArrayLong[thisDay.getMonth()]+" "+thisDay.getFullYear()+xDIV+xTD;html+=TD_buttons+getButtonCode(dateFieldName,thisDay,1,"&gt;")+xTD;html+=xTR;html+=TR_days;for(i=0;i<dayArrayShort.length;i++)
html+=TD_days+dayArrayShort[i]+xTD;html+=xTR;html+=TR;for(i=0;i<thisDay.getDay();i++)
html+=TD+"&nbsp;"+xTD;do{dayNum=thisDay.getDate();TD_onclick=" onclick=\"updateDateField('"+dateFieldName+"', '"+getDateString(thisDay)+"', '"+thisDay.getDate()+"', '"+thisDay.getMonth()+"', '"+thisDay.getFullYear()+"', '"+thisDay+"');\">";if(dayNum==day)
html+=TD_selected+TD_onclick+DIV_selected+dayNum+xDIV+xTD;else
html+=TD+TD_onclick+dayNum+xTD;if(thisDay.getDay()==6)
html+=xTR+TR;thisDay.setDate(thisDay.getDate()+1);}while(thisDay.getDate()>1)
if(thisDay.getDay()>0){for(i=6;i>thisDay.getDay();i--)
html+=TD+"&nbsp;"+xTD;}
html+=xTR;var today=new Date();var todayString="Today is "+dayArrayMed[today.getDay()]+", "+monthArrayMed[today.getMonth()]+" "+today.getDate();html+=TR_todaybutton+TD_todaybutton;html+="<button class='dpTodayButton' onClick='refreshDatePicker(\""+dateFieldName+"\");'>this month</button> ";html+="<button class='dpTodayButton' onClick='updateDateField(\""+dateFieldName+"\");'>close</button>";html+=xTD+xTR;html+=xTABLE;document.getElementById(datePickerDivID).innerHTML=html;adjustiFrame();}
function getButtonCode(dateFieldName,dateVal,adjust,label)
{var newMonth=(dateVal.getMonth()+adjust)%12;var newYear=dateVal.getFullYear()+parseInt((dateVal.getMonth()+adjust)/12);if(newMonth<0){newMonth+=12;newYear+=-1;}
return"<button class='dpButton' onClick='refreshDatePicker(\""+dateFieldName+"\", "+newYear+", "+newMonth+");'>"+label+"</button>";}
function getDateString(dateVal)
{var dayString="00"+dateVal.getDate();var monthString=(calendarMonth[dateVal.getMonth()]);dayString=dayString.substring(dayString.length-2);switch(dateFormat){case"dmy":return dayString+dateSeparator+monthString+dateSeparator+dateVal.getFullYear();case"ymd":return dateVal.getFullYear()+dateSeparator+monthString+dateSeparator+dayString;case"mdy":default:return monthString+dateSeparator+dayString+dateSeparator+dateVal.getFullYear();}}
function getFieldDate(dateString)
{var dateVal;var dArray;var d,m,y;try{dArray=splitDateString(dateString);if(dArray){switch(dateFormat){case"dmy":d=parseInt(dArray[0],10);m=parseInt(dArray[1],10)-1;y=parseInt(dArray[2],10);break;case"ymd":d=parseInt(dArray[2],10);m=parseInt(dArray[1],10)-1;y=parseInt(dArray[0],10);break;case"mdy":default:d=parseInt(dArray[1],10);m=parseInt(dArray[0],10)-1;y=parseInt(dArray[2],10);break;}
dateVal=new Date(y,m,d);}else if(dateString){dateVal=new Date(dateString);}else{dateVal=new Date();}}catch(e){dateVal=new Date();}
return dateVal;}
function splitDateString(dateString)
{var dArray;if(dateString.indexOf("/")>=0)
dArray=dateString.split("/");else if(dateString.indexOf(".")>=0)
dArray=dateString.split(".");else if(dateString.indexOf("-")>=0)
dArray=dateString.split("-");else if(dateString.indexOf("\\")>=0)
dArray=dateString.split("\\");else
dArray=false;return dArray;}
function updateDateField(dateFieldName,dateString,st_day,st_month,st_year,thisDay)
{var targetDateField=document.getElementsByName(dateFieldName).item(0);var toDay=new Date()
toDay_date=parseInt(toDay.getDate());toDay_month=parseInt(toDay.getMonth()+1);toDay_year=parseInt(toDay.getFullYear());if(dateString)
{if(toDay_year<parseInt(st_year))
{alert("Date can either be today's or any date in past");}
else if((toDay_year==parseInt(st_year))&&toDay_month<(parseInt(st_month)+1))
{alert("Date can either be today's or any date in past.");}
else
{if(toDay_month==(parseInt(st_month)+1))
{if(toDay_date>=parseInt(st_day))
{if(dateFieldName=='start_on')
{var end_date=document.getElementById("end_on").value;prev_endDate=end_date.split("-");var enddateString=prev_endDate[1]+" "+prev_endDate[0]+", "+prev_endDate[2];var myDate=new Date(enddateString);var thisDay=new Date(thisDay);if(myDate>=thisDay)
{targetDateField.value=dateString;}
else
{alert("Start date should be earlier than End date. ");}}
else
{var start_date=document.getElementById("start_on").value;prev_startDate=start_date.split("-");var startdateString=prev_startDate[1]+" "+prev_startDate[0]+", "+prev_startDate[2];var myDate=new Date(startdateString);var thisDay=new Date(thisDay);if(myDate<=thisDay)
{targetDateField.value=dateString;}
else
{alert("End date should follow start date.");}}}
else
{alert("Date can either be today's or any date in past.");}}
else
{if(dateFieldName=='start_on')
{var end_date=document.getElementById("end_on").value;prev_endDate=end_date.split("-");var enddateString=prev_endDate[1]+" "+prev_endDate[0]+", "+prev_endDate[2];var myDate=new Date(enddateString);var thisDay=new Date(thisDay);if(myDate>=thisDay)
{targetDateField.value=dateString;}
else
{alert("Start date should be earlier than End date.");}}
else
{var start_date=document.getElementById("start_on").value;prev_startDate=start_date.split("-");var startdateString=prev_startDate[1]+" "+prev_startDate[0]+", "+prev_startDate[2];var myDate=new Date(startdateString);var thisDay=new Date(thisDay);if(myDate<=thisDay)
{targetDateField.value=dateString;}
else
{alert("End date should follow start date.");}}}}}
var pickerDiv=document.getElementById(datePickerDivID);if(pickerDiv!=null)
{pickerDiv.style.visibility="hidden";pickerDiv.style.display="none";adjustiFrame();}
targetDateField.focus();if((dateString)&&(typeof(datePickerClosed)=="function"))
datePickerClosed(targetDateField);}
function adjustiFrame(pickerDiv,iFrameDiv)
{var is_opera=(navigator.userAgent.toLowerCase().indexOf("opera")!=-1);if(is_opera)
return;try{if(!document.getElementById(iFrameDivID)){var newNode=document.createElement("iFrame");newNode.setAttribute("id",iFrameDivID);newNode.setAttribute("src","javascript:false;");newNode.setAttribute("scrolling","no");newNode.setAttribute("frameborder","0");document.body.appendChild(newNode);}
if(!pickerDiv)
pickerDiv=document.getElementById(datePickerDivID);if(!iFrameDiv)
iFrameDiv=document.getElementById(iFrameDivID);try{iFrameDiv.style.position="absolute";iFrameDiv.style.width=pickerDiv.offsetWidth;iFrameDiv.style.height=pickerDiv.offsetHeight;iFrameDiv.style.top=pickerDiv.style.top;iFrameDiv.style.left=pickerDiv.style.left;iFrameDiv.style.zIndex=pickerDiv.style.zIndex-1;iFrameDiv.style.visibility=pickerDiv.style.visibility;iFrameDiv.style.display=pickerDiv.style.display;}catch(e){}}catch(ee){}}/* --------- /FusionMaps_Developer/JSClass/FusionMaps.js --------- */ 

if(typeof infosoftglobal=="undefined")var infosoftglobal=new Object();if(typeof infosoftglobal.FusionMapsUtil=="undefined")infosoftglobal.FusionMapsUtil=new Object();infosoftglobal.FusionMaps=function(swf,id,w,h,debugMode,registerWithJS,c,scaleMode,lang,detectFlashVersion,autoInstallRedirect){if(!document.getElementById){return;}
this.initialDataSet=false;this.params=new Object();this.variables=new Object();this.attributes=new Array();if(swf){this.setAttribute('swf',swf);}
if(id){this.setAttribute('id',id);}
w=w.toString().replace(/\%/,"%25");if(w){this.setAttribute('width',w);}
h=h.toString().replace(/\%/,"%25");if(h){this.setAttribute('height',h);}
if(c){this.addParam('bgcolor',c);}
this.addParam('quality','high');this.addParam('allowScriptAccess','always');this.addVariable('mapWidth',w);this.addVariable('mapHeight',h);debugMode=debugMode?debugMode:0;this.addVariable('debugMode',debugMode);this.addVariable('DOMId',id);registerWithJS=registerWithJS?registerWithJS:0;this.addVariable('registerWithJS',registerWithJS);scaleMode=scaleMode?scaleMode:'noScale';this.addVariable('scaleMode',scaleMode);lang=lang?lang:'EN';this.addVariable('lang',lang);this.detectFlashVersion=detectFlashVersion?detectFlashVersion:1;this.autoInstallRedirect=autoInstallRedirect?autoInstallRedirect:1;this.installedVer=infosoftglobal.FusionMapsUtil.getPlayerVersion();if(!window.opera&&document.all&&this.installedVer.major>7){infosoftglobal.FusionMaps.doPrepUnload=true;}}
infosoftglobal.FusionMaps.prototype={setAttribute:function(name,value){this.attributes[name]=value;},getAttribute:function(name){return this.attributes[name];},addParam:function(name,value){this.params[name]=value;},getParams:function(){return this.params;},addVariable:function(name,value){this.variables[name]=value;},getVariable:function(name){return this.variables[name];},getVariables:function(){return this.variables;},getVariablePairs:function(){var variablePairs=new Array();var key;var variables=this.getVariables();for(key in variables){variablePairs.push(key+"="+variables[key]);}
return variablePairs;},getSWFHTML:function(){var swfNode="";if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){swfNode='<embed type="application/x-shockwave-flash" src="'+this.getAttribute('swf')+'" width="'+this.getAttribute('width')+'" height="'+this.getAttribute('height')+'"  ';swfNode+=' id="'+this.getAttribute('id')+'" name="'+this.getAttribute('id')+'" ';var params=this.getParams();for(var key in params){swfNode+=[key]+'="'+params[key]+'" ';}
var pairs=this.getVariablePairs().join("&");if(pairs.length>0){swfNode+='flashvars="'+pairs+'"';}
swfNode+='/>';}else{swfNode='<object id="'+this.getAttribute('id')+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="'+this.getAttribute('width')+'" height="'+this.getAttribute('height')+'">';swfNode+='<param name="movie" value="'+this.getAttribute('swf')+'" />';var params=this.getParams();for(var key in params){swfNode+='<param name="'+key+'" value="'+params[key]+'" />';}
var pairs=this.getVariablePairs().join("&");if(pairs.length>0){swfNode+='<param name="flashvars" value="'+pairs+'" />';}
swfNode+="</object>";}
return swfNode;},setDataURL:function(strDataURL){if(this.initialDataSet==false){this.addVariable('dataURL',strDataURL);this.initialDataSet=true;}else{var mapObj=infosoftglobal.FusionMapsUtil.getMapObject(this.getAttribute('id'));mapObj.setDataURL(strDataURL);}},setDataXML:function(strDataXML){if(this.initialDataSet==false){this.addVariable('dataXML',strDataXML);this.initialDataSet=true;}else{var mapObj=infosoftglobal.FusionMapsUtil.getMapObject(this.getAttribute('id'));mapObj.setDataXML(strDataXML);}},setTransparent:function(isTransparent){if(typeof isTransparent=="undefined"){isTransparent=true;}
if(isTransparent)
this.addParam('WMode','transparent');else
this.addParam('WMode','Opaque');},render:function(elementId){if((this.detectFlashVersion==1)&&(this.installedVer.major<8)){if(this.autoInstallRedirect==1){var installationConfirm=window.confirm("You need Adobe Flash Player 8 (or above) to view the maps. It is a free and lightweight installation from Adobe.com. Please click on Ok to install the same.");if(installationConfirm){window.location="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash";}else{return false;}}else{return false;}}else{var n=(typeof elementId=='string')?document.getElementById(elementId):elementId;n.innerHTML=this.getSWFHTML();if(!document.embeds[this.getAttribute('id')]&&!window[this.getAttribute('id')])
window[this.getAttribute('id')]=document.getElementById(this.getAttribute('id'));return true;}}}
infosoftglobal.FusionMapsUtil.getPlayerVersion=function(){var PlayerVersion=new infosoftglobal.PlayerVersion([0,0,0]);if(navigator.plugins&&navigator.mimeTypes.length){var x=navigator.plugins["Shockwave Flash"];if(x&&x.description){PlayerVersion=new infosoftglobal.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."));}}else if(navigator.userAgent&&navigator.userAgent.indexOf("Windows CE")>=0){var axo=1;var counter=3;while(axo){try{counter++;axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+counter);PlayerVersion=new infosoftglobal.PlayerVersion([counter,0,0]);}catch(e){axo=null;}}}else{try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");}catch(e){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");PlayerVersion=new infosoftglobal.PlayerVersion([6,0,21]);axo.AllowScriptAccess="always";}catch(e){if(PlayerVersion.major==6){return PlayerVersion;}}
try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");}catch(e){}}
if(axo!=null){PlayerVersion=new infosoftglobal.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));}}
return PlayerVersion;}
infosoftglobal.PlayerVersion=function(arrVersion){this.major=arrVersion[0]!=null?parseInt(arrVersion[0]):0;this.minor=arrVersion[1]!=null?parseInt(arrVersion[1]):0;this.rev=arrVersion[2]!=null?parseInt(arrVersion[2]):0;}
infosoftglobal.FusionMapsUtil.cleanupSWFs=function(){var objects=document.getElementsByTagName("OBJECT");for(var i=objects.length-1;i>=0;i--){objects[i].style.display='none';for(var x in objects[i]){if(typeof objects[i][x]=='function'){objects[i][x]=function(){};}}}}
if(infosoftglobal.FusionMaps.doPrepUnload){if(!infosoftglobal.unloadSet){infosoftglobal.FusionMapsUtil.prepUnload=function(){__flash_unloadHandler=function(){};__flash_savedUnloadHandler=function(){};window.attachEvent("onunload",infosoftglobal.FusionMapsUtil.cleanupSWFs);}
window.attachEvent("onbeforeunload",infosoftglobal.FusionMapsUtil.prepUnload);infosoftglobal.unloadSet=true;}}
if(!document.getElementById&&document.all){document.getElementById=function(id){return document.all[id];}}
if(Array.prototype.push==null){Array.prototype.push=function(item){this[this.length]=item;return this.length;}}
infosoftglobal.FusionMapsUtil.getMapObject=function(id)
{var mapRef=null;if(navigator.appName.indexOf("Microsoft Internet")==-1){if(document.embeds&&document.embeds[id])
mapRef=document.embeds[id];else
mapRef=window.document[id];}
else{mapRef=window[id];}
if(!mapRef)
mapRef=document.getElementById(id);return mapRef;}
var getMapFromId=infosoftglobal.FusionMapsUtil.getMapObject;var FusionMaps=infosoftglobal.FusionMaps;
