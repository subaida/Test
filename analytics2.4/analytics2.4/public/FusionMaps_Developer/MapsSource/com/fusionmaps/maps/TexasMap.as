import com.fusionmaps.core.Map;
class com.fusionmaps.maps.TexasMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "TexasMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function TexasMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AND", "AND", "Anderson");
		super.addEntity("003", "ANR", "ANR", "Andrews");
		super.addEntity("005", "ANG", "ANG", "Angelina");
		super.addEntity("007", "ARA", "ARA", "Aransas");
		super.addEntity("009", "ARC", "ARC", "Archer");
		super.addEntity("011", "ARS", "ARS", "Armstrong");
		super.addEntity("013", "ATA", "ATA", "Atascosa");
		super.addEntity("015", "AUS", "AUS", "Austin");
		super.addEntity("017", "BAI", "BAI", "Bailey");
		super.addEntity("019", "BAN", "BAN", "Bandera");
		super.addEntity("021", "BAS", "BAS", "Bastrop");
		super.addEntity("023", "BAY", "BAY", "Baylor");
		super.addEntity("025", "BEE", "BEE", "Bee");
		super.addEntity("027", "BEL", "BEL", "Bell");
		super.addEntity("029", "BEX", "BEX", "Bexar");
		super.addEntity("031", "BLA", "BLA", "Blanco");
		super.addEntity("033", "BOR", "BOR", "Borden");
		super.addEntity("035", "BOS", "BOS", "Bosque");
		super.addEntity("037", "BOI", "BOI", "Bowie");
        super.addEntity("039", "BRZ", "BRZ", "Brazoria");
        super.addEntity("041", "BAZ", "BAZ", "Brazos");
        super.addEntity("043", "BRE", "BRE", "Brewster");
        super.addEntity("045", "BRI", "BRI", "Briscoe");
        super.addEntity("047", "BRO", "BRO", "Brooks");
        super.addEntity("049", "BOW", "BOW", "Brown");
		super.addEntity("051", "BUS", "BUS", "Burleson");
		super.addEntity("053", "BUN", "BUN", "Burnet");
		super.addEntity("055", "CAL", "CAL", "Caldwell");
		super.addEntity("057", "CAH", "CAH", "Calhoun");
		super.addEntity("059", "CAN", "CAN", "Callahan");
		super.addEntity("061", "CAM", "CAM", "Cameron");
		super.addEntity("063", "CAP", "CAP", "Camp");
		super.addEntity("065", "CAR", "CAR", "Carson");
		super.addEntity("067", "CAS", "CAS", "Cass");
		super.addEntity("069", "CAT", "CAT", "Castro");
		super.addEntity("071", "CHA", "CHA", "Chambers");
		super.addEntity("073", "CHE", "CHE", "Cherokee");
		super.addEntity("075", "CHI", "CHI", "Childress");
		super.addEntity("077", "CLA", "CLA", "Clay");
		super.addEntity("079", "COC", "COC", "Cochran");
		super.addEntity("081", "COK", "COK", "Coke");
		super.addEntity("083", "COL", "COL", "Coleman");
		super.addEntity("085", "CON", "CON", "Collin");
		super.addEntity("087", "CSW", "CSW", "Collingsworth");
	     super.addEntity("089", "COR", "COR", "Colorado");
		 super.addEntity("091", "COM", "COM", "Comal");
		 super.addEntity("093", "COA", "COA", "Comanche");
		 super.addEntity("095", "CCH", "CCH", "Concho");
		 super.addEntity("097", "CKE", "CKE", "Cooke");
		 super.addEntity("099", "CRY", "CRY", "Coryell");
		 super.addEntity("101", "COT", "COT", "Cottle");
		 super.addEntity("103", "CRA", "CRA", "Crane");
		 super.addEntity("105", "CKT", "CKT", "Crockett");
		 super.addEntity("107", "CSB", "CSB", "Crosby");
		 super.addEntity("109", "CUB", "CUB", "Culberson");
		 super.addEntity("111", "DAL", "DAL", "Dallam");
		 super.addEntity("113", "DAS", "DAS", "Dallas");
		 super.addEntity("115", "DAW", "DAW", "Dawson");
		 super.addEntity("117", "DES", "DES", "Deaf Smith");
		 super.addEntity("119", "DEL", "DEL", "Delta");
		 super.addEntity("121", "DEN", "DEN", "Denton");
		 super.addEntity("123", "DEW", "DEW", "Dewitt");
		 super.addEntity("125", "DIC", "DIC", "Dickens");
		 super.addEntity("127", "DIM", "DIM", "Dimmit");
		 super.addEntity("129", "DON", "DON", "Donley");
		 super.addEntity("131", "DUV", "DUV", "Duval"); 
		 super.addEntity("133", "EAS", "EAS", "Eastland");
		 super.addEntity("135", "ECT", "ECT", "Ector");
		 super.addEntity("137", "EDW", "EDW", "Edwards");
		 super.addEntity("139", "ELI", "ELI", "Ellis");
		 super.addEntity("141", "ELP", "ELP", "El Paso"); 
		 super.addEntity("143", "ERA", "ERA", "Erath");
		 super.addEntity("145", "FAL", "FAL", "Falls"); 
		 super.addEntity("147", "FAN", "FAN", "Fannin");
		 super.addEntity("149", "FAY", "FAY", "Fayette");
		 super.addEntity("151", "FIS", "FIS", "Fisher");
		 super.addEntity("153", "FLO", "FLO", "Floyd");
		 super.addEntity("155", "FOA", "FOA", "Foard");
		 super.addEntity("157", "FBE", "FBE", "Fort Bend"); 
		 super.addEntity("159", "FRA", "FRA", "Franklin");
		 super.addEntity("161", "FRS", "FRS", "Freestone");
		 super.addEntity("163", "FRI", "FRI", "Frio");
		 super.addEntity("165", "GAI", "GAI", "Gaines");
		 super.addEntity("167", "GAL", "GAL", "Galveston"); 
		 super.addEntity("169", "GAR", "GAR", "Garza");
		 super.addEntity("171", "GIE", "GIE", "Gillespie");
		 super.addEntity("173", "GLA", "GLA", "Glasscock");
		 super.addEntity("175", "GOL", "GOL", "Goliad");
		 super.addEntity("177", "GON", "GON", "Gonzales");
		 super.addEntity("179", "GRA", "GRA", "Gray");
		 
		 super.addEntity("181", "GRY", "GRY", "Grayson");
		 super.addEntity("183", "GRE", "GRE", "Gregg"); 
		 super.addEntity("185", "GRI", "GRI", "Grimes");
		 super.addEntity("187", "GUA", "GUA", "Guadalupe");
		 super.addEntity("189", "HAE", "HAE", "Hale");
		 super.addEntity("191", "HAL", "HAL", "Hall");
		 
		 super.addEntity("193", "HAM", "HAM", "Hamilton"); 
		 super.addEntity("195", "HAN", "HAN", "Hansford"); 
		 super.addEntity("197", "HAR", "HAR", "Hardeman"); 
		 super.addEntity("199", "HAD", "HAD", "Hardin"); 
		 super.addEntity("201", "HAS", "HAS", "Harris");
		 super.addEntity("203", "HRS", "HRS", "Harrison");
		 
		 super.addEntity("205", "HRT", "HRT", "Hartley"); 
		 super.addEntity("207", "HSK", "HSK", "Haskell");
		 super.addEntity("209", "HYS", "HYS", "Hays");
		 super.addEntity("211", "HEP", "HEP", "Hemphill"); 
		 super.addEntity("213", "HND", "HND", "Henderson");
		super.addEntity("215", "HID", "HID", "Hidalgo");
		super.addEntity("217", "HIL", "HIL", "Hill");
		 super.addEntity("219", "HOC", "HOC", "Hockley");
		 super.addEntity("221", "HOD", "HOD", "Hood");
		 super.addEntity("223", "HOP", "HOP", "Hopkins");
		 super.addEntity("225", "HOU", "HOU", "Houston");  
		 super.addEntity("227", "HOW", "HOW", "Howard"); 
		 super.addEntity("229", "HUD", "HUD", "Hudspeth");
		 super.addEntity("231", "HUN", "HUN", "Hunt");
		 super.addEntity("233", "HUT", "HUT", "Hutchinson");
		 super.addEntity("235", "IRI", "IRI", "Irion");
		 super.addEntity("237", "JAC", "JAC", "Jack");
		 super.addEntity("239", "JAK", "JAK", "Jackson");
		 super.addEntity("241", "JAS", "JAS", "Jasper"); 
		 super.addEntity("243", "JED", "JED", "Jeff Davis");
		 super.addEntity("245", "JEF", "JEF", "Jefferson");  
		 super.addEntity("247", "JIH", "JIH", "Jim Hogg");
		 super.addEntity("249", "JIW", "JIW", "Jim Wells");
		 super.addEntity("251", "JOH", "JOH", "Johnson"); 
		 super.addEntity("253", "JON", "JON", "Jones");
		 super.addEntity("255", "KAR", "KAR", "Karnes"); 
		 
		 super.addEntity("257", "KAU", "KAU", "Kaufman");
		 super.addEntity("259", "KEN", "KEN", "Kendall");
		 super.addEntity("261", "KED", "KED", "Kenedy");

		 super.addEntity("263", "KET", "KET", "Kent");
		 super.addEntity("265", "KER", "KER", "Kerr");
		 super.addEntity("267", "KIM", "KIM", "Kimble");
		 super.addEntity("269", "KIN", "KIN", "King"); 
		 super.addEntity("271", "KIE", "KIE", "Kinney"); 
		 super.addEntity("273", "KLE", "KLE", "Kleberg");
		 super.addEntity("275", "KNO", "KNO", "Knox");
		 super.addEntity("283", "LAS", "LAS", "La Salle"); 
		 super.addEntity("277", "LAM", "LAM", "Lamar");
		 super.addEntity("279", "LAB", "LAB", "Lamb"); 
		 super.addEntity("281", "LAP", "LAP", "Lampasas");
		 super.addEntity("285", "LAV", "LAV", "Lavaca"); 
		 super.addEntity("287", "LEE", "LEE", "Lee"); 
		 super.addEntity("289", "LEO", "LEO", "Leon");
		 super.addEntity("291", "LIB", "LIB", "Liberty"); 
		 super.addEntity("293", "LIM", "LIM", "Limestone");
		 super.addEntity("295", "LIP", "LIP", "Lipscomb");
		 super.addEntity("297", "LIV", "LIV", "Live Oak");
		 super.addEntity("299", "LAN", "LAN", "Llano"); 
		 super.addEntity("301", "LOV", "LOV", "Loving");
		 super.addEntity("303", "LUB", "LUB", "Lubbock");
		 super.addEntity("305", "LYN", "LYN", "Lynn");
		 super.addEntity("313", "MAD", "MAD", "Madison");
		 super.addEntity("315", "MAR", "MAR", "Marion");
		 super.addEntity("317", "MAT", "MAT", "Martin");
		 super.addEntity("319", "MAS", "MAS", "Mason"); 
		 super.addEntity("321", "MAG", "MAG", "Matagorda"); 
		 super.addEntity("323", "MAV", "MAV", "Maverick"); 
		 super.addEntity("307", "MCU", "MCU", "McCulloch"); 
		 super.addEntity("309", "MCL", "MCL", "McLennan"); 
		 super.addEntity("311", "MCM", "MCM", "McMullen"); 
		 super.addEntity("325", "MED", "MED", "Medina"); 
		 super.addEntity("327", "MEN", "MEN", "Menard"); 
		 super.addEntity("329", "MID", "MID", "Midland");
		 super.addEntity("331", "MIL", "MIL", "Milam");
		 super.addEntity("333", "MIS", "MIS", "Mills");
		 super.addEntity("335", "MIT", "MIT", "Mitchell"); 
		 super.addEntity("337", "MON", "MON", "Montague"); 
		 super.addEntity("339", "MOT", "MOT", "Montgomery");
		 super.addEntity("341", "MOR", "MOR", "Moore"); 
		 super.addEntity("343", "MOI", "MOI", "Morris"); 
		 super.addEntity("345", "MOE", "MOE", "Motley");
		 super.addEntity("347", "NAC", "NAC", "Nacogdoches"); 
		 super.addEntity("349", "NAV", "NAV", "Navarro"); 
		 super.addEntity("351", "NEW", "NEW", "Newton");
		 super.addEntity("353", "NOL", "NOL", "Nolan"); 
		 super.addEntity("355", "NUE", "NUE", "Nueces");
		 super.addEntity("357", "OCH", "OCH", "Ochiltree");
		 super.addEntity("359", "OLD", "OLD", "Oldham");
		 super.addEntity("361", "ORA", "ORA", "Orange"); 
		 super.addEntity("363", "PAL", "PAL", "Palo Pinto"); 
		 super.addEntity("365", "PAN", "PAN", "Panola"); 
		 super.addEntity("367", "PAR", "PAR", "Parker");
		 super.addEntity("369", "PAM", "PAM", "Parmer");
		 super.addEntity("371", "PEC", "PEC", "Pecos"); 
		 super.addEntity("373", "POL", "POL", "Polk"); 
		 super.addEntity("375", "POT", "POT", "Potter"); 
		 super.addEntity("377", "PRE", "PRE", "Presidio"); 
		 super.addEntity("379", "RAI", "RAI", "Rains");
		 super.addEntity("381", "RAN", "RAN", "Randall"); 
		 super.addEntity("383", "REA", "REA", "Reagan"); 
		 super.addEntity("385", "REL", "REL", "Real"); 
		 super.addEntity("387", "RED", "RED", "Red River"); 
		 super.addEntity("389", "REV", "REV", "Reeves");
		 super.addEntity("391", "REF", "REF", "Refugio"); 
		 super.addEntity("393", "ROB", "ROB", "Roberts"); 
		 super.addEntity("395", "ROE", "ROE", "Robertson"); 
		 super.addEntity("397", "ROC", "ROC", "Rockwall");
		 super.addEntity("399", "RUN", "RUN", "Runnels");
		 super.addEntity("401", "RUS", "RUS", "Rusk"); 
		 super.addEntity("403", "SAB", "SAB", "Sabine");
		 super.addEntity("405", "SAU", "SAU", "San Augustine");
		 super.addEntity("407", "SAJ", "SAJ", "San Jacinto");
		 super.addEntity("409", "SAP", "SAP", "San Patricio"); 
		 super.addEntity("411", "SAS", "SAS", "San Saba");
		 super.addEntity("413", "SCH", "SCH", "Schleicher");
		 super.addEntity("415", "SCU", "SCU", "Scurry"); 
		 super.addEntity("417", "SHA", "SHA", "Shackelford");
		 super.addEntity("419", "SHE", "SHE", "Shelby");
		 super.addEntity("421", "SHR", "SHR", "Sherman");
		 super.addEntity("423", "SMI", "SMI", "Smith");
		 super.addEntity("425", "SOM", "SOM", "Somervell");
		 super.addEntity("427", "STA", "STA", "Starr");
		 super.addEntity("429", "STE", "STE", "Stephens");
		 super.addEntity("431", "STR", "STR", "Sterling");
		 super.addEntity("433", "STO", "STO", "Stonewall");
		 super.addEntity("435", "SUT", "SUT", "Sutton");
		 super.addEntity("437", "SWI", "SWI", "Swisher");
		 super.addEntity("439", "TAR", "TAR", "Tarrant");
		 super.addEntity("441", "TAY", "TAY", "Taylor");
		 super.addEntity("443", "TER", "TER", "Terrell");
		 super.addEntity("445", "TEY", "TEY", "Terry");
		 super.addEntity("447", "THR", "THR", "Throckmorton");
		 super.addEntity("449", "TIT", "TIT", "Titus");
		 super.addEntity("451", "TOG", "TOG", "Tom Green");
		 super.addEntity("453", "TRA", "TRA", "Travis");
		 super.addEntity("455", "TRI", "TRI", "Trinity");
		 super.addEntity("457", "TYL", "TYL", "Tyler");
		 super.addEntity("459", "UPS", "UPS", "Upshur");
		 super.addEntity("461", "UPT", "UPT", "Upton");
		 super.addEntity("463", "UVA", "UVA", "Uvalde");
		 super.addEntity("465", "VAV", "VAV", "Val Verde");
		 super.addEntity("467", "VAZ", "VAZ", "Van Zandt");
		 super.addEntity("469", "VIC", "VIC", "Victoria");
		 super.addEntity("471", "WAK", "WAK", "Walker");
		 super.addEntity("473", "WAL", "WAL", "Waller");
		 super.addEntity("475", "WAR", "WAR", "Ward");
		 super.addEntity("477", "WAS", "WAS", "Washington");
		 super.addEntity("479", "WEB", "WEB", "Webb"); 
		 super.addEntity("481", "WHA", "WHA", "Wharton");
		 super.addEntity("483", "WHE", "WHE", "Wheeler"); 
		 super.addEntity("485", "WIC", "WIC", "Wichita"); 
		 super.addEntity("487", "WIB", "WIB", "Willbarger"); 
		 super.addEntity("489", "WIA", "WIA", "Willacy");
		 super.addEntity("491", "WIM", "WIM", "Williamson");
		 super.addEntity("493", "WIL", "WIL", "Wilson");
		 super.addEntity("495", "WIN", "WIN", "Winkler"); 
		 super.addEntity("497", "WIS", "WIS", "Wise"); 
		 super.addEntity("499", "WOD", "WOD", "Wood"); 
		 super.addEntity("501", "YOA", "YOA", "Yoakum"); 
		 super.addEntity("503", "YOU", "YOU", "Young"); 
		 super.addEntity("505", "ZAP", "ZAP", "Zapata");
		 super.addEntity("507", "ZAV", "ZAV", "Zavala");
		

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
