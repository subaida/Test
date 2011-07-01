import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PennsylvaniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PennsylvaniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PennsylvaniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("003", "AL", "AL", "Alleghany");
		super.addEntity("005", "AR", "AR", "Armstrong");
		super.addEntity("007", "BE", "BE", "Beaver");
		super.addEntity("009", "BD", "BD", "Bedford");
		super.addEntity("011", "BR", "BR", "Berks");
		super.addEntity("013", "BL", "BL", "Blair");
		super.addEntity("015", "BF", "BF", "Bradford");
		super.addEntity("017", "BU", "BU", "Bucks");
		super.addEntity("019", "BT", "BT", "Butler");
		super.addEntity("021", "CA", "CA", "Cambria");
		super.addEntity("023", "CM", "CM", "Cameron");
		super.addEntity("025", "CR", "CR", "Carbon");
		super.addEntity("027", "CE", "CE", "Centre");
		super.addEntity("029", "CH", "CH", "Chester");
		super.addEntity("031", "CI", "CI", "Clarion");
		super.addEntity("033", "CL", "CL", "Clearfield");
		super.addEntity("035", "CN", "CN", "Clinton");
		super.addEntity("037", "CO", "CO", "Columbia");
        super.addEntity("039", "CW", "CW", "Crawford");
        super.addEntity("041", "CU", "CU", "Cumberland");
        super.addEntity("043", "DA", "DA", "Dauphin");
        super.addEntity("045", "DL", "DL", "Delaware");
        super.addEntity("047", "EL", "EL", "Elk");
        super.addEntity("049", "ER", "ER", "Erie");
		super.addEntity("051", "FA", "FA", "Fayette");
		super.addEntity("053", "FO", "FO", "Forest");
		super.addEntity("055", "FR", "FR", "Franklin");
		super.addEntity("057", "FU", "FU", "Fulton");
		super.addEntity("059", "GR", "GR", "Greene");
		super.addEntity("061", "HU", "HU", "Huntingdon");
		super.addEntity("063", "IN", "IN", "Indiana");
		super.addEntity("065", "JE", "JE", "Jefferson");
		super.addEntity("067", "JU", "JU", "Juniata");
		super.addEntity("069", "LA", "LA", "Lackawanna");
		super.addEntity("071", "LN", "LN", "Lancaster");
		super.addEntity("073", "LW", "LW", "Lawrence");
		super.addEntity("075", "LE", "LE", "Lebanon");
		super.addEntity("077", "LH", "LH", "Lehigh");
		super.addEntity("079", "LZ", "LZ", "Luzerne");
		super.addEntity("081", "LY", "LY", "Lycoming");
		super.addEntity("083", "MK", "MK", "McKean");
		super.addEntity("085", "ME", "ME", "Mercer");
	     super.addEntity("087", "MI", "MI", "Mifflin");
		 super.addEntity("089", "MO", "MO", "Monroe");
		 super.addEntity("091", "MT", "MT", "Montgomery");
		 super.addEntity("093", "MU", "MU", "Montour");
		 super.addEntity("095", "NO", "NO", "Northampton");
		 super.addEntity("097", "NT", "NT", "Northumberland");
		 super.addEntity("099", "PE", "PE", "Perry");
		 super.addEntity("101", "PH", "PH", "Philadelphia");
		 super.addEntity("103", "PI", "PI", "Pike");
		 super.addEntity("105", "PO", "PO", "Potter");
		 super.addEntity("107", "SC", "SC", "Schuylkill");
		 super.addEntity("109", "SN", "SN", "Snyder");
		 super.addEntity("111", "SO", "SO", "Somerset");
		 super.addEntity("113", "SU", "SU", "Sullivan");
		 super.addEntity("115", "SQ", "SQ", "Susquehanna");
		 super.addEntity("117", "TI", "TI", "Tioga");
		 super.addEntity("119", "UN", "UN", "Union");
		 super.addEntity("121", "VE", "VE", "Venango");
		 super.addEntity("123", "WA", "WA", "Warren");
		 super.addEntity("125", "WS", "WS", "Washington"); 
		 super.addEntity("127", "WY", "WY", "Wayne");
		 super.addEntity("129", "WE", "WE", "Westmoreland");
		 super.addEntity("131", "WO", "WO", "Wyoming");
		 super.addEntity("133", "YO", "YO", "York");
		 
		 
		

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
