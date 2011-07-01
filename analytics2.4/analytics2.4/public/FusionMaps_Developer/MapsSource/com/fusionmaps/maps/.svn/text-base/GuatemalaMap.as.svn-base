import com.fusionmaps.core.Map;
class com.fusionmaps.maps.GuatemalaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "GuatemalaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function GuatemalaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AV", "AV", "Alta Verapaz");
		super.addEntity("02", "BV", "BV", "Baja Verapaz");
		super.addEntity("03", "CM", "CM", "Chimaltenango");
		super.addEntity("04", "CQ", "CQ", "Chiquimula");
		super.addEntity("05", "PR", "PR", "El Progreso");
		super.addEntity("06", "ES", "ES", "Escuintla");
		super.addEntity("07", "GU", "GU", "Guatemala");
		super.addEntity("08", "HU", "HU", "Huehuetenango");
		super.addEntity("09", "IZ", "IZ", "Izabal");
		super.addEntity("10", "JA", "JA", "Jalapa");
		super.addEntity("11", "JU", "JU", "Jutiapa");
		super.addEntity("12", "PE", "PE", "Petén");
		super.addEntity("13", "QZ", "QZ", "Quetzaltenango");
		super.addEntity("14", "QC", "QC", "Quiché");
		super.addEntity("15", "RE", "RE", "Retalhuleu");
		super.addEntity("16", "SA", "SA", "Sacatepéquez");
		super.addEntity("17", "SM", "SM", "San Marcos");
		super.addEntity("18", "SR", "SR", "Santa Rosa");
		super.addEntity("19", "SO", "SO", "Sololá");
        super.addEntity("20", "SU", "SU", "Suchitepequez");
        super.addEntity("21", "TO", "TO", "Totonicapán");
        super.addEntity("22", "ZA", "ZA", "Zacapa");
        	 
		

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
