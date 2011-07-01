import com.fusionmaps.core.Map;
class com.fusionmaps.maps.EstoniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "EstoniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function EstoniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "HA", "HA", "Harjumaa");
		super.addEntity("02", "HI", "HI", "Hiiumaa");
		super.addEntity("03", "IV", "IV", "Ida-Virumaa");
		super.addEntity("04", "JR", "JR", "Järvamaa");
		super.addEntity("05", "JN", "JN", "Jõgevamaa");
		super.addEntity("07", "LN", "LN", "Läänemaa");
		super.addEntity("08", "LV", "LV", "Lääne-Virumaa");
		super.addEntity("11", "PR", "PR", "Pärnumaa");
		super.addEntity("12", "PL", "PL", "Põlvamaa");
		super.addEntity("13", "RA", "RA", "Raplamaa");
		super.addEntity("14", "SA", "SA", "Saaremaa");
		super.addEntity("18", "TA", "TA", "Tartumaa");
		super.addEntity("19", "VG", "VG", "Valgamaa");
		super.addEntity("20", "VD", "VD", "Viljandimaa");
		super.addEntity("21", "VR", "VR", "Võrumaa");
		 
		

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
