import com.fusionmaps.core.Map;
class com.fusionmaps.maps.USANorthEastRegionMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "USANorthEastRegionMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function USANorthEastRegionMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
		//Invoke the super class constructor
		super(targetMC, depth, width, height, x, y, debugMode, lang, scaleMode ,registerWithJS, DOMId);
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
		super.addEntity("09", "CT", "CT", "Connecticut");
		super.addEntity("10", "DE", "DE", "Delaware");
		super.addEntity("11", "DC", "DC", "District of Columbia");
		super.addEntity("18", "IN", "IN", "Indiana");
		super.addEntity("21", "KY", "KY", "Kentucky");
		super.addEntity("23", "ME", "ME", "Maine");
		super.addEntity("24", "MD", "MD", "Maryland");
		super.addEntity("25", "MA", "MA", "Massachusetts");
		super.addEntity("26", "MI", "MI", "Michigan");
		super.addEntity("33", "NH", "NH", "New Hampshire");
		super.addEntity("34", "NJ", "NJ", "New Jersey");
		super.addEntity("36", "NY", "NY", "New York");
		super.addEntity("42", "PA", "PA", "Pennsylvania");
		super.addEntity("44", "RI", "RI", "Rhode Island");
		super.addEntity("50", "VT", "VT", "Vermont");
		super.addEntity("51", "VA", "VA", "Virginia");
		super.addEntity("54", "WV", "WV", "West Virginia");
		super.addEntity("39", "OH", "OH", "Ohio");
	
		
				 
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
