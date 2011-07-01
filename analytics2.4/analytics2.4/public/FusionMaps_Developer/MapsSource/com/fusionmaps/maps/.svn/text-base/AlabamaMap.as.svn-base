import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AlabamaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AlabamaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AlabamaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AU", "Autauga");
		super.addEntity("003 ", "003", "BA", "Baldwin");
		super.addEntity("005", "005", "BR", "Barbour");
		super.addEntity("007", "007", "BI", "Bibb");
		super.addEntity("009", "009", "BL", "Blount");
		super.addEntity("011", "011", "BU", "Bullock");
		super.addEntity("013", "013", "BT", "Butler");
		super.addEntity("015", "015", "CA", "Calhoun");
		super.addEntity("017 ", "017", "CH", "Chambers");
		super.addEntity("019", "019", "CE", "Cherokee");
		super.addEntity("021", "021", "CI", "Chilton");
		super.addEntity("023 ", "023", "CO", "Choctaw");
		super.addEntity("025", "025", "CL", "Clarke");
		super.addEntity("027", "027", "CY", "Clay");
		super.addEntity("029", "029", "CB", "Cleburne");
		super.addEntity("031 ", "031", "CF", "Coffee");
		super.addEntity("033", "033", "CR", "Colbert");
		super.addEntity("035", "035", "CN", "Conecuh");
		super.addEntity("037", "037", "CS", "Coosa");
		super.addEntity("039", "039", "CV", "Covington");
		super.addEntity("041", "041", "CW", "Crenshaw");
		super.addEntity("043 ", "043", "CU", "Cullman");
		super.addEntity("045", "045", "DA", "Dale");
		super.addEntity("047", "047", "DL", "Dallas");
		super.addEntity("049  ", "049", "DE", "Dekalb");
		super.addEntity("051 ", "051", "EL", "Elmore");
		super.addEntity("053 ", "053", "ES", "Escambia");
		super.addEntity("055 ", "055", "ET", "Etowah");
		super.addEntity("057 ", "057", "FA", "Fayette");
		super.addEntity("059 ", "059", "FR", "Franklin");
		super.addEntity("061 ", "061", "GE", "Geneva");
		super.addEntity("063", "063", "GR", "Greene");
		super.addEntity("065", "065", "HA", "Hale");
		super.addEntity("067 ", "067", "HE", "Henry");
		super.addEntity("069 ", "069", "HO", "Houston");
		super.addEntity("071 ", "071", "JA", "Jackson");
		super.addEntity("073 ", "073", "JE", "Jefferson");
		super.addEntity("075", "075", "LA", "Lamar");
		super.addEntity("077", "077", "LU", "Lauderdale");
		super.addEntity("079", "079", "LW", "Lawrence");
		super.addEntity("081 ", "081", "LE", "Lee");
		super.addEntity("083 ", "083", "LI", "Limestone");
		super.addEntity("085", "085", "LO", "Lowndes");
		super.addEntity("087", "087", "MA", "Macon");
		super.addEntity("089 ", "089", "MD", "Madison");
		super.addEntity("091 ", "091", "MR", "Marengo");
		super.addEntity("093", "093", "MI", "Marion");
		super.addEntity("095", "095", "MS", "Marshall");
		super.addEntity("097", "097", "MO", "Mobile");
		super.addEntity("099 ", "099", "MN", "Monroe");
		super.addEntity("101", "101", "MT", "Montgomery");
		super.addEntity("103", "103", "MG", "Morgan");
		super.addEntity("105 ", "105", "PE", "Perry");
		super.addEntity("107", "107", "PI", "Pickens");
		super.addEntity("109 ", "109", "PK", "Pike");
		super.addEntity("111 ", "111", "RA", "Randolph");
		super.addEntity("113", "113", "RU", "Russell");
		super.addEntity("117 ", "117", "SH", "Shelby");
		super.addEntity("115 ", "115", "SC", "St. Clair");
		super.addEntity("119 ", "119", "SU", "Sumter");
		super.addEntity("121", "121", "TA", "Talladega");
		super.addEntity("123", "123", "TL", "Tallapoosa");
		super.addEntity("125", "125", "TU", "Tuscaloosa");
		super.addEntity("127 ", "127", "WA", "Walker");
		super.addEntity("129", "129", "WS", "Washington");
		super.addEntity("131", "131", "WI", "Wilcox");
		super.addEntity("133", "133", "WN", "Winston");
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
