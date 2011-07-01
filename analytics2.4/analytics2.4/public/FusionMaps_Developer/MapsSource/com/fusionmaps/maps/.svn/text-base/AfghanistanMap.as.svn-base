import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AfghanistanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AfghanistanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AfghanistanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode:String, registerWithJS:Boolean, DOMID:String) {
		//Invoke the super class constructor
		super(targetMC, depth, width, height, x, y, debugMode, lang, scaleMode ,registerWithJS, DOMId);
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
		super.addEntity("01", "BDS", "BDS", "Badakhshan");
		super.addEntity("02", "BDG", "BDG", "Badghis");
		super.addEntity("03", "BGL", "BGL", "Baghlan");
		super.addEntity("30", "BAL", "BAL", "Balkh");
		super.addEntity("05", "BAM", "BAM", "Bamyan");
		super.addEntity("41", "DAY", "DAY", "Daykundi");
		super.addEntity("06", "FRA", "FRA", "Farah");
		super.addEntity("07", "FYB", "FYB", "Faryab");
		super.addEntity("08", "GHA", "GHA", "Ghazni");
		super.addEntity("09", "GHO", "GHO", "Ghowr");
		super.addEntity("10", "HEL", "HEL", "Helmand");
		super.addEntity("11", "HER", "HER", "Herat");
		super.addEntity("31", "JOW", "JOW", "Jowzjan");
		super.addEntity("13", "KAB", "KAB", "Kabul");
		super.addEntity("23", "KAN", "KAN", "Kandahar");
		super.addEntity("14", "KAP", "KAP", "Kapisa");
		super.addEntity("37", "KHO", "KHO", "Khost");
		super.addEntity("34", "KNR", "KNR", "Konar");
		super.addEntity("24", "KDZ", "KDZ", "Kondoz");
        super.addEntity("35", "LAG", "LAG", "Laghman");
        super.addEntity("17", "LOW", "LOW", "Lowgar");
        super.addEntity("18", "NAN", "NAN", "Nangarhar");
        super.addEntity("19", "NIM", "NIM", "Nimruz");
        super.addEntity("38", "NUR", "NUR", "Nurestan");
        super.addEntity("39", "ORU", "ORU", "Oruzgan");
		super.addEntity("36", "PIA", "PIA", "Paktia");
		super.addEntity("29", "PKA", "PKA", "Paktika");
		super.addEntity("42", "PAN", "PAN", "Panjshir");
		super.addEntity("40", "PAR", "PAR", "Parvan");
		super.addEntity("32", "SAM", "SAM", "Samangan");
		super.addEntity("33", "SAR", "SAR", "Sar-e Pol");
		super.addEntity("26", "TAK", "TAK", "Takhar");
		super.addEntity("27", "WAR", "WAR", "Wardak");
		super.addEntity("28", "ZAB", "ZAB", "Zabol");
		 
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
