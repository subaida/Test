import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CaliforniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CaliforniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CaliforniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AL", "Alameda");
		super.addEntity("003", "003", "AP", "Alpine");
		super.addEntity("005", "005", "AM", "Amador");
		super.addEntity("007", "007", "BU", "Butte");
		super.addEntity("009", "009", "CA", "Calaveras");
		super.addEntity("011", "011", "CO", "Colusa");
		super.addEntity("013", "013", "CN", "Contra Costa");
		super.addEntity("015", "015", "DE", "Del Norte");
		super.addEntity("017", "017", "EL", "El Dorado");
		super.addEntity("019", "019", "FR", "Fresno");
		super.addEntity("021", "021", "GL", "Glenn");
		super.addEntity("023", "023", "HU", "Humboldt");
		super.addEntity("025", "025", "IM", "Imperial");
		super.addEntity("027", "027", "IN", "Inyo");
		super.addEntity("029", "029", "KE", "Kern");
		super.addEntity("031", "031", "KI", "Kings");
		super.addEntity("033", "033", "LA", "Lake");
		super.addEntity("035", "035", "LS", "Lassen");
		super.addEntity("037", "037", "LO", "Los Angeles");
		super.addEntity("039", "039", "MA", "Madera");
		super.addEntity("041", "041", "MR", "Marin");
		super.addEntity("043", "043", "MI", "Mariposa");
		super.addEntity("045", "045", "ME", "Mendocino");
		super.addEntity("047", "047", "MC", "Merced");
		super.addEntity("049", "049", "MO", "Modoc");
		super.addEntity("051", "051", "MN", "Mono");
		super.addEntity("053", "053", "MT", "Monterey");
		super.addEntity("055", "055", "NA", "Napa");
		super.addEntity("057", "057", "NE", "Nevada");
		super.addEntity("059", "059", "OR", "Orange");
		super.addEntity("061", "061", "PL", "Placer");
		super.addEntity("063", "063", "PU", "Plumas");
		super.addEntity("065", "065", "RI", "Riverside");
		super.addEntity("067", "067", "SA", "Sacramento");
		super.addEntity("069", "069", "SN", "San Benito");
		super.addEntity("071", "071", "SB", "San Bernardino");
		super.addEntity("073", "073", "SD", "San Diego");
		super.addEntity("075", "075", "SF", "San Francisco");
		super.addEntity("077", "077", "SJ", "San Joaquin");
		super.addEntity("079", "079", "SP", "San Luis Obispo");
		super.addEntity("081", "081", "SE", "San Mateo");
		super.addEntity("083", "083", "SR", "Santa Barbara");
		super.addEntity("085", "085", "ST", "Santa Clara");
		super.addEntity("087", "087", "SC", "Santa Cruz");
		super.addEntity("089", "089", "SH", "Shasta");
		super.addEntity("091", "091", "SI", "Sierra");
		super.addEntity("093", "093", "SY", "Siskiyou");
		super.addEntity("095", "095", "SO", "Solano");
		super.addEntity("097", "097", "SM", "Sonoma");
		super.addEntity("099", "099", "SL", "Stanislaus");
		super.addEntity("101", "101", "SU", "Sutter");
		super.addEntity("103", "103", "TE", "Tehama");
		super.addEntity("105", "105", "TR", "Trinity");
		super.addEntity("107", "107", "TU", "Tulare");
		super.addEntity("109", "109", "TO", "Tuolumne");
		super.addEntity("111", "111", "VE", "Ventura");
		super.addEntity("113", "113", "YO", "Yolo");
		super.addEntity("115", "115", "YU", "Yuba");
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
