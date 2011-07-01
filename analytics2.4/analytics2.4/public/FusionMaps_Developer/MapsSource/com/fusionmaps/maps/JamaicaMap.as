import com.fusionmaps.core.Map;
class com.fusionmaps.maps.JamaicaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "JamaicaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function JamaicaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "CL", "CL", "Clarendon");
		super.addEntity("02", "HA", "HA", "Hanover");
		super.addEntity("17", "KI", "KI", "Kingston");
		super.addEntity("04", "MA", "MA", "Manchester");
		super.addEntity("07", "PO", "PO", "Portland");
		super.addEntity("08", "SD", "SD", "Saint Andrew");
		super.addEntity("09", "SN", "SN", "Saint Ann");
		super.addEntity("10", "SC", "SC", "Saint Catherine");
		super.addEntity("11", "SE", "SE", "Saint Elizabeth");
		super.addEntity("12", "SJ", "SJ", "Saint James");
		super.addEntity("13", "SM", "SM", "Saint Mary");
		super.addEntity("14", "ST", "ST", "Saint Thomas");
		super.addEntity("15", "TR", "TR", "Trelawny");
		super.addEntity("16", "WE", "WE", "Westmoreland");
		
		 
		 
		

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
