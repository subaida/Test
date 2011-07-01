/** --- Init.as ---
 * Copyright 2005 InfoSoft Global Private Ltd. and its licensors.  All Rights Reserved.
 * 
 * Use and/or redistribution of this file, in whole or in part, is subject
 * to the License Files, which was distributed with this component.
 * 
 * Map Initialization functions
 * This file contains functions and constant definitions only, and is not 
 * associated with a class/movie clip.
*/
//Get all the attributes specified to  as an array.
//This is done to get it in case-insensitive form.
var rootAttr:Array = getAttributesArray(_root);
/*
 * To include or load  XML data files that are not Unicode-encoded, 
 * we set system.useCodepage to true. The Flash Player will now interpret 
 * the XML file using the traditional code page of the operating system 
 * running the Flash Player. This is generally CP1252 for an English 
 * Windows operating system and Shift-JIS for a Japanese operating system.
*/
System.useCodepage = true;
/*
 * _isOnline represents whether the  is working in Local or online mode. 
 * If it's local mode, FusionCharts would cache the data, else it would apply 
 * methods to always received updated data from the defined source
*/
var _isOnline:Boolean = (this._url.subStr(0, 7) == "http://") || (this._url.subStr(0, 8) == "https://");
//Set the scale mode and align position
var _scaleMode:String = getFirstValue(rootAttr["scalemode"], "noScale");
//Loading mode of map
var _loadMode:String  = getFirstValue(rootAttr["mode"], "");
//For case insensitive check
_loadMode = _loadMode.toLowerCase();
//Set a flag based on _loadMode. 
var _loadModeExternal:Boolean = false;
if (_loadMode=="flex" || _loadMode=="laszlo"){
	_loadModeExternal = true;
}
//Check the loading mode and set scaling/alignment accordingly
if (!_loadModeExternal){
	//If we're not loading the SWF for Laszlo or Flex mode, set the scaling 
	//and alignment of movie. Otherwise, it'll change the same for parent
	//container, which is not our motive.
	//Set the scale mode of stage
	Stage.scaleMode = _scaleMode;
	//Set align to Top-left
	Stage.align = "TL";
}else{
	//If the mode is flex, we set some defaults.
	rootAttr["registerwithjs"] = 1;
}
//Get map width and height
var _mapWidth:Number = Stage.width;
var _mapHeight:Number = Stage.height;

//If maps width and chart height have registered as 0, we update to Flashvars value
if (_loadMode=="flex" || _loadMode=="laszlo" || _mapWidth==0 || _mapHeight==0){
	//Also, if we're loading for Flex/Laszlo, we just set the width/height provided.
	//But, if the width and height provided is in %, we get Stage's width/height
	_mapWidth = Number(rootAttr["mapwidth"]);
	_mapHeight = Number(rootAttr["mapheight"]);
}
//Get map horizontal and vertical center
var _mapXCenter:Number = _mapWidth/2;
var _mapYCenter:Number = _mapHeight/2;
/**
 * _lang sets the language in which we've to display application
 * message
*/
var _lang:String = getFirstValue(rootAttr["lang"], "EN");
//Convert to upper case
_lang = _lang.toUpperCase();
/**
 * _debugMode sets whether the map is operating in debug
 * mode or end-user mode. In debug mode, we show the debugger
 * to the developer.
*/
var _debugMode:Number = Number(getFirstValue(rootAttr["debugmode"], 0));
/**
 * _DOMId represents the DOM Id of the map. DOM id is the id of
 * the map in HTML container.
*/
var _DOMId:String = getFirstValue(rootAttr["domid"], rootAttr["flashid"], "");
/**
 * _registerWithJS indicates whether this movie will register with JavaScript
 * contained in the container HTML page. If yes, the movie will convey
 * events to JavaScript functions present in the page.
*/
var _registerWithJS:Boolean = (Number(getFirstValue(rootAttr["registerwithjs"], 0)) == 1) ? true : false;
/**
 * defaultDataFile represents the XML data file URI which would 
 * be loaded if no other URI or XML data has been provided to us.
*/
var _defaultDataFile:String = unescape(getFirstValue(rootAttr["defaultdatafile"], "Data.xml"));
/**
* _isSafeDataURL flag keeps a track of whether the user has provided a safe dataURL.
* If not, we do not add that to debug Mode.
*/
var _isSafeDataURL:Boolean = true;