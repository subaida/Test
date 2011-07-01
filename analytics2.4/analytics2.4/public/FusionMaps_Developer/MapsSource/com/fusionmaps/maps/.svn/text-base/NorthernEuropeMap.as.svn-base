import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NorthernEuropeMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NorthernEuropeMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NorthernEuropeMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String) {
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
		super.addEntity("003", "AU", "AU", "Aurora");
		super.addEntity("005", "BE", "BE", "Beadle");
		super.addEntity("007", "BN", "BN", "Bennett");
		super.addEntity("009", "BH", "BH", "Bon Homme");
		super.addEntity("011", "BR", "BR", "Brookings");
		super.addEntity("013", "BW", "BW", "Brown");
		super.addEntity("015", "BU", "BU", "Brule");
		super.addEntity("017", "BF", "BF", "Buffalo");
		super.addEntity("019", "BT", "BT", "Butte");
		super.addEntity("021", "CA", "CA", "Campbell");
		super.addEntity("023", "CM", "CM", "Charles Mix");
		super.addEntity("025", "CL", "CL", "Clark");
		super.addEntity("027", "CY", "CY", "Clay");
		super.addEntity("029", "CO", "CO", "Codington");
		super.addEntity("031", "CS", "CS", "Corson");
		super.addEntity("033", "CU", "CU", "Custer");
		super.addEntity("035", "DA", "DA", "Davison");
	    super.addEntity("037", "DY", "DY", "Day");
        super.addEntity("039", "DU", "DU", "Deuel");
        super.addEntity("041", "DE", "DE", "Dewey");
        super.addEntity("043", "DO", "DO", "Douglas");
        super.addEntity("045", "ED", "ED", "Edmunds");
		super.addEntity("047", "FR", "FR", "Fall River");
        super.addEntity("049", "FA", "FA", "Faulk");
		super.addEntity("051", "GR", "GR", "Grant");
		super.addEntity("053", "GE", "GE", "Gregory");
		super.addEntity("055", "HA", "HA", "Haakon");
		super.addEntity("057", "HM", "HM", "Hamlin");
		super.addEntity("059", "HN", "HN", "Hand");
		super.addEntity("061", "HS", "HS", "Hanson");
		super.addEntity("063", "HD", "HD", "Harding");
		super.addEntity("065", "HG", "HG", "Hughes");
		super.addEntity("067", "HT", "HT", "Hutchinson");
		super.addEntity("069", "HY", "HY", "Hyde");
		super.addEntity("071", "JA", "JA", "Jackson");
		super.addEntity("073", "JE", "JE", "Jerauld");
		super.addEntity("075", "JO", "JO", "Jones");
		super.addEntity("077", "KI", "KI", "Kingsbury");
		super.addEntity("079", "LA", "LA", "Lake");
		super.addEntity("081", "LW", "LW", "Lawrence");
		super.addEntity("083", "LI", "LI", "Lincoln");
		super.addEntity("085", "LY", "LY", "Lyman");
		super.addEntity("087", "MC", "MC", "McCook");
	    super.addEntity("089", "MP", "MP", "McPherson");
		super.addEntity("091", "MA", "MA", "Marshall");
		super.addEntity("093", "ME", "ME", "Meade");
		super.addEntity("095", "ML", "ML", "Mellette");
		super.addEntity("097", "MI", "MI", "Miner");
		super.addEntity("099", "MN", "MN", "Minnehaha");
		super.addEntity("101", "MO", "MO", "Moody");
		super.addEntity("103", "PE", "PE", "Pennington");
		 super.addEntity("105", "PR", "PR", "Perkins");
		 super.addEntity("107", "PO", "PO", "Potter");
		 super.addEntity("109", "RO", "RO", "Roberts");
		 super.addEntity("111", "SA", "SA", "Sanborn");
		 super.addEntity("113", "SH", "SH", "Shannon");
		 super.addEntity("115", "SP", "SP", "Spink");
		 super.addEntity("117", "ST", "ST", "Stanley");
		 super.addEntity("119", "SU", "SU", "Sully");
		 super.addEntity("121", "TO", "TO", "Todd");
		 super.addEntity("123", "TR", "TR", "Tripp");
		 super.addEntity("125", "TU", "TU", "Turner");
		 super.addEntity("127", "UN", "UN", "Union"); 
		 super.addEntity("129", "WA", "WA", "Walworth");
		 super.addEntity("135", "YA", "YA", "Yankton");
		 super.addEntity("137", "ZI", "ZI", "Ziebach");
		 
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
