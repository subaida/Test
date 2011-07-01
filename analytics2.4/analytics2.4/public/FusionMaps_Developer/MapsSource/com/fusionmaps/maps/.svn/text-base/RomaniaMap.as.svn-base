import com.fusionmaps.core.Map;
class com.fusionmaps.maps.RomaniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "RomaniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function RomaniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AB", "AB", "Alba");
		super.addEntity("02", "AR", "AR", "Arad");
		super.addEntity("03", "AG", "AG", "Argeş ");
		super.addEntity("04", "BC", "BC", "Bacău ");
		super.addEntity("05", "BH", "BH", "Bihor");
		super.addEntity("06", "BN", "BN", "Bistriţa-Năsăud");
		super.addEntity("07", "BT", "BT", "Botosani");
		super.addEntity("08", "BR", "BR", "Brăila ");
		super.addEntity("09", "BV", "BV", "Braşov ");
		super.addEntity("10", "BI", "BI", "Bucharest");
		super.addEntity("11", "BZ", "BZ", "Buzău");
		super.addEntity("12", "CS", "CS", "Caraş-Severin");
		super.addEntity("13", "CJ", "CJ", "Cluj");
		super.addEntity("14", "CT", "CT", "Constanţa");
		super.addEntity("15", "CV", "CV", "Covasna");
		super.addEntity("16", "DB", "DB", "Dâmboviţa");
		super.addEntity("17", "DJ", "DJ", "Dolj");
		super.addEntity("18", "GL", "GL", "Galaţi");
		super.addEntity("19", "GJ", "GJ", "Gorj");
		super.addEntity("20", "HR", "HR", "Harghita");
        super.addEntity("21", "HD", "HD", "Hunedoara");
        super.addEntity("22", "IL", "IL", "Ialomiţa ");
        super.addEntity("23", "IS", "IS", "Iaşi ");
        super.addEntity("25", "MM", "MM", "Maramureş");
        super.addEntity("26", "MH", "MH", "Mehedinţi ");
        super.addEntity("27", "MS", "MS", "Mureş ");
		super.addEntity("28", "NT", "NT", "Neamţ ");
		super.addEntity("29", "OT", "OT", "Olt");
		super.addEntity("30", "PH", "PH", "Prahova");
		super.addEntity("31", "SJ", "SJ", "Sălaj ");
		super.addEntity("32", "SM", "SM", "Satu Mare");
		super.addEntity("33", "SB", "SB", "Sibiu");
		super.addEntity("34", "SV", "SV", "Suceava");
		super.addEntity("35", "TR", "TR", "Teleorman");
		super.addEntity("36", "TM", "TM", "Timiş");
		super.addEntity("37", "TL", "TL", "Tulcea");
		super.addEntity("38", "VS", "VS", "Vaslui");
		super.addEntity("39", "VL", "VL", "Vâlcea ");
		super.addEntity("40", "VN", "VN", "Vrancea");
		super.addEntity("41", "CL", "CL", "Călăraşi ");
		super.addEntity("42", "GR", "GR", "Giurgiu");
		super.addEntity("43", "IF", "IF", "Ilfov");
		
		 
		 
		

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
