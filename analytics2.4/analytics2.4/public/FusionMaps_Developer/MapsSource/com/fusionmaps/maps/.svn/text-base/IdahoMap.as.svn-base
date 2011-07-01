import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IdahoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IdahoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IdahoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AD", "Ada");
		super.addEntity("003", "003", "AA", "Adams");
		super.addEntity("005", "005", "BA", "Bannock");
		super.addEntity("007", "007", "BE", "Bear Lake");
		super.addEntity("009", "009", "BN", "Benewah");
		super.addEntity("011", "011", "BI", "Bingham");
		super.addEntity("013", "013", "BL", "Blaine");
		super.addEntity("015", "015", "BO", "Boise");
		super.addEntity("017", "017", "BR", "Bonner");
		super.addEntity("019", "019", "BV", "Bonneville");
		super.addEntity("021", "021", "BU", "Boundary");
		super.addEntity("023", "023", "BT", "Butte");
		super.addEntity("025", "025", "CA", "Camas");
		super.addEntity("027", "027", "CN", "Canyon");
		super.addEntity("029", "029", "CR", "Caribou");
		super.addEntity("031", "031", "CS", "Cassia");
		super.addEntity("033", "033", "CL", "Clark");
		super.addEntity("035", "035", "CW", "Clearwater");
		super.addEntity("037", "037", "CU", "Custer");
		super.addEntity("039", "039", "EL", "Elmore");
		super.addEntity("041", "041", "FR", "Franklin");
		super.addEntity("043", "043", "FE", "Fremont");
		super.addEntity("045", "045", "GE", "Gem");
		super.addEntity("047", "047", "GO", "Gooding");
		super.addEntity("049", "049", "ID", "Idaho");
		super.addEntity("051", "051", "JE", "Jefferson");
		super.addEntity("053", "053", "JR", "Jerome");
		super.addEntity("055", "055", "KO", "Kootenai");
		super.addEntity("057", "057", "LA", "Latah");
		super.addEntity("059", "059", "LE", "Lemhi");
		super.addEntity("061", "061", "LW", "Lewis");
		super.addEntity("063", "063", "LI", "Lincoln");
		super.addEntity("065", "065", "MA", "Madison");
		super.addEntity("067", "067", "MI", "Minidoka");
		super.addEntity("069", "069", "NP", "Nez perce");
		super.addEntity("071", "071", "ON", "Oneida");
		super.addEntity("073", "073", "OW", "Owyhee");
		super.addEntity("075", "075", "PA", "Payette");
		super.addEntity("077", "077", "PO", "Power");
		super.addEntity("079", "079", "SH", "Shoshone");
		super.addEntity("081", "081", "TE", "Teton");
		super.addEntity("083", "083", "TF", "Twin falls");
		super.addEntity("085", "085", "VA", "Valley");
		super.addEntity("087", "087", "WA", "Washington");
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
