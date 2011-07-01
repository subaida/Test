import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SouthEuropeanRegionMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SouthEuropeanRegionMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SouthEuropeanRegionMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AL", "AL", "Albania");
		super.addEntity("02", "AD", "AD", "Andorra");
		super.addEntity("03", "BA", "BA", "Bosnia & Herzegovina");
		super.addEntity("04", "HY", "HY", "Croatia");
		super.addEntity("05", "GR", "GR", "Greece");
		super.addEntity("06", "IT", "IT", "Italy");
		super.addEntity("07", "MK", "MK", "Macedonia");
		super.addEntity("08", "MT", "MT", "Malta");
		super.addEntity("09", "MO", "MO", "Montenegro");
		super.addEntity("10", "PT", "PT", "Portugal");
		super.addEntity("11", "SM", "SM", "San Marino");
		super.addEntity("12", "CS", "CS", "Serbia");
		super.addEntity("13", "ES", "ES", "Spain");
		super.addEntity("14", "TK", "TK", "Turkey");
		super.addEntity("15", "CY", "CY", "Cyprus");
		super.addEntity("16", "VA", "VA", "Vatican City");
	
		
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
