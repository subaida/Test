import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MissouriMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MissouriMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MissouriMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AN", "AN", "Andrew");
		super.addEntity("005", "AT", "AT", "Atchison");
		super.addEntity("007", "AU", "AU", "Audrain");
		super.addEntity("009", "BY", "BY", "Barry");
		super.addEntity("011", "BR", "BR", "Barton");
		super.addEntity("013", "BA", "BA", "Bates");
		super.addEntity("015", "BT", "BT", "Benton");
		super.addEntity("017", "BN", "BN", "Bollinger");
		super.addEntity("019", "BO", "BO", "Boone");
		super.addEntity("021", "BC", "BC", "Buchanan");
		super.addEntity("023", "BU", "BU", "Butler");
		super.addEntity("025", "CA", "CA", "Caldwell");
		super.addEntity("027", "CW", "CW", "Callaway");
		super.addEntity("029", "CM", "CM", "Camden");
		super.addEntity("031", "CG", "CG", "Cape Girardeau");
		super.addEntity("033", "CR", "CR", "Carroll");
		super.addEntity("035", "CT", "CT", "Carter");
	    super.addEntity("037", "CS", "CS", "Cass");
		super.addEntity("039", "CE", "CE", "Cedar");
        super.addEntity("041", "CN", "CN", "Chariton");
        super.addEntity("043", "CH", "CH", "Christian");
        super.addEntity("045", "CK", "CK", "Clark");
        super.addEntity("047", "CY", "CY", "Clay");
        super.addEntity("049", "CI", "CI", "Clinton");
		super.addEntity("051", "CL", "CL", "Cole");
		super.addEntity("053", "CO", "CO", "Cooper");
		super.addEntity("055", "CF", "CF", "Crawford");
		super.addEntity("057", "DD", "DD", "Dade");
		super.addEntity("059", "DL", "DL", "Dallas");
		super.addEntity("061", "DA", "DA", "Daviess");
		super.addEntity("063", "DK", "DK", "DeKalb");
		super.addEntity("065", "DE", "DE", "Dent");
		super.addEntity("067", "DO", "DO", "Douglas");
		super.addEntity("069", "DU", "DU", "Dunklin");
		super.addEntity("071", "FR", "FR", "Franklin");
		super.addEntity("073", "GA", "GA", "Gasconade");
		super.addEntity("075", "GN", "GN", "Gentry");
		super.addEntity("077", "GE", "GE", "Greene");
		super.addEntity("079", "GR", "GR", "Grundy");
		super.addEntity("081", "HA", "HA", "Harrison");
		super.addEntity("083", "HE", "HE", "Henry");
		super.addEntity("085", "HK", "HK", "Hickory");
		super.addEntity("087", "HL", "HL", "Holt");
	     super.addEntity("089", "HW", "HW", "Howard");
		 super.addEntity("091", "HO", "HO", "Howell");
		 super.addEntity("093", "IR", "IR", "Iron");
		 super.addEntity("095", "JK", "JK", "Jackson");
		 super.addEntity("097", "JA", "JA", "Jasper");
		 super.addEntity("099", "JE", "JE", "Jefferson");
		 super.addEntity("101", "JO", "JO", "Johnson");
		 super.addEntity("103", "KN", "KN", "Knox");
		 super.addEntity("105", "LD", "LD", "Laclede");
		 super.addEntity("107", "LF", "LF", "Lafayette");
		 super.addEntity("109", "LA", "LA", "Lawrence");
		 super.addEntity("111", "LE", "LE", "Lewis");
		 super.addEntity("113", "LC", "LC", "Lincoln");
		 super.addEntity("115", "LN", "LN", "Linn");
		 super.addEntity("117", "LI", "LI", "Livingston");
		 super.addEntity("119", "MN", "MN", "McDonald");
		 super.addEntity("121", "MO", "MO", "Macon");
		 super.addEntity("123", "MD", "MD", "Madison");
		 super.addEntity("125", "ME", "ME", "Maries");
		 super.addEntity("127", "MA", "MA", "Marion");
		 super.addEntity("129", "MC", "MC", "Mercer");
		 super.addEntity("131", "ML", "ML", "Miller");
		 super.addEntity("133", "MS", "MS", "Mississippi");
		 super.addEntity("135", "MI", "MI", "Moniteau");
		 super.addEntity("137", "MR", "MR", "Monroe");
		 super.addEntity("139", "MY", "MY", "Montgomery");
		 super.addEntity("141", "MG", "MG", "Morgan");
		 super.addEntity("143", "NM", "NM", "New Madrid");
		 super.addEntity("145", "NE", "NE", "Newton");
		 super.addEntity("147", "NO", "NO", "Nodaway");
		 super.addEntity("149", "OR", "OR", "Oregon");
		 super.addEntity("151", "OS", "OS", "Osage");
		 super.addEntity("153", "OZ", "OZ", "Ozark");
		 super.addEntity("155", "PM", "PM", "Pemiscot");
		 super.addEntity("157", "PR", "PR", "Perry");
		 super.addEntity("159", "PT", "PT", "Pettis");
		 super.addEntity("161", "PH", "PH", "Phelps");
		 super.addEntity("163", "PI", "PI", "Pike");
		 super.addEntity("165", "PA", "PA", "Platte");
		 super.addEntity("167", "PO", "PO", "Polk");
		 super.addEntity("169", "PL", "PL", "Pulaski");
		 super.addEntity("171", "PU", "PU", "Putnam");
		 super.addEntity("173", "RS", "RS", "Ralls");
		 super.addEntity("175", "RO", "RO", "Randolph");
		 super.addEntity("177", "RA", "RA", "Ray");
		 super.addEntity("179", "RE", "RE", "Reynolds");
		 super.addEntity("181", "RI", "RI", "Ripley");
		 super.addEntity("183", "SR", "SR", "St.Charles");
		 super.addEntity("185", "SI", "SI", "St.Clair");
		 super.addEntity("186", "SG", "SG", "Ste.Genevieve");
		 super.addEntity("187", "SF", "SF", "St.Francois");
		 super.addEntity("189", "SO", "SO", "St.Louis");
		 super.addEntity("195", "SA", "SA", "Saline");
		 super.addEntity("197", "SY", "SY", "Schuyler");
		 super.addEntity("199", "SL", "SL", "Scotland");
		 super.addEntity("201", "SC", "SC", "Scott");
		 super.addEntity("203", "SN", "SN", "Shannon");
		 super.addEntity("205", "SH", "SH", "Shelby");
		 super.addEntity("207", "SD", "SD", "Stoddard");
		 super.addEntity("209", "ST", "ST", "Stone");
		 super.addEntity("211", "SU", "SU", "Sullivan");
		 super.addEntity("213", "TA", "TA", "Taney");
		 super.addEntity("215", "TE", "TE", "Texas");
		 super.addEntity("217", "VE", "VE", "Vernon");
		 super.addEntity("219", "WA", "WA", "Warren");
		 super.addEntity("221", "WS", "WS", "Washington");
		 super.addEntity("223", "WY", "WY", "Wayne");
		 super.addEntity("225", "WB", "WB", "Webster");
		 super.addEntity("227", "WO", "WO", "Worth");
		 super.addEntity("229", "WR", "WR", "Wright");
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
