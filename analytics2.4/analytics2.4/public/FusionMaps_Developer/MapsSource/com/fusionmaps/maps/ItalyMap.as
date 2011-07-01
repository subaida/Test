import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ItalyMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ItalyMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ItalyMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AB", "Abruzzo");
		super.addEntity("002", "002", "BA", "Basilicata");
		super.addEntity("003", "003", "CA", "Calabria");
		super.addEntity("004", "004", "CM", "Campania");
		super.addEntity("005", "005", "EM", "Emilia-Romagna");
		super.addEntity("006", "006", "FI", "Friuli-Venezia Giulia");
		super.addEntity("007", "007", "LA", "Lazio");
		super.addEntity("008", "008", "LI", "Liguria");
		super.addEntity("009", "009", "LO", "Lombardia");
		super.addEntity("010", "010", "MA", "Marche");
		super.addEntity("011", "011", "MO", "Molise");
		super.addEntity("012", "012", "PI", "Piemonte");
		super.addEntity("013", "013", "PU", "Puglia");
		super.addEntity("014", "014", "SA", "Sardegna");
		super.addEntity("015", "015", "SI", "Sicilia");
		super.addEntity("016", "016", "TO", "Toscana");
		super.addEntity("017", "017", "TR", "Trentino-Alto Adige");
		super.addEntity("018", "018", "UM", "Umbria");
		super.addEntity("019", "019", "VA", "Valle d'Aosta");
		super.addEntity("020", "020", "VE", "Veneto. ");
		super.addEntity("021", "021", "SM", "Sanmarino");
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
