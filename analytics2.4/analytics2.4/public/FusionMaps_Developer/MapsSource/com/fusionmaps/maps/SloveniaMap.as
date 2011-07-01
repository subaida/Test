import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SloveniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SloveniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SloveniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("09", "GO", "GO", "Gorenjska");
		super.addEntity("11", "SP", "SP", "Goriška");
		super.addEntity("07", "DO", "DO", "Jugovzhodna Slovenija");
		super.addEntity("03", "KO", "KO", "Koroška");
		super.addEntity("10", "NO", "NO", "Notranjsko-kraška");
		super.addEntity("12", "JP", "JP", "Obalno-kraška");
		super.addEntity("08", "LJ", "LJ", "Osrednjeslovenska");
		super.addEntity("02", "PD", "PD", "Podravska");
		super.addEntity("01", "PM", "PM", "Pomurska");
		super.addEntity("04", "SA", "SA", "Savinjska");
		super.addEntity("06", "PS", "PS", "Spodnjeposavska");
		super.addEntity("05", "ZS", "ZS", "Zasavska");
		
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
