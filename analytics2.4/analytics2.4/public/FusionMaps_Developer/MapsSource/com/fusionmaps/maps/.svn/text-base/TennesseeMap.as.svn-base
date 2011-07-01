import com.fusionmaps.core.Map;
class com.fusionmaps.maps.TennesseeMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "TennesseeMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function TennesseeMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AN", "AN", "Anderson");
		super.addEntity("003", "BD", "BD", "Bedford");
		super.addEntity("005", "BE", "BE", "Benton");
		super.addEntity("007", "BL", "BL", "Bledsoe");
		super.addEntity("009", "BU", "BU", "Blount");
		super.addEntity("011", "BR", "BR", "Bradley");
		super.addEntity("013", "CA", "CA", "Campbell");
		super.addEntity("015", "CN", "CN", "Cannon");
		super.addEntity("017", "CR", "CR", "Carroll");
		super.addEntity("019", "CT", "CT", "Carter");
		super.addEntity("021", "CH", "CH", "Cheatham");
		super.addEntity("023", "CS", "CS", "Chester");
		super.addEntity("025", "CB", "CB", "Claiborne");
		super.addEntity("027", "CY", "CY", "Clay");
		super.addEntity("029", "CK", "CK", "Cocke");
		super.addEntity("031", "CF", "CF", "Coffee");
		super.addEntity("033", "CO", "CO", "Crockett");
		super.addEntity("035", "CM", "CM", "Cumberland");
		super.addEntity("037", "DA", "DA", "Davidson");
		super.addEntity("039", "DE", "DE", "Decatur");
        super.addEntity("041", "DK", "DK", "DeKalb");
        super.addEntity("043", "DI", "DI", "Dickson");
        super.addEntity("045", "DY", "DY", "Dyer");
        super.addEntity("047", "FA", "FA", "Fayette");
        super.addEntity("049", "FE", "FE", "Fentress");
		super.addEntity("051", "FR", "FR", "Franklin");
		super.addEntity("053", "GI", "GI", "Gibson");
		super.addEntity("055", "GL", "GL", "Giles");
		super.addEntity("057", "GR", "GR", "Grainger");
		super.addEntity("059", "GE", "GE", "Greene");
		super.addEntity("061", "GU", "GU", "Grundy");
		super.addEntity("063", "HA", "HA", "Hamblen");
		super.addEntity("065", "HM", "HM", "Hamilton");
		super.addEntity("067", "HN", "HN", "Hancock");
		super.addEntity("069", "HR", "HR", "Hardeman");
		super.addEntity("071", "HD", "HD", "Hardin");
		super.addEntity("073", "HW", "HW", "Hawkins");
		super.addEntity("075", "HY", "HY", "Haywood");
		super.addEntity("077", "HS", "HS", "Henderson");
		super.addEntity("079", "HE", "HE", "Henry");
		super.addEntity("081", "HI", "HI", "Hickman");
		super.addEntity("083", "HO", "HO", "Houston");
		super.addEntity("085", "HP", "HP", "Humphreys");
		super.addEntity("087", "JA", "JA", "Jackson");
	     super.addEntity("089", "JE", "JE", "Jefferson");
		 super.addEntity("091", "JO", "JO", "Johnson");
		 super.addEntity("093", "KN", "KN", "Knox");
		 super.addEntity("095", "LA", "LA", "Lake");
		 super.addEntity("097", "LU", "LU", "Lauderdale");
		 super.addEntity("099", "LW", "LW", "Lawrence");
		 super.addEntity("101", "LE", "LE", "Lewis");
		 super.addEntity("103", "LI", "LI", "Lincoln");
		 super.addEntity("105", "LO", "LO", "Loudon");
		 super.addEntity("107", "MC", "MC", "McMinn");
		 super.addEntity("109", "MY", "MY", "McNairy");
		 super.addEntity("111", "MA", "MA", "Macon");
		 super.addEntity("113", "MD", "MD", "Madison");
		 super.addEntity("115", "MR", "MR", "Marion");
		 super.addEntity("117", "MS", "MS", "Marshall");
		 super.addEntity("119", "MU", "MU", "Maury");
		 super.addEntity("121", "MI", "MI", "Meigs");
		 super.addEntity("123", "MO", "MO", "Monroe");
		 super.addEntity("125", "MG", "MG", "Montgomery"); 
		 super.addEntity("127", "ME", "ME", "Moore");
		 super.addEntity("129", "MN", "MN", "Morgan");
		 super.addEntity("131", "OB", "OB", "Obion"); 
		 super.addEntity("133", "OV", "OV", "Overton");
		 super.addEntity("135", "PE", "PE", "Perry");
		 super.addEntity("137", "PI", "PI", "Pickett");
		 super.addEntity("139", "PO", "PO", "Polk");
		 super.addEntity("141", "PU", "PU", "Putnam"); 
		 super.addEntity("143", "RH", "RH", "Rhea");
		 super.addEntity("145", "RO", "RO", "Roane"); 
		 super.addEntity("147", "RB", "RB", "Robertson");
		 super.addEntity("149", "RU", "RU", "Rutherford");
		 super.addEntity("151", "SC", "SC", "Scott");
		 super.addEntity("153", "SQ", "SQ", "Sequatchie");
		 super.addEntity("155", "SB", "SB", "Sevier");
		 super.addEntity("157", "SH", "SH", "Shelby"); 
		 super.addEntity("159", "SM", "SM", "Smith");
		 super.addEntity("161", "ST", "ST", "Stewart");
		 super.addEntity("163", "SL", "SL", "Sullivan");
		 super.addEntity("165", "SU", "SU", "Sumner");
		 super.addEntity("167", "TI", "TI", "Tipton"); 
		 super.addEntity("169", "TR", "TR", "Trousdale");
		 super.addEntity("171", "UI", "UI", "Unicoi");
		 super.addEntity("173", "UN", "UN", "Union");
		 super.addEntity("175", "VB", "VB", "Van Buren");
		 super.addEntity("177", "WR", "WR", "Warren");
		 super.addEntity("179", "WS", "WS", "Washington");
		 super.addEntity("181", "WA", "WA", "Wayne");
		 super.addEntity("183", "WE", "WE", "Weakley");
		 super.addEntity("185", "WH", "WH", "White");
		 super.addEntity("187", "WL", "WL", "Williamson");
		 super.addEntity("189", "WI", "WI", "Wilson");
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
