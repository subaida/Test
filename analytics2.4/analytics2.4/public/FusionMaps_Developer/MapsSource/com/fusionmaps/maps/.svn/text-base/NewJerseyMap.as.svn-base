import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NewJerseyMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NewJerseyMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NewJerseyMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AT", "AT", "Atlantic");
		super.addEntity("003", "BE", "BE", "Bergen");
		super.addEntity("005", "BU", "BU", "Burlington");
		super.addEntity("007", "CA", "CA", "Camden");
		super.addEntity("009", "CM", "CM", "Cape May");
		super.addEntity("011", "CU", "CU", "Cumberland");
		super.addEntity("013", "ES", "ES", "Essex");
		super.addEntity("015", "GL", "GL", "Gloucester");
		super.addEntity("017", "HU", "HU", "Hudson");
		super.addEntity("019", "HT", "HT", "Hunterdon");
		super.addEntity("021", "ME", "ME", "Mercer");
		super.addEntity("023", "MI", "MI", "Middlesex");
		super.addEntity("025", "MO", "MO", "Monmouth");
		super.addEntity("027", "MR", "MR", "Morris");
		super.addEntity("029", "OC", "OC", "Ocean");
		super.addEntity("031", "PA", "PA", "Passaic");
		super.addEntity("033", "SA", "SA", "Salem");
		super.addEntity("035", "SO", "SO", "Somerset");
		super.addEntity("037", "SU", "SU", "Sussex");
		super.addEntity("039", "UN", "UN", "Union");
		super.addEntity("041", "WA", "WA", "Warren");
		
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
