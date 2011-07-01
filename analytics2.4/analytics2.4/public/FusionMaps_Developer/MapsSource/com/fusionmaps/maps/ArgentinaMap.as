import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ArgentinaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ArgentinaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ArgentinaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "BA", "BA", "Buenos Aires");
		super.addEntity("02", "CT", "CT", "Catamarca");
		super.addEntity("03", "CC", "CC", "Chaco");
		super.addEntity("04", "CH", "CH", "Chubut");
		super.addEntity("05", "CB", "CB", "Córdoba");
		super.addEntity("06", "CN", "CN", "Corrientes");
		super.addEntity("07", "DF", "DF", "Distrito Federal");
		super.addEntity("08", "ER", "ER", "Entre Rios");
		super.addEntity("09", "FM", "FM", "Formosa");
		super.addEntity("10", "JY", "JY", "Jujuy");
		super.addEntity("11", "LP", "LP", "La Pampa");
		super.addEntity("12", "LR", "LR", "La Rioja");
		super.addEntity("13", "MZ", "MZ", "Mendoza");
		super.addEntity("14", "MN", "MN", "Misiones");
		super.addEntity("15", "NQ", "NQ", "Neuquén");
		super.addEntity("16", "RN", "RN", "Rio Negro");
		super.addEntity("17", "SA", "SA", "Salta");
		super.addEntity("18", "SJ", "SJ", "San Juan");
		super.addEntity("19", "SL", "SL", "San Luis");
        super.addEntity("20", "SC", "SC", "Santa Cruz");
        super.addEntity("21", "SF", "SF", "Santa Fe");
        super.addEntity("22", "SE", "SE", "Santiago del Estero");
        super.addEntity("23", "TF", "TF", "Tierra del Feugo");
        super.addEntity("24", "TM", "TM", "Tucumán");
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
