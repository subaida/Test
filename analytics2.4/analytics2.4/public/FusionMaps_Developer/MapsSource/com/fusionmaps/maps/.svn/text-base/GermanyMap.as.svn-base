import com.fusionmaps.core.Map;
class com.fusionmaps.maps.GermanyMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "GermanyMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function GermanyMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "BA", "Baden-Wuerttemberg");
		super.addEntity("002", "002", "BY", "Bayern");
		super.addEntity("003", "003", "BE", "Berlin");
		super.addEntity("004", "004", "BR", "Brandenburg");
		super.addEntity("005", "005", "BM", "Bremen");
		super.addEntity("006", "006", "HA", "Hamburg");
		super.addEntity("007", "007", "HE", "Hessen");
		super.addEntity("008", "008", "ME", "Mecklenburg-Vorpommern");
		super.addEntity("009", "009", "NI", "Niedersachsen");
		super.addEntity("010", "010", "NO", "Nordrhein-Westfalen");
		super.addEntity("011", "011", "RH", "Rheinland-Pfalz");
		super.addEntity("012", "012", "SA", "Saarland");
		super.addEntity("013", "013", "SC", "Sachsen");
		super.addEntity("014", "014", "SH", "Sachsen-Anhalt");
		super.addEntity("015", "015", "SS", "Schleswig-Holstein");
		super.addEntity("016", "016", "TH", "Thueringen  ");
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
