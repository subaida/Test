import com.fusionmaps.core.Map;
class com.fusionmaps.maps.WestVirginiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "WestVirginiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function WestVirginiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "BA", "BA", "Barbour");
		super.addEntity("003", "BE", "BE", "Berkeley");
		super.addEntity("005", "BO", "BO", "Boone");
		super.addEntity("007", "BR", "BR", "Braxton");
		super.addEntity("009", "BK", "BK", "Brooke");
		super.addEntity("011", "CA", "CA", "Cabell");
		super.addEntity("013", "CH", "CH", "Calhoun");
		super.addEntity("015", "CL", "CL", "Clay");
		super.addEntity("017", "DO", "DO", "Doddridge");
		super.addEntity("019", "FA", "FA", "Fayette");
		super.addEntity("021", "GI", "GI", "Gilmer");
		super.addEntity("023", "GR", "GR", "Grant");
		super.addEntity("025", "GE", "GE", "Greenbrier");
		super.addEntity("027", "HA", "HA", "Hampshire");
		super.addEntity("029", "HN", "HN", "Hancock");
		super.addEntity("031", "HR", "HR", "Hardy");
		super.addEntity("033", "HI", "HI", "Harrison");
		super.addEntity("035", "JA", "JA", "Jackson");
		super.addEntity("037", "JE", "JE", "Jefferson");
        super.addEntity("039", "KA", "KA", "Kanawha");
        super.addEntity("041", "LE", "LE", "Lewis");
        super.addEntity("043", "LI", "LI", "Lincoln");
        super.addEntity("045", "LO", "LO", "Logan");
        super.addEntity("047", "MD", "MD", "McDowell");
        super.addEntity("049", "MA", "MA", "Marion");
		super.addEntity("051", "MR", "MR", "Marshall");
		super.addEntity("053", "MS", "MS", "Mason");
		super.addEntity("055", "ME", "ME", "Mercer");
		super.addEntity("057", "MI", "MI", "Mineral");
		super.addEntity("059", "MN", "MN", "Mingo");
		super.addEntity("061", "ML", "ML", "Monongalia");
		super.addEntity("065", "MG", "MG", "Morgan");
		super.addEntity("063", "MO", "MO", "Monroe");
		super.addEntity("067", "NI", "NI", "Nicholas");
		super.addEntity("069", "OH", "OH", "Ohio");
		super.addEntity("071", "PE", "PE", "Pendleton");
		super.addEntity("073", "PL", "PL", "Pleasants");
		super.addEntity("075", "PO", "PO", "Pocahontas");
		super.addEntity("077", "PR", "PR", "Preston");
		super.addEntity("079", "PU", "PU", "Putnam");
		super.addEntity("081", "RA", "RA", "Raleigh");
		super.addEntity("083", "RN", "RN", "Randolph");
		super.addEntity("085", "RI", "RI", "Ritchie");
		super.addEntity("087", "RO", "RO", "Roane");
	    super.addEntity("089", "SU", "SU", "Summers");
		super.addEntity("091", "TA", "TA", "Taylor");
		super.addEntity("093", "TU", "TU", "Tucker");
		 super.addEntity("095", "TY", "TY", "Tyler");
		 super.addEntity("097", "UP", "UP", "Upshur");
		 super.addEntity("099", "WA", "WA", "Wayne");
		 super.addEntity("101", "WE", "WE", "Webster");
		 super.addEntity("103", "WT", "WT", "Wetzel");
		 super.addEntity("105", "WI", "WI", "Wirt");
		 super.addEntity("107", "WO", "WO", "Wood");
		 super.addEntity("109", "WY", "WY", "Wyoming");
		 
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
