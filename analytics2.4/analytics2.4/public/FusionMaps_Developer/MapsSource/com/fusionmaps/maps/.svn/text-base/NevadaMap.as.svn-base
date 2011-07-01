import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NevadaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NevadaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NevadaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String){
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
		super.addEntity("001", "CH", "CH", "Churchill");
		super.addEntity("003", "CL", "CL", "Clark");
		super.addEntity("005", "DO", "DO", "Douglas");
		super.addEntity("007", "EL", "EL", "Elko");
		super.addEntity("009", "ES", "ES", "Esmeralda");
		super.addEntity("011", "EU", "EU", "Eureka");
		super.addEntity("013", "HU", "HU", "Humboldt");
		super.addEntity("015", "LA", "LA", "Lander");
		super.addEntity("017", "LI", "LI", "Lincoln");
		super.addEntity("019", "LY", "LY", "Lyon");
		super.addEntity("021", "MI", "MI", "Mineral");
		super.addEntity("023", "NY", "NY", "Nye");
		super.addEntity("027", "PE", "PE", "Pershing");
		super.addEntity("029", "ST", "ST", "Storey");
		super.addEntity("031", "WA", "WA", "Washoe");
		super.addEntity("033", "WP", "WP", "White Pine");
		super.addEntity("510", "CA", "CA", "Carson City");
		
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
