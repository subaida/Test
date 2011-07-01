import com.fusionmaps.core.Map;
class com.fusionmaps.maps.WashingtonMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "WashingtonMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function WashingtonMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AD", "Adams");
		super.addEntity("003", "003", "AS", "Asotin");
		super.addEntity("005", "005", "BE", "Benton");
		super.addEntity("007", "007", "CH", "Chelan");
		super.addEntity("009", "009", "CM", "Clallam");
		super.addEntity("011", "011", "CA", "Clark");
		super.addEntity("013", "013", "CL", "Columbia");
		super.addEntity("015", "015", "CO", "Cowlitz");
		super.addEntity("017", "017", "DO", "Douglas");
		super.addEntity("019", "019", "FE", "Ferry");
		super.addEntity("021", "021", "FR", "Franklin");
		super.addEntity("023", "023", "GF", "Garfield");
		super.addEntity("025", "025", "GA", "Grant");
		super.addEntity("027", "027", "GR", "Grays Harbor");
		super.addEntity("029", "029", "IS", "Island");
		super.addEntity("031", "031", "JE", "Jefferson");
		super.addEntity("033", "033", "KG", "King");
		super.addEntity("035", "035", "KT", "Kitsap");
		super.addEntity("037", "037", "KI", "Kittitas");
		super.addEntity("039", "039", "KL", "Klickitat");
		super.addEntity("041", "041", "LE", "Lewis");
		super.addEntity("043", "043", "LI", "Lincoln");
		super.addEntity("045", "045", "MA", "Mason");
		super.addEntity("047", "047", "OK", "Okanogan");
		super.addEntity("049", "049", "PA", "Pacific");
		super.addEntity("051", "051", "PE", "Pend Oreille");
		super.addEntity("053", "053", "PI", "Pierce");
		super.addEntity("055", "055", "SJ", "San Juan");
		super.addEntity("057", "057", "SA", "Skagit");
		super.addEntity("059", "059", "SK", "Skamania");
		super.addEntity("061", "061", "SN", "Snohomish");
		super.addEntity("063", "063", "SP", "Spokane");
		super.addEntity("065", "065", "ST", "Stevens");
		super.addEntity("067", "067", "TH", "Thurston");
		super.addEntity("069", "069", "WK", "Wahkiakum");
		super.addEntity("071", "071", "WL", "Wallawalla");
		super.addEntity("073", "073", "WA", "Whatcom");
		super.addEntity("075", "075", "WH", "Whitman");
		super.addEntity("077", "077", "YA", "Yakima");
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
