import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NewZealandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NewZealandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NewZealandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("E7", "AUK", "AUK", "Auckland");
		super.addEntity("E8", "BOP", "BOP", "Bay of Plenty");
		super.addEntity("E9", "CAN", "CAN", "Canterbury");
		super.addEntity("F1", "GIS", "GIS", "Gisborne");
		super.addEntity("F2", "HKB", "HKB", "Hawke's Bay");
		super.addEntity("F3", "MWT", "MWT", "Manawatu-Wanganui");
		super.addEntity("F4", "MBH", "MBH", "Marlborough");
		super.addEntity("F5", "NSN", "NSN", "Nelson");
		super.addEntity("F6", "NTL", "NTL", "Northland");
		super.addEntity("F7", "OTA", "OTA", "Otago");
		super.addEntity("F8", "STL", "STL", "Southland");
		super.addEntity("F9", "TKI", "TKI", "Taranaki");
		super.addEntity("F10", "TAS", "TAS", "Tasman");
		super.addEntity("G1", "WKO", "WKO", "Waikato");
		super.addEntity("G2", "WGN", "WGN", "Wellington");
		super.addEntity("G3", "WTC", "WTC", "West Coast");
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
