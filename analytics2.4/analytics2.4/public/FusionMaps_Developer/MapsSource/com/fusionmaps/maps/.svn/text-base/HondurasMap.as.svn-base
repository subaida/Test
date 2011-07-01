import com.fusionmaps.core.Map;
class com.fusionmaps.maps.HondurasMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "HondurasMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function HondurasMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AT", "AT", "Atlántida");
		super.addEntity("02", "CH", "CH", "Choluteca");
		super.addEntity("03", "CL", "CL", "Colón");
		super.addEntity("04", "CM", "CM", "Comayagua");
		super.addEntity("05", "CP", "CP", "Copán");
		super.addEntity("06", "CR", "CR", "Cortés");
		super.addEntity("07", "EP", "EP", "El Paraíso");
		super.addEntity("08", "FM", "FM", "Francisco Morazán");
		super.addEntity("09", "GD", "GD", "Gracias a Dios");
		super.addEntity("10", "IN", "IN", " Intibucá");
		super.addEntity("11", "IB", "IB", "Islas de la Bahía");
		super.addEntity("12", "LP", "LP", "La Paz");
		super.addEntity("13", "LE", "LE", "Lempira");
		super.addEntity("14", "OC", "OC", "Ocotepeque");
		super.addEntity("15", "OL", "OL", "Olancho");
		super.addEntity("16", "SB", "SB", "Santa Bárbara");
		super.addEntity("17", "VA", "VA", "Valle");
		super.addEntity("18", "YO", "YO", "Yoro");
		
		 
		

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
