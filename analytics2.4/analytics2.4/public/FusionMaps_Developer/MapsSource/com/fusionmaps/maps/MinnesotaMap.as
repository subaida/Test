import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MinnesotaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MinnesotaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MinnesotaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AI", "AI", "Aitkin");
		super.addEntity("003", "AN", "AN", "Anoka");
		super.addEntity("005", "BE", "BE", "Becker");
		super.addEntity("007", "BL", "BL", "Beltrami");
		super.addEntity("009", "BN", "BN", "Benton");
		super.addEntity("011", "BS", "BS", "Big Stone");
		super.addEntity("013", "BU", "BU", "Blue Earth");
		super.addEntity("015", "BW", "BW", "Brown");
		super.addEntity("017", "CA", "CA", "Carlton");
		super.addEntity("019", "CR", "CR", "Carver");
		super.addEntity("021", "CS", "CS", "Cass");
		super.addEntity("023", "CH", "CH", "Chippewa");
		super.addEntity("025", "CG", "CG", "Chisago");
		super.addEntity("027", "CL", "CL", "Clay");
		super.addEntity("029", "CW", "CW", "Clearwater");
		super.addEntity("031", "CO", "CO", "Cook");
		super.addEntity("033", "CT", "CT", "Cottonwood");
		super.addEntity("035", "CI", "CI", "Crow Wing");
		super.addEntity("037", "DA", "DA", "Dakota");
        super.addEntity("039", "DD", "DD", "Dodge");
        super.addEntity("041", "DU", "DU", "Douglas");
        super.addEntity("043", "FA", "FA", "Faribault");
        super.addEntity("045", "FI", "FI", "Fillmore");
        super.addEntity("047", "FR", "FR", "Freeborn");
        super.addEntity("049", "GO", "GO", "Goodhue");
		super.addEntity("051", "GR", "GR", "Grant");
		super.addEntity("053", "HE", "HE", "Hennepin");
		super.addEntity("055", "HU", "HU", "Houston");
		super.addEntity("057", "HB", "HB", "Hubbard");
		super.addEntity("059", "IS", "IS", "Isanti");
		super.addEntity("061", "IT", "IT", "Itasca");
		super.addEntity("063", "JA", "JA", "Jackson");
		super.addEntity("065", "KA", "KA", "Kanabec");
		super.addEntity("067", "KN", "KN", "Kandiyohi");
		super.addEntity("069", "KI", "KI", "Kittson");
		super.addEntity("071", "KO", "KO", "Koochiching");
		super.addEntity("073", "LQ", "LQ", "Lac Qui Parle");
		super.addEntity("075", "LA", "LA", "Lake");
		super.addEntity("077", "LW", "LW", "Lake of the Woods");
		super.addEntity("079", "LS", "LS", "Le Sueur");
		super.addEntity("081", "LI", "LI", "Lincoln");
		super.addEntity("083", "LY", "LY", "Lyon");
		super.addEntity("085", "ML", "ML", "McLeod");
		super.addEntity("087", "MA", "MA", "Mahnomen");
	     super.addEntity("089", "MR", "MR", "Marshall");
		 super.addEntity("091", "MT", "MT", "Martin");
		 super.addEntity("093", "MK", "MK", "Meeker");
		 super.addEntity("095", "MI", "MI", "Mille Lacs");
		 super.addEntity("097", "MS", "MS", "Morrison");
		 super.addEntity("099", "MW", "MW", "Mower");
		 super.addEntity("101", "MU", "MU", "Murray");
		 super.addEntity("103", "NI", "NI", "Nicollet");
		 super.addEntity("105", "NO", "NO", "Nobles");
		 super.addEntity("107", "NR", "NR", "Norman");
		 super.addEntity("109", "OL", "OL", "Olmsted");
		 super.addEntity("111", "OT", "OT", "Otter Tail");
		 super.addEntity("113", "PE", "PE", "Pennington");
		 super.addEntity("115", "PI", "PI", "Pine");
		 super.addEntity("117", "PS", "PS", "Pipestone");
		 super.addEntity("119", "PL", "PL", "Polk");
		 super.addEntity("121", "PO", "PO", "Pope");
		 super.addEntity("123", "RM", "RM", "Ramsey");
		 super.addEntity("125", "RL", "RL", "Red Lake");
		 super.addEntity("127", "RW", "RW", "Redwood");
		 super.addEntity("129", "RE", "RE", "Renville");
		 super.addEntity("131", "RI", "RI", "Rice"); 
		 super.addEntity("133", "RC", "RC", "Rock");
		 super.addEntity("135", "RO", "RO", "Roseau");
		 super.addEntity("137", "SL", "SL", "St.Louis");
		 super.addEntity("139", "SC", "SC", "Scott");
		 super.addEntity("141", "SH", "SH", "Sherburne"); 
		 super.addEntity("143", "SB", "SB", "Sibley");
		 super.addEntity("145", "SA", "SA", "Stearns"); 
		 super.addEntity("147", "SE", "SE", "Steele");
		 super.addEntity("149", "ST", "ST", "Stevens");
		 super.addEntity("151", "SW", "SW", "Swift");
		 super.addEntity("153", "TO", "TO", "Todd");
		 super.addEntity("155", "TR", "TR", "Traverse");
		 super.addEntity("157", "WB", "WB", "Wabasha"); 
		 super.addEntity("159", "WD", "WD", "Wadena");
		 super.addEntity("161", "WS", "WS", "Waseca");
		 super.addEntity("163", "WA", "WA", "Washington");
		 super.addEntity("165", "WT", "WT", "Watonwan");
		 super.addEntity("167", "WL", "WL", "Wilkin"); 
		 super.addEntity("169", "WI", "WI", "Winona");
		 super.addEntity("171", "WR", "WR", "Wright");
		 super.addEntity("173", "YM", "YM", "Yellow Medicine");
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
