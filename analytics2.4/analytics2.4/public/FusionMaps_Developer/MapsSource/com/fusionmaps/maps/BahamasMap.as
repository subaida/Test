import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BahamasMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BahamasMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BahamasMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AK", "AK", "Acklins");
		super.addEntity("02", "BR", "BR", "Berry Islands");
		super.addEntity("03", "BI", "BI", "Bimini");
		super.addEntity("04", "BP", "BP", "Black Point");
		super.addEntity("05", "CI", "CI", "Cat Island");
		super.addEntity("06", "CB", "CB", "Central Abaco");
		super.addEntity("07", "CN", "CN", "Central Andros");
		super.addEntity("08", "CE", "CE", "Central Eleuthera");
		super.addEntity("09", "FP", "FP", "City of Freeport");
		super.addEntity("10", "CK", "CK", "Crooked Island");
		super.addEntity("11", "EB", "EB", "East Grand Bahama");
		super.addEntity("12", "EM", "EM", "Exuma");
		super.addEntity("13", "GC", "GC", "Grand Cay");
		super.addEntity("14", "HB", "HB", "Harbour Island");
		super.addEntity("15", "HT", "HT", "Hope Town");
		super.addEntity("16", "IN", "IN", "Inagua");
		super.addEntity("17", "LI", "LI", "Long Island");
		super.addEntity("18", "MC", "MC", "Mangrove Cay");
		super.addEntity("19", "MG", "MG", "Mayaguana");
        super.addEntity("20", "MI", "MI", "Moore's Island");
        super.addEntity("21", "NW", "NW", "New Providence");
        super.addEntity("22", "NB", "NB", "North Abaco");
        super.addEntity("23", "NN", "NN", "North Andros");
        super.addEntity("24", "NE", "NE", "North Eleuthera");
        super.addEntity("25", "RI", "RI", "Ragged Island");
		super.addEntity("26", "RC", "RC", "Rum Cay");
		super.addEntity("27", "SS", "SS", "San Salvador");
		super.addEntity("28", "SB", "SB", "South Abaco");
		super.addEntity("29", "SN", "SN", "South Andros");
		super.addEntity("30", "SE", "SE", "South Eleuthera");
		super.addEntity("31", "SW", "SW", "Spanish Wells");
		super.addEntity("32", "WB", "WB", "West Grand Bahama");
	
		 
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
