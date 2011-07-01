import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SaintKittsandNevisMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SaintKittsandNevisMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SaintKittsandNevisMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "CC", "CC", "Christ Church Nichola Town");
		super.addEntity("02", "AS", "AS", "Saint Anne Sandy Point");
		super.addEntity("03", "GB", "GB", "Saint George Basseterre");
		super.addEntity("04", "GG", "GG", "Saint George Gingerland ");
		super.addEntity("05", "JW", "JW", "Saint James Windward");
		super.addEntity("06", "JC", "JC", "Saint John Capesterre");
		super.addEntity("07", "JF", "JF", "Saint John Figtree");
		super.addEntity("08", "MC", "MC", "Saint Mary Cayon");
		super.addEntity("09", "PP", "PP", "Saint Paul Capesterre");
		super.addEntity("10", "PL", "PL", "Saint Paul Charlestown");
		super.addEntity("11", "PB", "PB", "Saint Peter Basseterre");
		super.addEntity("12", "TL", "TL", "Saint Thomas Lowland");
		super.addEntity("13", "TM", "TM", "Saint Thomas Middle Island");
		super.addEntity("15", "TP", "TP", "Trinity Palmetto Point");
		
		

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
