import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ArizonaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ArizonaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ArizonaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AP", "Apache");
		super.addEntity("003", "003", "CO", "Cochise");
		super.addEntity("005", "005", "CC", "Coconino");
		super.addEntity("007", "007", "GI", "Gila");
		super.addEntity("009", "009", "GR", "Graham");
		super.addEntity("011", "011", "GE", "Greenlee");
		super.addEntity("012", "012", "LP", "La Paz");
		super.addEntity("013", "013", "MA", "Maricopa");
		super.addEntity("015", "015", "MO", "Mohave");
		super.addEntity("017", "017", "NA", "Navajo");
		super.addEntity("019", "019", "PI", "Pima");
		super.addEntity("021", "021", "PN", "Pinal");
		super.addEntity("023", "023", "SC", "Santa Cruz");
		super.addEntity("025", "025", "YA", "Yavapai");
		super.addEntity("027", "027", "YU", "Yuma");
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
