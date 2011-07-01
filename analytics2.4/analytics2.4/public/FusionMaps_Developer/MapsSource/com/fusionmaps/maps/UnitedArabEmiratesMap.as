import com.fusionmaps.core.Map;
class com.fusionmaps.maps.UnitedArabEmiratesMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "UnitedArabEmiratesMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function UnitedArabEmiratesMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String) {
		//Invoke the super class constructor
		super(targetMC, depth, width, height, x, y, debugMode, lang);
		//Set the identifier name of Map movie clip
		this.config.mapId = mapId;
	}
	/**
	 * render method renders the chart.
	*/
	public function render():Void {
		//Feed entities for this chart
		this.feedEntities();
		//Just call render of parent method
		super.render();
	}
	/**
	 * feedEntities method feeds the entities of this chart in the entity array.
	 * Each country/state/county/city on the map is stored as an entity with following
	 * properties: id, shortName, longName
	 * For any map, the feedEntities is a MUST. All entities on the map should be fed
	 * in this function.
	*/
	public function feedEntities() {
		super.addEntity("01", "AD", "AD", "Abu Dhabi");
		super.addEntity("02", "AJ", "AJ", "Ajman");
		super.addEntity("03", "DU", "DU", "Dubai");
		super.addEntity("04", "FU", "FU", "Fujairah");
		super.addEntity("05", "RA", "RA", "Ras Al Khaimah");
		super.addEntity("06", "SH", "SH", "Sharjah");
		super.addEntity("07", "UA", "UA", "Umm Al Quwain");
				 
		}
	/**
	 * reInit method re-initializes the map. This method is basically called
	 * when the user changes map data through JavaScript. In that case, we need
	 * to re-initialize the map, set new XML data and again render. 	 
	*/
	public function reInit():Void {
		//Invoke the super class's reInit method.
		super.reInit();
		//Set the identifier name of Map movie clip
		this.config.mapId = mapId;
	}
}
