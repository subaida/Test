import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NorthAmericaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NorthAmericaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NorthAmericaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AG", "Antigua and Barbuda");
		super.addEntity("002", "002", "BS", "Bahamas");
		super.addEntity("003", "003", "BB", "Barbados");
		super.addEntity("004", "004", "BZ", "Belize");
		super.addEntity("005", "005", "CA", "Canada");
		super.addEntity("006", "006", "CR", "Costa Rica");
		super.addEntity("007", "007", "CU", "Cuba");
		super.addEntity("008", "008", "DM", "Dominica");
		super.addEntity("009", "009", "DO", "Dominican Rep.");
		super.addEntity("010", "010", "SV", "El Salvador");
		super.addEntity("011", "011", "GD", "Grenada");
		super.addEntity("012", "012", "GT", "Guatemala");
		super.addEntity("013", "013", "HT", "Haiti");
		super.addEntity("014", "014", "HN", "Honduras");
		super.addEntity("015", "015", "JM", "Jamaica");
		super.addEntity("016", "016", "MX", "Mexico");
		super.addEntity("017", "017", "NI", "Nicaragua");
		super.addEntity("018", "018", "PA", "Panama");
		super.addEntity("019", "019", "KN", "St. Kitts & Nevis");
		super.addEntity("020", "020", "LC", "St. Lucia");
		super.addEntity("021", "021", "VC", "St. Vincent & the Grenadines");
		super.addEntity("022", "022", "TT", "Trinidad & Tobago ");
		super.addEntity("023", "023", "US", "United States ");
		super.addEntity("024", "024", "GL", "Greenland");
		super.addEntity("025", "025", "PR", "Puerto Rico ");
		super.addEntity("026", "026", "KY", "Cayman Islands");
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
