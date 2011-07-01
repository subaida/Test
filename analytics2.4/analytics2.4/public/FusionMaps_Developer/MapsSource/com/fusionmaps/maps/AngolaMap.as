import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AngolaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AngolaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AngolaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String, scaleMode: String, registerWithJS: Boolean, DOMId:String) {
		//Invoke the super class constructor
		super(targetMC, depth, width, height, x, y, debugMode, lang, scaleMode, registerWithJS, DOMId);
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
		super.addEntity("AO.BO", "BO", "BO", "Bengo");		
		super.addEntity("AO.BG", "BG", "BG", "Benguela");		
		super.addEntity("AO.BI", "BI", "BI", "Bie");		
		super.addEntity("AO.CB", "CB", "CB", "Cabinda");		
		super.addEntity("AO.CC", "CC", "CC", "Cuando Cubango");		
		super.addEntity("AO.CN", "CN", "CN", "Cuanza Norte");		
	    super.addEntity("AO.CS", "CS", "CS", "Cuanza Sul");
		super.addEntity("AO.CU", "CU", "CU", "Cunene");
		super.addEntity("AO.HM", "HM", "HM", "Huambo");
		super.addEntity("AO.HL", "HL", "HL", "Huila");
		super.addEntity("AO.LU", "LU", "LU", "Luanda");
		super.addEntity("AO.LN", "LN", "LN", "Lunda Norte");
		super.addEntity("AO.LS", "LS", "LS", "Lunda Sul");
		super.addEntity("AO.ML", "ML", "ML", "Malanje");
		super.addEntity("AO.MX", "MX", "MX", "Moxico");
		super.addEntity("AO.NA", "NA", "NA", "Namibe");
		super.addEntity("AO.UI", "UI", "UI", "Uige");
		super.addEntity("AO.ZA", "ZA", "ZA", "Zaire");
		
		
		
		
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
