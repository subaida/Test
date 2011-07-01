import com.fusionmaps.core.Map;
class com.fusionmaps.maps.OklahomaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "OklahomaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function OklahomaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AL", "AL", "Alfalfa");
		super.addEntity("005", "AT", "AT", "Atoka");
		super.addEntity("007", "BE", "BE", "Beaver");
		super.addEntity("009", "BC", "BC", "Beckham");
		super.addEntity("011", "BL", "BL", "Blaine");
		super.addEntity("013", "BR", "BR", "Bryan");
		super.addEntity("015", "CA", "CA", "Caddo");
		super.addEntity("017", "CN", "CN", "Canadian");
		super.addEntity("019", "CR", "CR", "Carter");
		super.addEntity("021", "CH", "CH", "Cherokee");
		super.addEntity("023", "CO", "CO", "Choctaw");
		super.addEntity("025", "CI", "CI", "Cimarron");
		super.addEntity("027", "CE", "CE", "Cleveland");
		super.addEntity("029", "CL", "CL", "Coal");
		super.addEntity("031", "CM", "CM", "Comanche");
		super.addEntity("033", "CT", "CT", "Cotton");
		super.addEntity("035", "CG", "CG", "Craig");
	    super.addEntity("037", "CK", "CK", "Creek"); 
		super.addEntity("039", "CS", "CS", "Custer");
        super.addEntity("041", "DE", "DE", "Delaware");
        super.addEntity("043", "DW", "DW", "Dewey");
        super.addEntity("045", "EL", "EL", "Ellis");
        super.addEntity("047", "GA", "GA", "Garfield");
        super.addEntity("049", "GR", "GR", "Garvin");
		super.addEntity("051", "GD", "GD", "Grady");
		super.addEntity("053", "GN", "GN", "Grant");
		super.addEntity("055", "GE", "GE", "Greer");
		super.addEntity("057", "HA", "HA", "Harmon");
		super.addEntity("059", "HR", "HR", "Harper");
		super.addEntity("061", "HS", "HS", "Haskell");
		super.addEntity("063", "HU", "HU", "Hughes");
		super.addEntity("065", "JA", "JA", "Jackson");
		super.addEntity("067", "JE", "JE", "Jefferson");
		super.addEntity("069", "JO", "JO", "Johnston");
		super.addEntity("071", "KA", "KA", "Kay");
		super.addEntity("073", "KI", "KI", "Kingfisher");
		super.addEntity("075", "KO", "KO", "Kiowa");
		super.addEntity("077", "LA", "LA", "Latimer");
		super.addEntity("079", "LF", "LF", "Le Flore");
		super.addEntity("081", "LI", "LI", "Lincoln");
		super.addEntity("083", "LO", "LO", "Logan");
		super.addEntity("085", "LV", "LV", "Love");
		super.addEntity("093", "MA", "MA", "Major");
	    super.addEntity("095", "MR", "MR", "Marshall");
		super.addEntity("097", "MY", "MY", "Mayes");
		super.addEntity("087", "MC", "MC", "McClain");
		super.addEntity("089", "MT", "MT", "McCurtain");
		super.addEntity("091", "ML", "ML", "McIntosh");
		super.addEntity("099", "MU", "MU", "Murray");
		super.addEntity("101", "MK", "MK", "Muskogee");
		super.addEntity("103", "NO", "NO", "Noble");
		super.addEntity("105", "NW", "NW", "Nowata");
		super.addEntity("107", "OK", "OK", "Okfuskee");
		super.addEntity("109", "OL", "OL", "Oklahoma");
		super.addEntity("111", "OM", "OM", "Okmulgee");
		super.addEntity("113", "OS", "OS", "Osage");
		super.addEntity("115", "OT", "OT", "Ottawa");
		super.addEntity("117", "PA", "PA", "Pawnee");
		super.addEntity("119", "PY", "PY", "Payne");
		super.addEntity("121", "PI", "PI", "Pittsburg");
		super.addEntity("123", "PO", "PO", "Pontotoc");
		super.addEntity("125", "PW", "PW", "Pottawatomie");
		super.addEntity("127", "PU", "PU", "Pushmataha");
		super.addEntity("129", "RM", "RM", "Roger Mills"); 
		super.addEntity("131", "RO", "RO", "Rogers"); 
		 super.addEntity("133", "SE", "SE", "Seminole");
		 super.addEntity("135", "SQ", "SQ", "Sequoyah");
		 super.addEntity("137", "ST", "ST", "Stephens");
		 super.addEntity("139", "TE", "TE", "Texas");
		 super.addEntity("141", "TI", "TI", "Tillman"); 
		 super.addEntity("143", "TU", "TU", "Tulsa");
		 super.addEntity("145", "WA", "WA", "Wagoner"); 
		 super.addEntity("147", "WS", "WS", "Washington");
		 super.addEntity("149", "WH", "WH", "Washita");
		 super.addEntity("151", "WO", "WO", "Woods");
		 super.addEntity("153", "WD", "WD", "Woodward");
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
