import com.fusionmaps.core.Map;
class com.fusionmaps.maps.OregonMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "OregonMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function OregonMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "BA", "BA", "Baker");
		super.addEntity("003", "BE", "BE", "Benton");
		super.addEntity("005", "CL", "CL", "Clackamas");
		super.addEntity("007", "CA", "CA", "Clatsop");
		super.addEntity("009", "CO", "CO", "Columbia");
		super.addEntity("011", "CS", "CS", "Coos");
		super.addEntity("013", "CR", "CR", "Crook");
		super.addEntity("015", "CU", "CU", "Curry");
		super.addEntity("017", "DE", "DE", "Deschutes");
		super.addEntity("019", "DO", "DO", "Douglas");
		super.addEntity("021", "GI", "GI", "Gilliam");
		super.addEntity("023", "GR", "GR", "Grant");
		super.addEntity("025", "HA", "HA", "Harney");
		super.addEntity("027", "HR", "HR", "Hood River");
		super.addEntity("029", "JA", "JA", "Jackson");
		super.addEntity("031", "JE", "JE", "Jefferson");
		super.addEntity("033", "JO", "JO", "Josephine");
		super.addEntity("035", "KL", "KL", "Klamath");
		super.addEntity("037", "LA", "LA", "Lake");
		super.addEntity("039", "LE", "LE", "Lane");
		super.addEntity("041", "LI", "LI", "Lincoln");
		super.addEntity("043", "LN", "LN", "Linn");
		super.addEntity("045", "MA", "MA", "Malheur");
		super.addEntity("047", "MR", "MR", "Marion");
		super.addEntity("049", "MO", "MO", "Morrow");
		super.addEntity("051", "MU", "MU", "Multnomah");
		super.addEntity("053", "PO", "PO", "Polk");
		super.addEntity("055", "SH", "SH", "Sherman");
		super.addEntity("057", "TI", "TI", "Tillamook");
		super.addEntity("059", "UM", "UM", "Umatilla");
		super.addEntity("061", "UN", "UN", "Union");
		super.addEntity("063", "WA", "WA", "Wallowa");
		super.addEntity("065", "WS", "WS", "Wasco");
		super.addEntity("067", "WH", "WH", "Washington");
		super.addEntity("069", "WE", "WE", "Wheeler");
		super.addEntity("071", "YA", "YA", "Yamhill");
	
		
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
