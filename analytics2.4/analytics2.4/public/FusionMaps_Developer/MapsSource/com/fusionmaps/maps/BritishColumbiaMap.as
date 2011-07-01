import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BritishColumbiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BritishColumbiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BritishColumbiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AC", "AC", "Alberni-Clayoquot");
		super.addEntity("02", "BN", "BN", "Bulkley-Nechako");
		super.addEntity("03", "CA", "CA", "Capital");
		super.addEntity("04", "CR", "CR", "Cariboo");
		super.addEntity("05", "CN", "CN", "Central Coast");
		super.addEntity("06", "CK", "CK", "Central Kootenay");
		super.addEntity("07", "CO", "CO", "Central Okanagan");
		super.addEntity("08", "CS", "CS", "Columbia-Shuswap");
		super.addEntity("09", "CM", "CM", "Comox-Strathcona");
		super.addEntity("10", "CV", "CV", "Cowichan Valley");
		super.addEntity("11", "EK", "EK", "East Kootenay");
		super.addEntity("12", "FV", "FV", "Fraser Valley");
		super.addEntity("13", "FG", "FG", "Fraser-Fort George");
		super.addEntity("14", "GV", "GV", "Greater Vancouver");
		super.addEntity("15", "KS", "KS", "Kitimat-Stikine");
		super.addEntity("16", "KB", "KB", "Kootenay-Boundary");
		super.addEntity("17", "MW", "MW", "Mount Waddington");
		super.addEntity("18", "NA", "NA", "Nanaimo");
		super.addEntity("19", "NO", "NO", "North Okanagan");
        super.addEntity("20", "NR", "NR", "Northern Rockies");
        super.addEntity("21", "OS", "OS", "Okanagan-Similkameen");
        super.addEntity("22", "PR", "PR", "Peace River");
        super.addEntity("23", "PO", "PO", "Powell River");
        super.addEntity("24", "SQ", "SQ", "Skeena-Queen Charlotte");
        super.addEntity("25", "SL", "SL", "Squamish-Lillooet");
		super.addEntity("26", "ST", "ST", "Stikine");
		super.addEntity("27", "SC", "SC", "Sunshine Coast");
		super.addEntity("28", "TN", "TN", "Thompson-Nicola");
		 
		

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
