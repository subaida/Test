import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MoldovaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MoldovaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MoldovaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("46", "BA", "BA", "Bălţi");
		super.addEntity("47", "CA", "CA", "Cahul");
		super.addEntity("48", "CU", "CU", "Chişinău");
		super.addEntity("50", "ED", "ED", "Edineţ");
		super.addEntity("51", "GA", "GA", "Găgăuzia");
		super.addEntity("52", "LA", "LA", "Lăpuşna");
		super.addEntity("53", "OR", "OR", "Orhei");
		super.addEntity("54", "SO", "SO", "Soroca");
		super.addEntity("49", "SN", "SN", "Stânga Nistrului");
		super.addEntity("55", "TI", "TI", "Tighina");
		super.addEntity("56", "UN", "UN", "Ungheni");
		
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
