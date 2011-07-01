import com.fusionmaps.core.Map;
class com.fusionmaps.maps.LouisianaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "LouisianaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function LouisianaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AC", "AC", "Acadia");
		super.addEntity("003", "AL", "AL", "Allen");
		super.addEntity("005", "AS", "AS", "Ascension");
		super.addEntity("007", "AU", "AU", "Assumption");
		super.addEntity("009", "AV", "AV", "Avoyelles");
		super.addEntity("011", "BE", "BE", "Beauregard");
		super.addEntity("013", "BI", "BI", "Bienville");
		super.addEntity("015", "BO", "BO", "Bossier");
		super.addEntity("017", "CA", "CA", "Caddo");
		super.addEntity("019", "CL", "CL", "Calcasieu");
		super.addEntity("021", "CD", "CD", "Caldwell");
		super.addEntity("023", "CM", "CM", "Cameron");
		super.addEntity("025", "CT", "CT", "Catahoula");
		super.addEntity("027", "CB", "CB", "Claiborne");
		super.addEntity("029", "CO", "CO", "Concordia");
		super.addEntity("031", "DS", "DS", "De Soto");
		super.addEntity("033", "EB", "EB", "East Baton Rouge");
		super.addEntity("035", "EC", "EC", "East Carroll");
		super.addEntity("037", "EF", "EF", "East Feliciana");
        super.addEntity("039", "EV", "EV", "Evangeline");
        super.addEntity("041", "FR", "FR", "Franklin");
        super.addEntity("043", "GR", "GR", "Grant");
        super.addEntity("045", "IB", "IB", "Iberia");
        super.addEntity("047", "IE", "IE", "Iberville");
        super.addEntity("049", "JA", "JA", "Jackson");
		super.addEntity("051", "JE", "JE", "Jefferson");
		super.addEntity("053", "JD", "JD", "Jefferson Davis");
		super.addEntity("055", "LA", "LA", "Lafayette");
		super.addEntity("057", "LF", "LF", "Lafourche");
		super.addEntity("059", "LS", "LS", "La Salle");
		super.addEntity("061", "LI", "LI", "Lincoln");
		super.addEntity("063", "LV", "LV", "Livingston");
		super.addEntity("065", "MA", "MA", "Madison");
		super.addEntity("067", "MO", "MO", "Morehouse");
		super.addEntity("069", "NA", "NA", "Natchitoches");
		super.addEntity("071", "OR", "OR", "Orleans");
		super.addEntity("073", "OU", "OU", "Ouachita");
		super.addEntity("075", "PL", "PL", "Plaquemines");
		super.addEntity("077", "PC", "PC", "Pointe Coupee");
		super.addEntity("079", "RA", "RA", "Rapides");
		super.addEntity("081", "RE", "RE", "Red River");
		super.addEntity("083", "RI", "RI", "Richland");
		super.addEntity("085", "SA", "SA", "Sabine");
		super.addEntity("087", "SB", "SB", "St.Bernard");
	    super.addEntity("089", "SC", "SC", "St.Charles");
		super.addEntity("091", "SH", "SH", "St.Helena");
		super.addEntity("093", "SJ", "SJ", "St.James");
		super.addEntity("095", "ST", "ST", "St.John the Baptist");
	    super.addEntity("097", "SL", "SL", "St.Landry");
		super.addEntity("099", "SM", "SM", "St.Martin");
		super.addEntity("101", "SR", "SR", "St.Mary");
		super.addEntity("103", "SY", "SY", "St.Tammany");
		super.addEntity("105", "TA", "TA", "Tangipahoa");
		super.addEntity("107", "TE", "TE", "Tensas");
		super.addEntity("109", "TR", "TR", "Terrebonne");
		super.addEntity("111", "UN", "UN", "Union");
		super.addEntity("113", "VE", "VE", "Vermilion");
		super.addEntity("115", "VN", "VN", "Vernon");
		super.addEntity("117", "WA", "WA", "Washington");
		super.addEntity("119", "WE", "WE", "Webster");
		super.addEntity("121", "WB", "WB", "West Baton Rouge");
		super.addEntity("123", "WC", "WC", "West Carroll");
		super.addEntity("125", "WF", "WF", "West Feliciana");
		super.addEntity("127", "WI", "WI", "Winn");
		
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
