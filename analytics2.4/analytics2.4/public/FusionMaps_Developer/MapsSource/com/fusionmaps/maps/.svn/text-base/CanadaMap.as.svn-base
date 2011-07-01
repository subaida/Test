import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CanadaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CanadaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CanadaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "01", "AB", "Alberta");
		super.addEntity("02", "02", "BC", "British Columbia");
		super.addEntity("03", "03", "MB", "Manitoba");
		super.addEntity("04", "04", "NB", "New Brunswick");
		super.addEntity("05", "05", "NL", "Newfoundland & Labrador");
		super.addEntity("13", "13", "NT", "Northwest Territories");
		super.addEntity("07", "07", "NS", "Nova Scotia");
		super.addEntity("14", "14", "NU", "Nunavut");
		super.addEntity("08", "08", "ON", "Ontario");
		super.addEntity("09", "09", "PE", "Prince Edward Island");
		super.addEntity("10", "10", "QC", "Quebec");
		super.addEntity("11", "11", "SK", "Saskatchewan");
		super.addEntity("12", "12", "YT", "Yukon Territory");
		
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
