import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ArkansasMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ArkansasMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ArkansasMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AR", "AR", "Arkansas");
		super.addEntity("003", "AS", "AS", "Ashley");
		super.addEntity("005", "BA", "BA", "Baxter");
		super.addEntity("007", "BE", "BE", "Benton");
		super.addEntity("009", "BO", "BO", "Boone");
		super.addEntity("011", "BR", "BR", "Bradley");
		super.addEntity("013", "CA", "CA", "Calhoun");
		super.addEntity("015", "CR", "CR", "Carroll");
		super.addEntity("017", "CH", "CH", "Chicot");
		super.addEntity("019", "CL", "CL", "Clark");
		super.addEntity("021", "CY", "CY", "Clay");
		super.addEntity("023", "CB", "CB", "Cleburne");
		super.addEntity("025", "CV", "CV", "Cleveland");
		super.addEntity("027", "CM", "CM", "Columbia");
		super.addEntity("029", "CW", "CW", "Conway");
		super.addEntity("031", "CI", "CI", "Craighead");
		super.addEntity("033", "CF", "CF", "Crawford");
		super.addEntity("035", "CT", "CT", "Crittenden");
		super.addEntity("037", "CS", "CS", "Cross");
	    super.addEntity("039", "DA", "DA", "Dallas");
	    super.addEntity("041", "DE", "DE", "Desha");
	    super.addEntity("043", "DR", "DR", "Drew");
	    super.addEntity("045", "FA", "FA", "Faulkner");
	    super.addEntity("047", "FR", "FR", "Franklin"); 
		super.addEntity("049", "FU", "FU", "Fulton"); 
		super.addEntity("051", "GA", "GA", "Garland"); 
		super.addEntity("053", "GR", "GR", "Grant");
		super.addEntity("055", "GE", "GE", "Greene");
		super.addEntity("057", "HE", "HE", "Hempstead");
		super.addEntity("059", "HS", "HS", "Hot Spring");
		super.addEntity("061", "HW", "HW", "Howard");
		super.addEntity("063", "IN", "IN", "Independence");
		super.addEntity("065", "IZ", "IZ", "Izard");
		super.addEntity("067", "JA", "JA", "Jackson");
		super.addEntity("069", "JE", "JE", "Jefferson");
		super.addEntity("071", "JO", "JO", "Johnson");
		super.addEntity("073", "LA", "LA", "Lafayette");
		super.addEntity("075", "LW", "LW", "Lawrence");
		super.addEntity("077", "LE", "LE", "Lee");
		super.addEntity("079", "LI", "LI", "Lincoln");
		super.addEntity("081", "LR", "LR", "Little River");
		super.addEntity("083", "LO", "LO", "Logan");
		super.addEntity("085", "LK", "LK", "Lonoke");
		super.addEntity("087", "MA", "MA", "Madison");
		super.addEntity("089", "MR", "MR", "Marion");
		super.addEntity("091", "MI", "MI", "Miller");
		super.addEntity("093", "MS", "MS", "Mississippi");
		super.addEntity("095", "MN", "MN", "Monroe");
		super.addEntity("097", "MT", "MT", "Montgomery");
		super.addEntity("099", "NE", "NE", "Nevada");
		super.addEntity("101", "NW", "NW", "Newton");
		super.addEntity("103", "OU", "OU", "Ouachita");
		super.addEntity("105", "PE", "PE", "Perry");
		super.addEntity("107", "PH", "PH", "Phillips");
		super.addEntity("109", "PI", "PI", "Pike");
		super.addEntity("111", "PO", "PO", "Poinsett");
		super.addEntity("113", "PL", "PL", "Polk");
		super.addEntity("115", "PP", "PP", "Pope");
		super.addEntity("117", "PR", "PR", "Prairie");
		super.addEntity("119", "PU", "PU", "Pulaski");
		super.addEntity("121", "RA", "RA", "Randolph");
		super.addEntity("123", "SF", "SF", "St.Francis");
		super.addEntity("125", "SA", "SA", "Saline");
		super.addEntity("127", "SC", "SC", "Scott");
		super.addEntity("129", "SE", "SE", "Searcy");
		super.addEntity("131", "SB", "SB", "Sebastian");
		super.addEntity("133", "SV", "SV", "Sevier");
		super.addEntity("135", "SH", "SH", "Sharp");
		super.addEntity("137", "ST", "ST", "Stone");
		super.addEntity("139", "UN", "UN", "Union");
		super.addEntity("141", "VB", "VB", "Van Buren");
		super.addEntity("143", "WA", "WA", "Washington");
		super.addEntity("145", "WH", "WH", "White");
		super.addEntity("147", "WO", "WO", "Woodruff");
		super.addEntity("149", "YE", "YE", "Yell");
		
	
		
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
