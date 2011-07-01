import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SouthCarolinaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SouthCarolinaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SouthCarolinaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String)  {
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
		super.addEntity("001", "AB", "AB", "Abbeville");
		super.addEntity("003", "AI", "AI", "Aiken");
		super.addEntity("005", "AL", "AL", "Allendale");
		super.addEntity("007", "AN", "AN", "Anderson");
		super.addEntity("009", "BA", "BA", "Bamberg");
		super.addEntity("011", "BR", "BR", "Barnwell");
		super.addEntity("013", "BE", "BE", "Beaufort");
		super.addEntity("015", "BK", "BK", "Berkeley");
		super.addEntity("017", "CA", "CA", "Calhoun");
		super.addEntity("019", "CH", "CH", "Charleston");
		super.addEntity("021", "CE", "CE", "Cherokee");
		super.addEntity("023", "CS", "CS", "Chester");
		super.addEntity("025", "CT", "CT", "Chesterfield");
		super.addEntity("027", "CD", "CD", "Clarendon");
		super.addEntity("029", "CL", "CL", "Colleton");
		super.addEntity("031", "DA", "DA", "Darlington");
		super.addEntity("033", "DI", "DI", "Dillon");
		super.addEntity("035", "DO", "DO", "Dorchester");
		super.addEntity("037", "ED", "ED", "Edgefield");
		super.addEntity("039", "FA", "FA", "Fairfield");
		super.addEntity("041", "FL", "FL", "Florence");
		super.addEntity("043", "GE", "GE", "Georgetown");
		super.addEntity("045", "GR", "GR", "Greenville");
		super.addEntity("047", "GW", "GW", "Greenwood");
		super.addEntity("049", "HA", "HA", "Hampton");
		super.addEntity("051", "HO", "HO", "Horry");
		super.addEntity("053", "JA", "JA", "Jasper");
		super.addEntity("055", "KE", "KE", "Kershaw");
		super.addEntity("057", "LA", "LA", "Lancaster");
		super.addEntity("059", "LU", "LU", "Laurens");
		super.addEntity("061", "LE", "LE", "Lee");
		super.addEntity("063", "LX", "LX", "Lexington");
		super.addEntity("065", "MC", "MC", "McCormick");
		super.addEntity("067", "MA", "MA", "Marion");
		super.addEntity("069", "MR", "MR", "Marlboro");
        super.addEntity("071", "NB", "NB", "Newberry");
		super.addEntity("073", "OC", "OC", "Oconee");
		super.addEntity("075", "OR", "OR", "Orangeburg");
		super.addEntity("077", "PI", "PI", "Pickens");
		super.addEntity("079", "RI", "RI", "Richland");
		super.addEntity("081", "SA", "SA", "Saluda");
		super.addEntity("083", "SP", "SP", "Spartanburg");
		super.addEntity("085", "SU", "SU", "Sumter");
		super.addEntity("087", "UN", "UN", "Union");
		super.addEntity("089", "WI", "WI", "Williamsburg");
		super.addEntity("091", "YO", "YO", "York");
		
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
