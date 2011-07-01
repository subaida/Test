import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MontanaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MontanaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MontanaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "BE", "BE", "Beaverhead");
		super.addEntity("003", "BH", "BH", "Big Horn");
		super.addEntity("005", "BL", "BL", "Blaine");
		super.addEntity("007", "BR", "BR", "Broadwater");
		super.addEntity("009", "CA", "CA", "Carbon");
		super.addEntity("011", "CR", "CR", "Carter");
		super.addEntity("013", "CS", "CS", "Cascade");
		super.addEntity("015", "CH", "CH", "Chouteau");
		super.addEntity("017", "CU", "CU", "Custer ");
		super.addEntity("019", "DA", "DA", "Daniels");
		super.addEntity("021", "DW", "DW", "Dawson");
		super.addEntity("023", "DL", "DL", "Deer Lodge");
		super.addEntity("025", "FA", "FA", "Fallon ");
		super.addEntity("027", "FE", "FE", "Fergus");
		super.addEntity("029", "FL", "FL", "Flathead");
		super.addEntity("031", "GA", "GA", "Gallatin");
		super.addEntity("033", "GR", "GR", "Garfield");
		super.addEntity("035", "GC", "GC", "Glacier");
		super.addEntity("037", "GV", "GV", "Golden Valley");
		super.addEntity("039", "GN", "GN", "Granite");
		super.addEntity("041", "HI", "HI", "Hill");
		super.addEntity("043", "JE", "JE", "Jefferson");
		super.addEntity("045", "JB", "JB", "Judith Basin");
		super.addEntity("047", "LA", "LA", "Lake  ");
		super.addEntity("049", "LC", "LC", "Lewis and Clark");
		super.addEntity("051", "LB", "LB", "Liberty");
		super.addEntity("053", "LI", "LI", "Lincoln");
		super.addEntity("055", "MC", "MC", "McCone");
		super.addEntity("057", "MA", "MA", "Madison");
		super.addEntity("059", "ME", "ME", "Meagher");
		super.addEntity("061", "MI", "MI", "Mineral");
		super.addEntity("063", "MS", "MS", "Missoula");
		super.addEntity("065", "MU", "MU", "Musselshell");
		super.addEntity("067", "PA", "PA", "Park");
		super.addEntity("069", "PE", "PE", "Petroleum");
		super.addEntity("071", "PH", "PH", "Phillips");
		super.addEntity("073", "PO", "PO", "Pondera");
		super.addEntity("075", "PR", "PR", "Powder River");
		super.addEntity("077", "PW", "PW", "Powell");
		super.addEntity("079", "PI", "PI", "Prairie");
		super.addEntity("081", "RA", "RA", "Ravalli");
		super.addEntity("083", "RI", "RI", "Richland");
		super.addEntity("085", "RO", "RO", "Roosevelt");
		super.addEntity("087", "RS", "RS", "Rosebud");
		super.addEntity("089", "SA", "SA", "Sanders");
		super.addEntity("091", "SH", "SH", "Sheridan");
		super.addEntity("093", "SB", "SB", "Silver Bow");
		super.addEntity("095", "SW", "SW", "Stillwater");
		super.addEntity("097", "SG", "SG", "Sweet Grass");
		super.addEntity("099", "TE", "TE", "Teton");
		super.addEntity("101", "TO", "TO", "Toole");
		super.addEntity("103", "TR", "TR", "Treasure");
		super.addEntity("105", "VA", "VA", "Valley");
		super.addEntity("107", "WH", "WH", "Wheatland ");
		super.addEntity("109", "WI", "WI", "Wibaux");
		super.addEntity("111", "YS", "YS", "Yellowstone");
		
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
