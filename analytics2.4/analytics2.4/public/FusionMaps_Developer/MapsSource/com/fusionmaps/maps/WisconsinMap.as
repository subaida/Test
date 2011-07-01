import com.fusionmaps.core.Map;
class com.fusionmaps.maps.WisconsinMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "WisconsinMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function WisconsinMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AS", "AS", "Ashland");
		super.addEntity("005", "BA", "BA", "Barron");
		super.addEntity("007", "BY", "BY", "Bayfield");
		super.addEntity("009", "BR", "BR", "Brown");
		super.addEntity("011", "BU", "BU", "Buffalo");
		super.addEntity("013", "BN", "BN", "Burnett");
		super.addEntity("015", "CA", "CA", "Calumet");
		super.addEntity("017", "CH", "CH", "Chippewa");
		super.addEntity("019", "CL", "CL", "Clark");
		super.addEntity("021", "CO", "CO", "Columbia");
		super.addEntity("023", "CR", "CR", "Crawford");
		super.addEntity("025", "DA", "DA", "Dane");
		super.addEntity("027", "DO", "DO", "Dodge");
		super.addEntity("029", "DR", "DR", "Door");
		super.addEntity("031", "DU", "DU", "Douglas");
		super.addEntity("033", "DN", "DN", "Dunn");
		super.addEntity("035", "EC", "EC", "Eau Claire");
		super.addEntity("037", "FL", "FL", "Florence");
        super.addEntity("039", "FD", "FD", "Fond du Lac");
        super.addEntity("041", "FO", "FO", "Forest");
        super.addEntity("043", "GR", "GR", "Grant");
        super.addEntity("045", "GE", "GE", "Green");
        super.addEntity("047", "GL", "GL", "Green Lake");
        super.addEntity("049", "IO", "IO", "Iowa");
		super.addEntity("051", "IR", "IR", "Iron");
		super.addEntity("053", "JA", "JA", "Jackson");
		super.addEntity("055", "JE", "JE", "Jefferson");
		super.addEntity("057", "JU", "JU", "Juneau");
		super.addEntity("059", "KE", "KE", "Kenosha");
		super.addEntity("061", "KW", "KW", "Kewaunee");
		super.addEntity("063", "LC", "LC", "La Crosse");
		super.addEntity("065", "LA", "LA", "Lafayette");
		super.addEntity("067", "LN", "LN", "Langlade");
		super.addEntity("069", "LI", "LI", "Lincoln");
		super.addEntity("071", "MA", "MA", "Manitowoc");
		super.addEntity("073", "MR", "MR", "Marathon");
		super.addEntity("075", "MI", "MI", "Marinette");
		super.addEntity("077", "MQ", "MQ", "Marquette");
		super.addEntity("078", "MN", "MN", "Menominee");
		super.addEntity("079", "ME", "ME", "Milwaukee");
		super.addEntity("081", "MO", "MO", "Monroe");
		super.addEntity("083", "OC", "OC", "Oconto");
		super.addEntity("085", "ON", "ON", "Oneida");
		super.addEntity("087", "OU", "OU", "Outagamie");
	    super.addEntity("089", "OZ", "OZ", "Ozaukee");
		super.addEntity("091", "PE", "PE", "Pepin");
		super.addEntity("093", "PI", "PI", "Pierce");
		super.addEntity("095", "PO", "PO", "Polk");
	    super.addEntity("097", "PR", "PR", "Portage");
		super.addEntity("099", "PC", "PC", "Price");
		super.addEntity("101", "RA", "RA", "Racine");
		super.addEntity("103", "RI", "RI", "Richland");
		super.addEntity("105", "RO", "RO", "Rock");
		super.addEntity("107", "RU", "RU", "Rusk");
		super.addEntity("109", "SC", "SC", "St.Croix");
		super.addEntity("111", "SA", "SA", "Sauk");
		super.addEntity("113", "SW", "SW", "Sawyer");
		super.addEntity("115", "SH", "SH", "Shawano");
		super.addEntity("117", "SE", "SE", "Sheboygan");
		super.addEntity("119", "TA", "TA", "Taylor");
		super.addEntity("121", "TR", "TR", "Trempealeau");
		super.addEntity("123", "VE", "VE", "Vernon");
		super.addEntity("125", "VI", "VI", "Vilas");
		super.addEntity("127", "WA", "WA", "Walworth");
		super.addEntity("129", "WS", "WS", "Washburn"); 
		super.addEntity("131", "WH", "WH", "Washington");
		super.addEntity("133", "WU", "WU", "Waukesha");
		super.addEntity("135", "WP", "WP", "Waupaca");
		super.addEntity("137", "WR", "WR", "Waushara");
		super.addEntity("139", "WN", "WN", "Winnebago"); 
		super.addEntity("141", "WO", "WO", "Wood");
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
