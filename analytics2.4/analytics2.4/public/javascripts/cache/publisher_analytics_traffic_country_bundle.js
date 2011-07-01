/* --------- /FusionMaps_Developer/JSClass/FusionMaps.js --------- */ 

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