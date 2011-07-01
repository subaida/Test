import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ColoradoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ColoradoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ColoradoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AD", "AD", "Adams");
		super.addEntity("003", "AL", "AL", "Alamosa");
		super.addEntity("005", "AR", "AR", "Arapahoe");
		super.addEntity("007", "AC", "AC", "Archuleta");
		super.addEntity("009", "BA", "BA", "Baca");
		super.addEntity("011", "BE", "BE", "Bent");
		super.addEntity("013", "BO", "BO", "Boulder");
		super.addEntity("014", "BR", "BR", "Broomfield");
		super.addEntity("015", "CH", "CH", "Chaffee");
		super.addEntity("017", "CE", "CE", "Cheyenne");
		super.addEntity("019", "CL", "CL", "Clear Creek");
		super.addEntity("021", "CO", "CO", "Conejos");
		super.addEntity("023", "CS", "CS", "Costilla");
		super.addEntity("025", "CR", "CR", "Crowley");
		super.addEntity("027", "CU", "CU", "Custer");
		super.addEntity("029", "DE", "DE", "Delta");
		super.addEntity("031", "DN", "DN", "Denver");
		super.addEntity("033", "DO", "DO", "Dolores");
		super.addEntity("035", "DU", "DU", "Douglas");
		super.addEntity("037", "EA", "EA", "Eagle");
		super.addEntity("039", "EL", "EL", "Elbert");
		super.addEntity("041", "EP", "EP", "El Paso");
		super.addEntity("043", "FR", "FR", "Fremont");
		super.addEntity("045", "GA", "GA", "Garfield");
		super.addEntity("047", "GI", "GI", "Gilpin");
		super.addEntity("049", "GR", "GR", "Grand");
		super.addEntity("051", "GU", "GU", "Gunnison");
		super.addEntity("053", "HI", "HI", "Hinsdale");
		super.addEntity("055", "HU", "HU", "Huerfano");
		super.addEntity("057", "JA", "JA", "Jackson");
		super.addEntity("059", "JE", "JE", "Jefferson");
		super.addEntity("061", "KI", "KI", "Kiowa");
		super.addEntity("063", "KC", "KC", "Kit Carson");
		super.addEntity("065", "LA", "LA", "Lake");
		super.addEntity("067", "LP", "LP", "La Plata");
		super.addEntity("069", "LR", "LR", "Larimer");
		super.addEntity("071", "LS", "LS", "Las Animas");
		super.addEntity("073", "LI", "LI", "Lincoln");
		super.addEntity("075", "LO", "LO", "Logan");
		super.addEntity("077", "ME", "ME", "Mesa");
		super.addEntity("079", "MI", "MI", "Mineral");
		super.addEntity("081", "MO", "MO", "Moffat");
		super.addEntity("083", "MN", "MN", "Montezuma");
		super.addEntity("085", "MT", "MT", "Montrose");
		super.addEntity("087", "MG", "MG", "Morgan");
		super.addEntity("089", "OT", "OT", "Otero");
		super.addEntity("091", "OU", "OU", "Ouray");
		super.addEntity("093", "PA", "PA", "Park");
		super.addEntity("095", "PH", "PH", "Phillips");
		super.addEntity("097", "PI", "PI", "Pitkin");
		super.addEntity("099", "PR", "PR", "Prowers");
		super.addEntity("101", "PU", "PU", "Pueblo");
		super.addEntity("103", "RB", "RB", "Rio Blanco");
		super.addEntity("105", "RG", "RG", "Rio Grande");
		super.addEntity("107", "RO", "RO", "Routt");
		super.addEntity("109", "SA", "SA", "Saguache");
		super.addEntity("111", "SJ", "SJ", "San Juan");
		super.addEntity("113", "SM", "SM", "San Miguel");
		super.addEntity("115", "SE", "SE", "Sedgwick");
		super.addEntity("117", "SU", "SU", "Summit");
		super.addEntity("119", "TE", "TE", "Teller");
		super.addEntity("121", "WA", "WA", "Washington");
		super.addEntity("123", "WL", "WL", "Weld");
		super.addEntity("125", "YU", "YU", "Yuma");
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
