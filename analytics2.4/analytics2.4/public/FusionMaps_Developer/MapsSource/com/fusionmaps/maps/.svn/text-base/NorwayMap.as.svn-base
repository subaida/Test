import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NorwayMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NorwayMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NorwayMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AK", "AK", "Akershus");
		super.addEntity("02", "AA", "AA", "Aust-Agder");
		super.addEntity("04", "BU", "BU", "Buskerud");
		super.addEntity("05", "FI", "FI", "Finnmark");
		super.addEntity("06", "HE", "HE", "Hedmark");
		super.addEntity("07", "HO", "HO", "Hordaland");
		super.addEntity("08", "MR", "MR", "Møre og Romsdal");
		super.addEntity("09", "NO", "NO", "Nordland");
		super.addEntity("10", "NT", "NT", "Nord-Trøndelag");
		super.addEntity("11", "OP", "OP", "Oppland");
		super.addEntity("12", "OS", "OS", "Oslo");
		super.addEntity("13", "OT", "OT", "Østfold");
		super.addEntity("14", "RO", "RO", "Rogaland");
		super.addEntity("15", "SO", "SO", "Sogn og Fjordane");
		super.addEntity("16", "ST", "ST", "Sør-Trøndelag ");
		super.addEntity("17", "TE", "TE", "Telemark");
		super.addEntity("18", "TR", "TR", "Troms");
		super.addEntity("19", "VA", "VA", "Vest-Agder");
		super.addEntity("20", "VE", "VE", "Vestfold");
		
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
