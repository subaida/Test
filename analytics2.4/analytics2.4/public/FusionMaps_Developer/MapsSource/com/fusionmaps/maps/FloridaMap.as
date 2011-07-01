import com.fusionmaps.core.Map;
class com.fusionmaps.maps.FloridaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "FloridaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function FloridaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AL", "Alachua");
		super.addEntity("003", "003", "BA", "Baker");
		super.addEntity("005", "005", "BY", "Bay");
		super.addEntity("007", "007", "BF", "Bradford");
		super.addEntity("009", "009", "BV", "Brevard");
		super.addEntity("011", "011", "BW", "Broward");
		super.addEntity("013", "013", "CA", "Calhoun");
		super.addEntity("015", "015", "CH", "Charlotte");
		super.addEntity("017", "017", "CI", "Citrus");
		super.addEntity("019", "019", "CL", "Clay");
		super.addEntity("021", "021", "CO", "Collier");
		super.addEntity("023", "023", "CU", "Columbia");
		super.addEntity("086", "086", "DA", "Miami-Dade");
		super.addEntity("027", "027", "DE", "Desoto");
		super.addEntity("029", "029", "DI", "Dixie");
		super.addEntity("031", "031", "DU", "Duval");
		super.addEntity("033", "033", "ES", "Escambia");
		super.addEntity("035", "035", "FL", "Flagler");
		super.addEntity("037", "037", "FR", "Franklin");
		super.addEntity("039", "039", "GA", "Gadsden");
		super.addEntity("041", "041", "GI", "Gilchrist");
		super.addEntity("043", "043", "GL", "Glades");
		super.addEntity("045", "045", "GU", "Gulf");
		super.addEntity("047", "047", "HT", "Hamilton");
		super.addEntity("049", "049", "HA", "Hardee");
		super.addEntity("051", "051", "HE", "Hendry");
		super.addEntity("053", "053", "HN", "Hernando");
		super.addEntity("055", "055", "HL", "Highlands");
		super.addEntity("057", "057", "HB", "Hillsborough");
		super.addEntity("059", "059", "HM", "Holmes");
		super.addEntity("061", "061", "IR", "Indian River");
		super.addEntity("063", "063", "JS", "Jackson");
		super.addEntity("065", "065", "JE", "Jefferson");
		super.addEntity("067", "067", "LY", "Lafayette");
		super.addEntity("069", "069", "LA", "Lake");
		super.addEntity("071", "071", "LE", "Lee");
		super.addEntity("073", "073", "LO", "Leon");
		super.addEntity("075", "075", "LV", "Levy");
		super.addEntity("077", "077", "LI", "Liberty");
		super.addEntity("079", "079", "MS", "Madison");
		super.addEntity("081", "081", "MN", "Manatee");
		super.addEntity("083", "083", "MR", "Marion");
		super.addEntity("085", "085", "MA", "Martin");
		super.addEntity("087", "087", "MO", "Monroe");
		super.addEntity("089", "089", "NA", "Nassau");
		super.addEntity("091", "091", "OL", "Okaloosa");
		super.addEntity("093", "093", "OK", "Okeechobee");
		super.addEntity("095", "095", "OR", "Orange");
		super.addEntity("097", "097", "OS", "Osceola");
		super.addEntity("099", "099", "PB", "Palm Beach");
		super.addEntity("101", "101", "PA", "Pasco");
		super.addEntity("103", "103", "PL", "Pinellas");
		super.addEntity("105", "105", "PO", "Polk");
		super.addEntity("107", "107", "PN", "Putnam");
		super.addEntity("113", "113", "SR", "Santa Rosa");
		super.addEntity("115", "115", "SS", "Sarasota");
		super.addEntity("117", "117", "SO", "Seminole");
		super.addEntity("109", "109", "SJ", "St.Johns");
		super.addEntity("111", "111", "SL", "St.Lucie");
		super.addEntity("119", "119", "ST", "Sumter");
		super.addEntity("121", "121", "SN", "Suwannee");
		super.addEntity("123", "123", "TA", "Taylor");
		super.addEntity("125", "125", "UN", "Union");
		super.addEntity("127", "127", "VO", "Volusia");
		super.addEntity("129", "129", "WK", "Wakulla");
		super.addEntity("131", "131", "WT", "Walton");
		super.addEntity("133", "133", "WG", "Washington");
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
