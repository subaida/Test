import com.fusionmaps.core.Map;
class com.fusionmaps.maps.UruguayMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "UruguayMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function UruguayMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AR", "AR", "Artigas");
		super.addEntity("02", "CA", "CA", "Canelones");
		super.addEntity("03", "CL", "CL", "Cerro Largo");
		super.addEntity("04", "CO", "CO", "Colonia");
		super.addEntity("05", "DU", "DU", "Durazno");
		super.addEntity("06", "FS", "FS", "Flores");
		super.addEntity("07", "FD", "FD", "Florida");
		super.addEntity("08", "LA", "LA", "Lavalleja");
		super.addEntity("09", "MA", "MA", "Maldonado");
		super.addEntity("10", "MO", "MO", "Montevideo");
		super.addEntity("11", "PA", "PA", "Paysandú");
		super.addEntity("12", "RN", "RN", "Rio Negro");
		super.addEntity("13", "RV", "RV", "Rivera");
		super.addEntity("14", "RO", "RO", "Rocha");
		super.addEntity("15", "SA", "SA", "Salto");
		super.addEntity("16", "SJ", "SJ", "San Jose");
		super.addEntity("17", "SO", "SO", "Soriano");
		super.addEntity("18", "TA", "TA", "Tacuarembó");
		super.addEntity("19", "TT", "TT", "Treinta y Tres");
        	 
		

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
