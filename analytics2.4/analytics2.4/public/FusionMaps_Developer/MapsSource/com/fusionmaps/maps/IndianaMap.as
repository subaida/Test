import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IndianaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IndianaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IndianaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AD", "AD", "Adams");
		super.addEntity("003", "AL", "AL", "Allen");
		super.addEntity("005", "BA", "BA", "Bartholomew");
		super.addEntity("007", "BE", "BE", "Benton");
		super.addEntity("009", "BL", "BL", "Blackford");
		super.addEntity("011", "BO", "BO", "Boone");
		super.addEntity("013", "BR", "BR", "Brown");
		super.addEntity("015", "CA", "CA", "Carroll");
		super.addEntity("017", "CS", "CS", "Cass");
		super.addEntity("019", "CL", "CL", "Clark");
		super.addEntity("021", "CY", "CY", "Clay");
		super.addEntity("023", "CI", "CI", "Clinton");
		super.addEntity("025", "CR", "CR", "Crawford");
		super.addEntity("027", "DA", "DA", "Daviess");
		super.addEntity("029", "DE", "DE", "Dearborn");
		super.addEntity("031", "DC", "DC", "Decatur");
		super.addEntity("033", "DK", "DK", "De Kalb");
		super.addEntity("035", "DL", "DL", "Delaware");
	    super.addEntity("037", "DU", "DU", "Dubois");
        super.addEntity("039", "EL", "EL", "Elkhart");
        super.addEntity("041", "FA", "FA", "Fayette");
        super.addEntity("043", "FL", "FL", "Floyd");
        super.addEntity("045", "FO", "FO", "Fountain");
		super.addEntity("047", "FR", "FR", "Franklin");
        super.addEntity("049", "FU", "FU", "Fulton");
		super.addEntity("051", "GI", "GI", "Gibson");
		super.addEntity("053", "GR", "GR", "Grant");
	    super.addEntity("055", "GE", "GE", "Greene");
		super.addEntity("057", "HA", "HA", "Hamilton");
		super.addEntity("059", "HN", "HN", "Hancock");
		super.addEntity("061", "HR", "HR", "Harrison");
		super.addEntity("063", "HD", "HD", "Hendricks");
		super.addEntity("065", "HY", "HY", "Henry");
		super.addEntity("067", "HO", "HO", "Howard");
		super.addEntity("069", "HU", "HU", "Huntington");
		super.addEntity("071", "JA", "JA", "Jackson");
		super.addEntity("073", "JS", "JS", "Jasper");
		super.addEntity("075", "JY", "JY", "Jay");
		super.addEntity("077", "JE", "JE", "Jefferson");
		super.addEntity("079", "JN", "JN", "Jennings");
		super.addEntity("081", "JO", "JO", "Johnson");
		super.addEntity("083", "KN", "KN", "Knox");
		super.addEntity("085", "KO", "KO", "Kosciusko");
		super.addEntity("087", "LA", "LA", "Lagrange");
	    super.addEntity("089", "LK", "LK", "Lake");
		super.addEntity("091", "LP", "LP", "La Porte");
		super.addEntity("093", "LW", "LW", "Lawrence");
		super.addEntity("095", "MA", "MA", "Madison");
		super.addEntity("097", "MR", "MR", "Marion");
		super.addEntity("099", "MS", "MS", "Marshall");
		super.addEntity("101", "MT", "MT", "Martin");
		super.addEntity("103", "MI", "MI", "Miami");
		super.addEntity("105", "MO", "MO", "Monroe");
		super.addEntity("107", "MN", "MN", "Montgomery");
		super.addEntity("109", "MG", "MG", "Morgan");
		super.addEntity("111", "NE", "NE", "Newton");
	    super.addEntity("113", "NO", "NO", "Noble");
		 super.addEntity("115", "OH", "OH", "Ohio");
		 super.addEntity("117", "OR", "OR", "Orange");
		 super.addEntity("119", "OW", "OW", "Owen");
		 super.addEntity("121", "PA", "PA", "Parke");
		 super.addEntity("123", "PE", "PE", "Perry");
		 super.addEntity("125", "PI", "PI", "Pike");
		 super.addEntity("127", "PO", "PO", "Porter");
		 super.addEntity("129", "PS", "PS", "Posey");
		 super.addEntity("131", "PU", "PU", "Pulaski"); 
		 super.addEntity("133", "PT", "PT", "Putnam");
		 super.addEntity("135", "RA", "RA", "Randolph");
		 super.addEntity("137", "RI", "RI", "Ripley");
		 super.addEntity("139", "RU", "RU", "Rush");
		 super.addEntity("141", "SJ", "SJ", "St.Joseph"); 
		 super.addEntity("143", "SC", "SC", "Scott");
		 super.addEntity("145", "SH", "SH", "Shelby"); 
		 super.addEntity("147", "SP", "SP", "Spencer");
		 super.addEntity("149", "ST", "ST", "Starke");
		 super.addEntity("151", "SU", "SU", "Steuben");
		 super.addEntity("153", "SL", "SL", "Sullivan");
		 super.addEntity("155", "SW", "SW", "Switzerland");
		 super.addEntity("157", "TI", "TI", "Tippecanoe"); 
		 super.addEntity("159", "TP", "TP", "Tipton");
		 super.addEntity("161", "UN", "UN", "Union");
		 super.addEntity("163", "VA", "VA", "Vanderburgh");
		 super.addEntity("165", "VE", "VE", "Vermillion");
		 super.addEntity("167", "VI", "VI", "Vigo"); 
		 super.addEntity("169", "WA", "WA", "Wabash");
		 super.addEntity("171", "WR", "WR", "Warren");
		 super.addEntity("173", "WI", "WI", "Warrick");
		 super.addEntity("175", "WS", "WS", "Washington");
		 super.addEntity("177", "WY", "WY", "Wayne");
		 super.addEntity("179", "WE", "WE", "Wells");
		 super.addEntity("181", "WH", "WH", "White");
		 super.addEntity("183", "WL", "WL", "Whitley"); 
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
