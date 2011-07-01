import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AlaskaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AlaskaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AlaskaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String, scaleMode:String, registerWithJS:Boolean, DOMId:String) {
		//Invoke the super class constructor
		super(targetMC, depth, width, height, x, y, debugMode, lang, scaleMode, registerWithJS, DOMId);
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
		super.addEntity("013", "013", "AE", "Aleutians East");
		super.addEntity("016", "016", "AW", "Aleutians West");
		super.addEntity("020", "020", "AN", "Anchorage");
		super.addEntity("050", "050", "BE", "Bethel");
		super.addEntity("060", "060", "BR", "Bristol Bay");
		super.addEntity("068", "068", "DE", "Denali Borough");
		super.addEntity("070", "070", "DI", "Dillingham");
		super.addEntity("090", "090", "FA", "Fairbanks North Star");
		super.addEntity("100", "100", "HA", "Haines");
		super.addEntity("110", "110", "JU", "Juneau");
		super.addEntity("122", "122", "KE", "Kenai Peninsula");
		super.addEntity("130", "130", "KG", "Ketchikan Gateway");
		super.addEntity("150", "150", "KO", "Kodiak Island");
		super.addEntity("170", "170", "MA", "Matanuska-Susitna");
		super.addEntity("180", "180", "NO", "Nome");
		super.addEntity("185", "185", "NS", "North Slope");
		super.addEntity("188", "188", "NA", "Northwest Arctic");
		super.addEntity("164", "164", "PL", "Peninsula And Lake");
		super.addEntity("201", "201", "PW", "Prince Of Wales-Outer Ketchika");
		super.addEntity("220", "220", "SI", "Sitka");
		super.addEntity("232", "232", "SH", "Skagway-Hoonah-Angoon");
		//super.addEntity("231", "231", "SY", "Skagway-Yakutat-Angoon");
		super.addEntity("240", "240", "SF", "Southeast Fairbanks");
		super.addEntity("261", "261", "VC", "Valdez-Cordova");
		super.addEntity("270", "270", "WH", "Wade Hampton");
		super.addEntity("280", "280", "WP", "Wrangell-Petersburg");
		super.addEntity("282", "282", "YA", "Yakutat");
		super.addEntity("290", "290", "YK", "Yukon-Koyukuk");
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
