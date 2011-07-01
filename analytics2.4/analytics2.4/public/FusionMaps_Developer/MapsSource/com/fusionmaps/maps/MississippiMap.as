import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MississippiMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MississippiMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MississippiMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AL", "AL", "Alcorn");
		super.addEntity("005", "AM", "AM", "Amite");
		super.addEntity("007", "AT", "AT", "Attala");
		super.addEntity("009", "BE", "BE", "Benton");
		super.addEntity("011", "BO", "BO", "Bolivar");
		super.addEntity("013", "CA", "CA", "Calhoun");
		super.addEntity("015", "CR", "CR", "Carroll");
		super.addEntity("017", "CH", "CH", "Chickasaw");
		super.addEntity("019", "CO", "CO", "Choctaw");
		super.addEntity("021", "CL", "CL", "Claiborne");
		super.addEntity("023", "CK", "CK", "Clarke");
		super.addEntity("025", "CY", "CY", "Clay");
		super.addEntity("027", "CM", "CM", "Coahoma");
		super.addEntity("029", "CP", "CP", "Copiah");
		super.addEntity("031", "CG", "CG", "Covington");
		super.addEntity("033", "DE", "DE", "DeSoto");
		super.addEntity("035", "FO", "FO", "Forrest");
	    super.addEntity("037", "FR", "FR", "Franklin");
		super.addEntity("039", "GO", "GO", "George");
        super.addEntity("041", "GR", "GR", "Greene");
        super.addEntity("043", "GE", "GE", "Grenada");
        super.addEntity("045", "HA", "HA", "Hancock");
        super.addEntity("047", "HR", "HR", "Harrison");
        super.addEntity("049", "HI", "HI", "Hinds");
		super.addEntity("051", "HO", "HO", "Holmes");
		super.addEntity("053", "HU", "HU", "Humphreys");
		super.addEntity("055", "IS", "IS", "Issaquena");
		super.addEntity("057", "IT", "IT", "Itawamba");
		super.addEntity("059", "JA", "JA", "Jackson");
		super.addEntity("061", "JS", "JS", "Jasper");
		super.addEntity("063", "JE", "JE", "Jefferson");
		super.addEntity("065", "JD", "JD", "Jefferson Davis");
		super.addEntity("067", "JO", "JO", "Jones");
		super.addEntity("069", "KE", "KE", "Kemper");
		super.addEntity("071", "LA", "LA", "Lafayette");
		super.addEntity("073", "LM", "LM", "Lamar");
		super.addEntity("075", "LU", "LU", "Lauderdale");
		super.addEntity("077", "LW", "LW", "Lawrence");
		super.addEntity("079", "LK", "LK", "Leake");
		super.addEntity("081", "LE", "LE", "Lee");
		super.addEntity("083", "LF", "LF", "Leflore");
		super.addEntity("085", "LN", "LN", "Lincoln");
		super.addEntity("087", "LD", "LD", "Lowndes");
	     super.addEntity("089", "MA", "MA", "Madison");
		 super.addEntity("091", "MR", "MR", "Marion");
		 super.addEntity("093", "MS", "MS", "Marshall");
		 super.addEntity("095", "MO", "MO", "Monroe");
		 super.addEntity("097", "MT", "MT", "Montgomery");
		 super.addEntity("099", "NE", "NE", "Neshoba");
		 super.addEntity("101", "NW", "NW", "Newton");
		 super.addEntity("103", "NO", "NO", "Noxubee");
		 super.addEntity("105", "OK", "OK", "Oktibbeha");
		 super.addEntity("107", "PA", "PA", "Panola");
		 super.addEntity("109", "PR", "PR", "Pearl River");
		 super.addEntity("111", "PE", "PE", "Perry");
		 super.addEntity("113", "PI", "PI", "Pike");
		 super.addEntity("115", "PO", "PO", "Pontotoc");
		 super.addEntity("117", "PS", "PS", "Prentiss");
		 super.addEntity("119", "QU", "QU", "Quitman");
		 super.addEntity("121", "RA", "RA", "Rankin");
		 super.addEntity("123", "SC", "SC", "Scott");
		 super.addEntity("125", "SH", "SH", "Sharkey");
		 super.addEntity("127", "SI", "SI", "Simpson");
		 super.addEntity("129", "SM", "SM", "Smith");
		 super.addEntity("131", "ST", "ST", "Stone"); 
		 super.addEntity("133", "SU", "SU", "Sunflower");
		 super.addEntity("135", "TA", "TA", "Tallahatchie");
		 super.addEntity("137", "TE", "TE", "Tate");
		 super.addEntity("139", "TP", "TP", "Tippah");
		 super.addEntity("141", "TI", "TI", "Tishomingo"); 
		 super.addEntity("143", "TU", "TU", "Tunica");
		 super.addEntity("145", "UN", "UN", "Union"); 
		 super.addEntity("147", "WA", "WA", "Walthall");
		 super.addEntity("149", "WR", "WR", "Warren");
		 super.addEntity("151", "WS", "WS", "Washington");
		 super.addEntity("153", "WY", "WY", "Wayne");
		 super.addEntity("155", "WB", "WB", "Webster");
		 super.addEntity("157", "WL", "WL", "Wilkinson"); 
		 super.addEntity("159", "WN", "WN", "Winston");
		 super.addEntity("161", "YA", "YA", "Yalobusha");
		 super.addEntity("163", "YZ", "YZ", "Yazoo");
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
