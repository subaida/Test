import com.fusionmaps.core.Map;
class com.fusionmaps.maps.EuropeMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "EuropeMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function EuropeMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AL", "AL", "Albania");
		super.addEntity("002", "AD", "AD", "Andorra");
		super.addEntity("003", "AT", "AT", "Austria");
		super.addEntity("004", "BY", "BY", "Belarus");
		super.addEntity("005", "BE", "BE", "Belgium");
		super.addEntity("006", "BA", "BA", "Bosnia and Herzegovina");
		super.addEntity("007", "BG", "BG", "Bulgaria");
		super.addEntity("008", "HY", "HY", "Croatia");
		super.addEntity("009", "CZ", "CZ", "Czech Republic");
		super.addEntity("010", "DK", "DK", "Denmark");
		super.addEntity("011", "EE", "EE", "Estonia");
		super.addEntity("012", "FI", "FI", "Finland");
		super.addEntity("013", "FR", "FR", "France");
		super.addEntity("014", "DE", "DE", "Germany");
		super.addEntity("015", "GR", "GR", "Greece");
		super.addEntity("016", "HU", "HU", "Hungary");
		super.addEntity("017", "IS", "IS", "Iceland");
		super.addEntity("018", "IE", "IE", "Ireland");
		super.addEntity("019", "IT", "IT", "Italy");
		super.addEntity("020", "LV", "LV", "Latvia");
		super.addEntity("021", "LI", "LI", "Liechtenstein");
		super.addEntity("022", "LT", "LT", "Lithuania");
		super.addEntity("023", "LU", "LU", "Luxembourg");
		super.addEntity("024", "MK", "MK", "Macedonia");
		super.addEntity("025", "MT", "MT", "Malta");
		super.addEntity("026", "MD", "MD", "Moldova");
		super.addEntity("027", "MC", "MC", "Monaco");
		super.addEntity("028", "MO", "MO", "Montenegro");
		super.addEntity("029", "NL", "NL", "Netherlands");
		super.addEntity("030", "NO", "NO", "Norway");
		super.addEntity("031", "PL", "PL", "Poland");
		super.addEntity("032", "PT", "PT", "Portugal");
		super.addEntity("033", "RO", "RO", "Romania");
		super.addEntity("034", "SM", "SM", "San Marino");
		super.addEntity("035", "CS", "CS", "Serbia");
		super.addEntity("036", "SK", "SK", "Slovakia");
		super.addEntity("037", "SL", "SL", "Slovenia");
		super.addEntity("038", "ES", "ES", "Spain");
		super.addEntity("039", "SE", "SE", "Sweden");
		super.addEntity("040", "CH", "CH", "Switzerland");
		super.addEntity("041", "UA", "UA", "Ukraine");
		super.addEntity("042", "UK", "UK", "United Kingdom");
		super.addEntity("043", "VA", "VA", "Vatican City");
		super.addEntity("044", "CY", "CY", "Cyprus");
		super.addEntity("045", "TK", "TK", "Turkey");
		super.addEntity("046", "RU", "RU", "Russia");
		
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
