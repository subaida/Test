import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NorthDakotaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NorthDakotaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NorthDakotaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "BA", "BA", "Barnes");
		super.addEntity("005", "BE", "BE", "Benson");
		super.addEntity("007", "BI", "BI", "Billings");
		super.addEntity("009", "BO", "BO", "Bottineau");
		super.addEntity("011", "BW", "BW", "Bowman");
		super.addEntity("013", "BU", "BU", "Burke");
		super.addEntity("015", "BR", "BR", "Burleigh");
		super.addEntity("017", "CA", "CA", "Cass");
		super.addEntity("019", "CV", "CV", "Cavalier");
		super.addEntity("021", "DI", "DI", "Dickey");
		super.addEntity("023", "DV", "DV", "Divide");
		super.addEntity("025", "DN", "DN", "Dunn");
		super.addEntity("027", "ED", "ED", "Eddy");
		super.addEntity("029", "EM", "EM", "Emmons");
		super.addEntity("031", "FO", "FO", "Foster");
		super.addEntity("033", "GV", "GV", "Golden Valley");
		super.addEntity("035", "GF", "GF", "Grand Forks");
	    super.addEntity("037", "GR", "GR", "Grant");
		super.addEntity("039", "GN", "GN", "Griggs");
        super.addEntity("041", "HE", "HE", "Hettinger");
        super.addEntity("043", "KI", "KI", "Kidder");
        super.addEntity("045", "LM", "LM", "LaMoure");
        super.addEntity("047", "LO", "LO", "Logan");
        super.addEntity("049", "MH", "MH", "McHenry");
		super.addEntity("051", "MI", "MI", "McIntosh");
		super.addEntity("053", "MK", "MK", "McKenzie");
		super.addEntity("055", "ML", "ML", "McLean");
		super.addEntity("057", "ME", "ME", "Mercer");
		super.addEntity("059", "MO", "MO", "Morton");
		super.addEntity("061", "MU", "MU", "Mountrail");
		super.addEntity("063", "NE", "NE", "Nelson");
		super.addEntity("065", "OL", "OL", "Oliver");
		super.addEntity("067", "PE", "PE", "Pembina");
		super.addEntity("069", "PI", "PI", "Pierce");
		super.addEntity("071", "RA", "RA", "Ramsey");
		super.addEntity("073", "RN", "RN", "Ransom");
		super.addEntity("075", "RV", "RV", "Renville");
		super.addEntity("077", "RI", "RI", "Richland");
		super.addEntity("079", "RO", "RO", "Rolette");
		super.addEntity("081", "SA", "SA", "Sargent");
		super.addEntity("083", "SH", "SH", "Sheridan");
		super.addEntity("085", "SI", "SI", "Sioux");
		super.addEntity("087", "SL", "SL", "Slope");
	     super.addEntity("089", "ST", "ST", "Stark");
		 super.addEntity("091", "SE", "SE", "Steele");
		 super.addEntity("093", "SU", "SU", "Stutsman");
		 super.addEntity("095", "TO", "TO", "Towner");
		 super.addEntity("097", "TR", "TR", "Traill");
		 super.addEntity("099", "WA", "WA", "Walsh");
		 super.addEntity("101", "WR", "WR", "Ward");
		 super.addEntity("103", "WE", "WE", "Wells");
		 super.addEntity("105", "WI", "WI", "Williams");
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
