import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SouthAmericaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SouthAmericaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SouthAmericaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AR", "Argentina");
		super.addEntity("002", "002", "BO", "Bolivia");
		super.addEntity("003", "003", "BR", "Brazil");
		super.addEntity("004", "004", "CL", "Chile");
		super.addEntity("005", "005", "CO", "Colombia");
		super.addEntity("006", "006", "EC", "Ecuador");
		super.addEntity("007", "007", "FK", "Falkland Islands");
		super.addEntity("008", "008", "GF", "French Guiana");
		super.addEntity("009", "009", "GY", "Guyana");
		super.addEntity("010", "010", "PY", "Paraguay");
		super.addEntity("011", "011", "PE", "Peru");
		super.addEntity("012", "012", "SR", "Suriname");
		super.addEntity("013", "013", "UY", "Uruguay");
		super.addEntity("014", "014", "VE", "Venezuela");
		
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
