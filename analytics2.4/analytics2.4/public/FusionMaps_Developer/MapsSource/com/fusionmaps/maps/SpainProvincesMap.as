import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SpainProvincesMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SpainProvincesMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SpainProvincesMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AB", "AB", "Albacete");
		super.addEntity("002", "AL", "AL", "Alava");
		super.addEntity("003", "AI", "AI", "Alicante");
		super.addEntity("004", "AM", "AM", "Almeria");
		super.addEntity("005", "AS", "AS", "Asturias");
		super.addEntity("006", "AV", "AV", "Avila");
		super.addEntity("007", "BA", "BA", "Badajoz");
		super.addEntity("008", "BL", "BL", "Baleares");
		super.addEntity("009", "BR", "BR", "Barcelona");
		super.addEntity("010", "BI", "BI", "Bizkaia");
		super.addEntity("011", "BU", "BU", "Burgos");
		super.addEntity("012", "CA", "CA", "Cáceres");
		super.addEntity("013", "CD", "CD", "Cádiz");
		super.addEntity("014", "CN", "CN", "Cantabria");
		super.addEntity("015", "CS", "CS", "Castellón");
		super.addEntity("016", "CE", "CE", "Ceuta");
		super.addEntity("017", "CR", "CR", "Ciudad Real");
		super.addEntity("018", "CO", "CO", "Córdoba");
		super.addEntity("019", "CU", "CU", "Cuenca");
        super.addEntity("020", "GU", "GU", "Guipúzcoa");
        super.addEntity("021", "GI", "GI", "Girona");
        super.addEntity("022", "GR", "GR", "Granada");
        super.addEntity("023", "GA", "GA", "Guadalajara");
        super.addEntity("024", "HU", "HU", "Huelva");
        super.addEntity("025", "HE", "HE", "Huesca");
		super.addEntity("026", "JA", "JA", "Jaén");
		super.addEntity("027", "LC", "LC", "La Coruña");
		super.addEntity("028", "LR", "LR", "La Rioja");
		super.addEntity("029", "LP", "LP", "Las Palmas");
		super.addEntity("030", "LE", "LE", "León");
		super.addEntity("031", "LI", "LI", "Lleida");
		super.addEntity("032", "LU", "LU", "Lugo");
		super.addEntity("033", "MA", "MA", "Madrid");
		super.addEntity("034", "ML", "ML", "Málaga");
		super.addEntity("035", "ME", "ME", "Melilla");
		super.addEntity("036", "MU", "MU", "Murcia");
		super.addEntity("037", "NA", "NA", "Navarra");
		super.addEntity("038", "OU", "OU", "Ourense");
		super.addEntity("039", "PA", "PA", "Palencia");
		super.addEntity("040", "PO", "PO", "Pontevedra");
		super.addEntity("041", "SA", "SA", "Salamanca");
		super.addEntity("042", "SC", "SC", "Santa Cruz de Tenerife");
		super.addEntity("043", "SE", "SE", "Segovia");
	     super.addEntity("044", "SV", "SV", "Sevilla");
		 super.addEntity("045", "SO", "SO", "Soria");
		 super.addEntity("046", "TA", "TA", "Tarragona");
		 super.addEntity("047", "TE", "TE", "Teruel");
		 super.addEntity("048", "TO", "TO", "Toledo");
		 super.addEntity("049", "VA", "VA", "Valencia");
		 super.addEntity("050", "VL", "VL", "Valladolid");
		 super.addEntity("051", "ZA", "ZA", "Zamora");
		 super.addEntity("052", "ZR", "ZR", "Zaragoza");
		
		 
		

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
