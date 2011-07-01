import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SouthKoreaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SouthKoreaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SouthKoreaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("10", "PU", "PU", "Busan");
		super.addEntity("05", "GB", "GB", "Chungcheongbuk-do");
		super.addEntity("17", "GN", "GN", "Chungcheongnam-do");
		super.addEntity("15", "TG", "TG", "Daegu");
		super.addEntity("19", "TJ", "TJ", "Daejeon");
		super.addEntity("06", "KW", "KW", "Gangwon-do");
		super.addEntity("18", "KJ", "KJ", "Gwangju");
		super.addEntity("13", "KG", "KG", "Gyeonggi-do");
		super.addEntity("14", "KB", "KB", "Gyeongsangbuk-do");
		super.addEntity("20", "KN", "KN", "Gyeongsangnam-do");
		super.addEntity("12", "IN", "IN", "Incheon");
		super.addEntity("01", "CJ", "CJ", "Jeju");
		super.addEntity("03", "CB", "CB", "Jeollabuk-do");
		super.addEntity("16", "CN", "CN", "Jeollanam-do ");
		super.addEntity("11", "SO", "SO", "Seoul");
		super.addEntity("21", "UL", "UL", "Ulsan");
		
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
