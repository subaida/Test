import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CubaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CubaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CubaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("05", "CM", "CM", "Camagüey");
		super.addEntity("07", "CA", "CA", "Ciego de Ávila");
		super.addEntity("08", "CF", "CF", "Cienfuegos");
		super.addEntity("02", "CH", "CH", "Ciudad de La Habana");
		super.addEntity("09", "GR", "GR", "Granma");
		super.addEntity("10", "GU", "GU", "Guantánamo");
		super.addEntity("12", "HO", "HO", "Holguín");
		super.addEntity("04", "IJ", "IJ", "Isla de la Juventud");
		super.addEntity("11", "LH", "LH", "La Habana");
		super.addEntity("13", "LT", "LT", "Las Tunas");
		super.addEntity("03", "MA", "MA", "Matanzas");
		super.addEntity("01", "PR", "PR", "Pinar del Río");
		super.addEntity("14", "SS", "SS", "Sancti Spíritus");
		super.addEntity("15", "SC", "SC", "Santiago de Cuba");
		super.addEntity("16", "VC", "VC", "Villa Clara");
		
		
		
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
