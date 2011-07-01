import com.fusionmaps.core.Map;
class com.fusionmaps.maps.WyomingMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "WyomingMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function WyomingMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AL", "AL", "Albany");
		super.addEntity("003", "BH", "BH", "Big Horn");
		super.addEntity("005", "CM", "CM", "Campbell");
		super.addEntity("007", "CA", "CA", "Carbon");
		super.addEntity("009", "CO", "CO", "Converse");
		super.addEntity("011", "CR", "CR", "Crook");
		super.addEntity("013", "FR", "FR", "Fremont");
		super.addEntity("015", "GO", "GO", "Goshen");
		super.addEntity("017", "HS", "HS", "Hot Springs");
		super.addEntity("019", "JO", "JO", "Johnson");
		super.addEntity("021", "LA", "LA", "Laramie");
		super.addEntity("023", "LI", "LI", "Lincoln");
		super.addEntity("025", "NA", "NA", "Natrona");
		super.addEntity("027", "NI", "NI", "Niobrara");
		super.addEntity("029", "PA", "PA", "Park");
		super.addEntity("031", "PL", "PL", "Platte");
		super.addEntity("033", "SH", "SH", "Sheridan");
		super.addEntity("035", "SU", "SU", "Sublette");
		super.addEntity("037", "SW", "SW", "Sweetwater");
		super.addEntity("039", "TE", "TE", "Teton");
		super.addEntity("041", "UI", "UI", "Uinta");
		super.addEntity("043", "WA", "WA", "Washakie");
		super.addEntity("045", "WE", "WE", "Weston");
		
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
