import com.fusionmaps.core.Map;
class com.fusionmaps.maps.KentuckyMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "KentuckyMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function KentuckyMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AD", "AD", "Adair");
		super.addEntity("003", "AL", "AL", "Allen");
		super.addEntity("005", "AN", "AN", "Anderson");
		super.addEntity("007", "BA", "BA", "Ballard");
		super.addEntity("009", "BR", "BR", "Barren");
		super.addEntity("011", "BT", "BT", "Bath");
		super.addEntity("013", "BE", "BE", "Bell");
		super.addEntity("015", "BN", "BN", "Boone");
		super.addEntity("017", "BO", "BO", "Bourbon");
		super.addEntity("019", "BY", "BY", "Boyd");
		super.addEntity("021", "BL", "BL", "Boyle");
		super.addEntity("023", "BK", "BK", "Bracken");
		super.addEntity("025", "BH", "BH", "Breathitt");
		super.addEntity("027", "BG", "BG", "Breckinridge");
		super.addEntity("029", "BI", "BI", "Bullitt");
		super.addEntity("031", "BU", "BU", "Butler");
		super.addEntity("033", "CA", "CA", "Caldwell");
		super.addEntity("035", "CL", "CL", "Calloway");
        super.addEntity("037", "CB", "CB", "Campbell");
		super.addEntity("039", "CR", "CR", "Carlisle");
        super.addEntity("041", "CO", "CO", "Carroll");
        super.addEntity("043", "CT", "CT", "Carter");
        super.addEntity("045", "CS", "CS", "Casey");
        super.addEntity("047", "CH", "CH", "Christian");
        super.addEntity("049", "CK", "CK", "Clark");
		super.addEntity("051", "CY", "CY", "Clay");
		super.addEntity("053", "CN", "CN", "Clinton");
		super.addEntity("055", "CD", "CD", "Crittenden");
		super.addEntity("057", "CM", "CM", "Cumberland");
		super.addEntity("059", "DA", "DA", "Daviess");
		super.addEntity("061", "ED", "ED", "Edmonson");
		super.addEntity("063", "EL", "EL", "Elliott");
		super.addEntity("065", "ES", "ES", "Estill");
		super.addEntity("067", "FA", "FA", "Fayette");
		super.addEntity("069", "FL", "FL", "Fleming");
		super.addEntity("071", "FO", "FO", "Floyd");
		super.addEntity("073", "FR", "FR", "Franklin");
		super.addEntity("075", "FU", "FU", "Fulton");
		super.addEntity("077", "GA", "GA", "Gallatin");
		super.addEntity("079", "GR", "GR", "Garrard");
		super.addEntity("081", "GN", "GN", "Grant");
		super.addEntity("083", "GV", "GV", "Graves");
		super.addEntity("085", "GY", "GY", "Grayson");
		super.addEntity("087", "GE", "GE", "Green");
	     super.addEntity("089", "GU", "GU", "Greenup");
		 super.addEntity("091", "HA", "HA", "Hancock");
		 super.addEntity("093", "HR", "HR", "Hardin");
		 super.addEntity("095", "HL", "HL", "Harlan");
		 super.addEntity("097", "HI", "HI", "Harrison");
		 super.addEntity("099", "HT", "HT", "Hart");
		 super.addEntity("101", "HE", "HE", "Henderson");
		 super.addEntity("103", "HY", "HY", "Henry");
		 super.addEntity("105", "HK", "HK", "Hickman");
		 super.addEntity("107", "HO", "HO", "Hopkins");
		 super.addEntity("109", "JA", "JA", "Jackson");
		 super.addEntity("111", "JE", "JE", "Jefferson");
		 super.addEntity("113", "JS", "JS", "Jessamine");
		 super.addEntity("115", "JO", "JO", "Johnson");
		 super.addEntity("117", "KE", "KE", "Kenton");
		 super.addEntity("119", "KN", "KN", "Knott");
		 super.addEntity("121", "KO", "KO", "Knox");
		 super.addEntity("123", "LA", "LA", "Larue");
		 super.addEntity("125", "LU", "LU", "Laurel");
		 super.addEntity("127", "LW", "LW", "Lawrence");
		 super.addEntity("129", "LE", "LE", "Lee");
		 super.addEntity("131", "LS", "LS", "Leslie"); 
		 super.addEntity("133", "LT", "LT", "Letcher");
		 super.addEntity("135", "LI", "LI", "Lewis");
		 super.addEntity("137", "LN", "LN", "Lincoln");
		 super.addEntity("139", "LG", "LG", "Livingston");
		 super.addEntity("141", "LO", "LO", "Logan"); 
		 super.addEntity("143", "LY", "LY", "Lyon");
		 super.addEntity("145", "MK", "MK", "McCracken"); 
		 super.addEntity("147", "MR", "MR", "McCreary");
		 super.addEntity("149", "ML", "ML", "McLean");
		 super.addEntity("151", "MI", "MI", "Madison");
		 super.addEntity("153", "MG", "MG", "Magoffin");
		 super.addEntity("155", "MH", "MH", "Marion");
		 super.addEntity("157", "MS", "MS", "Marshall"); 
		 super.addEntity("159", "MT", "MT", "Martin");
		 super.addEntity("161", "MO", "MO", "Mason");
		 super.addEntity("163", "MD", "MD", "Meade");
		 super.addEntity("165", "ME", "ME", "Menifee");
		 super.addEntity("167", "MC", "MC", "Mercer"); 
		 super.addEntity("169", "MF", "MF", "Metcalfe");
		 super.addEntity("171", "MN", "MN", "Monroe");
		 super.addEntity("173", "MY", "MY", "Montgomery");
		 super.addEntity("175", "MA", "MA", "Morgan");
		 super.addEntity("177", "MB", "MB", "Muhlenberg");
		 super.addEntity("179", "NE", "NE", "Nelson");
		 super.addEntity("181", "NI", "NI", "Nicholas");
		 super.addEntity("183", "OH", "OH", "Ohio"); 
		 super.addEntity("185", "OL", "OL", "Oldham");
		 super.addEntity("187", "OW", "OW", "Owen");
		 super.addEntity("189", "OS", "OS", "Owsley");
		 super.addEntity("191", "PE", "PE", "Pendleton");
		 super.addEntity("193", "PR", "PR", "Perry"); 
		 super.addEntity("195", "PI", "PI", "Pike"); 
		 super.addEntity("197", "PO", "PO", "Powell"); 
		 super.addEntity("199", "PU", "PU", "Pulaski"); 
		 super.addEntity("201", "RO", "RO", "Robertson");
		 super.addEntity("203", "RC", "RC", "Rockcastle");
		 super.addEntity("205", "RW", "RW", "Rowan"); 
		 super.addEntity("207", "RS", "RS", "Russell");
		 super.addEntity("209", "SC", "SC", "Scott");
		 super.addEntity("211", "SH", "SH", "Shelby"); 
		 super.addEntity("213", "SI", "SI", "Simpson");
		super.addEntity("215", "SP", "SP", "Spencer");
		super.addEntity("217", "TA", "TA", "Taylor");
		 super.addEntity("219", "TO", "TO", "Todd");
		 super.addEntity("221", "TR", "TR", "Trigg");
		 super.addEntity("223", "TI", "TI", "Trimble");
		 super.addEntity("225", "UN", "UN", "Union");  
		 super.addEntity("227", "WA", "WA", "Warren"); 
		 super.addEntity("229", "WS", "WS", "Washington");
		 super.addEntity("231", "WY", "WY", "Wayne");
		 super.addEntity("233", "WB", "WB", "Webster");
		 super.addEntity("235", "WH", "WH", "Whitley");
		 super.addEntity("237", "WO", "WO", "Wolfe");
		 super.addEntity("239", "WD", "WD", "Woodford");
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
