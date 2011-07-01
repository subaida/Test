import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IraqMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IraqMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IraqMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String) {
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
		super.addEntity("01", "AN", "AN", "Al-Anbar");
		super.addEntity("02", "BA", "BA", "Al-Basrah");
		super.addEntity("03", "MU", "MU", "Al-Muthannā");
		super.addEntity("04", "QA", "QA", "Al-Qādisiyyah");
		super.addEntity("17", "NA", "NA", "An-Najaf");
		super.addEntity("11", "AR", "AR", "Arbīl");
		super.addEntity("05", "SU", "SU", "As-Sulaymāniyah");
		super.addEntity("13", "TS", "TS", "At-Ta'mim");
		super.addEntity("06", "BB", "BB", "Bābil");
		super.addEntity("07", "BG", "BG", "Baghdād");
		super.addEntity("08", "DA", "DA", "Dahūk ");
		super.addEntity("09", "DQ", "DQ", "Dhī Qār");
		super.addEntity("10", "DI", "DI", "Diyālā");
		super.addEntity("12", "KA", "KA", "Karbala");
		super.addEntity("14", "MA", "MA", "Maysān");
		super.addEntity("15", "NI", "NI", "Nīnawā");
		super.addEntity("18", "SD", "SD", "Salāh ad-Dīn");
		super.addEntity("16", "WA", "WA", "Wāsit");
		
		
	
		
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
