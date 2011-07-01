import com.fusionmaps.core.Map;
class com.fusionmaps.maps.DominicanRepublicMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "DominicanRepublicMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function DominicanRepublicMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
		//Invoke the super class constructor
		super(targetMC, depth, width, height, x, y, debugMode, lang);
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
		super.addEntity("01", "AZ", "AZ", "Ázua");
		super.addEntity("02", "BR", "BR", "Bahoruco");
		super.addEntity("03", "BH", "BH", "Barahona");
		super.addEntity("04", "DA", "DA", "Dajabón");
	    super.addEntity("06", "DU", "DU", "Duarte");
		super.addEntity("34", "NC", "NC", "Distrito Nacional");
		super.addEntity("11", "EP", "EP", "Elías Piña");
		super.addEntity("28", "SE", "SE", "El Seibo");
		super.addEntity("08", "ES", "ES", "Espaillat");
		super.addEntity("29", "HM", "HM", "Hato Mayor");
		super.addEntity("09", "IN", "IN", "Independencia");
		super.addEntity("10", "AL", "AL", "La Altagracia");
		super.addEntity("12", "RO", "RO", "La Romana");
		super.addEntity("30", "VE", "VE", "La Vega");
		super.addEntity("14", "MT", "MT", "María Trinidad Sánchez");
		super.addEntity("31", "MN", "MN", "Monseñor Nouel");
		super.addEntity("15", "MC", "MC", "Monte Cristi");
		super.addEntity("32", "MP", "MP", "Monte Plata");
		super.addEntity("16", "PN", "PN", "Pedernales");
		super.addEntity("35", "PV", "PV", "Peravia");
        super.addEntity("18", "PP", "PP", "Puerto Plata");
        super.addEntity("19", "SC", "SC", "Salcedo");
        super.addEntity("20", "SM", "SM", "Samaná");
        super.addEntity("21", "SZ", "SZ", "Sánchez Ramírez");
        super.addEntity("33", "CR", "CR", "San Cristóbal");
        super.addEntity("36", "JO", "JO", "San José de Ocoa");
		super.addEntity("23", "JU", "JU", "San Juan");
		super.addEntity("24", "PM", "PM", "San Pedro de Macorís");
		super.addEntity("25", "ST", "ST", "Santiago");
		super.addEntity("26", "SR", "SR", "Santiago Rodríguez");
		super.addEntity("37", "SD", "SD", "Santo Domingo");
		super.addEntity("27", "VA", "VA", "Valverde");
		
		 
		 
		

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
