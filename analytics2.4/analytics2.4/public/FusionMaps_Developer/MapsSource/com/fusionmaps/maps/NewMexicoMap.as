import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NewMexicoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NewMexicoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NewMexicoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "BE", "BE", "Bernalillo");
		super.addEntity("003", "CA", "CA", "Catron");
		super.addEntity("005", "CH", "CH", "Chaves");
		super.addEntity("006", "CI", "CI", "Cibola");
		super.addEntity("007", "CO", "CO", "Colfax");
		super.addEntity("009", "CU", "CU", "Curry");
		super.addEntity("011", "DB", "DB", "De Baca");
		super.addEntity("013", "DA", "DA", "Doña Ana ");
		super.addEntity("015", "ED", "ED", "Eddy");
		super.addEntity("017", "GR", "GR", "Grant");
		super.addEntity("019", "GU", "GU", "Guadalupe");
		super.addEntity("021", "HA", "HA", "Harding");
		super.addEntity("023", "HI", "HI", "Hidalgo");
		super.addEntity("025", "LE", "LE", "Lea");
		super.addEntity("027", "LI", "LI", "Lincoln");
		super.addEntity("028", "LA", "LA", "Los Alamos");
		super.addEntity("029", "LU", "LU", "Luna");
		super.addEntity("031", "MK", "MK", "McKinley");
		super.addEntity("033", "MO", "MO", "Mora");
		super.addEntity("035", "OT", "OT", "Otero");
		super.addEntity("037", "QU", "QU", "Quay");
		super.addEntity("039", "RA", "RA", "Rio Arriba");
		super.addEntity("041", "RS", "RS", "Roosevelt");
		super.addEntity("043", "SA", "SA", "Sandoval");
		super.addEntity("045", "SJ", "SJ", "San Juan");
		super.addEntity("047", "SM", "SM", "San Miguel");
		super.addEntity("049", "SF", "SF", "Santa Fe");
		super.addEntity("051", "SI", "SI", "Sierra");
		super.addEntity("053", "SO", "SO", "Socorro");
		super.addEntity("055", "TA", "TA", "Taos");
		super.addEntity("057", "TR", "TR", "Torrance");
		super.addEntity("059", "UN", "UN", "Union");
		super.addEntity("061", "VA", "VA", "Valencia");
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
