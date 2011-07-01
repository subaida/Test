import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MalaysiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MalaysiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MalaysiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "JO", "Johor");
		super.addEntity("002", "002", "KE", "Kedah");
		super.addEntity("003", "003", "KL", "Kelantan");
		super.addEntity("004", "004", "ME", "Melaka");
		super.addEntity("005", "005", "NS", "Negeri Sembilan");
		super.addEntity("006", "006", "PA", "Pahang");
		super.addEntity("007", "007", "PE", "Perak");
		super.addEntity("008", "008", "PR", "Perlis");
		super.addEntity("009", "009", "PP", "Pulau Pinang");
		super.addEntity("010", "010", "SA", "Sabah");
		super.addEntity("011", "011", "SR", "Sarawak");
		super.addEntity("012", "012", "SL", "Selangor");
		super.addEntity("013", "013", "TE", "Terengganu");
		//super.addEntity("014", "014", "WP", "one federal territory (wilayah persekutuan) ");
		super.addEntity("015", "015", "KL", "Kuala Lumpur");
		super.addEntity("016", "016", "LA", "Labuan");
		super.addEntity("017", "017", "PU", "Putrajaya. ");
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
