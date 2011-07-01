import com.fusionmaps.core.Map;
class com.fusionmaps.maps.LatviaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "LatviaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function LatviaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AI", "AI", "Aizkraukle");
		super.addEntity("02", "AL", "AL", "Alūksne");
		super.addEntity("03", "BL", "BL", "Balvi");
		super.addEntity("04", "BU", "BU", "Bauska");
		super.addEntity("05", "CE", "CE", "Cēsis");
		super.addEntity("06", "DA", "DA", "Daugavpils");
		super.addEntity("07", "DGV", "DGV", "Daugavpils (city)");
		super.addEntity("08", "DO", "DO", "Dobele");
		super.addEntity("09", "GU", "GU", "Gulbene");
		super.addEntity("10", "JK", "JK", "Jēkabpils");
		super.addEntity("11", "JL", "JL", "Jelgava");
		super.addEntity("12", "JEL", "JEL", "Jelgava (city)");
		super.addEntity("13", "JUR", "JUR", "Jūrmala (city)");
		super.addEntity("14", "KR", "KR", "Krāslava");
		super.addEntity("15", "KU", "KU", "Kuldīga");
		super.addEntity("16", "LE", "LE", "Liepāja");
		super.addEntity("17", "LPX", "LPX", "Liepāja (city)");
		super.addEntity("18", "LM", "LM", "Limbaži");
		super.addEntity("19", "LU", "LU", "Ludza");
        super.addEntity("20", "MA", "MA", "Madona");
        super.addEntity("21", "OG", "OG", "Ogre");
        super.addEntity("22", "PR", "PR", "Preiļi");
        super.addEntity("23", "RE", "RE", "Rēzekne");
        super.addEntity("24", "REZ", "REZ", "Rēzekne (city)");
        super.addEntity("25", "RI", "RI", "Rīga");
		super.addEntity("26", "RIX", "RIX", "Rīga (city)");
		super.addEntity("27", "SA", "SA", "Saldus");
		super.addEntity("28", "TA", "TA", "Talsi");
		super.addEntity("29", "TU", "TU", "Tukums");
		super.addEntity("30", "VK", "VK", "Valka");
		super.addEntity("31", "VM", "VM", "Valmiera");
		super.addEntity("32", "VE", "VE", "Ventspils");
		super.addEntity("33", "VEN", "VEN", "Ventspils (city)");
		

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
