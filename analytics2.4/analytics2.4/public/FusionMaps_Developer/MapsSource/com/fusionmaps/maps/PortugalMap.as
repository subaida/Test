import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PortugalMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PortugalMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PortugalMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("02", "AV", "AV", "Aveiro");
		super.addEntity("03", "BE", "BE", "Beja");
		super.addEntity("04", "BR", "BR", "Braga");
		super.addEntity("05", "BA", "BA", "Bragança ");
		super.addEntity("06", "CB", "CB", "Castelo Branco");
		super.addEntity("07", "CO", "CO", "Coimbra");
		super.addEntity("08", "EV", "EV", "Évora ");
		super.addEntity("09", "FA", "FA", "Faro");
		super.addEntity("11", "GU", "GU", "Guarda");
		super.addEntity("13", "LE", "LE", "Leiria");
		super.addEntity("14", "LI", "LI", "Lisboa");
		super.addEntity("16", "PA", "PA", "Portalegre");
		super.addEntity("17", "PO", "PO", "Porto");
		super.addEntity("18", "SA", "SA", "Santarém ");
		super.addEntity("19", "SE", "SE", "Setúbal");
		super.addEntity("20", "VC", "VC", "Viana do Castelo");
		super.addEntity("21", "VR", "VR", "Vila Real");
		super.addEntity("22", "VI", "VI", "Viseu");
		
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
