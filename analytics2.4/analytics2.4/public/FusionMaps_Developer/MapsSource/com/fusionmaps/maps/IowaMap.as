import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IowaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IowaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IowaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AA", "AA", "Adams");
		super.addEntity("005", "AL", "AL", "Allamakee");
		super.addEntity("007", "AP", "AP", "Appanoose");
		super.addEntity("009", "AU", "AU", "Audubon");
		super.addEntity("011", "BE", "BE", "Benton");
		super.addEntity("013", "BH", "BH", "Black Hawk");
		super.addEntity("015", "BO", "BO", "Boone");
		super.addEntity("017", "BR", "BR", "Bremer");
		super.addEntity("019", "BU", "BU", "Buchanan");
		super.addEntity("021", "BV", "BV", "Buena Vista");
		super.addEntity("023", "BT", "BT", "Butler");
		super.addEntity("025", "CA", "CA", "Calhoun");
		super.addEntity("027", "CR", "CR", "Carroll");
		super.addEntity("029", "CS", "CS", "Cass");
		super.addEntity("031", "CE", "CE", "Cedar");
		super.addEntity("033", "CG", "CG", "Cerro Gordo");
		super.addEntity("035", "CH", "CH", "Cherokee");
		super.addEntity("037", "CK", "CK", "Chickasaw");
		super.addEntity("039", "CL", "CL", "Clarke");
		super.addEntity("041", "CY", "CY", "Clay");
		super.addEntity("043", "CT", "CT", "Clayton");
		super.addEntity("045", "CN", "CN", "Clinton");
		super.addEntity("047", "CF", "CF", "Crawford");
		super.addEntity("049", "DA", "DA", "Dallas");
		super.addEntity("051", "DV", "DV", "Davis");
		super.addEntity("053", "DE", "DE", "Decator");
		super.addEntity("055", "DL", "DL", "Delaware");
		super.addEntity("057", "DM", "DM", "Des Moines");
		super.addEntity("059", "DI", "DI", "Dickinson");
		super.addEntity("061", "DU", "DU", "Dubuque");
		super.addEntity("063", "EM", "EM", "Emmet");
		super.addEntity("065", "FA", "FA", "Fayette");
		super.addEntity("067", "FL", "FL", "Floyd");
		super.addEntity("069", "FR", "FR", "Franklin");
		
		super.addEntity("071", "FE", "FE", "Fremont");
		super.addEntity("073", "GR", "GR", "Greene");
		super.addEntity("075", "GU", "GU", "Grundy");
		super.addEntity("077", "GT", "GT", "Guthrie");
		super.addEntity("079", "HA", "HA", "Hamilton");
		super.addEntity("081", "HN", "HN", "Hancock");
		super.addEntity("083", "HR", "HR", "Hardin");
		super.addEntity("085", "HI", "HI", "Harrison");
		super.addEntity("087", "HE", "HE", "Henry");
		super.addEntity("089", "HO", "HO", "Howard");
		super.addEntity("091", "HU", "HU", "Humboldt");
		super.addEntity("093", "ID", "ID", "Ida");
		super.addEntity("095", "IW", "IW", "Iowa");
		super.addEntity("097", "JA", "JA", "Jackson");
		super.addEntity("099", "JS", "JS", "Jasper");
		super.addEntity("101", "JE", "JE", "Jefferson");
		super.addEntity("103", "JO", "JO", "Johnson");
		super.addEntity("105", "JN", "JN", "Jones");
		super.addEntity("107", "KE", "KE", "Keokuk");
		super.addEntity("109", "KO", "KO", "Kossuth");
		super.addEntity("111", "LE", "LE", "Lee");
		super.addEntity("113", "LI", "LI", "Linn");
		super.addEntity("115", "LO", "LO", "Louisa");
		super.addEntity("117", "LU", "LU", "Lucas");
		super.addEntity("119", "LY", "LY", "Lyon");
		super.addEntity("121", "MA", "MA", "Madison");
		super.addEntity("123", "MH", "MH", "Mahaska");
		super.addEntity("125", "MR", "MR", "Marion");
		super.addEntity("127", "MS", "MS", "Marshall");
		super.addEntity("129", "MI", "MI", "Mills");
		super.addEntity("131", "MT", "MT", "Mitchell");
		super.addEntity("133", "MO", "MO", "Monona");
		super.addEntity("135", "MN", "MN", "Monroe");
		super.addEntity("137", "MG", "MG", "Montgomery");
		super.addEntity("139", "MU", "MU", "Muscatine");
		super.addEntity("141", "OB", "OB", "O'Brien");
		super.addEntity("143", "OS", "OS", "Osceola");
		super.addEntity("145", "PA", "PA", "Page");
		super.addEntity("147", "PL", "PL", "Palo Alto");
		super.addEntity("149", "PY", "PY", "Plymouth");
		super.addEntity("151", "PC", "PC", "Pocahontas");
		super.addEntity("153", "PO", "PO", "Polk");
		super.addEntity("155", "PT", "PT", "Pottawattamie");
		super.addEntity("157", "PW", "PW", "Poweshiek");
		super.addEntity("159", "RG", "RG", "Ringgold");
		super.addEntity("161", "SA", "SA", "Sac");
		super.addEntity("163", "SC", "SC", "Scott");
		super.addEntity("165", "SH", "SH", "Shelby");
		super.addEntity("167", "SI", "SI", "Sioux");
		super.addEntity("169", "ST", "ST", "Story");
		super.addEntity("171", "TA", "TA", "Tama");
		super.addEntity("173", "TY", "TY", "Taylor");
		super.addEntity("175", "UN", "UN", "Union");
		super.addEntity("177", "VB", "VB", "Van Buren");
		super.addEntity("179", "WA", "WA", "Wapello");
		super.addEntity("181", "WR", "WR", "Warren");
		super.addEntity("183", "WS", "WS", "Washington");
		super.addEntity("185", "WY", "WY", "Wayne");
		super.addEntity("187", "WE", "WE", "Webster");
		super.addEntity("189", "WI", "WI", "Winnebago");
		super.addEntity("191", "WN", "WN", "Winneshiek");
		super.addEntity("193", "WO", "WO", "Woodbury");
		super.addEntity("195", "WH", "WH", "Worth");
		super.addEntity("197", "WG", "WG", "Wright");
		
		
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
