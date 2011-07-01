import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ElSalvadorMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ElSalvadorMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ElSalvadorMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AH", "AH", "Ahuachapán");
		super.addEntity("02", "CA", "CA", "Cabañas");
		super.addEntity("03", "CH", "CH", "Chalatenango");
		super.addEntity("04", "CU", "CU", "Cuscatlán");
		super.addEntity("05", "LI", "LI", "La Libertad");
		super.addEntity("06", "PA", "PA", "La Paz");
		super.addEntity("07", "UN", "UN", "La Unión");
		super.addEntity("08", "MO", "MO", "Morazán");
		super.addEntity("09", "SM", "SM", "San Miguel");
		super.addEntity("10", "SS", "SS", "San Salvador");
		super.addEntity("11", "SA", "SA", "Santa Ana");
		super.addEntity("12", "SV", "SV", "San Vicente");
		super.addEntity("13", "SO", "SO", "Sonsonate");
		super.addEntity("14", "US", "US", "Usulután");
			 
		

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
