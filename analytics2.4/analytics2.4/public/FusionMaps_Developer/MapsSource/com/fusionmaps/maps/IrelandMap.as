import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IrelandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IrelandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IrelandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "CA", "Ceatharlach");
		super.addEntity("002", "002", "CV", "Cabhán");
		super.addEntity("003", "003", "CL", "Clár");
		super.addEntity("004", "004", "CO", "Corcaigh");
		super.addEntity("005", "005", "DO", "Dún na nGall");
		super.addEntity("006", "006", "DU", "Baile Átha Cliath");
		super.addEntity("007", "007", "GA", "Gaillimh");
		super.addEntity("008", "008", "KE", "Ciarraí");
		super.addEntity("009", "009", "KI", "Cill Dara");
		super.addEntity("010", "010", "KL", "Cill Chainnigh");
		super.addEntity("011", "011", "LA", "Laois");
		super.addEntity("012", "012", "LE", "Liatroim");
		super.addEntity("013", "013", "LI", "Luimneach");
		super.addEntity("014", "014", "LO", "Longfort");
		super.addEntity("015", "015", "LU", "Lú");
		super.addEntity("016", "016", "MA", "Maigh Eo");
		super.addEntity("017", "017", "ME", "Mí");
		super.addEntity("018", "018", "MO", "Muineacháin");
		super.addEntity("019", "019", "OF", "Ua Fáilghe");
		super.addEntity("020", "020", "RO", "Ros Comán");
		super.addEntity("021", "021", "SL", "Sligeach");
		super.addEntity("022", "022", "TI", "Tiobraid Arainn");
		super.addEntity("023", "023", "WA", "Port Lairge");
		super.addEntity("024", "024", "WE", "Iarmhí");
		super.addEntity("025", "025", "WX", "Loch Garman");
		super.addEntity("026", "026", "WI", "Cill Mhantáin");
		super.addEntity("027", "027", "NL", "Northern Ireland");
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
