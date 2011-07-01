import com.fusionmaps.core.Map;
class com.fusionmaps.maps.HungaryMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "HungaryMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function HungaryMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "BK", "BK", "Bács-Kiskun");
		super.addEntity("02", "BA", "BA", "Baranya");
		super.addEntity("03", "BE", "BE", "Békés");
		super.addEntity("04", "BO", "BO", "Borsod-Abaúj-Zemplén");
		super.addEntity("05", "BU", "BU", "Budapest");
		super.addEntity("06", "CS", "CS", "Csongrád");
		super.addEntity("08", "FE", "FE", "Fejér");
		super.addEntity("09", "GM", "GM", "Győr-Moson-Sopron");
		super.addEntity("10", "HB", "HB", "Hajdú-Bihar");
		super.addEntity("11", "HE", "HE", "Heves");
		super.addEntity("12", "KE", "KE", "Komárom-Esztergom");
		super.addEntity("14", "NO", "NO", "Nógrád");
		super.addEntity("16", "PE", "PE", "Pest");
		super.addEntity("17", "SO", "SO", "Somogy");
		super.addEntity("18", "SZ", "SZ", "Szabolcs-Szatmár-Bereg");
		super.addEntity("20", "JN", "JN", "Jász-Nagykun-Szolnok");
		super.addEntity("21", "TO", "TO", "Tolna");
		super.addEntity("22", "VA", "VA", "Vas");
		super.addEntity("23", "VE", "VE", "Veszprém");
        super.addEntity("24", "ZA", "ZA", "Zala");
        
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
