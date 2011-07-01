/**
* @class Map
* @author InfoSoft Global (P) Ltd. www.InfoSoftGlobal.com
* @version 3.0
*
* Copyright (C) InfoSoft Global Pvt. Ltd.
*
* Map class is the super class for any FusionMaps map. The map class is
* responsible for a lot of features inherited by individual maps.
*/
//Utilities
import com.fusionmaps.helper.Utils;
//Log class
import com.fusionmaps.helper.Logger;
//Enumeration class
import com.fusionmaps.helper.FCEnum;
//Extensions
import com.fusionmaps.extensions.StringExt;
import com.fusionmaps.extensions.MathExt;
import com.fusionmaps.extensions.ColorExt;
import com.fusionmaps.extensions.DrawingExt;
//Custom Error Object
import com.fusionmaps.helper.FCError;
//Tool Tip
import com.fusionmaps.helper.ToolTip;
//Style Managers
import com.fusionmaps.core.StyleObject;
import com.fusionmaps.core.StyleManager;
//Depth Manager
import com.fusionmaps.helper.DepthManager;
//Legend Class
import com.fusionmaps.helper.Legend;
//Delegate Class
import mx.utils.Delegate;
//Marker Shape
import com.fusionmaps.helper.MarkerShape;
//Class to help as saving as image
import com.fusionmaps.helper.BitmapSave;
//Progress bar
import com.fusionmaps.helper.FCProgressBar;
//External Interface
import flash.external.ExternalInterface;
//Event Dispatcher
import mx.events.EventDispatcher;
//Also expose the map to FlashInterface for Flex/Laszlo Mode.
import com.fusionmaps.helper.FlashInterface;
class com.fusionmaps.core.Map
{
	//Instance properties
	//Version of the map.
	private var _version : String = "3.0.6";
	//Pointer to own instance
	var mapRef : Map;
	//XML data storage object for the map.
	private var xmlData : XML;
	//entity array stores all the entities for the given map
	private var entity : Array;
	//colorRange array stores all the color range defined for the map
	private var colorRange : Array;
	//Number of total map entities.
	private var tNum : Number;
	//Number of entity data provided in XML
	private var num : Number;
	//Number of color range defined
	private var numCR : Number;
	//arrObjects array would store the list of map
	//objects as string. The motive is to retrieve this
	//string information to be added to log.
	public var arrObjects : Array;
	//Array to store marker definitions (those defined by users in XML)
	private var markerDef:Array;
	private var numMarkerDefs:Number;
	//Array to store marker shapes defined by the user
	private var markerShape:Array;
	//Array to store marker Data
	private var markerData:Array;
	private var numMarkerData:Number;
	//Connectors between markers
	private var markerConnectors:Array;
	private var numMarkerConnectors:Number;
	//Object Enumeration stores the above array elements
	//(map objects) as enumeration, so that we can refer
	//to each map element as a numeric value.
	public var objects : FCEnum;
	//Object to store map parameters
	//All attributes retrieved from XML will be stored in
	//params object.
	private var params : Object;
	//Object to store map configuration
	//Any calculation done by our code will be stored in
	//config object. Or, if we over-ride any param values
	//we store in config.
	private var config : Object;
	//DepthManager instance. The DepthManager class helps us
	//allot and retrieve depths of various objects in the map.
	private var dm : DepthManager;
	//Movie clip in which the entire map will be built.
	//If map is not being loaded into another Flash movie,
	//parentMC is set as _root (as we need only 1 map per
	//movie timeline).
	private var parentMC : MovieClip;
	//Movie clip reference for actual map MC
	//All map objects (movie clips) would be rendered as
	//sub-movie clips of this movie clip.
	private var mapMC : MovieClip;
	//Movie clip reference for log MC. The logger elements
	//are contained as a part of this movie clip. Even if the
	//movie is not in debug mode, we create at least the
	//parent log movie clip.
	private var logMC : MovieClip;
	//Movie clip reference for tool tip. We created a separate
	//tool tip movie clip because of two reasons. One, tool tip
	//always appears above the map. So, we've created tool tip
	//movie clip at a depth greater than that of mapMC(map movie
	//clip). Secondly, the tool tip is not an integral part of
	//map - it's a helper class.
	private var ttMC : MovieClip;
	//Movie clip which holds the actual map.
	private var actualMapMC : MovieClip;
	//Tool Tip Object. This object is common to all maps.
	//Whenever we need to show/hide tool tips, we called methods
	//of this class.
	private var tTip : ToolTip;
	//Reference to logger class instance.
	private var lgr;
	//Depth in parent movie clip in which we've to create map
	//This is useful when you are loading this map class as a part
	//of your Flash movie, as then you can create various maps at
	//various depths of a single movie clip. In case of single map
	//(non-load), this is set to 3 (as 1 and 2 are reserved for global
	//progress bar and global application text).
	private var depth : Number;
	//Width & Height of movie in pixels. If the movie is in exactFit
	//mode, the width and height remains the same as that of original
	//document (.fla). However, everything is scaled in proportion.
	//In case of noScale, these variables assume the width and height
	//provided either by map constructor (when loading map in your
	//flash movie) or HTML page.
	private var width : Number, height : Number;
	//X and Y Position of top left of map. When loading the map in
	//your flash movie, you might want to shift the map to particular
	//position. These x and y denote that shift.
	private var x : Number, y : Number;
	//Debug mode - Flag whether the map is in debug mode. It's passed
	//from the HTML page as OBJECT/EMBED variable debugMode=1/0.
	private var debugMode : Boolean;
	//Copy of debug mode (original value passed)
	private var debugModeO : Boolean;
	//Language for application messages. By default, we show application
	//messages in English. However, if you need to define your application
	//messages, you can do so in com\fusionmaps\includes\AppMessages.as
	//This value is passed from HTML page as OBJECT/EMBED variable.
	private var lang : String;
	//Scale mode - noScale or exactFit.
	//This value is passed from HTML page as OBJECT/EMBED variable.
	private var scaleMode : String;
	//Is Online Mode. If the map is working online, we avoid caching
	//of data. Else, we cache data.
	private var isOnline : Boolean;
	//Style Manager object. The style manager object handles the style
	//quotient (FONT, BLUR, BEVEL, GLOW, SHADOW, ANIMATION) of different
	//elements of map.
	private var styleM : StyleManager;
	//Counter to store timeElapsed. The map animates sequentially.
	//e.g., the background comes first, then canvas, then div lines.
	//So, we internally need to keep a track of time passed, so that
	//we can call next what to render.
	private var timeElapsed : Number = 0;
	//Store a short name reference for Utils.getFirstValue function
	//and Utils.getFirstNumber function
	//As we'll be using this function a lot.
	private var getFV : Function;
	private var getFN : Function;
	//Short name for ColorExt.formatHexColor function
	private var formatColor : Function;
	//Short name for Utils.createText function
	private var createText : Function;
	//Whether to register chart with JS
	private var registerWithJS:Boolean;
	//DOM Id
	private var DOMId:String;
	//Flag to indicate whether we've conveyed the chart rendering event
	//to JavaScript and loader Flash
	private var renderEventConveyed:Boolean = false;
	//Error handler. We've a custom error object to represent
	//any map error. All such errors get logged and none are visible
	//to end user, to make their experience smooth.
	var e : FCError;
	//Text field to hold application messages.
	private var tfAppMsg : TextField;
	//Variable to store the maximum number of decimal places in any given
	//data
	private var maxDecimals : Number = 0;
	//Reference to legend component of map
	private var lgnd : Legend;
	//Reference to legend movie clip
	private var lgndMC : MovieClip;
	//Global level flag to store whether the map will be animated.
	//This is required for switching off animation when mao is resized
	//from JS. So, even if the XML contains animation, the map wouldn't
	//animate.
	private var animationFlag : Boolean = true;
	/**
	* Constructor method for map. Here, we store the
	* properties of the map from constructor parameters
	* in instance variables.
	* @param	targetMC	Parent movie clip reference in which
	*						we'll create map movie clips
	* @param	depth		Depth inside parent movie clip in which
	*						we'll create map movie clips
	* @param	width		Width of map
	* @param	height		Height of map
	* @param	x			x Position of Map
	* @param	y			y Position of Map
	* @param	debugMode	Boolean value indicating whether the map
	*						is in debug mode.
	* @param	lang		2 Letter ISO code for the language of application
	*						messages
	* @param	scaleMode	Scale mode of the movie - noScale or exactFit
	*/
	function Map (targetMC : MovieClip, depth : Number, width : Number, height : Number, x : Number, y : Number, debugMode : Boolean, lang : String, scaleMode : String, registerWithJS : Boolean, DOMId : String)
	{
		//Loop variables
		var i : Number;
		//Point to self
		mapRef = this;		
		// ------------- Short references to functions --------------------//
		//Get the reference to Utils.getFirstValue
		this.getFV = Utils.getFirstValue;
		//Get the reference to getFirstNumber
		this.getFN = Utils.getFirstNumber;
		//Get reference to ColorExt.formatHexColor
		this.formatColor = ColorExt.formatHexColor;
		//Get reference to Utils.createText
		this.createText = Utils.createText;
		// --------------- Store properties in instance variables ------------------//
		this.parentMC = targetMC;
		this.depth = depth;
		this.width = width;
		this.height = height;
		this.x = getFN (x, 0);
		this.y = getFN (y, 0);
		this.debugMode = getFV (debugMode, false);		
		this.lang = getFV (lang, "EN");
		this.scaleMode = getFV (scaleMode, "noScale");
		this.registerWithJS = getFV(registerWithJS, false);
		this.DOMId = getFV(DOMId, "");		
		//Copy of original debug mode passed to map
		this.debugModeO = this.debugMode;
		// ----------------------- Add Map Objects -----------------------------------//
		//Create array of map objects
		this.arrObjects = new Array ("BACKGROUND", "PLOT", "LABELS", "LEGEND", "TOOLTIP", "MARKERS", "MARKERLABELS", "MARKERCONNECTORS");
		//Store the list of map objects in enumeration
		this.objects = new FCEnum (this.arrObjects);
		// ------------------------ Initialize Containers -----------------------------
		//Initialize parameter storage object
		this.params = new Object ();
		//Initialize map configuration storage object
		this.config = new Object ();
		//Object to store map rendering intervals
		this.config.intervals = new Object ();
		//Initialize style manager
		this.styleM = new StyleManager (this);
		//Initialize Depth Manager
		this.dm = new DepthManager (0);
		//Initialize entity array
		this.entity = new Array ();
		//Color Range Array
		this.colorRange = new Array ();
		//Set counters to 0
		this.tNum = 0;
		this.num = 0;
		this.numCR = 0;
		//Marker related containers
		this.markerDef = new Array();
		this.markerShape = new Array();
		this.markerData = new Array();
		this.markerConnectors = new Array();
		this.numMarkerConnectors = 0;
		this.numMarkerDefs = 0;
		this.numMarkerData = 0;
		// ------------------ CREATE REQUIRED MOVIE CLIPS NOW --------------//
		//Create the map movie clip container
		this.mapMC = parentMC.createEmptyMovieClip ("Map", depth + 1);
		//Re-position the map Movie clip to required x and y position
		this.mapMC._x = this.x;
		this.mapMC._y = this.y;
		//Create movie clip for tool tip
		this.ttMC = parentMC.createEmptyMovieClip ("ToolTip", depth + 3);
		//Initialize tool tip by setting co-ordinates and span area
		this.tTip = new ToolTip (this.ttMC, this.x, this.y, this.width, this.height, 8);
		//Create the movie clip holder for log
		this.logMC = parentMC.createEmptyMovieClip ("Log", depth + 2);
		//Re-position the log Movie clip to required x and y position
		this.logMC._x = this.x;
		this.logMC._y = this.y;
		//Create the log instance
		this.lgr = new Logger (logMC, this.width, this.height);
		if (this.debugMode)
		{
			/**
			* If the map is in debug mode, we:
			* - Show log.
			*/
			//Log the map parameters
			this.log ("Info", "Map loaded and initialized.", Logger.LEVEL.INFO);
			
			//Log map version.
			this.log("Version", _version, Logger.LEVEL.INFO);
			
			//Log Map Objects
			var strMapObjects : String = "";
			for (i = 0; i < arrObjects.length; i ++)
			{
				strMapObjects += "<LI>" + arrObjects [i] + "</LI>";
			}
			this.log ("Map Objects", strMapObjects, Logger.LEVEL.INFO);
			
			this.log ("Initial Width", String (this.width) , Logger.LEVEL.INFO);
			this.log ("Initial Height", String (this.height) , Logger.LEVEL.INFO);
			this.log ("Scale Mode", this.scaleMode, Logger.LEVEL.INFO);
			this.log ("Debug Mode", (this.debugMode == true) ? "Yes" : "No", Logger.LEVEL.INFO);
			this.log ("Application Message Language", this.lang, Logger.LEVEL.INFO);
			//Now show the log
			lgr.show ();
		}		
		//Expose image saving functionality to JS. 
		if (this.registerWithJS==true && ExternalInterface.available){
			ExternalInterface.addCallback("saveAsImage",this, saveAsImage);
		}
		//Expose the methods to JavaScript using ExternalInterface		
		if (this.registerWithJS==true && ExternalInterface.available){
			ExternalInterface.addCallback("print", this, printMap);
		}
		//Expose the methods required by External Interface
		if (this.registerWithJS==true && ExternalInterface.available){
			//Register the getEntityList method of map 
			ExternalInterface.addCallback("getEntityList", this, getEntityList);
			//Register the co-ordinate choosing methods of map
			ExternalInterface.addCallback("enableChooseMode", this, enableChooseMode);
			ExternalInterface.addCallback("disableChooseMode", this, disableChooseMode);
		}
		//Initialize EventDispatcher to implement the event handling functions
		mx.events.EventDispatcher.initialize(this);
	}
	//These functions are defined in the class to prevent
	//the compiler from throwing an error when they are called
	//They are not implemented until EventDispatcher.initalize(this)
	//overwrites them.
	public function dispatchEvent() {
	}
	public function addEventListener() {
	}
	public function removeEventListener() {
	}
	public function dispatchQueue() {
	}
	/**
	 * exposeMapRendered method is called when the map has rendered. 
	 * Here, we expose the event to JS (if required) & also dispatch a
	 * event (so that, if other movies are loading this map, they can listen).
	*/
	private function exposeMapRendered():Void{
		//Proceed, if we've not already conveyed the event
		if (this.renderEventConveyed==false){
			if (parentMC._loadModeExternal){
				var dataObj:Object = new Object();
				//Create a data object containing details
				dataObj.id = this.DOMId;
				//Dispatch event via FlashInterface
				FlashInterface.dispatchEvent({type:'mapRendered', data:dataObj});
				//Update flag that we've conveyed both rendered events now.
				this.renderEventConveyed = true;
			}else{			
				//Expose event to JS
				if (this.registerWithJS==true &&  ExternalInterface.available){
					ExternalInterface.call("FC_Rendered", this.DOMId);
				}
				//Dispatch an event to loader class
				this.dispatchEvent({type:"rendered", target:this});
				//Update flag that we've conveyed both rendered events now.
				this.renderEventConveyed = true;
			}
		}
		//Clear calling interval
		clearInterval(this.config.intervals.renderedEvent);
	}
	/**
	* render method is the single call method that does the rendering of strMapObjects:
	* - Parsing XML
	* - Calculating values and co-ordinates
	* - Visual layout and rendering
	* - Event handling
	*/
	public function render () : Void 
	{
		//Parse the XML Data document
		this.parseXML ();
		//Re-set the animation flag
		this.params.animation = this.getAnimationFlag();
		//Now, if the number of data elements is 0, we show pertinent
		//error.
		if (this.tNum == 0)
		{
			tfAppMsg = this.renderAppMessage (_global.getAppMessage ("NODATA", this.lang));
			//Add a message to log.
			this.log ("No Entities to Display", "No entities found in the map.", Logger.LEVEL.ERROR);
		} else 
		{
			//Detect number scales
			this.detectNumberScales ();
			//Set Style defaults
			this.setStyleDefaults ();
			//Allot the depths for various strMapObjectss objects now
			this.allotDepths ();
			//Calculate Points
			this.calculate ();
			//Set tool tip parameter
			this.setToolTipParam ();
			//Remove application message
			this.removeAppMessage (this.tfAppMsg);
			//-----Start Visual Rendering Now------//
			//Draw background
			this.drawBackground ();
			//Set click handler
			this.drawClickURLHandler ();
			//Load background SWF
			this.loadBgSWF ();
			//Update timer
			this.timeElapsed = (this.params.animation) ? this.styleM.getMaxAnimationTime (this.objects.BACKGROUND) : 0;
			//Draw canvas
			this.config.intervals.plot = setInterval (Delegate.create (this, renderMap) , this.timeElapsed);
			//Legend
			this.config.intervals.legend = setInterval (Delegate.create (this, drawLegend) , this.timeElapsed);
			//Update timer
			this.timeElapsed += (this.params.animation) ? this.styleM.getMaxAnimationTime (this.objects.PLOT, this.objects.LEGEND) : 0;
			//Render the markers
			this.config.intervals.markers = setInterval (Delegate.create (this, renderMarkers) , this.timeElapsed);
			//Update timer
			this.timeElapsed += (this.params.animation) ? this.styleM.getMaxAnimationTime (this.objects.MARKERS) : 0;
			//And their connectors
			this.config.intervals.markerConnectors = setInterval (Delegate.create (this, renderMarkerConnectors) , this.timeElapsed);			
			//And their labels
			this.config.intervals.markerLabels = setInterval (Delegate.create (this, renderMarkerLabels) , this.timeElapsed);			
			//Labels
			this.config.intervals.labels = setInterval (Delegate.create (this, drawLabels) , this.timeElapsed);
			//Update timer
			this.timeElapsed += (this.params.animation) ? this.styleM.getMaxAnimationTime (this.objects.LABELS, this.objects.MARKERLABELS, this.objects.MARKERCONNECTORS) : 0;
			//Dispatch event that the chart has loaded.
			this.config.intervals.renderedEvent = setInterval(Delegate.create(this, exposeMapRendered) , this.timeElapsed);
			//Set the context menu items
			this.setContextMenu ();
		}
	}
	//----------- CORE FUNCTIONAL METHODS ----------//
	/**
	* isMapObject method helps check whether the given
	* object name is a valid map object (pre-defined).
	*	@param	isMapObject	Name of map object
	*	@return				Boolean value indicating whether
	*							it's a valid map object.
	*/
	private function isMapObject (strObjName : String) : Boolean 
	{
		//By default assume invalid
		var isValid : Boolean = false;
		var i : Number;
		//Iterate through the list of objects to see if this is
		//valid
		for (i = 0; i < arrObjects.length; i ++)
		{
			if (arrObjects [i].toUpperCase () == strObjName)
			{
				isValid = true;
				break;
			}
		}
		return isValid;
	}
	/**
	* isValidEntity method checks whether the given entity id is a
	* valid one for this map.
	*	@param	id	String Identifier of the entity.
	*	@return	Boolean value indicating whether it's valid or not.
	*/
	private function isValidEntity (id : String) : Boolean
	{
		//Convert id to upper case
		id = id.toUpperCase ();
		//By default, assume it's invalid
		var isValid : Boolean = false;
		//Iterate through all the entities and see if we can find a match
		var i : Number;
		for (i = 1; i <= this.tNum; i ++)
		{
			if (this.entity [i].id == id)
			{
				isValid = true;
				break;
			}
		}
		//Return
		return isValid;
	}
	/**
	* getEntityIndex method returns the index of the entity in entity array.
	* If entity is not found, it returns -1.
	*	@param	id	String Identifier of the entity.
	*	@return	Numeric value (index)
	*/
	private function getEntityIndex (id : String) : Number
	{
		//Convert id to upper case
		id = id.toUpperCase ();
		//By default, assume it's not present
		var index : Number = - 1;
		//Iterate through all the entities and see if we can find a match
		var i : Number;
		for (i = 1; i <= this.tNum; i ++)
		{
			if (this.entity [i].id.toUpperCase () == id)
			{
				index = i;
				break;
			}
		}
		//Return
		return index;
	}
	/**
	* addEntity method adds a new entity to this map.
	*	@param	id		String identitier for new entity
	*	@param	mcName	Instance Name of the movie clip representing the
	*					entity on the map.
	*	@param	sName	Short Name for the entity
	*	@param	lName	Long name for the entity
	*	@return		Nothing
	*/
	private function addEntity (id : String, mcName : String, sName : String, lName : String) : Void
	{
		//Increment count of total entities for the map
		this.tNum ++;
		//Trim the id and capitalize it.
		id = StringExt.removeSpaces (id.toUpperCase ());
		//Now, if the entity id already exists in our list, throw an error
		if (isValidEntity (id))
		{
			throw new Error ("Entity " + id + " already exists in list. Please remove duplicates.");
			//Add error to log.
			this.log ("ERROR", "Duplicate entity Id. Entity '" + id + "' already exists in list. Please remove duplicates.", Logger.LEVEL.ERROR);
		}else
		{
			//Get the object for this entity
			var eObj : Object = this.returnDataAsEntity (id, mcName, sName, lName);
			//Store in entity array;
			this.entity [tNum] = eObj;
		}
	}
	/**
	* getColorRangeIndex method returns the color range index based on
	* the value specified. If no color range could be found, it returns -1.
	*	@param	value	Value on which we've to check ranges.
	*	@return		Returns the index for the range which
	*					contains this value.
	*/
	private function getColorRangeIndex (value : Number) : Number
	{
		//If no color range has been defined, return -1
		if (this.numCR == 0)
		{
			return - 1;
		}
		//Store index as -1
		var index : Number = - 1;
		//Iterate through all the color ranges to see if this value fits in
		var i : Number;
		for (i = 1; i <= this.numCR; i ++)
		{
			if (value >= this.colorRange [i].minValue && value < this.colorRange [i].maxValue)
			{
				index = i;
				break;
			}
		}
		return index;
	}
	/**
	* getColorFromRange method gets the color for the entity based on value.
	* It searches through the color range to find the range containing this
	* value and then returns this color.
	*	@param	value	Value on which we've to check ranges.
	*	@return		Returns the hex color code for the range which
	*					contains this value.
	*/
	private function getColorFromRange (value : Number) : String
	{
		//Get index of this color range
		var index : Number = getColorRangeIndex (value);
		//If index is -1, that means we couldn't find a valid color range
		//so return default color. Else return proper color range color
		if (index == - 1)
		{
			return this.params.fillColor;
		}
		else
		{
			return this.colorRange [index].color;
		}
	}
	/**
	* getAlphaFromRange method gets the alpha for the entity based on value.
	* It searches through the color range to find the range containing this
	* value and then returns this alpha.
	*	@param	value	Value on which we've to check ranges.
	*	@return		Returns the alpha for the range which
	*					contains this value.
	*/
	private function getAlphaFromRange (value : Number) : Number
	{
		//Get index of this color range
		var index : Number = getColorRangeIndex (value);
		//If index is -1, that means we couldn't find a valid color range
		//so return default alpha. Else return proper color range alpha
		if (index == - 1)
		{
			return this.params.fillAlpha;
		}
		else
		{
			return this.colorRange [index].alpha;
		}
	}
	/**
	 * setSize method just sets the new size of the map in the instance variables.
	 * It doesn't actually update the view content. That needs to be 
	 * separately handled. This method assumes that w,h values have
	 * BEEN validated before passing to the method.
	 * This method is invoked by resize() method, when the map is resized
	 * from JavaScript.
	 * @param	w	New width of map.
	 * @param	h	New height of map.
	*/
	public function setSize(w:Number, h:Number):Void{
		this.width = w;
		this.height = h;
	}
	/**
	 * updateLogSize method updates the size of log window visually. 
	*/
	public function updateLogSize():Void{
		if (debugMode){			
			lgr.resetSize(this.width, this.height);
		}
	}
	/**
	 * setDebugMode sets the debug mode internal flag to true/false.
	 * Note: It doesn't hide the already being shown debug mode. It just
	 * sets the internal flag to true/false to enable/disable logging of
	 * messages.
	*/
	public function setDebugMode(mode:Boolean):Void{
		this.debugMode=mode;
	}
	/**
	 * getAnimationFlag method combines the value of this.params.animation and the
	 * current animation state and returns whether the map should animate. 
	 * @return	Value of animationFlag
	*/
	public function getAnimationFlag():Boolean{
		//Basically, if the map is being resized, we do not animate.
		//But, if user has specified animation in his XML data, and uses
		//JS to update chart to a new XML, we should respect that flag.
		var r:Boolean = this.params.animation && animationFlag;
		//Reset flag to true, so that if setDataURL/setDataXML is invoked, 
		//the map animates again
		animationFlag = true;
		//Return result
		return r;
	}
	/**
	 * setAnimationFlag method sets the value of animationFlag
	 * @return	Value of animationFlag
	*/
	public function setAnimationFlag(val:Boolean):Void{
		animationFlag = val;
	}
	/**
	* log method records a message to the map's logger. We record
	* messages in the logger, only if the map is in debug mode to
	* save memory
	*	@param	strTitle	Title of messsage
	*	@param	strMsg		Message to be logged
	*	@param	intLevel	Numeric level of message - a value from
	*						Logger.LEVEL Enumeration
	*/
	public function log (strTitle : String, strMsg : String, intLevel : Number)
	{
		if (debugMode)
		{
			lgr.record (strTitle, strMsg, intLevel);
		}
	}
	/**
	* reInit method re-initializes the map. This method is basically called
	* when the user changes map data through JavaScript. In that case, we need
	* to re-initialize the map, set new XML data and again render.
	* TODO: Modify it to reInit all
	*/
	public function reInit () : Void
	{
		//Re-initialize params and config object
		this.params = new Object ();
		this.config = new Object ();
		this.config.intervals = new Object ();
		//Re-initialize storage arrays
		this.entity = new Array ();
		this.colorRange = new Array ();
		this.markerDef = new Array();
		this.markerShape = new Array();
		this.markerData = new Array();
		this.markerConnectors = new Array();		
		//Set counters to 0
		this.tNum = 0;
		this.num = 0;
		this.numCR = 0;
		this.maxDecimals = 0;
		this.numMarkerDefs = 0;
		this.numMarkerData = 0;
		this.numMarkerConnectors = 0;
		//Re-create empty map movie clip
		this.mapMC = parentMC.createEmptyMovieClip ("Map", depth + 1);
		//Re-position the map Movie clip to required x and y position
		this.mapMC._x = this.x;
		this.mapMC._y = this.y;
		//Reset the style manager
		this.styleM = new StyleManager (this);
		//Reset depth manager
		this.dm.clear ();
		this.dm.setStartDepth (0);
		//Set timeElapsed to 0
		this.timeElapsed = 0;
		//Reset legend
		this.lgnd.reset ();
	}
	/**
	* remove method removes the map by clearing the map movie clip
	* and removing any listeners. However, the logger still stays on.
	* To remove the logger too, you need to call destroy method of map.
	* TODO: Modify it to remove all
	*/
	public function remove () : Void 
	{
		//Remove all the intervals (which might not have been cleared)
		//from this.config.intervals
		var item : Object;
		for (item in this.config.intervals)
		{
			//Clear interval
			clearInterval (this.config.intervals [item]);
		}
		//Remove application message (if any)
		this.removeAppMessage (this.tfAppMsg);
		//Remove actual map
		actualMapMC.removeMovieClip ();
		//Remove the map movie clip
		mapMC.removeMovieClip ();
		//Hide tool tip
		tTip.hide ();
		//Remove legend
		this.lgnd.destroy ();
		lgndMC.removeMovieClip ();
	}
	/**
	* destroy method destroys the map by removing the map movie clip,
	* logger movie clip, and removing any listeners.
	* TODO: Modify it to destroy all
	*/
	public function destroy () : Void 
	{
		//Remove the map first
		this.remove ();
		//Remove the map movie clip
		mapMC.removeMovieClip ();
		//Destroy the logger
		this.lgr.destroy ();
		//Destroy tool tip
		this.tTip.destroy ();
		//Remove tool tip movie clip
		this.ttMC.removeMovieClip ();
		//Remove logger movie clip
		this.logMC.removeMovieClip ();
	}
	//----------- DATA RELATED AND PARSING METHODS ----------------//
	/**
	* setXMLData helps set the XML data for the map. The XML data
	* is acquired from external source. Like, if you load the map
	* in your movie, you need to create/load the XML data and handle
	* the loading events (etc.). Finally, when the proper XML is loaded,
	* you need to pass it to map class. When FusionMaps is loaded
	* in HTML, the .fla file loads the XML and displays loading progress
	* bar and text. Finally, when loaded, errors are checked for, and if
	* ok, the XML is passed to map for further processing and rendering.
	*	@param	objXML	XML Object containing the XML Data
	*	@return		Nothing.
	*/
	public function setXMLData (objXML : XML) : Void 
	{
		//If the XML data has no child nodes, we display error
		if ( ! objXML.hasChildNodes ())
		{
			//Show "No data to display" error
			tfAppMsg = this.renderAppMessage (_global.getAppMessage ("NODATA", this.lang));
			//Add a message to the log.
			this.log ("ERROR", "No data to display. There isn't any node/element in the XML document. Please check if your dataURL is properly URL Encoded or, if XML has been correctly embedded in case of dataXML.", Logger.LEVEL.ERROR);
		} else 
		{
			//We've data.
			//Store the XML data in class
			this.xmlData = new XML ();
			this.xmlData = objXML;
			//Show rendering map message
			tfAppMsg = this.renderAppMessage (_global.getAppMessage ("RENDERINGMAP", this.lang));
			//If the map is in debug mode, then add XML data to log
			if (this.debugMode)
			{
				var strXML : String = this.xmlData.toString ();
				//First we need to convert < and > in XML to &lt; and &gt;
				//As our logger textbox is HTML enabled.
				strXML = StringExt.replace (strXML, "<", "&lt;");
				strXML = StringExt.replace (strXML, ">", "&gt;");
				//Also convert carriage returns to <BR> for better viewing.
				strXML = StringExt.replace (strXML, "/r", "<BR>");
				this.log ("XML Data", strXML, Logger.LEVEL.CODE);
			}
		}
		//Retrieve the copy of existing debug mode value and set it back for
		//debug mode variable. This is done for automatic resizing feature:
		//When the chart is resized, the XML data is set again. But, we do not
		//need to log it over and over again. So, we keep switching values of
		//debug mode to handle that.
		this.debugMode = this.debugModeO;
	}
	/**
	* parseXML method parses the XML data, sets defaults and validates
	* the attributes before storing them to data storage objects.
	*/
	private function parseXML () : Void 
	{
		//Get the element nodes
		var arrDocElement : Array = this.xmlData.childNodes;
		//Loop variable
		var i : Number;
		var j : Number;
		var k : Number;
		//Look for <map> element
		for (i = 0; i < arrDocElement.length; i ++)
		{
			//If it's a <map> element, proceed.
			//Do case in-sensitive mathcing by changing to upper case
			if (arrDocElement [i].nodeName.toUpperCase () == "MAP")
			{
				//Extract attributes of <map> element
				this.parseAttributes (arrDocElement [i]);
				//Now, get the child nodes - first level nodes
				//Level 1 nodes can be - ENTITYDEF, COLORRANGE, DATA, STYLES etc.
				var arrLevel1Nodes : Array = arrDocElement [i].childNodes;
				var setNode : XMLNode;
				//First up, we need to find the Entity Definition node and parse it
				//Before parsing the entity definition, we cannot allocate data to
				//proper id.
				for (j = 0; j < arrLevel1Nodes.length; j ++)
				{
					if (arrLevel1Nodes [j].nodeName.toUpperCase () == "ENTITYDEF")
					{
						//Entity Definition - extract child nodes
						var arrEntityDefNodes : Array = arrLevel1Nodes [j].childNodes;
						//Parse the entity definition nodes to extract information
						this.parseEntityDef (arrEntityDefNodes);
					}
				}
				//Now, iterate through rest of level 1 nodes.
				for (j = 0; j < arrLevel1Nodes.length; j ++)
				{
					if (arrLevel1Nodes [j].nodeName.toUpperCase () == "COLORRANGE")
					{
						//Color Range - extract child nodes
						var arrColorRangeNodes : Array = arrLevel1Nodes [j].childNodes;
						//Parse the color range nodes to extract color range information
						this.parseColorRangeXML (arrColorRangeNodes);
					} 
					if (arrLevel1Nodes [j].nodeName.toUpperCase () == "MARKERS")
					{
						//Markers definition
						var arrMarkers : Array = arrLevel1Nodes [j].childNodes;
						//Parse the marker children nodes to extract additional information
						//We necessarily first need to parse definition nodes.
						for (k=0; k<arrMarkers.length; k++){
							if (arrMarkers[k].nodeName.toUpperCase()=="DEFINITION"){
								//Extract marker definition information
								this.parseMarkerDefXML(arrMarkers[k].childNodes);
							}
						}
						//Now, only if we've atleast 1 marker definition, we extract rest
						//of marker information. Else, they won't be of any use
						if (this.numMarkerDefs>0){
							//Before parsing any shapes defined by the user, we feed the default
							//shapes into the system.
							this.feedDefaultMarkerShapes();
							//Iterate through nodes and extract SHAPES nodes
							//This is done so that we can report non-existent ShapeIDs directly.
							for (k=0; k<arrMarkers.length; k++){
								if (arrMarkers[k].nodeName.toUpperCase()=="SHAPES"){
									//Extract marker definition information
									this.parseMarkerShapesXML(arrMarkers[k].childNodes);
								} 
							}
							//Finally, parse the APPLICATION node and CONNECTORS node
							for (k=0; k<arrMarkers.length; k++){
								if (arrMarkers[k].nodeName.toUpperCase()=="APPLICATION"){
									//Extract marker definition information
									this.parseMarkerDataXML(arrMarkers[k].childNodes);
								} else if (arrMarkers[k].nodeName.toUpperCase()=="CONNECTORS"){
									//Extract marker connectors information
									this.parseMarkerConnectorsXML(arrMarkers[k].childNodes);
								}
							}
						}
					} 
					else if (arrLevel1Nodes [j].nodeName.toUpperCase () == "DATA")
					{
						//Extract the entity data nodes
						var dataNodes : Array = arrLevel1Nodes [j].childNodes;
						//Run through each of them
						for (k = 0; k < dataNodes.length; k ++)
						{
							//If it's a data definition for entity
							if (dataNodes [k].nodeName.toUpperCase () == "ENTITY")
							{
								//Data found - Get attributes in array
								var dataAtts : Array = this.getAttributesArray (dataNodes [k]);
								//Extract attributes
								var id : String = dataAtts ["id"];
								//If it's a valid id, proceed only then. Else raise error
								var index : Number = this.getEntityIndex (id);
								if (index == - 1)
								{
									//Id not found for this map. Raise error.
									this.log ("Invalid Entity Id", "'" + id + "' is not a valid entity Id for this Map. Please cross check the documentation to see the list of IDs for this map.", Logger.LEVEL.ERROR);
								} 
								else
								{
									//Extract other attributes.
									var value : Number = this.getSetValue (dataAtts ["value"]);
									var displayValue : String = dataAtts ["displayvalue"];
									var showLabel : Boolean = toBoolean(getFV(dataAtts ["showlabel"], this.params.showLabels));
									var toolText : String = dataAtts ["tooltext"];
									var strColor : String = dataAtts ["color"];
									var intAlpha : Number = dataAtts ["alpha"];
									var link : String = dataAtts ["link"];
									var font:String = dataAtts ["font"];
									var fontSize:String = dataAtts ["fontsize"];
									var fontColor:String = dataAtts ["fontcolor"];
									var fontBold:String = dataAtts ["fontbold"];
									//Update
									this.entity [index].value = value;
									this.entity [index].displayValue = displayValue;
									this.entity [index].showLabel = showLabel;
									this.entity [index].toolText = toolText;
									this.entity [index].color = strColor;
									this.entity [index].alpha = intAlpha;
									this.entity [index].link = link;
									//Individual font properties
									this.entity [index].font = font;
									this.entity [index].fontSize = fontSize;
									this.entity [index].fontColor = fontColor;
									this.entity [index].fontBold = fontBold;
								}
							}
						}
					} 
					else if (arrLevel1Nodes [j].nodeName.toUpperCase () == "STYLES")
					{
						//Styles Node - extract child nodes
						var arrStyleNodes : Array = arrLevel1Nodes [j].childNodes;
						//Parse the style nodes to extract style information
						this.parseStyleXML (arrStyleNodes);
					}
				}
			}
		}
	}
	/**
	* parseAttributes method parses the attributes and stores them in
	* strMapObjects storage objects.
	* Starting ActionScript 2, the parsing of XML attributes have also
	* become case-sensitive. However, prior versions of FusionMaps
	* supported case-insensitive attributes. So we need to parse all
	* attributes as case-insensitive to maintain backward compatibility.
	* To do so, we first extract all attributes from XML, convert it into
	* lower case and then store it in an array. Later, we extract value from
	* this array.
	* @param	graphElement	XML Node containing the <graph> element
	*							and it's attributes
	*/
	private function parseAttributes (graphElement : XMLNode) : Void 
	{
		//Array to store the attributes
		var atts : Array = this.getAttributesArray (graphElement);
		//NOW IT'S VERY NECCESARY THAT WHEN WE REFERENCE THIS ARRAY
		//TO GET AN ATTRIBUTE VALUE, WE SHOULD PROVIDE THE ATTRIBUTE
		//NAME IN LOWER CASE. ELSE, UNDEFINED VALUE WOULD SHOW UP.
		//Extract attributes pertinent to this map
		//Whether to set animation for entire map.
		this.params.animation = toBoolean (getFN (atts ["animation"] , 1));
		//Whether to show about FusionMaps Menu Item - by default set to on
		this.params.showFCMenuItem = toBoolean(getFN (atts ["showfcmenuitem"] , 1));
		//Whether to show print Menu Item - by default set to on
		this.params.showPrintMenuItem = toBoolean(getFN(atts ["showprintmenuitem"] , 1));		
		//Whether to set the default map animation
		this.params.defaultAnimation = toBoolean (getFN (atts ["defaultanimation"] , 1));
		//Border Properties of map
		this.params.showCanvasBorder = toBoolean (getFN (atts ["showcanvasborder"] , 1));
		this.params.canvasBorderColor = formatColor (getFV (atts ["canvasbordercolor"] , "999999"));
		this.params.canvasBorderThickness = getFN (atts ["canvasborderthickness"] , 1);
		this.params.canvasBorderAlpha = getFN (atts ["canvasborderalpha"] , 100);
		//Background properties - Gradient
		this.params.bgColor = getFV (atts ["bgcolor"] , "FFFFFF");
		this.params.bgAlpha = getFV (atts ["bgalpha"] , "100");
		this.params.bgRatio = getFV (atts ["bgratio"] , "");
		this.params.bgAngle = getFV (atts ["bgangle"] , "90");
		//Background swf
		this.params.bgSWF = getFV (atts ["bgswf"] , "");
		this.params.bgSWFAlpha = getFN (atts ["bgswfalpha"] , 100);
		//Click URL
		this.params.clickURL = getFV (atts ["clickurl"] , "");
		//Font Properties
		this.params.baseFont = getFV (atts ["basefont"] , "Verdana");
		this.params.baseFontSize = getFN (atts ["basefontsize"] , 11);
		this.params.baseFontColor = formatColor (getFV (atts ["basefontcolor"] , "000000"));
		//Marker label font properties
		this.params.markerFont = getFV (atts ["markerfont"] , this.params.baseFont);
		this.params.markerFontSize = getFN (atts ["markerfontsize"] , this.params.baseFontSize);
		this.params.markerFontColor = formatColor (getFV (atts ["markerfontcolor"] , this.params.baseFontColor));
		//Fill color and alpha of the map
		this.params.fillColor = formatColor (getFV (atts ["fillcolor"] , "FFFFCC"));
		this.params.fillAlpha = getFN (atts ["fillalpha"] , 100);
		//Border properties
		this.params.borderColor = formatColor (getFV (atts ["bordercolor"] , "333333"));
		this.params.borderAlpha = getFN (atts ["borderalpha"] , 100);
		//Connector line color
		this.params.connectorColor = formatColor (getFV (atts ["connectorcolor"] , "999999"));
		this.params.connectorAlpha = getFN (atts ["connectoralpha"] , 100);
		//Plot Shadow
		this.params.showShadow = toBoolean (getFN (atts ["showshadow"] , 1));
		//Plot Bevel
		this.params.showBevel = toBoolean (getFN (atts ["showbevel"] , 1));
		//Tool Tip - Show/Hide, Background Color, Border Color, Separator Character
		this.params.showToolTip = toBoolean (getFN (atts ["showtooltip"] , atts ["showhovercap"] , 1));
		this.params.toolTipBgColor = formatColor (getFV (atts ["tooltipbgcolor"] , atts ["hovercapbgcolor"] , atts ["hovercapbg"] , "F1F1F1"));
		this.params.toolTipBorderColor = formatColor (getFV (atts ["tooltipbordercolor"] , atts ["hovercapbordercolor"] , atts ["hovercapborder"] , "666666"));
		this.params.toolTipSepChar = getFV (atts ["tooltipsepchar"] , atts ["hovercapsepchar"] , ", ");
		this.params.useHoverColor = toBoolean (getFN (atts ["usehovercolor"] , (this.params.showToolTip) ?1 : 0));
		this.params.hoverColor = formatColor (getFV (atts ["hovercolor"] , "ffcc66"));
		this.params.hoverOnEmpty = toBoolean(getFN (atts ["hoveronempty"] , 1));
		this.params.exposeHoverEvent = toBoolean(getFN (atts ["exposehoverevent"] , 0));
		//Whether to use short name or long name in tool tip
		this.params.useSNameInToolTip = toBoolean (getFN (atts ["usesnameintooltip"] , 0));
		//Data label configuration properties
		this.params.showLabels = toBoolean (getFN (atts ["showlabels"] , 1));
		this.params.includeNameInLabels = toBoolean (getFN (atts ["includenameinlabels"] , 1));
		this.params.includeValueInLabels = toBoolean (getFN (atts ["includevalueinlabels"] , 0));
		this.params.useSNameInLabels = toBoolean (getFN (atts ["usesnameinlabels"] , 1));
		this.params.labelSepChar = getFV (atts ["labelsepchar"] , ", ");
		//Marker properties
		this.params.showMarkerToolTip = toBoolean (getFN (atts ["showmarkertooltip"] , this.params.showToolTip));
		this.params.showMarkerLabels = toBoolean (getFN (atts ["showmarkerlabels"] , this.params.showLabels));
		//Marker label padding
		this.params.markerLabelPadding = getFN (atts ["markerlabelpadding"] , 1);
		//Marker default colors
		this.params.markerBgColor = formatColor (getFV (atts ["markerbgcolor"] , this.params.hoverColor));
		this.params.markerBorderColor = formatColor (getFV (atts ["markerbordercolor"] , this.params.connectorColor));
		//Marker radius
		this.params.markerRadius = getFN (atts ["markerradius"] , 6);
		//Marker connector properties
		this.params.markerConnThickness = getFN(atts["markerconnthickness"], 2);
		this.params.markerConnColor = formatColor(getFV(atts["markerconncolor"], this.params.connectorColor)); 
		this.params.markerConnAlpha = getFN(atts["markerconnalpha"], 100);
		this.params.markerConnDashed = toBoolean (getFN(atts["markerconndashed"] , 0));
		this.params.markerConnDashLen = getFN(atts["markerconndashlen"], 4);
		this.params.markerConnDashGap = getFN(atts["markerconndashgap"], 3);
		//Legend properties
		this.params.showLegend = toBoolean (getFN (atts ["showlegend"] , 1));
		//Alignment position
		this.params.legendPosition = getFV (atts ["legendposition"] , "RIGHT");
		//Legend position can be either RIGHT or BOTTOM -Check for it
		this.params.legendPosition = (this.params.legendPosition.toUpperCase () == "RIGHT") ?"RIGHT" : "BOTTOM";
		this.params.legendCaption = getFV(atts ["legendcaption"] , "");
		this.params.legendMarkerCircle = toBoolean(getFN(atts ["legendmarkercircle"] , 0));		
		this.params.legendBorderColor = formatColor (getFV (atts ["legendbordercolor"] , "666666"));
		this.params.legendBorderThickness = getFN (atts ["legendborderthickness"] , 1);
		this.params.legendBorderAlpha = getFN (atts ["legendborderalpha"] , 100);
		this.params.legendBgColor = getFV (atts ["legendbgcolor"] , "FFFFFF");
		this.params.legendBgAlpha = getFN (atts ["legendbgalpha"] , 100);
		this.params.legendShadow = toBoolean (getFN (atts ["legendshadow"] , 1));
		this.params.legendAllowDrag = toBoolean (getFN (atts ["legendallowdrag"] , 0));
		this.params.legendScrollBgColor = formatColor (getFV (atts ["legendscrollbgcolor"] , "CCCCCC"));
		this.params.legendScrollBarColor = formatColor (getFV (atts ["legendscrollbarcolor"] , this.params.legendBorderColor));
		this.params.legendScrollBtnColor = formatColor (getFV (atts ["legendscrollbtncolor"] , this.params.legendBorderColor));
		//Padding of legend from right/bottom side of canvas
		this.params.legendPadding = getFN (atts ["legendpadding"] , 6);
		//Map Margins - Empty space at the 4 sides
		this.params.mapLeftMargin = getFN (atts ["mapleftmargin"] , 10);
		this.params.mapRightMargin = getFN (atts ["maprightmargin"] , 10);
		this.params.mapTopMargin = getFN (atts ["maptopmargin"] , 10);
		this.params.mapBottomMargin = getFN (atts ["mapbottommargin"] , 10);
		// ------------------------- NUMBER FORMATTING ---------------------------- //
		//Option whether the format the number (using Commas)
		this.params.formatNumber = getFN (atts ["formatnumber"] , 1);
		//Option to format number scale
		this.params.formatNumberScale = getFN (atts ["formatnumberscale"] , 0);
		//Number Scales
		this.params.defaultNumberScale = getFV (atts ["defaultnumberscale"] , "");
		this.params.numberScaleUnit = getFV (atts ["numberscaleunit"] , "K,M");
		this.params.numberScaleValue = getFV (atts ["numberscalevalue"] , "1000,1000");
		//Number prefix and suffix
		this.params.numberPrefix = getFV (atts ["numberprefix"] , "");
		this.params.numberSuffix = getFV (atts ["numbersuffix"] , "");
		//Decimal Separator Character
		this.params.decimalSeparator = getFV (atts ["decimalseparator"] , ".");
		//Thousand Separator Character
		this.params.thousandSeparator = getFV (atts ["thousandseparator"] , ",");
		//Input decimal separator and thousand separator. In some european countries,
		//commas are used as decimal separators and dots as thousand separators. In XML,
		//if the user specifies such values, it will give a error while converting to
		//number. So, we accept the input decimal and thousand separator from user, so that
		//we can covert it accordingly into the required format.
		this.params.inDecimalSeparator = getFV (atts ["indecimalseparator"] , "");
		this.params.inThousandSeparator = getFV (atts ["inthousandseparator"] , "");
		//Decimal Precision (number of decimal places to be rounded to)
		this.params.decimals = getFV (atts ["decimals"] , atts ["decimalprecision"]);
		//Force Decimal Padding
		this.params.forceDecimals = toBoolean (getFN (atts ["forcedecimals"] , 0));
		// ---------------------- Image Saving ------------------------------//
		this.params.imageSave = toBoolean (getFN (atts ["imagesave"] , 0));
		this.params.imageSaveURL = getFV (atts ["imagesaveurl"] , "");
		this.params.imageSaveDialogColor = formatColor (getFV (atts ["imagesavedialogcolor"] , "E2E2E2"));
		this.params.imageSaveDialogFontColor = formatColor (getFV (atts ["imagesavedialogfontcolor"] , "666666"));
	}
	/**
	* parseEntityDef method parses the XML nodes which defines the entity
	* definitions
	*	@param	arrNodes	Array of entity nodes
	*/
	private function parseEntityDef (arrNodes : Array) : Void
	{
		//Iterate through all the nodes and find <entity> node
		var i : Number;
		for (i = 0; i < arrNodes.length; i ++)
		{
			if (arrNodes [i].nodeName.toUpperCase () == "ENTITY")
			{
				//New definition found - Extract attributes
				var defAtts : Array = this.getAttributesArray (arrNodes [i]);
				//Internal Id
				var iId : String = getFV (defAtts ["internalid"] , "");
				//Get entity index from the internal id specified
				var index : Number = getEntityIndex (iId);
				//Now, if the index is returned as -1, it means that the given
				//internal id was not found. So, we will raise an error.
				//Else, we'll extract the rest of attributes and store.
				if (index == - 1)
				{
					this.log ("Invalid Entity Id", "'" + iId + "' is not a valid entity Id for this Map. Please cross check the documentation to see the list of IDs for this map.", Logger.LEVEL.ERROR);
				}
				else
				{
					//Get new Id
					var newId : String = defAtts ["newid"];
					//New Short Name
					var sName : String = getFV (defAtts ["sname"] , this.entity [index].sName);
					//New Long Name
					var lName : String = getFV (defAtts ["lname"] , this.entity [index].lName);
					//Now, if the new Id is not already present in the entity list, we update
					//the entity. Else, we raise error.
					if (newId == "" || isValidEntity (newId))
					{
						//Throw error
						this.log ("Duplicate Entity Id", "'" + newId + "' is already present as ID for another entity of the map. Please use a different identifier.", Logger.LEVEL.ERROR);
					} 
					else
					{
						//Update entity
						this.entity [index].id = newId;
						this.entity [index].sName = sName;
						this.entity [index].lName = lName;
					}
				}
			}
		}
	}
	/**
	* parseColorRangeXML method parses the XML nodes which defines the color
	* range information
	*	@param	arrNodes	Array of color range nodes
	*/
	private function parseColorRangeXML (arrNodes : Array) : Void
	{
		var i : Number;
		for (i = 0; i < arrNodes.length; i ++)
		{
			if (arrNodes [i].nodeName.toUpperCase () == "COLOR")
			{
				//Color Range found. Get attributes array
				var crAtts : Array = this.getAttributesArray (arrNodes [i]);
				//Get min and max value.
				var minValue : Number = getSetValue (crAtts ["minvalue"]);
				var maxValue : Number = getSetValue (crAtts ["maxvalue"]);
				//If either min value or max value is NaN, we raise error
				if (isNaN (maxValue) || isNaN (minValue))
				{
					this.log ("Non-numeric color range", "Minimum and maximum values for Color Range cannot be non-numeric.", Logger.LEVEL.ERROR);
				} 
				else
				{
					//Extract rest of attributes and store
					var displayValue : String = crAtts ["displayvalue"];
					var strColor : String = formatColor (getFV (crAtts ["color"] , this.params.fillColor));
					var intAlpha : Number = getFN (crAtts ["alpha"] , this.params.fillAlpha);
					//Create a color range object and store it in
					var crObj : Object = this.returnDataAsColorRange (minValue, maxValue, displayValue, strColor, intAlpha);
					//Increment counter and add to array
					this.numCR ++;
					this.colorRange [this.numCR] = crObj;
				}
			}
		}
	}
	/**
	 * parseMarkerDefXML method parses the marker definition specified by the
	 * user in XML.
	*/
	private function parseMarkerDefXML(arrMarkerNodes:Array):Void{
		//Loop variables
		var i:Number;
		//Iterate through all the nodes
		for (i=0; i<arrMarkerNodes.length; i++){
			//If it's a marker node
			if (arrMarkerNodes[i].nodeName.toUpperCase() == "MARKER"){
				//Extract attributes. Get attributes array
				var mrAtts : Array = this.getAttributesArray(arrMarkerNodes[i]);
				var x:Number = getFN(mrAtts["x"],-1);
				var y:Number = getFN(mrAtts["y"],-1);
				var id:String = getFV(mrAtts["id"],"");
				//Convert id to lower case for case in-sensitive comparison
				id = id.toLowerCase();
				var label:String = getFV(mrAtts["label"],"");
				//Label position
				var labelPos:String = StringExt.removeSpaces(getFV(mrAtts["labelpos"],"top"));
				//Convert to lower case
				labelPos = labelPos.toLowerCase();
				//If not a valid value, set default
				if (labelPos!="top" && labelPos!="bottom" && labelPos!="left" && labelPos!="right" && labelPos!="center"){
					labelPos="top";
				}					
				//We store a marker definition only if it's x,y & id have been defined
				if (x!=-1 && y!=-1 && id!=""){
					//Now, only if the marker is within the original map bounds, we add it
					if (x<0 || y<0){
						this.log ("ERROR", "Invalid co-ordinates specified for marker '" + id + "'. Marker co-ordinates need to be contained within original map area width & height.", Logger.LEVEL.ERROR);
					}else{
						this.numMarkerDefs++;
						//Store as associative array on id as key. This will let Flash index
						//the array based on string key. As such, the searching will be a lot faster.
						this.markerDef[id] = this.returnDataAsMarkerDef(x,y,id,label,labelPos);					
					}
				}else{
					this.log ("ERROR", "Invalid marker definition specified in XML. Each marker needs to have an Id and its respective x and y co-ordinates.", Logger.LEVEL.ERROR);
				}
			}
		}
	}
	/**
	 * parseMarkerShapesXML method parses the user defined shapes for markers
	*/
	private function parseMarkerShapesXML(arrNodes:Array){		
		//Now, iterate through the user defined shapes.
		var i:Number;
		for (i=0; i<arrNodes.length; i++){
			//If it's a shape node
			if (arrNodes[i].nodeName.toUpperCase()=="SHAPE"){
				//Get the attributes array.
				var shpAtts : Array = this.getAttributesArray(arrNodes[i]);
				//Object to store shape properties
				var obj:Object = new Object();
				//Extract type.
				obj.type = StringExt.removeSpaces(shpAtts["type"]);
				//Convert to lower case
				obj.type = obj.type.toLowerCase();
				//Only if it's a valid shape type, we go further
				if (obj.type=="circle" || obj.type=="arc" || obj.type=="polygon" || obj.type=="image"){
					//Extract other information
					//Id of the shape
					obj.id = String(getFV(shpAtts["id"], ""));
					//Convert shape id to lower case for case-insensitive comparison 
					obj.id = obj.id.toLowerCase();
					//If the user has defined an id for the marker shape, only then we go ahead.
					if (obj.id!=""){
						obj.alpha = getFN(shpAtts["alpha"], 100);
						obj.xScale = getFN(shpAtts["xscale"], 100);
						obj.yScale = getFN(shpAtts["yscale"], 100);
						obj.fillColor = ColorExt.parseColorList(getFV(shpAtts["fillcolor"], this.params.markerBgColor));				
						obj.fillAlpha = ColorExt.parseAlphaList(getFV(shpAtts["fillalpha"], "100"),obj.fillColor.length);
						obj.fillRatio = ColorExt.parseRatioList(getFV(shpAtts["fillratio"], ""),obj.fillColor.length);
						obj.fillAngle = getFV(shpAtts["fillangle"], 0);				
						obj.fillPattern = getFV(shpAtts["fillpattern"], ((obj.type == "circle" || obj.type == "arc") ? ("radial") : ("linear")));
						obj.fillPattern = obj.fillPattern.toLowerCase();
						//Restrict fillpattern to linear or radial
						if (obj.fillPattern!="radial" && obj.fillPattern!="linear"){
							obj.fillPattern="linear";
						}
						obj.showBorder = toBoolean(getFN(shpAtts["showborder"], 1));
						obj.borderColor = formatColor(getFV(shpAtts["bordercolor"], this.params.markerBorderColor));
						obj.borderThickness = getFN(shpAtts["borderthickness"], 1);
						obj.borderAlpha = getFN(shpAtts["borderalpha"], 100);
						//If border is not to be shown, we set alpha as 0
						if (!obj.showBorder){
							obj.borderAlpha = 0;
						}
						//Radius
						obj.radius = getFN(shpAtts["radius"], this.params.markerRadius);
						//Inner radius for arc - by default 50% of outer radius
						obj.innerRadius = getFN(shpAtts["innerradius"], 0.5*obj.radius);
						//Number of sides in case of polygon
						obj.sides = getFN(shpAtts["sides"], 4);
						//Start angle
						obj.startAngle = getFN(shpAtts["startangle"], (obj.type=="arc")?0:90);
						obj.endAngle = getFN(shpAtts["endangle"], 360);
						//Label padding
						obj.labelPadding = getFN(shpAtts["labelpadding"],this.params.markerLabelPadding);
						//URL (for image)
						obj.url = getFV(shpAtts["url"],"");
						//Vertical align for image
						obj.vAlign = getFV(shpAtts["valign"],"middle");
						obj.vAlign = obj.vAlign.toLowerCase();
						//Restrict it to top, middle or bottom
						if (obj.vAlign!="top" && obj.vAlign!="bottom" && obj.vAlign!="middle"){
							obj.vAlign = "middle";
						}
						//Add the shape definition to our registry - based on it's id
						this.markerShape[obj.id] = obj;
					}else{
						this.log ("ERROR", "No ID specified for the marker shape. To use a marker shape for your markers, you need to specify an ID for the same.", Logger.LEVEL.ERROR);
					}
				}else{
					this.log ("ERROR", "Invalid shape type specified in XML. Valid values are 'Circle', 'Arc', 'Polygon' or 'Image'.", Logger.LEVEL.ERROR);
				}
			}
		}
	}
	/**
	 * feedDefaultMarkerShapes method feeds the default marker shapes into
	 * the system.
	*/
	private function feedDefaultMarkerShapes(){
		//We need to add Circle, Arc, Rectangle & Triangle as default shapes
		this.markerShape["circle"] = {type:"circle", fillColor:ColorExt.parseColorList(this.params.markerBgColor), fillAlpha:ColorExt.parseAlphaList("100",1), fillRatio:ColorExt.parseRatioList("100",1), fillPattern:"radial", showBorder:true, borderThickness:1, borderColor:this.params.markerBorderColor, borderAlpha:100, radius:this.params.markerRadius, labelPadding:this.params.markerLabelPadding, xScale:100, yScale:100};
		this.markerShape["arc"] = {type:"arc", fillColor:ColorExt.parseColorList(this.params.markerBgColor), fillAlpha:ColorExt.parseAlphaList("100",1), fillRatio:ColorExt.parseRatioList("100",1), fillPattern:"radial", showBorder:true, borderThickness:1, borderColor:this.params.markerBorderColor, borderAlpha:100, radius:this.params.markerRadius, innerRadius:(this.params.markerRadius/2), startAngle:0, endAngle:360, labelPadding:this.params.markerLabelPadding, xScale:100, yScale:100};
		this.markerShape["triangle"] = {type:"polygon", fillColor:ColorExt.parseColorList(this.params.markerBgColor), fillAlpha:ColorExt.parseAlphaList("100",1), fillRatio:ColorExt.parseRatioList("100",1), fillPattern:"linear", showBorder:true, borderThickness:1, borderColor:this.params.markerBorderColor, borderAlpha:100, radius:this.params.markerRadius, sides:3, startAngle:90, labelPadding:this.params.markerLabelPadding, xScale:100, yScale:100};
		this.markerShape["diamond"] = {type:"polygon", fillColor:ColorExt.parseColorList(this.params.markerBgColor), fillAlpha:ColorExt.parseAlphaList("100",1), fillRatio:ColorExt.parseRatioList("100",1), fillPattern:"linear", showBorder:true, borderThickness:1, borderColor:this.params.markerBorderColor, borderAlpha:100, radius:this.params.markerRadius, sides:4, startAngle:0, labelPadding:this.params.markerLabelPadding, xScale:100, yScale:100};
	}
	/**
	 * parseMarkerDataXML method parses the data for markers.
	*/
	private function parseMarkerDataXML(arrNodes:Array){
		//We need to iterate through each marker data.
		var i:Number;
		for (i=0; i<arrNodes.length; i++){
			//Check if it's MARKER node
			if (arrNodes[i].nodeName.toUpperCase() == "MARKER"){
				//Extract information. Get attributes array.
				var mAtts : Array = this.getAttributesArray(arrNodes[i]);
				//Create object to store information
				var obj:Object = new Object();
				obj.id = String(getFV(mAtts["id"],""));
				obj.shapeId = String(getFV(mAtts["shapeid"],""));
				//Convert both to lower case for case-in-sensitive comparison
				obj.id = obj.id.toLowerCase();
				obj.shapeId = obj.shapeId.toLowerCase();
				//Now, if marker is undefined, or shape is undefined, we throw error
				if (this.markerDef[obj.id]==undefined){
					this.log ("ERROR", "Invalid marker '" + obj.id + "' specified in XML. The map couldn't find a marker with this ID. You'll need to define Marker IDs before using them. ", Logger.LEVEL.ERROR);
				}else if(this.markerShape[obj.shapeId] == undefined){
					this.log ("ERROR", "Invalid Marker Shape with ID '" + obj.shapeId + "' specified in XML. The map couldn't find a Marker Shape with this ID. You'll need to define Marker Shapes before using them. ", Logger.LEVEL.ERROR);
				}else{
					//We extract rest of information and store it.
					obj.label = getFV(mAtts["label"],this.markerDef[obj.id].label);
					//Label position
					obj.labelPos = StringExt.removeSpaces(getFV(mAtts["labelpos"],this.markerDef[obj.id].labelPos));					
					//Convert to lower case
					obj.labelPos = obj.labelPos.toLowerCase();
					//If not a valid value, set default
					if (obj.labelPos!="top" && obj.labelPos!="bottom" && obj.labelPos!="left" && obj.labelPos!="right" && obj.labelPos!="center"){
						obj.labelPos=this.markerDef[obj.id].labelPos;
					}					
					//Tool-text
					obj.toolText = getFV(mAtts["tooltext"],obj.label);
					//Link (if any) for the marker
					obj.link = getFV(mAtts["link"],"");
					//What scale to apply to this marker
					obj.scale = getFN(mAtts["scale"],1);
					//Update counter
					this.numMarkerData++;
					//Push to register
					this.markerData[this.numMarkerData] = obj;
				}
			}
		}
	}
	/**
	 * parseMarkerConnectorsXML method parses the connectors between markers.
	*/
	private function parseMarkerConnectorsXML(arrNodes:Array){
		//We need to iterate through each marker data.
		var i:Number;
		for (i=0; i<arrNodes.length; i++){
			//Check if it's CONNECTOR node
			if (arrNodes[i].nodeName.toUpperCase() == "CONNECTOR"){
				//Extract information. Get attributes array.
				var mAtts : Array = this.getAttributesArray(arrNodes[i]);
				//Create object to store information
				var obj:Object = new Object();
				obj.from = String(getFV(mAtts["from"],""));
				obj.to = String(getFV(mAtts["to"],""));
				//Convert both to lower case for case-in-sensitive comparison
				obj.from = obj.from.toLowerCase();
				obj.to = obj.to.toLowerCase();
				//Now, if from or to marker is undefined we throw error
				if (this.markerDef[obj.from]==undefined){
					this.log ("ERROR", "Invalid marker '" + obj.from + "' specified in XML. The map couldn't find a marker with this ID. You'll need to define Marker IDs before using them. ", Logger.LEVEL.ERROR);
				}else if(this.markerDef[obj.to] == undefined){
					this.log ("ERROR", "Invalid marker '" + obj.to + "' specified in XML. The map couldn't find a marker with this ID. You'll need to define Marker IDs before using them. ", Logger.LEVEL.ERROR);
				}else{
					//We extract rest of information and store it.
					obj.thickness = getFN(mAtts["thickness"],this.params.markerConnThickness);
					obj.color = formatColor(getFV(mAtts["color"],this.params.markerConnColor));
					obj.alpha = getFN(mAtts["alpha"],this.params.markerConnAlpha);
					obj.dashed = toBoolean(getFN(mAtts["dashed"],this.params.markerConnDashed));
					obj.dashLen = getFN(mAtts["dashlen"],this.params.markerConnDashLen);
					obj.dashGap = getFN(mAtts["dashgap"],this.params.markerConnDashGap);
					//Label of the marker connector.
					obj.label = getFV(mAtts["label"],"");					
					//Tool-text
					obj.toolText = getFV(mAtts["tooltext"],obj.label);
					//Link (if any) for the marker
					obj.link = getFV(mAtts["link"],"");					
					//Update counter
					this.numMarkerConnectors++;
					//Push to register
					this.markerConnectors[this.numMarkerConnectors] = obj;
				}
			}
		}
	}
	
	/**
	* parseStyleXML method parses the XML nodes which defines the Styles
	* elements (application and definition). This method is common to all
	* maps, as STYLE is an integral part of FusionMaps v3. So, we've
	* defined this parsing in map class, to avoid code duplication.
	*	@param	arrStyleNodes	Array of XML Nodes containing style definition
	*	@return				Nothing
	*/
	private function parseStyleXML (arrStyleNodes : Array) : Void
	{
		//Loop variables
		var k : Number;
		var l : Number;
		var m : Number;
		//Search for Definition Node first
		for (k = 0; k < arrStyleNodes.length; k ++)
		{
			if (arrStyleNodes [k].nodeName.toUpperCase () == "DEFINITION")
			{
				//Store the definition nodes in arrDefNodes
				var arrDefNodes : Array = arrStyleNodes [k].childNodes;
				//Iterate through each definition node and extract the style parameters
				for (l = 0; l < arrDefNodes.length; l ++)
				{
					//If the node name is STYLE, store it
					if (arrDefNodes [l].nodeName.toUpperCase () == "STYLE")
					{
						//Store the node reference
						var styleNode : XMLNode = arrDefNodes [l];
						//Get the attributes array
						var styleAttr : Array = this.getAttributesArray (styleNode)
						//Get attributes of style definition
						var styleName : String = styleAttr ["name"];
						var styleTypeName : String = styleAttr ["type"];
						//Now, if the style type identifier is valid, we proceed
						try 
						{
							//Get the style type id from style type name
							var styleTypeId : Number = this.styleM.getStyleTypeId (styleTypeName);
							//If the control comes here, that means the style type identifier is correct.
							//Create a style object to store the attributes for this style
							var styleObj : StyleObject = new StyleObject ();
							//Now, iterate through all attributes and store them in style obj
							//WE NECESSARILY NEED TO CONVERT ALL ATTRIBUTES TO LOWER CASE
							//BEFORE STORING IT IN STYLE OBJECT
							var attr : Object;
							for (attr in styleNode.attributes)
							{
								styleObj [attr.toLowerCase ()] = styleNode.attributes [attr];
							}
							//Add this style to style manager
							this.styleM.addStyle (styleName, styleTypeId, styleObj);
						} catch (e : com.fusionmaps.helper.FCError)
						{
							//If the control comes here, that means the given style type
							//identifier is invalid. So, we log the error message to the
							//logger.
							this.log (e.name, e.message, e.level);
						}
					}
				}
			}
		}
		//Definition nodes have been stored. So search and store application nodes
		for (k = 0; k < arrStyleNodes.length; k ++)
		{
			if (arrStyleNodes [k].nodeName.toUpperCase () == "APPLICATION")
			{
				//Store the application nodes in arrAppNodes
				var arrAppNodes : Array = arrStyleNodes [k].childNodes;
				for (l = 0; l < arrAppNodes.length; l ++)
				{
					//If it's an application definition
					if (arrAppNodes [l].nodeName.toUpperCase () == "APPLY")
					{
						//Get attributes array
						var appAttr : Array = this.getAttributesArray (arrAppNodes [l]);
						//Extract the attributes
						var toObject : String = appAttr ["toobject"];
						//NECESSARILY CONVERT toObject TO UPPER CASE FOR MATCHING
						toObject = toObject.toUpperCase ();
						var styles : String = appAttr ["styles"];
						//Now, we need to check if the given Object is a valid map object
						if (isMapObject (toObject))
						{
							//If it's a valid map object, we get the id of the object
							//and associate the list of styles.
							//First, we need to convert the comma separated list of styles
							//into an array
							var arrStyles : Array = new Array ();
							arrStyles = styles.split (",");
							//Get the numeric id of the map object
							var objectId = this.objects [toObject];
							//Now iterate through each style defined for this object and associate
							for (m = 0; m < arrStyles.length; m ++)
							{
								try
								{
									//Associate object with style.
									this.styleM.associateStyle (objectId, arrStyles [m]);
								}
								catch (e : com.fusionmaps.helper.FCError)
								{
									//If the control comes here, that means the given object name
									//is invalid. So, we log the error message to the logger.
									this.log (e.name, e.message, e.level);
								}
							}
						} 
						else
						{
							this.log ("Invalid Map Object in Style Definition", "\"" + toObject + "\" is not a valid Map Object. Please see the list above for valid Map Objects.", Logger.LEVEL.ERROR);
						}
					}
				}
			}
		}
		//Clear garbage
		delete arrDefNodes;
		delete arrAppNodes;
		delete styleNode;
		delete attr;
	}
	/**
	* allotDepths method allots the depths for various strMapObjects objects
	* to be rendered. We do this before hand, so that we can later just
	* go on rendering strMapObjects objects, without swapping.
	*/
	private function allotDepths () : Void 
	{
		//Background
		this.dm.reserveDepths ("BACKGROUND", 1);
		//Click URL Handler
		this.dm.reserveDepths ("CLICKURLHANDLER", 1);
		//Background SWF
		this.dm.reserveDepths ("BGSWF", 1);
		//Plot
		this.dm.reserveDepths ("PLOT", 1);
		//Marker Connectors
		this.dm.reserveDepths ("MARKERCONNECTORS", this.numMarkerConnectors);		
		//Markers
		this.dm.reserveDepths ("MARKERS", this.numMarkerData);		
		//Labels
		this.dm.reserveDepths ("LABELS", this.tNum);
		//Marker Labels
		this.dm.reserveDepths ("MARKERLABELS", this.numMarkerData);
		//Legend
		this.dm.reserveDepths ("LEGEND", 1);
	}
	// --------------------------------------------------------------------//
	/**
	* setStyleDefaults method sets the default values for styles or
	* extracts information from the attributes and stores them into
	* style objects.
	*/
	private function setStyleDefaults () : Void 
	{
		/**
		* We need to set defaults for the following object - property combinations:
		* LABELS - FONT
		* PLOT - EFFECT (Shadow)
		* PLOT - EFFECT (Bevel)
		* PLOT - ANIMATION (Alpha)
		* TOOLTIP - FONT
		* LEGEND - FONT, SHADOW
		*/
		//-----------------------------------------------------------------//
		//Default font object for Labels
		//-----------------------------------------------------------------//
		var labelsFont = new StyleObject ();
		labelsFont.name = "_SdLabelsFont";
		labelsFont.font = this.params.baseFont;
		labelsFont.size = this.params.baseFontSize;
		labelsFont.color = this.params.baseFontColor;
		labelsFont.align = "center";
		labelsFont.valign = "middle";
		//Over-ride
		this.styleM.overrideStyle (this.objects.LABELS, labelsFont, this.styleM.TYPE.FONT, null);
		delete labelsFont;
		//-----------------------------------------------------------------//
		//Default font object for Marker Labels
		//-----------------------------------------------------------------//
		var mLabelsFont = new StyleObject ();
		mLabelsFont.name = "_SdMarkerLabelsFont";
		mLabelsFont.font = this.params.markerFont;
		mLabelsFont.size = this.params.markerFontSize;
		mLabelsFont.color = this.params.markerFontColor;
		mLabelsFont.align = "center";
		mLabelsFont.valign = "middle";
		//Over-ride
		this.styleM.overrideStyle (this.objects.MARKERLABELS, mLabelsFont, this.styleM.TYPE.FONT, null);
		delete mLabelsFont;
		//-----------------------------------------------------------------//
		//Default font object for Marker Connector Labels
		//-----------------------------------------------------------------//
		var mConnectorLabelsFont = new StyleObject ();
		mConnectorLabelsFont.name = "_SdMarkerConnectorLabelsFont";
		mConnectorLabelsFont.font = this.params.markerFont;
		mConnectorLabelsFont.size = this.params.markerFontSize;
		mConnectorLabelsFont.color = this.params.markerFontColor;
		mConnectorLabelsFont.bgcolor = this.params.fillColor;
		mConnectorLabelsFont.align = "center";
		mConnectorLabelsFont.valign = "middle";
		//Over-ride
		this.styleM.overrideStyle (this.objects.MARKERCONNECTORS, mConnectorLabelsFont, this.styleM.TYPE.FONT, null);
		delete mConnectorLabelsFont;
		//-----------------------------------------------------------------//
		//Default font object for ToolTip
		//-----------------------------------------------------------------//
		var toolTipFont = new StyleObject ();
		toolTipFont.name = "_SdToolTipFont";
		toolTipFont.font = this.params.baseFont;
		toolTipFont.size = this.params.baseFontSize;
		toolTipFont.color = this.params.baseFontColor;
		toolTipFont.bgcolor = this.params.toolTipBgColor;
		toolTipFont.bordercolor = this.params.toolTipBorderColor;
		//Over-ride
		this.styleM.overrideStyle (this.objects.TOOLTIP, toolTipFont, this.styleM.TYPE.FONT, null);
		delete toolTipFont;
		//-----------------------------------------------------------------//
		//Default font object for Legend
		//-----------------------------------------------------------------//
		var legendFont = new StyleObject ();
		legendFont.name = "_SdLegendFont";
		legendFont.font = this.params.baseFont;
		legendFont.size = this.params.baseFontSize;
		legendFont.color = this.params.baseFontColor;
		legendFont.ishtml = 1;
		legendFont.leftmargin = 3;
		//Over-ride
		this.styleM.overrideStyle (this.objects.LEGEND, legendFont, this.styleM.TYPE.FONT, null);
		delete legendFont;
		//-----------------------------------------------------------------//
		//Default Effect (Shadow) object for DataPlot
		//-----------------------------------------------------------------//
		if (this.params.showShadow)
		{
			var plotShadow = new StyleObject ();
			plotShadow.name = "_SdPlotShadow";
			plotShadow.alpha = 80;
			//Over-ride
			this.styleM.overrideStyle (this.objects.PLOT, plotShadow, this.styleM.TYPE.SHADOW, null);
			delete plotShadow;
		}
		//-----------------------------------------------------------------//
		//Default Effect (Bevel) object for DataPlot
		//-----------------------------------------------------------------//
		if (this.params.showBevel)
		{
			var plotBevel = new StyleObject ();
			plotBevel.name = "_SdPlotBevel";
			plotBevel.distance = 8;
			//Over-ride
			this.styleM.overrideStyle (this.objects.PLOT, plotBevel, this.styleM.TYPE.BEVEL, null);
			delete plotBevel;
		}
		//-----------------------------------------------------------------//
		//Default Effect (Shadow) object for Legend
		//-----------------------------------------------------------------//
		if (this.params.legendShadow)
		{
			var legendShadow = new StyleObject ();
			legendShadow.name = "_SdLegendShadow";
			legendShadow.distance = 2;
			legendShadow.alpha = 90;
			//Over-ride
			this.styleM.overrideStyle (this.objects.LEGEND, legendShadow, this.styleM.TYPE.SHADOW, null);
			delete legendShadow;
		}
		//-----------------------------------------------------------------//
		//Default Animation object for DataPlot (if required)
		//-----------------------------------------------------------------//
		if (this.params.defaultAnimation)
		{
			var plotAnim = new StyleObject ();
			plotAnim.name = "_SdPlotAnim";
			plotAnim.param = "_alpha";
			plotAnim.easing = "regular";
			plotAnim.wait = 0;
			plotAnim.start = 0;
			plotAnim.duration = 1;
			//Over-ride
			this.styleM.overrideStyle (this.objects.PLOT, plotAnim, this.styleM.TYPE.ANIMATION, "_alpha");
			delete plotAnim;
		}
	}
	/**
	* setToolTipParam method sets the parameter for tool tip.
	*/
	private function setToolTipParam ()
	{
		//Get the style object for tool tip
		var tTipStyleObj : Object = this.styleM.getTextStyle (this.objects.TOOLTIP);
		this.tTip.setParams (tTipStyleObj.font, tTipStyleObj.size, tTipStyleObj.color, tTipStyleObj.bgColor, tTipStyleObj.borderColor, tTipStyleObj.isHTML, false);
	}
	/**
	* calculate method calculates the various points on the map.
	*/
	private function calculate ()
	{
		//Loop variable
		var i : Number;
		//Always keep to a decimal precision of minimum 2 if the number
		//scale is defined, as we've just checked for decimal precision of numbers
		//and not the numbers against number scale. So, even if they do not need yield a
		//decimal, we keep 2, as we do not force decimals on numbers.
		if (this.config.numberScaleDefined == true)
		{
			maxDecimals = (maxDecimals > 2) ? maxDecimals : 2;
		}
		//Get proper value for decimals
		this.params.decimals = Number (getFV (this.params.decimals, maxDecimals));
		//Decimal Precision cannot be less than 0 - so adjust it
		if (this.params.decimals < 0)
		{
			this.params.decimals = 0;
		}
		//Format all the numbers on the map and store their display values
		//We format and store here itself, so that later, whenever needed,
		//we just access displayValue instead of formatting once again.
		var displayValue : String;
		var toolText : String
		for (i = 1; i <= this.tNum; i ++)
		{
			//Store the formatted value for the entity - if value is not undefined or NaN
			if (this.entity [i].value == undefined || isNaN (this.entity [i].value))
			{
				this.entity [i].formattedValue = "";
			} else 
			{
				this.entity [i].formattedValue = formatNumber (this.entity [i].value, this.params.formatNumber, this.params.decimals, this.params.forceDecimals, this.params.formatNumberScale, this.params.defaultNumberScale, this.config.nsv, this.config.nsu, this.params.numberPrefix, this.params.numberSuffix);
			}
			//Define the displayValue if not already defined
			if (this.entity [i].displayValue == undefined || this.entity [i].displayValue == "")
			{
				displayValue = "";
				//If labels are to be included
				if (this.params.includeNameInLabels)
				{
					displayValue = displayValue + ((this.params.useSNameInLabels) ? (this.entity [i].sName) : (this.entity [i].lName));
					//If values are to be shown, add the separator character
					if (this.params.includeValueInLabels && this.entity [i].formattedValue != "")
					{
						displayValue = displayValue + this.params.labelSepChar;
					}
				}
				if (this.params.includeValueInLabels && this.entity [i].formattedValue != "")
				{
					//Add formatted label
					displayValue = displayValue + this.entity [i].formattedValue;
				}
				//Set displayValue
				this.entity [i].displayValue = displayValue;
			}
			//Prepare the tool text - if the tool tip text is not already defined
			if (this.entity [i].toolText == undefined || this.entity [i].toolText == "")
			{
				toolText = (this.params.useSNameInToolTip) ? (this.entity [i].sName) : (this.entity [i].lName);
				if (this.entity [i].formattedValue != "")
				{
					toolText = toolText + this.params.toolTipSepChar + this.entity [i].formattedValue;
				}
				this.entity [i].toolText = toolText;
			}
		}
		//Alter showLegend if no color range has been defined
		if (this.numCR == 0)
		{
			this.params.showLegend = false;
		}
		//Set the displayValue for color ranges
		for (i = 1; i <= this.numCR; i ++)
		{
			if (this.colorRange [i].displayValue == "" || this.colorRange [i].displayValue == undefined)
			{
				//Create the value
				displayValue = formatNumber (this.colorRange [i].minValue, this.params.formatNumber, this.params.decimals, this.params.forceDecimals, this.params.formatNumberScale, this.params.defaultNumberScale, this.config.nsv, this.config.nsu, this.params.numberPrefix, this.params.numberSuffix) + " - " + formatNumber (this.colorRange [i].maxValue, this.params.formatNumber, this.params.decimals, this.params.forceDecimals, this.params.formatNumberScale, this.params.defaultNumberScale, this.config.nsv, this.config.nsu, this.params.numberPrefix, this.params.numberSuffix);
				//Assing it
				this.colorRange [i].displayValue = displayValue;
			}
		}
		//For each entity, get the color and alpha based on its value
		for (i = 1; i <= this.tNum; i ++)
		{
			this.entity [i].color = formatColor (getFV (this.entity [i].color, getColorFromRange (this.entity [i].value)));
			this.entity [i].alpha = getFN (this.entity [i].alpha, getAlphaFromRange (this.entity [i].value));
		}
		//Now, we'll check the size of the map and adjust the margins
		//By Canvas, we mean the area covered by just the core map.
		//Initialize canvasHeight to total height minus margins
		var canvasHeight : Number = this.height - (this.params.mapTopMargin + this.params.mapBottomMargin);
		//Set canvasStartY
		var canvasStartY : Number = this.params.mapTopMargin;
		//Initialize Canvas Width
		var canvasWidth : Number = this.width - (this.params.mapLeftMargin + this.params.mapRightMargin);
		//Set canvas startX
		var canvasStartX : Number = this.params.mapLeftMargin;
		//We now check whether the legend is to be drawn
		if (this.params.showLegend)
		{
			//Object to store dimensions
			var lgndDim : Object;
			//Create container movie clip for legend
			this.lgndMC = this.mapMC.createEmptyMovieClip ("Legend", this.dm.getDepth ("LEGEND"));
			//Create instance of legend
			if (this.params.legendPosition == "BOTTOM")
			{
				//Maximum Height - 50% of stage
				lgnd = new Legend (lgndMC, this.styleM.getTextStyle (this.objects.LEGEND) , false, this.params.legendPosition, canvasStartX + canvasWidth / 2, this.height / 2, canvasWidth, (this.height - (this.params.mapTopMargin + this.params.mapBottomMargin)) * 0.5, this.params.legendAllowDrag, this.width, this.height, this.params.legendBgColor, this.params.legendBgAlpha, this.params.legendBorderColor, this.params.legendBorderThickness, this.params.legendBorderAlpha, this.params.legendScrollBgColor, this.params.legendScrollBarColor, this.params.legendScrollBtnColor);
			} 
			else 
			{
				//Maximum Width - 40% of stage
				lgnd = new Legend (lgndMC, this.styleM.getTextStyle (this.objects.LEGEND) , false, this.params.legendPosition, this.width / 2, canvasStartY + canvasHeight / 2, (this.width - (this.params.mapLeftMargin + this.params.mapRightMargin)) * 0.4, canvasHeight, this.params.legendAllowDrag, this.width, this.height, this.params.legendBgColor, this.params.legendBgAlpha, this.params.legendBorderColor, this.params.legendBorderThickness, this.params.legendBorderAlpha, this.params.legendScrollBgColor, this.params.legendScrollBarColor, this.params.legendScrollBtnColor);
			}
			//If user has defined a caption for the legend, set it
			if (this.params.legendCaption!=""){
				lgnd.setCaption(this.params.legendCaption);
			}
			//Whether to use circular marker
			lgnd.useCircleMarker(this.params.legendMarkerCircle);
			//Feed data set series Name for legend
			for (i = 1; i <= this.numCR; i ++)
			{
				lgnd.addItem (this.colorRange [i].displayValue, this.colorRange [i].color, i);
			}
			if (this.params.legendPosition == "BOTTOM")
			{
				lgndDim = lgnd.getDimensions ();
				//Store legend height
				this.config.legendHeight = lgndDim.height + this.params.legendPadding;
				//Now deduct the height from the calculated canvas height
				canvasHeight = canvasHeight - lgndDim.height - this.params.legendPadding;
				//Re-set the legend position
				this.lgnd.resetXY (canvasStartX + canvasWidth / 2, this.height - this.params.mapBottomMargin - lgndDim.height / 2);
			}
			else
			{
				//Get dimensions
				lgndDim = lgnd.getDimensions ();
				//Store legend height
				this.config.legendHeight = 0;
				//Now deduct the width from the calculated canvas width
				canvasWidth = canvasWidth - lgndDim.width - this.params.legendPadding;
				//Right position
				this.lgnd.resetXY (this.width - this.params.mapRightMargin - lgndDim.width / 2, canvasStartY + canvasHeight / 2);
			}
		}
		//Store the parameters in config
		this.config.canvasStartX = canvasStartX;
		this.config.canvasStartY = canvasStartY;
		this.config.canvasWidth = canvasWidth;
		this.config.canvasHeight = canvasHeight;
	}
	// -------------------- UTILITY METHODS --------------------//
	/**
	* getAttributesArray method helps convert the list of attributes
	* for an XML node into an array.
	* Reason:
	* Starting ActionScript 2, the parsing of XML attributes have also
	* become case-sensitive. However, prior versions of FusionMaps
	* supported case-insensitive attributes. So we need to parse all
	* attributes as case-insensitive to maintain backward compatibility.
	* To do so, we first extract all attributes from XML, convert it into
	* lower case and then store it in an array. Later, we extract value from
	* this array.
	* Once this array is returned, IT'S VERY NECESSARY IN THE CALLING CODE TO
	* REFERENCE THE NAME OF ATTRIBUTE IN LOWER CASE (STORED IN THIS ARRAY).
	* ELSE, UNDEFINED VALUE WOULD SHOW UP.
	*	@param	xmlNd	XML Node for which we've to get the attributes.
	*	@return		An associative array containing the attributes. The name
	*					of attribute (in all lower case) is the key and attribute value
	*					is value.
	*/
	private function getAttributesArray (xmlNd : XMLNode) : Array
	{
		//Array that will store the attributes
		var	atts : Array = new Array ();
		//Object used to iterate through the attributes collection
		var obj : Object;
		//Iterate through each attribute in the attributes collection,
		//convert to lower case and store it in array.
		for (obj in xmlNd.attributes)
		{
			//Store it in array
			atts [obj.toString ().toLowerCase ()] = xmlNd.attributes [obj];
		}
		//Return the array
		return atts;
	}
	/**
	* returnDataAsEntity method returns the data passed to this
	* method as an Entity Object. We store each map entity as an
	* obejct to unify the various properties.
	*	@param	id		String identifier for the entity
	*	@param	mcName	Instance name of the movie clip representing the entity
	*					on the map
	*	@param	sName	Short Name for entity (Abbreviations)
	*	@param	lName	Long Name for entity (Full Name)
	*	@return		Object representing the entity
	*/
	private function returnDataAsEntity (id : String, mcName : String, sName : String, lName : String) : Object
	{
		//Create new object
		var entity : Object = new Object ();
		//Store parameters
		entity.id = id;
		entity.mc = mcName;
		entity.sName = sName;
		entity.lName = lName;
		//Value
		entity.value = undefined;
		//Display value
		entity.displayValue = "";
		//Cosmetic properties of entity
		entity.color = "";
		entity.alpha = 100;
		//Return
		return entity;
	}
	/**
	* returnDataAsColorRange method returns the data passed to this
	* method as a color range Object. We store each color range as an
	* obejct to unify the various properties.
	*	@param	minValue		Lower limit of the range.
	*	@param	maxValue		Upper limit of the range.
	*	@param	displayValue	Display value for the color range
	*	@param	color			Color for this range
	*	@param	alpha			Fill Alpha for this color range.
	*	@return		Object representing the color range
	*/
	private function returnDataAsColorRange (minValue : Number, maxValue : Number, displayValue : String, color : String, alpha : Number) : Object
	{
		//Create new object
		var crObj : Object = new Object ();
		//Store parameters
		crObj.minValue = minValue;
		crObj.maxValue = maxValue;
		crObj.displayValue = displayValue;
		crObj.color = color;
		crObj.alpha = alpha;
		//Return
		return crObj;
	}
	/**
	 * returnDataAsMarkerDef method returns the data passed to it
	 * as a marker definition object.
	*/
	private function returnDataAsMarkerDef(x:Number, y:Number, id:String, label:String, labelPos:String){
		var mrObj:Object = new Object();
		mrObj.x = x;
		mrObj.y = y;
		mrObj.id = StringExt.removeSpaces(id);
		mrObj.label = label;
		mrObj.labelPos = labelPos;
		//Return
		return mrObj;
	}
	/**
	* toBoolean method converts numeric form (1,0) to Flash
	* boolean.
	*	@param	num		Number (0,1)
	*	@return		Boolean value based on above number
	*/
	private function toBoolean (num : Number) : Boolean
	{
		return ((num == 1) ? (true) : (false));
	}
	/**
	* invokeLink method invokes a link for any defined drill down item.
	* A link in XML needs to be URL Encoded. Also, there are a few prefixes,
	* parameters that can be added to link so as to defined target link
	* opener object. For e.g., a link can open in same window, new window,
	* frame, pop-up window. Or, a link can invoke a JavaScript method.
	* Prefixes can be N - new window, F - Frame, P - Pop up
	*	@param	strLink	Link to be invoked.
	*/
	private function invokeLink (strLink : String) : Void
	{
		//We continue only if the link is not empty
		if (strLink != undefined && strLink != null && strLink != "")
		{
			//Unescape the link - as it might be URL Encoded
			strLink = unescape (strLink);
			//Now, if the map has been loaded as a flex or laszlo, then we need to handle differently
			if (parentMC._loadModeExternal){
				var dataObj:Object = new Object();
				//Create a data object containing details
				dataObj.id = this.DOMId;
				dataObj.link =  strLink;
				//Dispatch event via FlashInterface
				FlashInterface.dispatchEvent({type:'linkClicked', data:dataObj});
			}else{
				//Now based on what the first character in the link is (N, F, P)
				//we invoke the link.
				if (strLink.charAt (0).toUpperCase () == "N" && strLink.charAt (1) == "-")
				{
					//Means we have to open the link in a new window.
					getURL (strLink.slice (2) , "_blank");
				} else if (strLink.charAt (0).toUpperCase () == "F" && strLink.charAt (1) == "-")
				{
					//Means we have to open the link in a frame.
					var dashPos : Number = strLink.indexOf ("-", 2);
					//strLink.slice(dashPos+1) indicates link
					//strLink.substr(2, dashPos-2) indicates frame name
					getURL (strLink.slice (dashPos + 1) , strLink.substr (2, dashPos - 2));
				} else if (strLink.charAt (0).toUpperCase () == "P" && strLink.charAt (1) == "-")
				{
					//Means we have to open the link in a pop-up window.
					var dashPos : Number = strLink.indexOf ("-", 2);
					var commaPos : Number = strLink.indexOf (",", 2);
					getURL ("javaScript:var " + strLink.substr (2, commaPos - 2) + " = window.open('" + strLink.slice (dashPos + 1) + "','" + strLink.substr (2, commaPos - 2) + "','" + strLink.substr (commaPos + 1, dashPos - commaPos - 1) + "'); " + strLink.substr (2, commaPos - 2) + ".focus(); void(0);");
				}  else if (strLink.charAt (0).toUpperCase () == "J" && strLink.charAt (1) == "-")
				{
					//We can operate JS link only if ExternalInterface is available and the chart 
					//has been registered
					if (this.registerWithJS==true &&  ExternalInterface.available){
						//Means we have to open the link as JavaScript
						var dashPos : Number = strLink.indexOf ("-", 2);
						//strLink.slice(dashPos+1) indicates arguments if any
						//strLink.substr(2, dashPos-2) indicates link
						//If no arguments, just call the link
						if (dashPos==-1){
							ExternalInterface.call(strLink.substr(2, strLink.length-2));
						}else{
							ExternalInterface.call(strLink.substr(2, dashPos-2), strLink.slice(dashPos+1));
						}
					}
				} else if (strLink.charAt (0).toUpperCase () == "S" && strLink.charAt (1) == "-")
				{
					//Means we have to convey the link as a event to parent Flash movie
					this.dispatchEvent({type:"linkClicked", target:this, link:strLink.slice (2)});				
				} else 
				{
					//Open the link in same window
					getURL (strLink, "_self");
				}
			}
		}
	}
	/**
	* renderAppMessage method helps display an application message to
	* end user.
	* @param	strMessage	Message to be displayed
	* @return				Reference to the text field created
	*/
	private function renderAppMessage (strMessage : String) : TextField 
	{
		return _global.createBasicText (strMessage, this.parentMC, depth, (this.width / 2) , (this.height / 2) , "Verdana", 10, "666666", "center", "bottom");
	}
	/**
	* removeAppMessage method removes the displayed application message
	* @param	tf	Text Field reference to the message
	*/
	private function removeAppMessage (tf : TextField)
	{
		tf.removeTextField ();
	}
	// --------------------- VISUAL RENDERING METHODS ------------------//
	/**
	* drawBackground method renders the map background. The background
	* cant be solid color or gradient. All maps have a backround. So, we've
	* defined drawBackground in map class itself, so that sub classes can
	* directly access it (as it's common).
	*	@return		Nothing
	*/
	private function drawBackground () : Void
	{
		//Create a new movie clip container for background
		var bgMC = this.mapMC.createEmptyMovieClip ("Background", this.dm.getDepth ("BACKGROUND"));
		//Parse the color, alpha and ratio array
		var bgColor : Array = ColorExt.parseColorList (this.params.bgColor);
		var bgAlpha : Array = ColorExt.parseAlphaList (this.params.bgAlpha, bgColor.length);
		var bgRatio : Array = ColorExt.parseRatioList (this.params.bgRatio, bgColor.length);
		//Move to (-w/2, 0); - 0,0 registration point at center (x,y)
		bgMC.moveTo ( - (this.width / 2) , - (this.height / 2));
		//Create matrix object
		var matrix : Object = {
			matrixType : "box", w : this.width, h : this.height, x : - (this.width / 2) , y : - (this.height / 2) , r : MathExt.toRadians (this.params.bgAngle)
		};
		//If border is to be shown
		if (this.params.showCanvasBorder)
		{
			bgMC.lineStyle (this.params.canvasBorderThickness, parseInt (this.params.canvasBorderColor, 16) , this.params.canvasBorderAlpha);
		}
		//Border thickness half
		var bth : Number = this.params.canvasBorderThickness / 2;
		//Start the fill.
		bgMC.beginGradientFill ("linear", bgColor, bgAlpha, bgRatio, matrix);
		//Draw the rectangle with center registration point
		bgMC.lineTo (this.width / 2 - bth, - (this.height / 2) + bth);
		bgMC.lineTo (this.width / 2 - bth, this.height / 2 - bth);
		bgMC.lineTo ( - (this.width / 2) + bth, this.height / 2 - bth);
		bgMC.lineTo ( - (this.width / 2) + bth, - (this.height / 2) + bth);
		//Set the x and y position
		bgMC._x = this.width / 2;
		bgMC._y = this.height / 2;
		//End Fill
		bgMC.endFill ();
		//Apply animation
		if (this.params.animation)
		{
			this.styleM.applyAnimation (bgMC, this.objects.BACKGROUND, bgMC._x - this.width / 2, bgMC._y - this.height / 2, 100, 100, 100, null);
		}
		//Apply filters
		this.styleM.applyFilters (bgMC, this.objects.BACKGROUND);		
	}
	/**
	* loadBgSWF method loads the background .swf file (if required)
	*/
	private function loadBgSWF () : Void
	{
		if (this.params.bgSWF != "")
		{
			if (this.params.bgSWF.indexOf(":")==-1 && this.params.bgSWF.indexOf("%3A")==-1){
				//Create a movie clip container
				var bgSWFMC : MovieClip = this.mapMC.createEmptyMovieClip ("BgSWF", this.dm.getDepth ("BGSWF"));
				//Load the clip
				bgSWFMC.loadMovie (this.params.bgSWF);
				//Set alpha
				bgSWFMC._alpha = this.params.bgSWFAlpha;
			}else{
				this.log ("bgSWF not loaded", "The bgSWF path contains special characters like colon, which can be potentially dangerous in XSS attacks. As such, FusionMaps has not loaded the bgSWF. If you've specified the absolute path for bgSWF URL, we recommend specifying relative path under the same domain.", Logger.LEVEL.ERROR);
			}
		}
	}
	/**
	* drawClickURLHandler method draws the rectangle over the map
	* that responds to click URLs. It draws only if clickURL has been
	* defined for the map.
	*/
	private function drawClickURLHandler () : Void
	{
		//Check if it needs to be created
		if (this.params.clickURL != "")
		{
			//Create a new movie clip container for background
			var clickMC = this.mapMC.createEmptyMovieClip ("ClickURLHandler", this.dm.getDepth ("CLICKURLHANDLER"));
			clickMC.moveTo (0, 0);
			//Set fill with 0 alpha
			clickMC.beginFill (0xffffff, 0);
			//Draw the rectangle
			clickMC.lineTo (this.width, 0);
			clickMC.lineTo (this.width, this.height);
			clickMC.lineTo (0, this.height);
			clickMC.lineTo (0, 0);
			//End Fill
			clickMC.endFill ();
			clickMC.useHandCursor = true;
			//Set click handler
			var strLink : String = this.params.clickURL;
			var thisMapRef : Map = this;
			clickMC.onMouseDown = function ()
			{
				thisMapRef.invokeLink (strLink);
			}
			clickMC.onRollOver = function ()
			{
				//Empty function just to show hand cursor				
			}
		}
	}
	/**
	* renderMap method renders the map and colors entities.
	*/
	private function renderMap () : Void
	{
		var depth : Number = this.dm.getDepth ("PLOT");
		//Attached the movie clip with identifier name stored in this.config.mapId
		actualMapMC = this.mapMC.attachMovie (this.config.mapId, "Map", depth);
		//Set the x and y position
		actualMapMC._x = this.config.canvasStartX;
		actualMapMC._y = this.config.canvasStartY;
		//Get the new scales
		var newXScale : Number = (this.config.canvasWidth / actualMapMC._width) * 100;
		var newYScale : Number = (this.config.canvasHeight / actualMapMC._height) * 100;
		//Scale the map - minimum
		actualMapMC._xscale = actualMapMC._yscale = Math.min (newXScale, newYScale);				
		//Center it (if scale has changed).
		if (newXScale != 100 || newYScale != 100)
		{
			actualMapMC._x += (this.config.canvasWidth - actualMapMC._width) / 2;
			actualMapMC._y += (this.config.canvasHeight - actualMapMC._height) / 2;
		}	
		// ----------- Set the cosmetic properties now ------------- //
		//Set the border color of map
		var clrBorder : Color = new Color (actualMapMC.Border);
		clrBorder.setRGB (parseInt (this.params.borderColor, 16));
		//Set the border alpha
		actualMapMC.Border._alpha = this.params.borderAlpha;
		//Set the canvas border (visible only in choose mode) to red
		var chooseBrdColor:Color = new Color(actualMapMC.CanvasBorder);
		chooseBrdColor.setRGB(0xFF0000);
		//Set the color and alpha of label connector lines if it's to be shown
		if (this.params.showLabels){
			var clrCntr : Color = new Color (actualMapMC.Connectors);
			clrCntr.setRGB (parseInt (this.params.connectorColor, 16));
			//Set the border alpha
			actualMapMC.Connectors._alpha = this.params.connectorAlpha;
		}else{
			//Hide the connectors
			actualMapMC.Connectors._visible = false;
		}
		//Now color, the map entities
		var i : Number;
		var mcName : String;
		var entityMC : MovieClip;
		var clrEntity : Color;
		//Function storage containers for Delegate functions
		var fnRollOver : Function, fnRollOut : Function, fnClick : Function;
		for (i = 1; i <= this.tNum; i ++)
		{
			//Get the name of movie clip
			mcName = this.entity [i].mc;
			entityMC = actualMapMC [mcName];
			//Color it
			clrEntity = new Color (entityMC);
			clrEntity.setRGB (parseInt (this.entity [i].color, 16));
			//Set alpha
			entityMC._alpha = this.entity [i].alpha;
			// -------------- Set Event Handlers ------------- //
			//We set the roll over events only if we have to hover on empty
			//or data value is defined
			if (this.params.hoverOnEmpty || (this.entity[i].value!=undefined && isNaN(this.entity[i].value)==false)){
				//Create Delegate for roll over function mapOnRollOver
				fnRollOver = Delegate.create (this, mapOnRollOver);
				//Set the index
				fnRollOver.index = i;
				//Roll Out Delegate
				fnRollOut = Delegate.create (this, mapOnRollOut);
				fnRollOut.index = i;
				//Assing the delegates to movie clip handler
				entityMC.onRollOver = fnRollOver;
				//Set roll out and mouse move too.
				entityMC.onRollOut = entityMC.onReleaseOutside = fnRollOut;
				entityMC.onMouseMove = Delegate.create (this, mapOnMouseMove);
			}
			//Click handler for entities - only if link for this entity has been defined and click URL
			//has not been defined.
			if (this.entity [i].link != "" && this.entity [i].link != undefined && this.params.clickURL == "")
			{
				//Create delegate function
				fnClick = Delegate.create (this, mapOnClick);
				//Set index
				fnClick.index = i;
				//Assign
				entityMC.onRelease = fnClick;
			}
			else
			{
				//Do not use hand cursor
				entityMC.useHandCursor = (this.params.clickURL == "") ?false : true;
			}
		}
		//Apply animation
		if (this.params.animation)
		{
			this.styleM.applyAnimation (actualMapMC, this.objects.PLOT, actualMapMC._x, actualMapMC._y, 100, actualMapMC._xscale, actualMapMC._xscale, null);
		}
		//Apply filters
		this.styleM.applyFilters (actualMapMC, this.objects.PLOT);
		//Clear Interval
		clearInterval (this.config.intervals.plot);
	}
	/**
	 * renderMarkers method draws the markers on the map.
	*/
	private function renderMarkers():Void{
		//Iterate through all the markers and render them.
		var i:Number = 0;
		//Starting depth
		var depth:Number = this.dm.getDepth("MARKERS");
		//Function storage containers for Delegate functions
		var fnRollOver : Function, fnRollOut : Function, fnClick : Function;
		for (i=1; i<=this.numMarkerData; i++){
			//We need to calculate the x and y positions for the marker
			var x:Number = this.markerDef[this.markerData[i].id].x;
			var y:Number = this.markerDef[this.markerData[i].id].y;
			//Adjust according to scaled movie
			x = actualMapMC._x + (x * (actualMapMC._xscale/100));
			y = actualMapMC._y + (y * (actualMapMC._yscale/100));
			//Create a movie clip for the marker
			var mc:MovieClip = this.mapMC.createEmptyMovieClip("Marker_"+i,depth);
			//Create an instance of MarkerShape
			var shape:MarkerShape = new MarkerShape(mc, x, y, this.markerShape[this.markerData[i].shapeId], this.markerData[i].scale);			
			shape.draw();
			
			// -------------- Set Event Handlers ------------- //
			//Create Delegate for roll over function markerOnRollOver
			fnRollOver = Delegate.create (this, markerOnRollOver);
			//Set the index
			fnRollOver.index = i;
			//Roll Out Delegate
			fnRollOut = Delegate.create (this, markerOnRollOut);			
			//Assing the delegates to movie clip handler
			mc.onRollOver = fnRollOver;
			//Set roll out and mouse move too.
			mc.onRollOut = mc.onReleaseOutside = fnRollOut;
			//Click handler for markers - only if link for this marker has been defined and click URL
			//has not been defined.
			if (this.markerData[i].link != "" && this.markerData[i].link != undefined && this.params.clickURL == "")
			{
				//Create delegate function
				fnClick = Delegate.create (this, markerOnClick);
				//Set index
				fnClick.index = i;
				//Assign
				mc.onRelease = fnClick;
			}
			else
			{
				//Do not use hand cursor
				mc.useHandCursor = (this.params.clickURL == "") ?false : true;
			}
			//Apply animation
			if (this.params.animation)
			{
				this.styleM.applyAnimation (mc, this.objects.MARKERS, x, y, 100, this.markerShape[this.markerData[i].shapeId].xScale, this.markerShape[this.markerData[i].shapeId].yScale, null);
			}
			//Apply filters
			this.styleM.applyFilters (mc, this.objects.MARKERS);
		
			//Increase depth
			depth++;
		}			 
		//Clear the interval
		clearInterval(this.config.intervals.markers);
	}
	/**
	* drawLabels method draws the labels on the map.
	*/
	private function drawLabels () : Void
	{
		var i : Number;
		var x : Number;
		var y : Number;
		var point : Object;
		var entityMC : MovieClip;			
		//Depth
		var depth : Number = this.dm.getDepth ("LABELS");
		//Iterate through all entities
		for (i = 1; i <= this.tNum; i ++)
		{
			//If displayValue is not empty and we've to show the label
			if ((this.entity [i].displayValue != "") && (this.params.showLabels==true && this.entity [i].showLabel!=false))
			{				
				//Get reference to entity MC
				entityMC = actualMapMC [this.entity [i].mc];
				//Calculate the local to global for entire map movie clip w.r.t parent movie clip
				var pointAMC = new Object();
				pointAMC.x = actualMapMC._x;
				pointAMC.y = actualMapMC._y;					
				//Convert it from local to global
				this.parentMC.localToGlobal (pointAMC);				
				//Get the X and Y of entity in Point Object
				point = new Object ();				
				//Calculate the global position of labels w.r.t their position
				//inside the map movie clip and displacement of map movie.
				point.x = this.x + actualMapMC._x + (entityMC._x * (actualMapMC._xscale/100));
				point.y = this.y + actualMapMC._y + (entityMC._y * (actualMapMC._yscale/100));
				//actualMapMC.localToGlobal (point);
				//Get the style object
				var labelStyleObj : Object = this.styleM.getTextStyle (this.objects.LABELS);
				//Over-ride with local properties (if defined)
				if (this.entity [i].font!=undefined && this.entity [i].font!=null && this.entity [i].font!=""){
					labelStyleObj.font = this.entity [i].font;
				}
				if (this.entity [i].fontSize!=undefined && this.entity [i].fontSize!=null && this.entity [i].fontSize!=""){
					labelStyleObj.size = Number(this.entity [i].fontSize);
				}
				if (this.entity [i].fontColor!=undefined && this.entity [i].fontColor!=null && this.entity [i].fontColor!=""){
					labelStyleObj.color = this.entity [i].fontColor;
				}
				if (this.entity [i].fontBold!=undefined && this.entity [i].fontBold!=null && this.entity [i].fontBold!=""){
					labelStyleObj.bold = toBoolean(Number(this.entity [i].fontBold));
				}
				//Draw the text at the new location
				var entityTxt : Object = createText (false, this.entity [i].displayValue, this.mapMC, depth, point.x - this.x, point.y - this.y, 0, labelStyleObj, false, 0, 0);
				//Apply filter
				this.styleM.applyFilters (entityTxt.tf, this.objects.LABELS);
				//Apply animation
				if (this.params.animation)
				{
					this.styleM.applyAnimation (entityTxt.tf, this.objects.LABELS, entityTxt.tf._x, entityTxt.tf._y, 100, null, null, null);
				}
				//Increment depth
				depth ++;
			}
		}
		//Clear interval
		clearInterval (this.config.intervals.labels);
	}
	/**
	 * renderMarkerLabels method draws the marker labels on the map.
	*/
	private function renderMarkerLabels(){
		//Only, if we've to show marker labels
		if (this.numMarkerData>0 & this.params.showMarkerLabels==true){
			//Iterate through all the markers and render them.
			var i:Number = 0;
			//Starting depth
			var depth:Number = this.dm.getDepth("MARKERLABELS");
			//Style for maker
			var labelStyleObj : Object = this.styleM.getTextStyle(this.objects.MARKERLABELS);
			for (i=1; i<=this.numMarkerData; i++){
				if (this.markerData[i].label!=""){
					//We need to calculate the x and y positions for the marker
					var x:Number = this.markerDef[this.markerData[i].id].x;
					var y:Number = this.markerDef[this.markerData[i].id].y;
					//Shifts due to padding & radius
					var xShift:Number=0;
					var yShift:Number=0;
					//Adjust according to scaled movie
					x = actualMapMC._x + (x * (actualMapMC._xscale/100));
					y = actualMapMC._y + (y * (actualMapMC._yscale/100));
					//Add the padding to x, if marker labelPos is left,right				
					if (this.markerData[i].labelPos=="left" || this.markerData[i].labelPos=="right"){
						xShift = this.markerShape[this.markerData[i].shapeId].labelPadding;
					}else if (this.markerData[i].labelPos=="top" || this.markerData[i].labelPos=="bottom"){
						yShift = this.markerShape[this.markerData[i].shapeId].labelPadding;
					}				
					//If the marker is a circle, arc or polygon, we need to take its radius into 
					//consideration for placing the labels. We do not add anything for image, as we leave
					//that for the user to control using labelPadding				
					if (this.markerShape[this.markerData[i].shapeId].type=="circle" || this.markerShape[this.markerData[i].shapeId].type=="arc" || this.markerShape[this.markerData[i].shapeId].type=="polygon"){
						xShift += this.markerShape[this.markerData[i].shapeId].radius * this.markerData[i].scale;
						yShift += this.markerShape[this.markerData[i].shapeId].radius * this.markerData[i].scale;
					}
					//Alignment positions
					var align:String, vAlign:String;
					//Decide x, y, alignment positions based on label position
					switch(this.markerData[i].labelPos){
						case "left":
							align = "right";
							x = x - xShift;
							break;
						case "right":
							align = "left";
							x = x + xShift;
							break;
						default:
							//Center align
							align = "center";
							break;
					}
					switch(this.markerData[i].labelPos){
						case "top":
							vAlign = "top";
							y = y-yShift;
							break;
						case "bottom":
							y = y+yShift;
							vAlign = "bottom";
							break;
						default:
							//Center align
							vAlign = "middle";
							break;
					}
					//Update the style object with alignment properties
					labelStyleObj.align = align;
					labelStyleObj.vAlign = vAlign;
					//Create the text.				
					//Draw the text at the new location
					var markerTxt : Object = createText (false, this.markerData[i].label, this.mapMC, depth, x, y, 0, labelStyleObj, false, 0, 0);
					//Apply filter
					this.styleM.applyFilters (markerTxt.tf, this.objects.MARKERLABELS);
					//Apply animation
					if (this.params.animation)
					{
						this.styleM.applyAnimation (markerTxt.tf, this.objects.MARKERLABELS, markerTxt.tf._x, markerTxt.tf._y, 100, null, null, null);
					}
					//Increment depth
					depth ++;
				}
			}
		}
		//Clear interval
		clearInterval(this.config.intervals.markerLabels);
	}
	
	/**
	 * renderMarkerConnectors method draws the markers connectors on the map.
	*/
	private function renderMarkerConnectors():Void{
		//Continue, if there are any to draw at all
		if (this.numMarkerConnectors>0){
			//Iterate through all the markers and render them.
			var i:Number = 0;
			//Starting depth
			var depth:Number = this.dm.getDepth("MARKERCONNECTORS");
			//Get text style
			var markerStyle = this.styleM.getTextStyle(this.objects.MARKERCONNECTORS);
			//Function storage containers for Delegate functions
			var fnRollOver : Function, fnRollOut : Function, fnClick : Function;
			for (i=1; i<=this.numMarkerConnectors; i++){
				//We need to calculate the x and y positions for the marker
				var fromX:Number = this.markerDef[this.markerConnectors[i].from].x;
				var fromY:Number = this.markerDef[this.markerConnectors[i].from].y;
				var toX:Number = this.markerDef[this.markerConnectors[i].to].x;
				var toY:Number = this.markerDef[this.markerConnectors[i].to].y;
				//Adjust according to scaled movie
				fromX = actualMapMC._x + (fromX * (actualMapMC._xscale/100));
				fromY = actualMapMC._y + (fromY * (actualMapMC._yscale/100));
				toX = actualMapMC._x + (toX * (actualMapMC._xscale/100));
				toY = actualMapMC._y + (toY * (actualMapMC._yscale/100));
				//Min X and Min Y
				var minX:Number = Math.min(fromX,toX);
				var minY:Number = Math.min(fromY,toY);
				//Max X and Max Y
				var maxX:Number = Math.max(fromX,toX);
				var maxY:Number = Math.max(fromY,toY);
				//Center X and Center Y
				var centerX:Number = minX + (maxX-minX)/2;
				var centerY:Number = minY + (maxY-minY)/2;
				//X and Y Extensions
				var xExt:Number = (fromX-toX)/2;
				var yExt:Number = (fromY-toY)/2;
				//Create a movie clip for the marker connector
				var mc:MovieClip = this.mapMC.createEmptyMovieClip("MarkerConnector_"+i,depth);
				//Re-position movie clip - at center (for animation)
				mc._x = centerX;
				mc._y = centerY;
				//Set the line style
				mc.lineStyle(this.markerConnectors[i].thickness, parseInt(this.markerConnectors[i].color,16), this.markerConnectors[i].alpha);
				//Draw the line - whether its to be drawn as dashed or normal?
				if (this.markerConnectors[i].dashed){
					//Dashed line
					DrawingExt.dashTo(mc, -xExt,-yExt, xExt, yExt, this.markerConnectors[i].dashLen, this.markerConnectors[i].dashGap);
				}else{
					mc.moveTo(-xExt,-yExt);
					mc.lineTo(xExt, yExt);
				}				
				//Draw the label (if required)
				if (this.markerConnectors[i].label!=""){
					//Set the border color to that of existing marker connector
					markerStyle.borderColor = this.markerConnectors[i].color;
					var labelTxt:Object = createText (false, this.markerConnectors[i].label, mc, 2, 0, 0, 0, markerStyle, false, 0, 0);
				}
					
				// -------------- Set Event Handlers ------------- //
				if (this.params.showMarkerToolTip && this.markerConnectors[i].toolText!=""){
					//Create Delegate for roll over function markerOnRollOver
					fnRollOver = Delegate.create(this, markerConnectorOnRollOver);
					//Set the index
					fnRollOver.index = i;
					//Roll Out Delegate
					fnRollOut = Delegate.create(this, markerConnectorOnRollOut);			
					//Assing the delegates to movie clip handler
					mc.onRollOver = fnRollOver;
					//Set roll out and mouse move too.
					mc.onRollOut = mc.onReleaseOutside = fnRollOut;
				}
				//Click handler for markers - only if link for this marker has been defined and click URL
				//has not been defined.
				if (this.markerConnectors[i].link != "" && this.markerConnectors[i].link != undefined && this.params.clickURL == ""){
					//Create delegate function
					fnClick = Delegate.create (this, markerConnectorOnClick);
					//Set index
					fnClick.index = i;
					//Assign
					mc.onRelease = fnClick;
				} else {
					//Do not use hand cursor
					mc.useHandCursor = (this.params.clickURL == "") ?false : true;
				}
				//Apply animation
				if (this.params.animation){
					this.styleM.applyAnimation (mc, this.objects.MARKERCONNECTORS, null, null, 100, 100, 100, null);
				}
				//Apply filters
				this.styleM.applyFilters (mc, this.objects.MARKERCONNECTORS);
				//Increase depth
				depth++;
			}			 
		}
		//Clear the interval
		clearInterval(this.config.intervals.markerConnectors);
	}
	/**
	 * getEntityList method is used by External Interface to access the
	 * list of defined entities for this map. We simply return the entity
	 * array.
	*/
	private function getEntityList():Array{
		return this.entity;
	}
	/**
	 * enableChooseMode renders the map in co-ordinate choosing mode. 
	 * This method is to be called by ExternalInterface. Using the GUI and
	 * JS, the user can then visually select the points on map and create XML
	 * data out of those points.
	*/
	private function enableChooseMode():Void{
		//If External Interface is not available, we show an alert.		
		if (!ExternalInterface.available){
			getURL("javascript:alert('FusionMaps is unable to connect to JavaScript interface. As such, you would not be able to use the features provided by the GUI. Please check your Flash Player settings and enable the JavaScript interface to proceed.');");
		}else{
			//Show the rectangle around rectangle
			actualMapMC.CanvasBorder._alpha = 100;
			//Define the map as a hot spot for choosing co-ordinates
			this.mapMC.onPress = function(){
				var rtnValue = ExternalInterface.call("registerMarker",int((this._xmouse-this["Map"]._x)*(100/this["Map"]._xscale)*100)/100,int((this._ymouse-this["Map"]._y)*(100/this["Map"]._yscale)*100)/100);
			}
		}
	}
	/**
	 * disableChooseMode method disables the co-ordinates choosing mode and
	 * renders the map in normal mode.
	*/
	private function disableChooseMode():Void{
		//Set the alpha of rectangle back to 0
		actualMapMC.CanvasBorder._alpha = 0;
		delete this.mapMC.onPress;
	}
	/**
	* drawLegend method renders the legend
	*/
	private function drawLegend () : Void
	{
		if (this.params.showLegend)
		{
			this.lgnd.render ();
			//Apply filter
			this.styleM.applyFilters (lgndMC, this.objects.LEGEND);
			//Apply animation
			if (this.params.animation)
			{
				this.styleM.applyAnimation (lgndMC, this.objects.LEGEND, null, null, 100, null, null, null);
			}
		}
		//Clear interval
		clearInterval (this.config.intervals.legend);
	}
	/**
	* setContextMenu method sets the context menu for the map.
	* For this strMapObjects, the context items are "Print Map".
	*/
	private function setContextMenu () : Void 
	{
		var mapMenu : ContextMenu = new ContextMenu ();
		mapMenu.hideBuiltInItems ();
		if (this.params.showPrintMenuItem){
			//Create a print strMapObjects contenxt menu item
			var printCMI : ContextMenuItem = new ContextMenuItem ("Print Map", Delegate.create (this, printMap));
			//Push print item.
			mapMenu.customItems.push (printCMI);
		}
		if (this.params.imageSave){
			//Add the export to image option
			var saveCMI : ContextMenuItem = new ContextMenuItem ("Save as Image", Delegate.create (this, saveAsImage));
			saveCMI.separatorBefore = true;			
			mapMenu.customItems.push(saveCMI);		
		}
		if (this.params.showFCMenuItem){
			//Create a about context menu item
			var aboutCMI : ContextMenuItem = new ContextMenuItem ("About FusionMaps", Delegate.create (this, openAboutFusionMaps));
			aboutCMI.separatorBefore = true;
			mapMenu.customItems.push(aboutCMI);
		}
		//Assign the menu to mapMC movie clip
		this.mapMC.menu = mapMenu;
	}
	/**
	* printMap method prints the map.
	*/
	public function printMap () : Void
	{
		//Create a Print Job Instance
		var PrintQueue = new PrintJob ();
		//Show the Print box.
		var PrintStart : Boolean = PrintQueue.start ();
		//If User has selected Ok, set the parameters.
		if (PrintStart)
		{
			//Add the map MC to the print job with the required dimensions
			//If the map width/height is bigger than page width/height, we need to scale.
			if (this.width>PrintQueue.pageWidth || this.height>PrintQueue.pageHeight){				
				//Scale on the lower factor
				var factor:Number = Math.min((PrintQueue.pageWidth/this.width),(PrintQueue.pageHeight/this.height));
				//Scale the movie clip to fit paper size 
				this.mapMC._xScale = factor*100;
				this.mapMC._yScale = factor*100;
			}
			//Add the map to printer queue
			PrintQueue.addPage (this.mapMC, {xMin : 0, xMax : this.width, yMin : 0, yMax : this.height}, {printAsBitmap : true});
			//Send the page for printing
			PrintQueue.send ();
			//Re-scale back to normal form (as the printing is over).
			this.mapMC._xScale = this.mapMC._yScale = 100;
		}		
		delete PrintQueue;		
	}
	/**
	 * openAboutFusionMaps is the handler for "About FusionMaps"
	 * context menu item
	*/
	private function openAboutFusionMaps():Void{
		//Open FusionMaps website
		getURL("http://www.fusioncharts.com/maps","_blank");
	}
	/**
	 * saveAsImage method saves the map as an image.
	*/
	private function saveAsImage():Void{
		//Here, we do the following:
		//1. Create an instance of BitmapSave to capture the maps's image.
		//2. Define listener objects to track progress of it.
		//3. Send data to the defined server side script.
		//RLE Compression is done while capturing the bitmap data.
		
		//Reference to this class
		var classRef = this;
		
		//Create listener object for capture.
		var cList:Object = new Object();		

		//Progress bar positioning and dimension
		var PBWidth:Number = (this.width > 200) ? 150 : (this.width - 25);
		var PBStartX:Number = this.x + this.width/2 - PBWidth/2;
		var PBStartY:Number = this.y + this.height/2 - 15;

		//Create a progress bar to show capturing pixels.
		var imgSaveBg:MovieClip;
		//Text field to show percent complete for image saving progress bar
		var tfImageSavePB:TextField;
		//Create the empty movie clips
		imgSaveBg = this.parentMC.createEmptyMovieClip("ImgSaveBg", this.depth+5);
		//Create a black overlay rectangle
		imgSaveBg.beginFill(0x000000,20);
		imgSaveBg.moveTo(this.x, this.y);
		imgSaveBg.lineTo(this.x + this.width, this.y);
		imgSaveBg.lineTo(this.x + this.width, this.y + this.height);
		imgSaveBg.lineTo(this.x, this.y + this.height);
		imgSaveBg.lineTo(this.x, this.y);
		
		//Another white rectangle in center
		var pad:Number = 20;
		imgSaveBg.beginFill(0xFFFFFF,100);
		imgSaveBg.lineStyle(1, 0xE2E2E2, 100);
		imgSaveBg.moveTo(PBStartX - pad, PBStartY - pad);
		imgSaveBg.lineTo(PBStartX  + PBWidth + pad, PBStartY - pad);
		imgSaveBg.lineTo(PBStartX  + PBWidth + pad, PBStartY + 40 + pad);
		imgSaveBg.lineTo(PBStartX  - pad , PBStartY + 40 + pad);
		imgSaveBg.lineTo(PBStartX - pad, PBStartY - pad);
		
		//Capture mouse event from everything otherwise underneath
		imgSaveBg.useHandCursor = false;
		imgSaveBg.onRollOver = function(){
		}
		
		//Instantiate the progress bar
		var imgSPB:FCProgressBar = new FCProgressBar(this.parentMC, this.depth+6, 0, 100, PBStartX, PBStartY, PBWidth, 15, this.params.imageSaveDialogColor, this.params.imageSaveDialogColor, 1);
		
		//Create the text
		tfImageSavePB = Utils.createText (false, "Capturing data", this.parentMC, this.depth+7, this.x + this.width/2, this.y + this.height/2 + 15, null, {align:"center", vAlign:"bottom", bold:false, italic:false, underline:false, font:"Verdana", size:10, color:this.params.imageSaveDialogFontColor, isHTML:true, leftMargin:0, letterSpacing:0, bgColor:"", borderColor:""}, false, 0, 0).tf;
		var tFormat:TextFormat = tfImageSavePB.getTextFormat();
		
		//Event to detect when capturing is complete.
		cList.onCaptureComplete = function(eventObj:Object){
			//Remove all progress bar related movie clips
			imgSPB.destroy();
			tfImageSavePB.removeTextField();
			imgSaveBg.removeMovieClip();			
			//Capturing is complete. Send it to server side script.			
			classRef.sendImageData(eventObj.out);			
		}
		
		//Event to detect progress of capturing
		cList.onProgress = function(eventObj:Object){
			//Update the text field
			tfImageSavePB.htmlText = "<font face='Verdana' size='10' color='#" + this.params.imageSaveDialogFontColor + "'>Capturing data: " + eventObj.percentDone + "%</font>";
			tfImageSavePB.setTextFormat(tFormat);
			//Set the value of progress bar
			imgSPB.setValue(eventObj.percentDone);
		}

		//Create an instance of BitmapSave 
		var bmpS:BitmapSave = new BitmapSave(this.mapMC,this.x,this.y,this.width,this.height,0xffffff);		
		
		//Before we start capturing, we need to make sure that none of the movie clips
		//are cached as bitmap. So run a function that does this job.
		if(!this.mapMC.skipBmpCacheCheck){
			var arrCache:Array = this.setPreSaving(this.mapMC);
		}
		
		//Capture the bitmap now.
		bmpS.capture();
		
		//Now that the bitmap is captured, we need to set the cache property to original
		if(!this.mapMC.skipBmpCacheCheck){
			this.resetPostSaving(this.mapMC, arrCache)
		}
		
		//Add the event listeners
		bmpS.addEventListener("onCaptureComplete", cList);
		bmpS.addEventListener("onProgress", cList);
		
		return;	
	}	
	/**
	 * This method sets the bitmap caching of all objects in the map
	 * so as to avoid freezing of interface.
	*/
	private function setPreSaving(mc:MovieClip):Array{
		//Get the list of filters.
		var arrMcFilters:Array = new Array()
		//Iterate through each movie clip
		for(var i in mc){
			//Work only if it's a movie clip.
			if(mc[i] instanceof MovieClip){
				//Store the filters for this MC
				arrMcFilters[i] = new Array();
				arrMcFilters[i]['filters'] = mc[i].filters;
				mc[i].filters = [];
				//Store the cache property
				arrMcFilters[i]['cache'] = mc[i].cacheAsBitmap;
				mc[i].cacheAsBitmap = false;
				//Store children
				arrMcFilters[i]['children'] = arguments.callee(mc[i]);
			}
		}
		//Return the array
		return arrMcFilters;
	}
	/**
	 * This method restores the bitmap caching state of all the objects
	 * in the map, once capturing is done.
	*/
	private function resetPostSaving(mc:MovieClip, arrMcFilters:Array){
		for(var i in arrMcFilters){			
			mc[i].filters = arrMcFilters[i]['filters'];
			mc[i].cacheAsBitmap = arrMcFilters[i]['cache'];
			arguments.callee(mc[i],arrMcFilters[i]['children']);
		}
	}
	
	/**
	 * sendImageData actually sends the image data to the server.
	*/
	private function sendImageData(strData:String):Void{
		//Create a loadvars object
		var l:LoadVars = new LoadVars();		
		//Set width and height
		l.width = this.width;
		l.height = this.height;
		//Color to ignore
		l.bgcolor = "FFFFFF";
		l.data = strData;
		//Send the data to server side script.
		l.send(this.params.imageSaveURL, "_self", "POST");
		//Delete loadvars after sending data
		delete l;
	}
	// ---------- NUMBER DETECTION, FORMATTING RELATED METHODS -------//
	/**
	* detectNumberScales method detects whether we've been provided
	* with number scales. If yes, we parse them. This method needs to
	* called before calculate, as calculatePoint methods calls
	* formatNumber, which in turn uses number scales.
	*	@return	Nothing.
	*/
	private function detectNumberScales () : Void
	{
		//Check if either has been defined
		if (this.params.numberScaleValue.length == 0 || this.params.numberScaleUnit.length == 0 || this.params.formatNumberScale == 0)
		{
			//Set flag to false
			this.config.numberScaleDefined = false;
		} else 
		{
			//Set flag to true
			this.config.numberScaleDefined = true;
			//Split the data into arrays
			this.config.nsv = new Array ();
			this.config.nsu = new Array ();
			//Parse the number scale value
			this.config.nsv = this.params.numberScaleValue.split (",");
			//Convert all number scale values to numbers as they're
			//currently in string format.
			var i : Number;
			for (i = 0; i < this.config.nsv.length; i ++)
			{
				this.config.nsv [i] = Number (this.config.nsv [i]);
				//If any of numbers are NaN, set defined to false
				if (isNaN (this.config.nsv [i]))
				{
					this.config.numberScaleDefined = false;
				}
			}
			//Parse the number scale unit
			this.config.nsu = this.params.numberScaleUnit.split (",");
			//If the length of two arrays do not match, set defined to false.
			if (this.config.nsu.length != this.config.nsv.length)
			{
				this.config.numberScaleDefined = false;
			}
		}
		//Convert numberPrefix and numberSuffix now.
		this.params.numberPrefix = this.unescapeChar (this.params.numberPrefix);
		this.params.numberSuffix = this.unescapeChar (this.params.numberSuffix);
	}
	/**
	* unescapeChar method helps to unescape certain escape characters
	* which might have got through the XML. Like, %25 is escaped back to %.
	* This function would be used to format the number prefixes and suffixes.
	*	@param	strChar		The character or character sequence to be unescaped.
	*	@return			The unescaped character
	*/
	private function unescapeChar (strChar : String) : String
	{
		//Perform only if strChar is defined
		if (strChar == "" || strChar == undefined)
		{
			return "";
		}
		//If it doesnt contain a %, return the original string
		if (strChar.indexOf ("%") == - 1)
		{
			return strChar;
		}
		//We're not doing a case insensitive search, as there might be other
		//characters provided in the Prefix/Suffix, which need to be present in lowe case.
		//Create the conversion table.
		var cTable : Array = new Array ();
		cTable.push (
		{
			char : "%", encoding : "%25"
		});
		cTable.push (
		{
			char : "&", encoding : "%26"
		});
		cTable.push (
		{
			char : "£", encoding : "%A3"
		});
		cTable.push (
		{
			char : "€", encoding : "%E2%82%AC"
		});
		//v2.3 Backward compatible Euro
		cTable.push (
		{
			char : "€", encoding : "%80"
		});
		cTable.push (
		{
			char : "¥", encoding : "%A5"
		});
		cTable.push (
		{
			char : "¢", encoding : "%A2"
		});
		cTable.push (
		{
			char : "₣", encoding : "%E2%82%A3"
		});
		cTable.push (
		{
			char : "+", encoding : "%2B"
		});
		cTable.push (
		{
			char : "#", encoding : "%23"
		});
		//Loop variable
		var i : Number;
		//Return string (escaped)
		var rtnStr : String = strChar;
		for (i = 0; i < cTable.length; i ++)
		{
			if (strChar == cTable [i].encoding)
			{
				//If the given character matches the encoding, convert to character
				rtnStr = cTable [i].char;
				break;
			}
		}
		//Return it
		return rtnStr;
		//Clean up
		delete cTable;
	}
	/**
	* formatNumber method helps format a number as per the user
	* requirements.
	* Requires this.config.numberScaleDefined to be defined (boolean)
	*	@param		intNum				Number to be formatted
	*	@param		bFormatNumber		Flag whether we've to format
	*									decimals and add commas
	*	@param		decimalPrecision	Number of decimal places we need to
	*									round the number to.
	*	@param		forceDecimals		Whether we force decimal padding.
	*	@param		bFormatNumberScale	Flag whether we've to format number
	*									scale
	*	@param		defaultNumberScale	Default scale of the number provided.
	*	@param		numScaleValues		Array of values (for scaling)
	*	@param		numScaleUnits		Array of Units (for scaling)
	*	@param		numberPrefix		Number prefix to be added to number.
	*	@param		numberSuffix		Number Suffix to be added.
	*	@return						Formatted number as string.
	*
	*/
	private function formatNumber (intNum : Number, bFormatNumber : Boolean, decimalPrecision : Number, forceDecimals : Boolean, bFormatNumberScale : Boolean, defaultNumberScale : String, numScaleValues : Array, numScaleUnits : Array, numberPrefix : String, numberSuffix : String) : String 
	{
		//First, if number is to be scaled, scale it
		//Number in String format
		var strNum : String = String (intNum);
		//Number Scale
		var strScale : String
		if (bFormatNumberScale)
		{
			strScale = defaultNumberScale;
		}else
		{
			strScale = "";
		}
		if (bFormatNumberScale && this.config.numberScaleDefined)
		{
			//Get the formatted scale and number
			var objNum : Object = formatNumberScale (intNum, defaultNumberScale, numScaleValues, numScaleUnits);
			//Store from return in local primitive variables
			strNum = String (objNum.value);
			intNum = objNum.value;
			strScale = objNum.scale;
		}
		//Now, if we've to format the decimals and commas
		if (bFormatNumber)
		{
			//Format decimals
			strNum = formatDecimals (intNum, decimalPrecision, forceDecimals);
			//Format commas now
			strNum = formatCommas (strNum);
		}
		//Now, add scale, number prefix and suffix
		strNum = numberPrefix + strNum + strScale + numberSuffix;
		return strNum;
	}
	/**
	* formatNumberScale formats the number as per given scale.
	* For example, if number Scale Values are 1000,1000 and
	* number Scale Units are K,M, this method will divide any
	* value over 1000000 using M and any value over 1000 (<1M) using K
	* so as to give abbreviated figures.
	* Number scaling lets you define your own scales for numbers.
	* To clarify further, let's consider an example. Say you're plotting
	* a map which indicates the time taken by a list of automated
	* processes. Each process in the list can take time ranging from a
	* few seconds to few days. And you've the data for each process in
	* seconds itself. Now, if you were to show all the data on the map
	* in seconds only, it won't appear too legible. What you can do is
	* build a scale of yours and then specify it to the map. A scale,
	* in human terms, would look something as under:
	* 60 seconds = 1 minute
	* 60 minute = 1 hr
	* 24 hrs = 1 day
	* 7 days = 1 week
	* First you would need to define the unit of the data which you're providing.
	* Like, in this example, you're providing all data in seconds. So, default
	* number scale would be represented in seconds. You can represent it as under:
	* <graph defaultNumberScale='s' ...>
	* Next, the scale for the map is defined as under:
	* <graph numberScaleValue='60,60,24,7' numberScaleUnit='min,hr,day,wk' >
	* If you carefully see this and match it with our range, whatever numeric
	* figure was present on the left hand side of the range is put in
	* numberScaleValue and whatever unit was present on the right side of
	* the scale has been put under numberScaleUnit - all separated by commas.
	
	*	@param	intNum				The number to be scaled.
	*	@param	defaultNumberScale	Scale of the number provided.
	*	@param	numScaleValues		Incremental list of values (divisors) on
	*								which the number will be scaled.
	*	@param
	*/
	private function formatNumberScale (intNum : Number, defaultNumberScale : String, numScaleValues : Array, numScaleUnits : Array) : Object 
	{
		//Create an object, which will be returned
		var objRtn : Object = new Object ();
		//Scale Unit to be stored (assume default)
		var strScale : String = defaultNumberScale;
		var i : Number = 0;
		//If the scale unit or values have something fed in them
		//we manipulate the scales.
		for (i = 0; i < numScaleValues.length; i ++)
		{
			if (Math.abs (Number (intNum)) >= numScaleValues [i])
			{
				strScale = numScaleUnits [i];
				intNum = Number (intNum) / numScaleValues [i];
			} else 
			{
				break;
			}
		}
		//Set the values as properties of objRtn
		objRtn.value = intNum;
		objRtn.scale = strScale;
		return objRtn;
	}
	/**
	* formatDecimals method formats the decimal places of a number.
	* Requires the following to be defined:
	* this.params.decimalSeparator
	* this.params.thousandSeparator
	*	@param	intNum				Number on which we've to work.
	*	@param	decimalPrecision	Number of decimal places to which we've
	*								to format the number to.
	*	@param	forceDecimals		Boolean value indicating whether to add decimal
	*								padding to numbers which are falling as whole
	*								numbers?
	*	@return					A number with the required number of decimal places
	*								in String format. If we return as Number, Flash will remove
	*								our decimal padding or un-wanted decimals.
	*/
	private function formatDecimals (intNum : Number, decimalPrecision : Number, forceDecimals : Boolean) : String 
	{
		//If no decimal places are needed, just round the number and return
		if (decimalPrecision <= 0)
		{
			return String (Math.round (intNum));
		}
		//Round the number to specified decimal places
		//e.g. 12.3456 to 3 digits (12.346)
		//Step 1: Multiply by 10^decimalPrecision - 12345.6
		//Step 2: Round it - i.e., 12346
		//Step 3: Divide by 10^decimalPrecision - 12.346
		var tenToPower : Number = Math.pow (10, decimalPrecision);
		var strRounded : String = String (Math.round (intNum * tenToPower) / tenToPower);
		//Now, strRounded might have a whole number or a number with required
		//decimal places. Our next job is to check if we've to force Decimals.
		//If yes, we add decimal padding by adding 0s at the end.
		if (forceDecimals)
		{
			//Add a decimal point if missing
			//At least one decimal place is required (as we split later on .)
			//10 -> 10.0
			if (strRounded.indexOf (".") == - 1)
			{
				strRounded += ".0";
			}
			//Finally, we start add padding of 0s.
			//Split the number into two parts - pre & post decimal
			var parts : Array = strRounded.split (".");
			//Get the numbers falling right of the decimal
			//Compare digits in right half of string to digits wanted
			var paddingNeeded : Number = decimalPrecision - parts [1].length;
			//Number of zeros to add
			for (var i = 1; i <= paddingNeeded; i ++)
			{
				//Add them
				strRounded += "0";
			}
		}
		return (strRounded);
	}
	/**
	* formatCommas method adds proper commas to a number in blocks of 3
	* i.e., 123456 would be formatted as 123,456
	*	@param	strNum	The number to be formatted (as string).
	*					Why are numbers taken in string format?
	*					Here, we are asking for numbers in string format
	*					to preserve the leading and padding 0s of decimals
	*					Like as in -20.00, if number is just passed as number,
	*					Flash automatically reduces it to -20. But, we've to
	*					make sure that we do not disturb the original number.
	*	@return		Formatted number with commas.
	*/
	private function formatCommas (strNum : String) : String 
	{
		//intNum would represent the number in number format
		var intNum : Number = Number (strNum);
		//If the number is invalid, return an empty value
		if (isNaN (intNum))
		{
			return "";
		}
		var strDecimalPart : String = "";
		var boolIsNegative : Boolean = false;
		var strNumberFloor : String = "";
		var formattedNumber : String = "";
		var startPos : Number = 0;
		var endPos : Number = 0;
		//Define startPos and endPos
		startPos = 0;
		endPos = strNum.length;
		//Extract the decimal part
		if (strNum.indexOf (".") != - 1)
		{
			strDecimalPart = strNum.substring (strNum.indexOf (".") + 1, strNum.length);
			endPos = strNum.indexOf (".");
		}
		//Now, if the number is negative, get the value into the flag
		if (intNum < 0)
		{
			boolIsNegative = true;
			startPos = 1;
		}
		//Now, extract the floor of the number
		strNumberFloor = strNum.substring (startPos, endPos);
		//Now, strNumberFloor contains the actual number to be formatted with commas
		// If it's length is greater than 3, then format it
		if (strNumberFloor.length > 3)
		{
			// Get the length of the number
			var lenNumber : Number = strNumberFloor.length;
			for (var i : Number = 0; i <= lenNumber; i ++)
			{
				//Append proper commans
				if ((i > 2) && ((i - 1) % 3 == 0))
				{
					formattedNumber = strNumberFloor.charAt (lenNumber - i) + this.params.thousandSeparator + formattedNumber; 
				} else 
				{
					formattedNumber = strNumberFloor.charAt (lenNumber - i) + formattedNumber; 
				}
			}
		} else 
		{
			formattedNumber = strNumberFloor; 
		}
		// Now, append the decimal part back
		if (strDecimalPart != "")
		{
			formattedNumber = formattedNumber + this.params.decimalSeparator + strDecimalPart; 
		}
		//Now, if neg num
		if (boolIsNegative == true)
		{
			formattedNumber = "-" + formattedNumber; 
		}
		//Return
		return formattedNumber;
	}
	/**
	* getSetValue method helps us check whether the given set value is specified.
	* If not, we take steps accordingly and return values.
	*	@param	num		Number (in string/object format) which we've to check.
	*	@return		Numeric value of the number. (or NaN)
	*/
	private function getSetValue (num) : Number
	{
		//If it's not a number, or if input separators characters
		//are explicity defined, we need to convert value.
		var setValue : Number;
		if (isNaN (num) || (this.params.inThousandSeparator != "") || (this.params.inDecimalSeparator != ""))
		{
			//Number in XML can be invalid or missing (discontinuous data)
			//So, if the length is undefined, it's missing.
			if (num.length == undefined)
			{
				//Missing data. So just add it as NaN.
				setValue = Number (num);
			}else
			{
				//It means the number can have different separator, or
				//it can be non-numeric.
				setValue = this.convertNumberSeps (num);
			}
		}else
		{
			//Simply convert it to numeric form.
			setValue = Number (num);
		}
		//Get the decimal places in data (if not integral value)
		if ( ! isNaN (setValue) && Math.floor (setValue) != setValue)
		{
			var decimalPlaces : Number = MathExt.numDecimals (setValue);
			//Store in class variable
			maxDecimals = (decimalPlaces > maxDecimals) ?decimalPlaces : maxDecimals;
		}
		//Return value
		return setValue;
	}
	/**
	* convertNumberSeps method helps us convert the separator (thousands and decimal)
	* character from the user specified input separator characters to normal numeric
	* values that Flash can handle. In some european countries, commas are used as
	* decimal separators and dots as thousand separators. In XML, if the user specifies
	* such values, it will give a error while converting to number. So, we accept the
	* input decimal and thousand separator from user, so thatwe can covert it accordingly
	* into the required format.
	* If the number is still not a valid number after converting the characters, we log
	* the error and return 0.
	*	@param	strNum	Number in string format containing user defined separator characters.
	*	@return		Number in numeric format.
	*/
	private function convertNumberSeps (strNum : String) : Number
	{
		//If thousand separator is defined, replace the thousand separators
		//in number
		//Store a copy
		var origNum : String = strNum;
		if (this.params.inThousandSeparator != "")
		{
			strNum = StringExt.replace (strNum, this.params.inThousandSeparator, "");
		}
		//Now, if decimal separator is defined, convert it to .
		if (this.params.inDecimalSeparator != "")
		{
			strNum = StringExt.replace (strNum, this.params.inDecimalSeparator, ".");
		}
		//Now, if the original number was in a valid format(with just different sep chars),
		//it has now been converted to normal format. But, if it's still giving a NaN, it means
		//that the number is not valid. So, we add to log and store it as undefined data.
		if (isNaN (strNum))
		{
			this.log ("ERROR", "Invalid number " + origNum + " specified in XML. FusionMaps can accept number in pure numerical form only. If your number formatting (thousand and decimal separator) is different, please specify so in XML. Also, do not add any currency symbols or other signs to the numbers.", Logger.LEVEL.ERROR);
		}
		return Number (strNum);
	}
	// ------------------- TESTING METHODS ---------------------//
	/**
	* test method helps to test the map at the time of creation.
	* Here, first we check whether the given mc names for each entity
	* are valid MCs.
	* There by, we generate a simple XML data document and pass it to
	* map to render.
	* test method should be called only while creating the map, as this
	* method aids you to automatically check whether the movie clips are
	* created and named properly.
	*/
	public function test () : Void
	{
		//First we check whether the given instance names are actually present
		//Attach the map movie clip
		var depth : Number = this.dm.getDepth ("PLOT");
		actualMapMC = this.mapMC.attachMovie (this.config.mapId, "Map", depth);
		//Get each entity Movie clip now and check for their existence
		var entityMC : MovieClip;
		//Flag that all movie clip names are valid - by default assume true
		var isValid : Boolean = true;
		//Id of the entity which we're checking
		var notFoundName : String;
		//Loop Variable
		var i : Number;
		//Iterate through all entities
		for (i = 1; i <= this.tNum; i ++)
		{
			entityMC = actualMapMC [this.entity [i].mc];
			//If the entity's name is not defined, raise error.
			if (entityMC._name == undefined)
			{
				notFoundName = this.entity [i].id;
				isValid = false;
				break;
			}
		}
		if (isValid == false)
		{
			throw new Error ("Instance name for entity '" + notFoundName + "' could not be found within the map. Please check your corresponding Map Class > feedEntities() method to see that you're providing the right instance names for each entity. Or, check the map to see if you've given the right instance name for the entity.");
		}
		//Re-initialize as we now check with XML.
		this.reInit ();
		//Now, set the new XML and render
		this.setXMLData (new XML ("<map connectorColor='FF5904' baseFont='Arial' baseFontColor='FF0000' baseFontSize='10'></map>"));
		//Render
		this.render ();
	}
	// -------------------- EVENT HANDLERS --------------------//
	/**
	* mapOnRollOver is the delegat-ed event handler method that'll
	* be invoked when the user rolls his mouse over a map entity.
	* This function is invoked, only if the tool tip is to be shown.
	* Here, we show the tool tip.
	*/
	private function mapOnRollOver () : Void
	{
		//Index of entity is stored in arguments.caller.index
		var index : Number = arguments.caller.index;
		//Change color to this.params.hoverColor if required
		if (this.params.useHoverColor)
		{
			//Set hover color
			//Get the movie clip
			var entityMC : MovieClip;
			entityMC = actualMapMC [this.entity [index].mc];
			var clrE : Color = new Color (entityMC);
			clrE.setRGB (parseInt (this.params.hoverColor, 16));
		}
		//Show tool tip if required
		if (this.params.showToolTip)
		{
			//Set tool tip text
			this.tTip.setText (this.entity [index].toolText);
			//Show the tool tip
			this.tTip.show ();
		}
		//Now, if hover event is to be exposed
		if (this.params.exposeHoverEvent){
			//Expose event to JS
			if (this.registerWithJS==true &&  ExternalInterface.available){
				ExternalInterface.call("FC_Event", this.DOMId, "rollOver", {id: this.entity [index].id, sName: this.entity [index].sName, lName: this.entity [index].lName, value: this.entity [index].value});
			}
			//Dispatch an event to loader class
			this.dispatchEvent({type:"rollOver", target:this, id:this.entity [index].id, mc:this.mapMC.Map[this.entity [index].mc], sName:this.entity [index].sName, lName:this.entity [index].lName, value:this.entity [index].value});
		}
	}
	/**
	* mapOnRollOut method is invoked when the mouse rolls out
	* of entity. We just hide the tool tip here.
	*/
	private function mapOnRollOut () : Void
	{
		//Index of entity is stored in arguments.caller.index
		var index : Number = arguments.caller.index;
		//Change color to actual color if required
		if (this.params.useHoverColor)
		{
			//Remove hover color
			//Get the movie clip
			var entityMC : MovieClip;
			entityMC = actualMapMC [this.entity [index].mc];
			var clrE : Color = new Color (entityMC);
			clrE.setRGB (parseInt (this.entity [index].color, 16));
		}
		//Hide tool tip if required
		if (this.params.showToolTip)
		{
			//Hide the tool tip
			this.tTip.hide ();
		}
		//Now, if hover event is to be exposed
		if (this.params.exposeHoverEvent){
			//Expose event to JS
			if (this.registerWithJS==true &&  ExternalInterface.available){
				ExternalInterface.call("FC_Event", this.DOMId, "rollOut", {id: this.entity [index].id, sName: this.entity [index].sName, lName: this.entity [index].lName, value: this.entity [index].value});
			}
			//Dispatch an event to loader class
			this.dispatchEvent({type:"rollOut", target:this, id:this.entity [index].id, mc:this.mapMC.Map[this.entity [index].mc], sName:this.entity [index].sName, lName:this.entity [index].lName, value:this.entity [index].value});
		}
	}
	/*
	* mapOnMouseMove is called when the mouse position has changed
	* over entity. We reposition the tool tip.
	*/
	private function mapOnMouseMove () : Void
	{
		//Reposition the tool tip only if it's in visible state
		if (this.tTip.visible ())
		{
			this.tTip.rePosition ();
		}
	}
	/**
	* mapOnClick is invoked when the user clicks on an entity (if link
	* has been defined). We invoke the required link.
	*/
	private function mapOnClick () : Void
	{
		//Index of entity is stored in arguments.caller.index
		var index : Number = arguments.caller.index;
		//Invoke the link
		super.invokeLink (this.entity [index].link);
	}
	
	// ------------- Marker Related Events --------------
	/**
	* markerOnRollOver is the delegat-ed event handler method that'll
	* be invoked when the user rolls his mouse over a marker.
	* Here, we show the tool tip.
	*/
	private function markerOnRollOver () : Void
	{
		//Index of entity is stored in arguments.caller.index
		var index : Number = arguments.caller.index;
		//Show tool tip if required
		if (this.params.showMarkerToolTip && this.markerData[index].toolText!="")
		{
			//Set tool tip text
			this.tTip.setText(this.markerData[index].toolText);
			//Show the tool tip
			this.tTip.show ();
		}
	}
	/**
	* markerOnRollOut method is invoked when the mouse rolls out
	* of a marker entity. We just hide the tool tip here.
	*/
	private function markerOnRollOut () : Void
	{		
		//Hide tool tip if required
		if (this.params.showMarkerToolTip)
		{
			//Hide the tool tip
			this.tTip.hide ();
		}
	}
	/**
	* markerOnClick is invoked when the user clicks on a marker (if link
	* has been defined). We invoke the required link.
	*/
	private function markerOnClick () : Void
	{
		//Index of entity is stored in arguments.caller.index
		var index : Number = arguments.caller.index;
		//Invoke the link
		super.invokeLink (this.markerData[index].link);
	}
	/** ------------ Marker Connector Related Events --------------- //
	/**
	* markerConnectorOnRollOver  is the delegat-ed event handler method that'll
	* be invoked when the user rolls his mouse over a marker connector.
	* Here, we show the tool tip.
	*/
	private function markerConnectorOnRollOver():Void{
		//Index of entity is stored in arguments.caller.index
		var index : Number = arguments.caller.index;
		//Set tool tip text
		this.tTip.setText(this.markerConnectors[index].toolText);
		//Show the tool tip
		this.tTip.show ();
	}
	/**
	* markerConnectorOnRollOut method is invoked when the mouse rolls out
	* of a marker connector. We just hide the tool tip here.
	*/
	private function markerConnectorOnRollOut():Void{		
		//Hide tool tip if required
		if (this.params.showMarkerToolTip){
			//Hide the tool tip
			this.tTip.hide();
		}
	}
	/**
	* markerConnectorOnClick is invoked when the user clicks on a marker Connector(if link
	* has been defined). We invoke the required link.
	*/
	private function markerConnectorOnClick():Void{
		//Index of entity is stored in arguments.caller.index
		var index:Number = arguments.caller.index;
		//Invoke the link
		super.invokeLink (this.markerConnectors[index].link);
	}
}
