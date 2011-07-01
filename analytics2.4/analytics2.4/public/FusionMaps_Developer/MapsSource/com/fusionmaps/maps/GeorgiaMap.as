import com.fusionmaps.core.Map;
class com.fusionmaps.maps.GeorgiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "GeorgiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function GeorgiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AP", "Appling");
		super.addEntity("003", "003", "AT", "Atkinson");
		super.addEntity("005", "005", "BA", "Bacon");
		super.addEntity("007", "007", "BK", "Baker");
		super.addEntity("009", "009", "BD", "Baldwin");
		super.addEntity("011", "011", "BN", "Banks");
		super.addEntity("013", "013", "BW", "Barrow");
		super.addEntity("015", "015", "BT", "Bartow");
		super.addEntity("017", "017", "BH", "Ben Hill");
		super.addEntity("019", "019", "BI", "Berrien");
		super.addEntity("021", "021", "BB", "Bibb");
		super.addEntity("023", "023", "BL", "Bleckley");
		super.addEntity("025", "025", "BE", "Brantley");
		super.addEntity("027", "027", "BO", "Brooks");
		super.addEntity("029", "029", "BR", "Bryan");
		super.addEntity("031", "031", "BC", "Bulloch");
		super.addEntity("033", "033", "BU", "Burke");
		super.addEntity("035", "035", "BS", "Butts");
		super.addEntity("037", "037", "CL", "Calhoun");
		super.addEntity("039", "039", "CM", "Camden");
		super.addEntity("043", "043", "CN", "Candler");
		super.addEntity("045", "045", "CR", "Carroll");
		super.addEntity("047", "047", "CS", "Catoosa");
		super.addEntity("049", "049", "CH", "Charlton");
		super.addEntity("051", "051", "CA", "Chatham");
		super.addEntity("053", "053", "CC", "Chattahoochee");
		super.addEntity("055", "055", "CG", "Chattooga");
		super.addEntity("057", "057", "CE", "Cherokee");
		super.addEntity("059", "059", "CK", "Clarke");
		super.addEntity("061", "061", "CY", "Clay");
		super.addEntity("063", "063", "CT", "Clayton");
		super.addEntity("065", "065", "CI", "Clinch");
		super.addEntity("067", "067", "CB", "Cobb");
		super.addEntity("069", "069", "CF", "Coffee");
		super.addEntity("071", "071", "CQ", "Colquitt");
		super.addEntity("073", "073", "CU", "Columbia");
		super.addEntity("075", "075", "CO", "Cook");
		super.addEntity("077", "077", "CW", "Coweta");
		super.addEntity("079", "079", "CD", "Crawford");
		super.addEntity("081", "081", "CP", "Crisp");
		super.addEntity("083", "083", "DA", "Dade");
		super.addEntity("085", "085", "DW", "Dawson");
		super.addEntity("087", "087", "DE", "Decatur");
		super.addEntity("089", "089", "DK", "DeKalb");
		super.addEntity("091", "091", "DO", "Dodge");
		super.addEntity("093", "093", "DL", "Dooly");
		super.addEntity("095", "095", "DU", "Dougherty");
		super.addEntity("097", "097", "DG", "Douglas");
		super.addEntity("099", "099", "EA", "Early");
		super.addEntity("101", "101", "EC", "Echols");
		super.addEntity("103", "103", "EF", "Effingham");
		super.addEntity("105", "105", "EL", "Elbert");
		super.addEntity("107", "107", "EM", "Emanuel");
		super.addEntity("109", "109", "EV", "Evans");
		super.addEntity("111", "111", "FA", "Fannin");
		super.addEntity("113", "113", "FY", "Fayette");
		super.addEntity("115", "115", "FL", "Floyd");
		super.addEntity("117", "117", "FO", "Forsyth");
		super.addEntity("119", "119", "FR", "Franklin");
		super.addEntity("121", "121", "FU", "Fulton");
		super.addEntity("123", "123", "GI", "Gilmer");
		super.addEntity("125", "125", "GL", "Glascock");
		super.addEntity("127", "127", "GY", "Glynn");
		super.addEntity("129", "129", "GO", "Gordon");
		super.addEntity("131", "131", "GR", "Grady");
		super.addEntity("133", "133", "GE", "Greene");
		super.addEntity("135", "135", "GW", "Gwinnett");
		super.addEntity("137", "137", "HA", "Habersham");
		super.addEntity("139", "139", "HL", "Hall");
		super.addEntity("141", "141", "HN", "Hancock");
		super.addEntity("143", "143", "HR", "Haralson");
		super.addEntity("145", "145", "HI", "Harris");
		super.addEntity("147", "147", "HT", "Hart");
		super.addEntity("149", "149", "HE", "Heard");
		super.addEntity("151", "151", "HY", "Henry");
		super.addEntity("153", "153", "HO", "Houston");
		super.addEntity("155", "155", "IR", "Irwin");
		super.addEntity("157", "157", "JA", "Jackson");
		super.addEntity("159", "159", "JS", "Jasper");
		super.addEntity("161", "161", "JD", "Jeff Davis");
		super.addEntity("163", "163", "JE", "Jefferson");
		super.addEntity("165", "165", "JK", "Jenkins");
		super.addEntity("167", "167", "JO", "Johnson");
		super.addEntity("169", "169", "JN", "Jones");
		super.addEntity("171", "171", "LA", "Lamar");
		super.addEntity("173", "173", "LN", "Lanier");
		super.addEntity("175", "175", "LU", "Laurens");
		super.addEntity("177", "177", "LE", "Lee");
		super.addEntity("179", "179", "LI", "Liberty");
		super.addEntity("181", "181", "LC", "Lincoln");
		super.addEntity("183", "183", "LO", "Long");
		super.addEntity("185", "185", "LW", "Lowndes");
		super.addEntity("187", "187", "LP", "Lumpkin");
		super.addEntity("193", "193", "MA", "Macon");
		super.addEntity("195", "195", "MD", "Madison");
		super.addEntity("197", "197", "MR", "Marion");
		super.addEntity("189", "189", "MC", "Mcduffie");
		super.addEntity("191", "191", "MI", "Mcintosh");
		super.addEntity("199", "199", "ME", "Meriwether");
		super.addEntity("201", "201", "ML", "Miller");
		super.addEntity("205", "205", "MT", "Mitchell");
		super.addEntity("207", "207", "MO", "Monroe");
		super.addEntity("209", "209", "MG", "Montgomery");
		super.addEntity("211", "211", "MN", "Morgan");
		super.addEntity("213", "213", "MU", "Murray");
		super.addEntity("215", "215", "MS", "Muscogee");
		super.addEntity("217", "217", "NE", "Newton");
		super.addEntity("219", "219", "OC", "Oconee");
		super.addEntity("221", "221", "OG", "Oglethorpe");
		super.addEntity("223", "223", "PD", "Paulding");
		super.addEntity("225", "225", "PA", "Peach");
		super.addEntity("227", "227", "PC", "Pickens");
		super.addEntity("229", "229", "PE", "Pierce");
		super.addEntity("231", "231", "PI", "Pike");
		super.addEntity("233", "233", "PO", "Polk");
		super.addEntity("235", "235", "PL", "Pulaski");
		super.addEntity("237", "237", "PU", "Putnam");
		super.addEntity("239", "239", "QU", "Quitman");
		super.addEntity("241", "241", "RB", "Rabun");
		super.addEntity("243", "243", "RA", "Randolph");
		super.addEntity("245", "245", "RI", "Richmond");
		super.addEntity("247", "247", "RO", "Rockdale");
		super.addEntity("249", "249", "SC", "Schley");
		super.addEntity("251", "251", "SR", "Screven");
		super.addEntity("253", "253", "SM", "Seminole");
		super.addEntity("255", "255", "SP", "Spalding");
		super.addEntity("257", "257", "SE", "Stephens");
		super.addEntity("259", "259", "ST", "Stewart");
		super.addEntity("261", "261", "SU", "Sumter");
		super.addEntity("263", "263", "TB", "Talbot");
		super.addEntity("265", "265", "TA", "Taliaferro");
		super.addEntity("267", "267", "TT", "Tattnall");
		super.addEntity("269", "269", "TY", "Taylor");
		super.addEntity("271", "271", "TF", "Telfair");
		super.addEntity("273", "273", "TL", "Terrell");
		super.addEntity("275", "275", "TH", "Thomas");
		super.addEntity("277", "277", "TI", "Tift");
		super.addEntity("279", "279", "TM", "Toombs");
		super.addEntity("281", "281", "TO", "Towns");
		super.addEntity("283", "283", "TE", "Treutlen");
		super.addEntity("285", "285", "TR", "Troup");
		super.addEntity("287", "287", "TU", "Turner");
		super.addEntity("289", "289", "TW", "Twiggs");
		super.addEntity("291", "291", "UN", "Union");
		super.addEntity("293", "293", "UP", "Upson");
		super.addEntity("295", "295", "WK", "Walker");
		super.addEntity("297", "297", "WN", "Walton");
		super.addEntity("299", "299", "WA", "Ware");
		super.addEntity("301", "301", "WR", "Warren");
		super.addEntity("303", "303", "WG", "Washington");
		super.addEntity("305", "305", "WY", "Wayne");
		super.addEntity("307", "307", "WS", "Webster");
		super.addEntity("309", "309", "WE", "Wheeler");
		super.addEntity("311", "311", "WT", "White");
		super.addEntity("313", "313", "WH", "Whitfield");
		super.addEntity("315", "315", "WC", "Wilcox");
		super.addEntity("317", "317", "WL", "Wilkes");
		super.addEntity("319", "319", "WI", "Wilkinson");
		super.addEntity("321", "321", "WO", "Worth");
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
