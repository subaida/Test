import com.fusionmaps.core.Map;
class com.fusionmaps.maps.UtahMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "UtahMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function UtahMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "BV", "BV", "Beaver");
		super.addEntity("003", "BE", "BE", "Box Elder");
		super.addEntity("005", "CA", "CA", "Cache");
		super.addEntity("007", "CR", "CR", "Carbon");
		super.addEntity("009", "DA", "DA", "Daggett");
		super.addEntity("011", "DV", "DV", "Davis");
		super.addEntity("013", "DU", "DU", "Duchesne");
		super.addEntity("015", "EM", "EM", "Emery");
		super.addEntity("017", "GA", "GA", "Garfield");
		super.addEntity("019", "GR", "GR", "Grand");
		super.addEntity("021", "IR", "IR", "Iron");
		super.addEntity("023", "JU", "JU", "Juab");
		super.addEntity("025", "KA", "KA", "Kane");
		super.addEntity("027", "MI", "MI", "Millard");
		super.addEntity("029", "MO", "MO", "Morgan");
		super.addEntity("031", "PI", "PI", "Piute");
		super.addEntity("033", "RI", "RI", "Rich");
		super.addEntity("035", "SL", "SL", "Salt Lake");
		super.addEntity("037", "SJ", "SJ", "San Juan");
		super.addEntity("039", "SA", "SA", "Sanpete");
		super.addEntity("041", "SE", "SE", "Sevier");
		super.addEntity("043", "SU", "SU", "Summit");
		super.addEntity("045", "TO", "TO", "Tooele");
		super.addEntity("047", "UI", "UI", "Uintah");
		super.addEntity("049", "UT", "UT", "Utah");
		super.addEntity("051", "WA", "WA", "Wasatch");
		super.addEntity("053", "WS", "WS", "Washington");
		super.addEntity("055", "WY", "WY", "Wayne");
		super.addEntity("057", "WE", "WE", "Weber");
		
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
