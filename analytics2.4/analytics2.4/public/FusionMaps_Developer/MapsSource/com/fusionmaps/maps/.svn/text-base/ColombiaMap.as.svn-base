import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ColombiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ColombiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ColombiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AMA", "AMA", "Amazonas");
		super.addEntity("02", "ANT", "ANT", "Antioquia");
		super.addEntity("03", "ARA", "ARA", "Arauca");
		super.addEntity("04", "ATL", "ATL", "Atlántico");
		super.addEntity("34", "DC", "DC", "Bogotá (Distrito Capital)");
		super.addEntity("35", "BOL", "BOL", "Bolívar");
		super.addEntity("36", "BOY", "BOY", "Boyacá");
		super.addEntity("37", "CAL", "CAL", "Caldas");
		super.addEntity("08", "CAQ", "CAQ", "Caquetá");
		super.addEntity("32", "CAS", "CAS", "Casanare");
		super.addEntity("09", "CAU", "CAU", "Cauca");
		super.addEntity("10", "CES", "CES", "Cesar");
		super.addEntity("11", "CHO", "CHO", "Chocó");
		super.addEntity("12", "COR", "COR", "Córdoba");
		super.addEntity("33", "CUN", "CUN", "Cundinamarca");
		super.addEntity("15", "GUA", "GUA", "Guainía");
		super.addEntity("14", "GUV", "GUV", "Guaviare");
		super.addEntity("16", "HUI", "HUI", "Huila");
		super.addEntity("17", "LAG", "LAG", "La Guajira");
        super.addEntity("38", "MAG", "MAG", "Magdalena");
        super.addEntity("19", "MET", "MET", "Meta");
        super.addEntity("20", "NAR", "NAR", "Nariño");
        super.addEntity("21", "NSA", "NSA", "Norte de Santander");
        super.addEntity("22", "PUT", "PUT", "Putumayo");
        super.addEntity("23", "QUI", "QUI", "Quindío");
		super.addEntity("24", "RIS", "RIS", "Risaralda");
		super.addEntity("25", "SAP", "SAP", "San Andrés and Providencia");
		super.addEntity("26", "SAN", "SAN", "Santander");
		super.addEntity("27", "SUC", "SUC", "Sucre");
		super.addEntity("28", "TOL", "TOL", "Tolima");
		super.addEntity("29", "VAC", "VAC", "Valle del Cauca");
		super.addEntity("30", "VAU", "VAU", "Vaupés");
		super.addEntity("31", "CID", "CID", "Vichada");
		
		

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
