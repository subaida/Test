import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NewYorkMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NewYorkMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NewYorkMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AL", "Albany");
		super.addEntity("003", "003", "AE", "Allegany");
		super.addEntity("005", "005", "BR", "Bronx");
		super.addEntity("007", "007", "BO", "Broome");
		super.addEntity("009", "009", "CA", "Cattaraugus");
		super.addEntity("011", "011", "CY", "Cayuga");
		super.addEntity("013", "013", "CH", "Chautauqua");
		super.addEntity("015", "015", "CE", "Chemung");
		super.addEntity("017", "017", "CN", "Chenango");
		super.addEntity("019", "019", "CL", "Clinton");
		super.addEntity("021", "021", "CO", "Columbia");
		super.addEntity("023", "023", "CT", "Cortland");
		super.addEntity("025", "025", "DE", "Delaware");
		super.addEntity("027", "027", "DU", "Dutchess");
		super.addEntity("029", "029", "ER", "Erie");
		super.addEntity("031", "031", "ES", "Essex");
		super.addEntity("033", "033", "FR", "Franklin");
		super.addEntity("035", "035", "FU", "Fulton");
		super.addEntity("037", "037", "GE", "Genesee");
		super.addEntity("039", "039", "GR", "Greene");
		super.addEntity("041", "041", "HA", "Hamilton");
		super.addEntity("043", "043", "HE", "Herkimer");
		super.addEntity("045", "045", "JE", "Jefferson");
		super.addEntity("047", "047", "KI", "Kings");
		super.addEntity("049", "049", "LE", "Lewis");
		super.addEntity("051", "051", "LI", "Livingston");
		super.addEntity("053", "053", "MA", "Madison");
		super.addEntity("055", "055", "MN", "Monroe");
		super.addEntity("057", "057", "MO", "Montgomery");
		super.addEntity("059", "059", "NA", "Nassau");
		super.addEntity("061", "061", "NY", "New York");
		super.addEntity("063", "063", "NI", "Niagara");
		super.addEntity("065", "065", "ON", "Oneida");
		super.addEntity("067", "067", "OO", "Onondaga");
		super.addEntity("069", "069", "OT", "Ontario");
		super.addEntity("071", "071", "OR", "Orange");
		super.addEntity("073", "073", "OL", "Orleans");
		super.addEntity("075", "075", "OS", "Oswego");
		super.addEntity("077", "077", "OG", "Otsego");
		super.addEntity("079", "079", "PU", "Putnam");
		super.addEntity("081", "081", "QU", "Queens");
		super.addEntity("083", "083", "RE", "Rensselaer");
		super.addEntity("085", "085", "RI", "Richmond");
		super.addEntity("087", "087", "RO", "Rockland");
		super.addEntity("091", "091", "SA", "Saratoga");
		super.addEntity("093", "093", "SC", "Schenectady");
		super.addEntity("095", "095", "SH", "Schoharie");
		super.addEntity("097", "097", "SU", "Schuyler");
		super.addEntity("099", "099", "SE", "Seneca");
		super.addEntity("089", "089", "SL", "St.Lawrence");
		super.addEntity("101", "101", "ST", "Steuben");
		super.addEntity("103", "103", "SF", "Suffolk");
		super.addEntity("105", "105", "SV", "Sullivan");
		super.addEntity("107", "107", "TI", "Tioga");
		super.addEntity("109", "109", "TO", "Tompkins");
		super.addEntity("111", "111", "UL", "Ulster");
		super.addEntity("113", "113", "WA", "Warren");
		super.addEntity("115", "115", "WS", "Washington");
		super.addEntity("117", "117", "WY", "Wayne");
		super.addEntity("119", "119", "WE", "Westchester");
		super.addEntity("121", "121", "WO", "Wyoming");
		super.addEntity("123", "123", "YA", "Yates");
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
