import com.fusionmaps.core.Map;
class com.fusionmaps.maps.VermontMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "VermontMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function VermontMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AD", "AD", "Addison");
		super.addEntity("003", "BE", "BE", "Bennington");
		super.addEntity("005", "CA", "CA", "Caledonia");
		super.addEntity("007", "CH", "CH", "Chittenden");
		super.addEntity("009", "ES", "ES", "Essex");
		super.addEntity("011", "FR", "FR", "Franklin");
		super.addEntity("013", "GI", "GI", "Grand Isle");
		super.addEntity("015", "LA", "LA", "Lamoille");
		super.addEntity("017", "OR", "OR", "Orange");
		super.addEntity("019", "OL", "OL", "Orleans");
		super.addEntity("021", "RU", "RU", "Rutland");
		super.addEntity("023", "WA", "WA", "Washington");
		super.addEntity("025", "WI", "WI", "Windham");
		super.addEntity("027", "WN", "WN", "Windsor");
		
		
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
