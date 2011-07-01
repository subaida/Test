import com.fusionmaps.core.Map;
class com.fusionmaps.maps.EcuadorMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "EcuadorMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function EcuadorMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("02", "A", "A", "Azuay");
		super.addEntity("03", "B", "B", "Bolívar");
		super.addEntity("04", "F", "F", "Cañar");
		super.addEntity("05", "C", "C", "Carchi");
		super.addEntity("06", "H", "H", "Chimborazo");
		super.addEntity("07", "X", "X", "Cotopaxi");
		super.addEntity("08", "O", "O", "El Oro");
		super.addEntity("09", "E", "E", "Esmeraldas");
		super.addEntity("01", "W", "W", "Galápagos");
		super.addEntity("10", "G", "G", "Guayas");
		super.addEntity("11", "I", "I", "Imbabura");
		super.addEntity("12", "L", "L", "Loja");
		super.addEntity("13", "R", "R", "Los Ríos");
		super.addEntity("14", "M", "M", "Manabí");
		super.addEntity("15", "S", "S", "Morona-Santiago");
		super.addEntity("23", "N", "N", "Napo");
		super.addEntity("24", "D", "D", "Orellana");
		super.addEntity("17", "Y", "Y", "Pastaza");
		super.addEntity("18", "P", "P", "Pichincha");
        super.addEntity("22", "U", "U", "Sucumbíos");
        super.addEntity("19", "T", "T", "Tungurahua");
        super.addEntity("20", "Z", "Z", "Zamora-Chinchipe");
        	 
		

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
