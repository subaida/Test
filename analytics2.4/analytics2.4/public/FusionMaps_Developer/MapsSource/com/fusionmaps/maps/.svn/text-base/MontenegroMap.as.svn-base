import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MontenegroMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MontenegroMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MontenegroMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AN", "AN", "Andrijevica");
		super.addEntity("02", "BA", "BA", "Bar");
		super.addEntity("03", "BE", "BE", "Berane");
		super.addEntity("04", "BP", "BP", "Bijelo Polje");
		super.addEntity("05", "BU", "BU", "Budva");
		super.addEntity("06", "CE", "CE", "Cetinje");
		super.addEntity("07", "DA", "DA", "Danilovgrad");
		super.addEntity("08", "HN", "HN", "Herceg Novi");
		super.addEntity("09", "KL", "KL", "Kolašin");
		super.addEntity("10", "KT", "KT", "Kotor");
		super.addEntity("11", "MK", "MK", "Mojkovac");
		super.addEntity("12", "NK", "NK", "Nikšić");
		super.addEntity("13", "PV", "PV", "Plav");
		super.addEntity("14", "PL", "PL", "Plužine");
		super.addEntity("15", "PU", "PU", "Pljevlja");
		super.addEntity("16", "PG", "PG", "Podgorica");
        super.addEntity("17", "RO", "RO", "Rožaje");
		super.addEntity("18", "SA", "SA", "Šavnik");
		super.addEntity("19", "TI", "TI", "Tivat");
		super.addEntity("20", "UL", "UL", "Ulcinj");
		super.addEntity("21", "ZA", "ZA", "Žabljak");
		
		 
		

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
