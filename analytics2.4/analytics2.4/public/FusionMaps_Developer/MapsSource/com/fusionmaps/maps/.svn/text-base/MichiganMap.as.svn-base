import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MichiganMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MichiganMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MichiganMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AL", "AL", "Alcona");
		super.addEntity("003", "AG", "AG", "Alger");
		super.addEntity("005", "AE", "AE", "Allegan");
		super.addEntity("007", "AP", "AP", "Alpena");
		super.addEntity("009", "AN", "AN", "Antrim");
		super.addEntity("011", "AR", "AR", "Arenac");
		super.addEntity("013", "BA", "BA", "Baraga");
		super.addEntity("015", "BR", "BR", "Barry");
		super.addEntity("017", "BY", "BY", "Bay");
		super.addEntity("019", "BE", "BE", "Benzie");
		super.addEntity("021", "BI", "BI", "Berrien");
		super.addEntity("023", "BN", "BN", "Branch");
		super.addEntity("025", "CA", "CA", "Calhoun");
		super.addEntity("027", "CS", "CS", "Cass");
		super.addEntity("029", "CH", "CH", "Charlevoix");
		super.addEntity("031", "CE", "CE", "Cheboygan");
		super.addEntity("033", "CI", "CI", "Chippewa");
		super.addEntity("035", "CL", "CL", "Clare");
		super.addEntity("037", "CN", "CN", "Clinton");
        super.addEntity("039", "CR", "CR", "Crawford");
        super.addEntity("041", "DE", "DE", "Delta");
        super.addEntity("043", "DI", "DI", "Dickinson");
        super.addEntity("045", "EA", "EA", "Eaton");
        super.addEntity("047", "EM", "EM", "Emmet");
        super.addEntity("049", "GE", "GE", "Genesee");
		super.addEntity("051", "GL", "GL", "Gladwin");
		super.addEntity("053", "GO", "GO", "Gogebic");
		super.addEntity("055", "GT", "GT", "Grand Traverse");
		super.addEntity("057", "GA", "GA", "Gratiot");
		super.addEntity("059", "HI", "HI", "Hillsdale");
		super.addEntity("061", "HO", "HO", "Houghton");
		super.addEntity("063", "HU", "HU", "Huron");
		super.addEntity("065", "IN", "IN", "Ingham");
		super.addEntity("067", "IO", "IO", "Ionia");
		super.addEntity("069", "IS", "IS", "Iosco");
		super.addEntity("071", "IR", "IR", "Iron");
		super.addEntity("073", "IA", "IA", "Isabella");
		super.addEntity("075", "JA", "JA", "Jackson");
		super.addEntity("077", "KM", "KM", "Kalamazoo");
		super.addEntity("079", "KA", "KA", "Kalkaska");
		super.addEntity("081", "KN", "KN", "Kent");
		super.addEntity("083", "KE", "KE", "Keweenaw");
		super.addEntity("085", "LK", "LK", "Lake");
	     super.addEntity("087", "LP", "LP", "Lapeer");
		 super.addEntity("089", "LL", "LL", "Leelanau");
		 super.addEntity("091", "LE", "LE", "Lenawee");
		 super.addEntity("093", "LI", "LI", "Livingston");
		 super.addEntity("095", "LU", "LU", "Luce");
		 super.addEntity("097", "MK", "MK", "Mackinac");
		 super.addEntity("099", "MB", "MB", "Macomb");
		 super.addEntity("101", "MS", "MS", "Manistee");
		 super.addEntity("103", "MQ", "MQ", "Marquette");
		 super.addEntity("105", "MA", "MA", "Mason");
		 super.addEntity("107", "MC", "MC", "Mecosta");
		 super.addEntity("109", "MM", "MM", "Menominee");
		 super.addEntity("111", "MD", "MD", "Midland");
		 super.addEntity("113", "MI", "MI", "Missaukee");
		 super.addEntity("115", "MR", "MR", "Monroe");
		 super.addEntity("117", "MN", "MN", "Montcalm");
		 super.addEntity("119", "MO", "MO", "Montmorency");
		 super.addEntity("121", "MU", "MU", "Muskegon");
		 super.addEntity("123", "NE", "NE", "Newaygo");
		 super.addEntity("125", "OK", "OK", "Oakland"); 
		 super.addEntity("127", "OA", "OA", "Oceana");
		 super.addEntity("129", "OG", "OG", "Ogemaw");
		 super.addEntity("131", "ON", "ON", "Ontonagon");
		 super.addEntity("133", "OE", "OE", "Osceola");
		 super.addEntity("135", "OC", "OC", "Oscoda"); 
		 super.addEntity("137", "OS", "OS", "Otsego");
		 super.addEntity("139", "OT", "OT", "Ottawa"); 
		 super.addEntity("141", "PR", "PR", "Presque Isle");
		 super.addEntity("143", "RO", "RO", "Roscommon");
		 super.addEntity("145", "SA", "SA", "Saginaw");
		 super.addEntity("147", "SC", "SC", "St.Clair");
		 super.addEntity("149", "SJ", "SJ", "St.Joseph"); 
		 super.addEntity("151", "SN", "SN", "Sanilac");
		 super.addEntity("153", "SH", "SH", "Schoolcraft");
		 super.addEntity("155", "SW", "SW", "Shiawassee");
		 super.addEntity("157", "TU", "TU", "Tuscola");
		 super.addEntity("159", "VB", "VB", "Van Buren"); 
		 super.addEntity("161", "WA", "WA", "Washtenaw");
		 super.addEntity("163", "WY", "WY", "Wayne");
		 super.addEntity("165", "WE", "WE", "Wexford");
		 
		 
		

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
