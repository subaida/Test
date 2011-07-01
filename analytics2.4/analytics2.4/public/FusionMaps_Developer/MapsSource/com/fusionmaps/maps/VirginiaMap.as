import com.fusionmaps.core.Map;
class com.fusionmaps.maps.VirginiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "VirginiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function VirginiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AC", "AC", "Accomack");
		super.addEntity("003", "AL", "AL", "Albemarle");
		super.addEntity("005", "AE", "AE", "Alleghany");
		super.addEntity("007", "AM", "AM", "Amelia");
		super.addEntity("009", "AH", "AH", "Amherst");
		super.addEntity("011", "AP", "AP", "Appomattox");
		super.addEntity("013", "AR", "AR", "Arlington");
		super.addEntity("015", "AU", "AU", "Augusta");
		super.addEntity("017", "BA", "BA", "Bath");
		super.addEntity("019", "BE", "BE", "Bedford");
		super.addEntity("021", "BL", "BL", "Bland");
		super.addEntity("023", "BO", "BO", "Botetourt");
		super.addEntity("025", "BR", "BR", "Brunswick");
		super.addEntity("027", "BU", "BU", "Buchanan");
		super.addEntity("029", "BC", "BC", "Buckingham");
		super.addEntity("031", "CA", "CA", "Campbell");
		super.addEntity("033", "CR", "CR", "Caroline");
		super.addEntity("035", "CL", "CL", "Carroll");
		super.addEntity("036", "CC", "CC", "Charles City");
        super.addEntity("037", "CH", "CH", "Charlotte");
        super.addEntity("041", "CS", "CS", "Chesterfield");
        super.addEntity("043", "CK", "CK", "Clarke");
        super.addEntity("045", "CG", "CG", "Craig");
        super.addEntity("047", "CU", "CU", "Culpeper");
        super.addEntity("049", "CM", "CM", "Cumberland");
		super.addEntity("051", "DI", "DI", "Dickenson");
		super.addEntity("053", "DN", "DN", "Dinwiddie");
		super.addEntity("057", "ES", "ES", "Essex");
		super.addEntity("059", "FI", "FI", "Fairfax");
		super.addEntity("061", "FU", "FU", "Fauquier");
		super.addEntity("063", "FL", "FL", "Floyd");
		super.addEntity("065", "FV", "FV", "Fluvanna");
		super.addEntity("067", "FK", "FK", "Franklin");
		super.addEntity("069", "FD", "FD", "Frederick");
		super.addEntity("071", "GI", "GI", "Giles");
		super.addEntity("073", "GL", "GL", "Gloucester");
		super.addEntity("075", "GO", "GO", "Goochland");
		super.addEntity("077", "GR", "GR", "Grayson");
		super.addEntity("079", "GE", "GE", "Greene");
		super.addEntity("081", "GV", "GV", "Greensville");
		super.addEntity("083", "HL", "HL", "Halifax");
		super.addEntity("085", "HN", "HN", "Hanover");
		super.addEntity("087", "HC", "HC", "Henrico");
	     super.addEntity("089", "HY", "HY", "Henry");
		 super.addEntity("091", "HI", "HI", "Highland");
		 super.addEntity("093", "IW", "IW", "Isle of Wight");
		 super.addEntity("095", "JC", "JC", "James City");
		 super.addEntity("097", "KQ", "KQ", "King and Queen");
		 super.addEntity("099", "KG", "KG", "King George");
		 super.addEntity("101", "KW", "KW", "King William");
		 super.addEntity("103", "LA", "LA", "Lancaster");
		 super.addEntity("105", "LE", "LE", "Lee");
		 super.addEntity("107", "LO", "LO", "Loudoun");
		 super.addEntity("109", "LU", "LU", "Louisa");
		 super.addEntity("111", "LN", "LN", "Lunenburg");
		 super.addEntity("113", "MA", "MA", "Madison");
		 super.addEntity("115", "MT", "MT", "Mathews");
		 super.addEntity("117", "ME", "ME", "Mecklenburg");
		 super.addEntity("119", "MI", "MI", "Middlesex");
		 super.addEntity("121", "MO", "MO", "Montgomery");
		 super.addEntity("125", "NE", "NE", "Nelson");
		 super.addEntity("127", "NK", "NK", "New Kent");
		 super.addEntity("131", "NT", "NT", "Northampton"); 
		 super.addEntity("133", "NH", "NH", "Northumberland");
		 super.addEntity("135", "NW", "NW", "Nottoway");
		 super.addEntity("137", "OR", "OR", "Orange");
		 super.addEntity("139", "PA", "PA", "Page");
		 super.addEntity("141", "PT", "PT", "Patrick"); 
		 super.addEntity("143", "PI", "PI", "Pittsylvania");
		 super.addEntity("145", "PO", "PO", "Powhatan"); 
		 super.addEntity("147", "PE", "PE", "Prince Edward");
		 super.addEntity("149", "PG", "PG", "Prince George");
		 super.addEntity("153", "PW", "PW", "Prince William");
		 super.addEntity("155", "PU", "PU", "Pulaski");
		 super.addEntity("157", "RP", "RP", "Rappahannock"); 
		 super.addEntity("159", "RC", "RC", "Richmond");
		 super.addEntity("161", "RN", "RN", "Roanoke");
		 super.addEntity("163", "RK", "RK", "Rockbridge");
		 super.addEntity("165", "RG", "RG", "Rockingham");
		 super.addEntity("167", "RU", "RU", "Russell"); 
		 super.addEntity("169", "SC", "SC", "Scott");
		 super.addEntity("171", "SH", "SH", "Shenandoah");
		 super.addEntity("173", "SM", "SM", "Smyth");
		 super.addEntity("175", "SU", "SU", "Southampton");
		 super.addEntity("177", "SP", "SP", "Spotsylvania");
		 super.addEntity("179", "ST", "ST", "Stafford");
		 
		 super.addEntity("181", "SR", "SR", "Surry");
		 super.addEntity("183", "SS", "SS", "Sussex"); 
		 super.addEntity("185", "TA", "TA", "Tazewell");
		 super.addEntity("187", "WA", "WA", "Warren");
		 super.addEntity("191", "WS", "WS", "Washington");
		 
		 super.addEntity("193", "WE", "WE", "Westmoreland"); 
		 super.addEntity("195", "WI", "WI", "Wise"); 
		 super.addEntity("197", "WY", "WY", "Wythe"); 
		 super.addEntity("199", "YO", "YO", "York"); 
		 super.addEntity("510", "AX", "AX", "Alexandria(City)");
		 super.addEntity("515", "BF", "BF", "Bedford(City)");
		 
		 super.addEntity("520", "BS", "BS", "Bristol (City)"); 
		 super.addEntity("530", "BV", "BV", "Buena Vista (City)");
		 super.addEntity("540", "CV", "CV", "Charlottesville (City)");
		 super.addEntity("550", "CP", "CP", "Chesapeake (City)"); 
		 super.addEntity("570", "CO", "CO", "Colonial Heights (City)");
		super.addEntity("560", "CF", "CF", "Clifton Forge (City)");
		super.addEntity("580", "CI", "CI", "Covington (City)");
		 super.addEntity("590", "DA", "DA", "Danville (City)");
		 super.addEntity("595", "EM", "EM", "Emporia (City)");
		 super.addEntity("600", "FA", "FA", "Fairfax (City)");
		 super.addEntity("610", "FC", "FC", "Falls Church (City)");  
		 
		 super.addEntity("620", "FR", "FR", "Franklin (City)"); 
		 super.addEntity("630", "FE", "FE", "Fredericksburg (City)");
		 super.addEntity("640", "GA", "GA", "Galax (City)");
		 super.addEntity("650", "HA", "HA", "Hampton (City)");

		 super.addEntity("660", "HR", "HR", "Harrisonburg (City)");
		 super.addEntity("670", "HO", "HO", "Hopewell (City)");
		 super.addEntity("678", "LX", "LX", "Lexington (City)");
		 super.addEntity("680", "LY", "LY", "Lynchburg (City)"); 
		 super.addEntity("683", "MN", "MN", "Manassas (City)");
		 super.addEntity("685", "MP", "MP", "Manassas Park (City)");  
		 super.addEntity("690", "MV", "MV", "Martinsville (City)");
		 super.addEntity("700", "NN", "NN", "Newport News (City)");
		 super.addEntity("710", "NO", "NO", "Norfolk (City)"); 
		 super.addEntity("720", "NR", "NR", "Norton (City)");
		 super.addEntity("730", "PB", "PB", "Petersburg (City)"); 
		 
		 super.addEntity("735", "PQ", "PQ", "Poquoson (City)");
		 super.addEntity("740", "PM", "PM", "Portsmouth (City)");
		 super.addEntity("750", "RA", "RA", "Radford (City)");

		 super.addEntity("760", "RI", "RI", "Richmond (City)");
		 super.addEntity("770", "RO", "RO", "Roanoke (City)");
		 super.addEntity("775", "SA", "SA", "Salem (City)");
		 super.addEntity("790", "SN", "SN", "Staunton  (sCity)"); 
		 super.addEntity("800", "SF", "SF", "Suffolk (City)"); 
		 super.addEntity("810", "VB", "VB", "Virginia Beach (City)");
		 super.addEntity("820", "WB", "WB", "Waynesboro (City)");
		 super.addEntity("830", "WL", "WL", "Williamsburg (City)"); 
		 super.addEntity("840", "WT", "WT", "Winchester (City)");
		 
		 
		

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
