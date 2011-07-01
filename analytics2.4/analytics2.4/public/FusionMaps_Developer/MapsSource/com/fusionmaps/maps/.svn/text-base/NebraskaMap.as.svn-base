import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NebraskaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NebraskaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NebraskaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AN", "AN", "Antelope");
		super.addEntity("005", "AR", "AR", "Arthur");
		super.addEntity("007", "BA", "BA", "Banner");
		super.addEntity("009", "BL", "BL", "Blaine");
		super.addEntity("011", "BO", "BO", "Boone");
		super.addEntity("013", "BX", "BX", "Box Butte");
		super.addEntity("015", "BY", "BY", "Boyd");
		super.addEntity("017", "BR", "BR", "Brown");
		super.addEntity("019", "BF", "BF", "Buffalo");
		super.addEntity("021", "BU", "BU", "Burt");
		super.addEntity("023", "BT", "BT", "Butler");
		super.addEntity("025", "CA", "CA", "Cass");
		super.addEntity("027", "CE", "CE", "Cedar");
		super.addEntity("029", "CH", "CH", "Chase");
		super.addEntity("031", "CR", "CR", "Cherry");
		super.addEntity("033", "CY", "CY", "Cheyenne");
		super.addEntity("035", "CL", "CL", "Clay");
		super.addEntity("037", "CO", "CO", "Colfax");
        super.addEntity("039", "CU", "CU", "Cuming");
        super.addEntity("041", "CS", "CS", "Custer");
        super.addEntity("043", "DA", "DA", "Dakota");
        super.addEntity("045", "DW", "DW", "Dawes");
        super.addEntity("047", "DS", "DS", "Dawson");
        super.addEntity("049", "DE", "DE", "Deuel");
		super.addEntity("051", "DI", "DI", "Dixon");
		super.addEntity("053", "DO", "DO", "Dodge");
		super.addEntity("055", "DU", "DU", "Douglas");
		super.addEntity("057", "DN", "DN", "Dundy");
		super.addEntity("059", "FI", "FI", "Fillmore");
		super.addEntity("061", "FR", "FR", "Franklin");
		super.addEntity("063", "FO", "FO", "Frontier");
		super.addEntity("065", "FU", "FU", "Furnas");
		super.addEntity("067", "GA", "GA", "Gage");
		super.addEntity("069", "GR", "GR", "Garden");
		super.addEntity("071", "GF", "GF", "Garfield");
		super.addEntity("073", "GO", "GO", "Gosper");
		super.addEntity("075", "GT", "GT", "Grant");
		super.addEntity("077", "GE", "GE", "Greeley");
		super.addEntity("079", "HA", "HA", "Hall");
		super.addEntity("081", "HM", "HM", "Hamilton");
		super.addEntity("083", "HR", "HR", "Harlan");
		super.addEntity("085", "HY", "HY", "Hayes");
	     super.addEntity("087", "HT", "HT", "Hitchcock");
		 super.addEntity("089", "HO", "HO", "Holt");
		 super.addEntity("091", "HK", "HK", "Hooker");
		 super.addEntity("093", "HW", "HW", "Howard");
		 super.addEntity("095", "JE", "JE", "Jefferson");
		 super.addEntity("097", "JO", "JO", "Johnson");
		 super.addEntity("099", "KE", "KE", "Kearney");
		 super.addEntity("101", "KI", "KI", "Keith");
		 super.addEntity("103", "KP", "KP", "Keya Paha");
		 super.addEntity("105", "KM", "KM", "Kimball");
		 super.addEntity("107", "KN", "KN", "Knox");
		 super.addEntity("109", "LA", "LA", "Lancaster");
		 super.addEntity("111", "LI", "LI", "Lincoln");
		 super.addEntity("113", "LO", "LO", "Logan");
		 super.addEntity("115", "LU", "LU", "Loup");
		 super.addEntity("117", "MP", "MP", "McPherson");
		 super.addEntity("119", "MA", "MA", "Madison");
		 super.addEntity("121", "ME", "ME", "Merrick");
		 super.addEntity("123", "MO", "MO", "Morrill");
		 super.addEntity("125", "NA", "NA", "Nance");
		 super.addEntity("127", "NE", "NE", "Nemaha"); 
		 super.addEntity("129", "NU", "NU", "Nuckolls");
		 super.addEntity("131", "OT", "OT", "Otoe");
		 super.addEntity("133", "PA", "PA", "Pawnee");
		 super.addEntity("135", "PE", "PE", "Perkins");
		 super.addEntity("137", "PH", "PH", "Phelps"); 
		 super.addEntity("139", "PI", "PI", "Pierce");
		 super.addEntity("141", "PL", "PL", "Platte"); 
		 super.addEntity("143", "PO", "PO", "Polk");
		 super.addEntity("145", "RW", "RW", "Red Willow");
		 super.addEntity("147", "RI", "RI", "Richardson");
		 super.addEntity("149", "RO", "RO", "Rock");
		 super.addEntity("151", "SA", "SA", "Saline"); 
		 super.addEntity("153", "SR", "SR", "Sarpy");
		 super.addEntity("155", "SU", "SU", "Saunders");
		 super.addEntity("157", "SB", "SB", "Scotts Bluff");
		 super.addEntity("159", "SE", "SE", "Seward");
		 super.addEntity("161", "SH", "SH", "Sheridan"); 
		 super.addEntity("163", "SM", "SM", "Sherman");
		 super.addEntity("165", "SI", "SI", "Sioux");
		 super.addEntity("167", "ST", "ST", "Stanton");
		 super.addEntity("169", "TH", "TH", "Thayer");
		 super.addEntity("171", "TO", "TO", "Thomas");
		 super.addEntity("173", "TU", "TU", "Thurston");
		 super.addEntity("175", "VA", "VA", "Valley");
		 super.addEntity("177", "WA", "WA", "Washington");
		 super.addEntity("179", "WY", "WY", "Wayne");
		 super.addEntity("181", "WB", "WB", "Webster");
		 super.addEntity("183", "WH", "WH", "Wheeler");
		 super.addEntity("185", "YO", "YO", "York");
		 
		 
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
