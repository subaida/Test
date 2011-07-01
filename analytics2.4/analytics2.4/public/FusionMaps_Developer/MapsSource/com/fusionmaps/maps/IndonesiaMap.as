import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IndonesiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IndonesiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IndonesiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AC", "AC", "Aceh");
		super.addEntity("02", "BA", "BA", "Bali");
		super.addEntity("35", "BB", "BB", "Bangka-Belitung");
		super.addEntity("33", "BT", "BT", "Banten");
		super.addEntity("03", "BE", "BE", "Bengkulu");
		super.addEntity("07", "JT", "JT", "Central Java");
		super.addEntity("13", "KT", "KT", "Central Kalimantan");
		super.addEntity("21", "ST", "ST", "Central Sulawesi");
		super.addEntity("08", "JI", "JI", "East Java");
		super.addEntity("14", "KI", "KI", "East Kalimantan");
		super.addEntity("18", "NT", "NT", "East Nusa Tenggara");
		super.addEntity("34", "GO", "GO", "Gorontalo");
		super.addEntity("04", "JK", "JK", "Jakarta");
		super.addEntity("05", "JA", "JA", "Jambi");
		super.addEntity("15", "LA", "LA", "Lampung");
		super.addEntity("28", "MA", "MA", "Maluku");
		super.addEntity("29", "MU", "MU", "North Maluku");
		super.addEntity("31", "SA", "SA", "North Sulawesi");
		super.addEntity("26", "SU", "SU", "North Sumatra");
        super.addEntity("36", "PA", "PA", "Papua");
        super.addEntity("37", "RI", "RI", "Riau");
        super.addEntity("40", "KR", "KR", "Riau Islands");
        super.addEntity("22", "SG", "SG", "South East Sulawesi");
        super.addEntity("12", "KS", "KS", "South Kalimantan");
        super.addEntity("38", "SN", "SN", "South Sulawesi");
		super.addEntity("32", "SL", "SL", "South Sumatra");
		super.addEntity("39", "IB", "IB", "West Irian Jaya");
		super.addEntity("30", "JR", "JR", "West Java");
		super.addEntity("11", "KB", "KB", "West Kalimantan");
		super.addEntity("17", "NB", "NB", "West Nusa Tenggara");
		super.addEntity("41", "SR", "SR", "West Sulawesi");
		super.addEntity("24", "SB", "SB", "West Sumatra");
		super.addEntity("10", "YO", "YO", "Yogyakarta");
		
		

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
