import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AsiaGeorgiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AsiaGeorgiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AsiaGeorgiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AB", "AB", "Abkhazia");
		super.addEntity("02", "AJ", "AJ", "Adjara");
		super.addEntity("03", "GU", "GU", "Guria");
		super.addEntity("04", "IM", "IM", "Imereti");
		super.addEntity("05", "KA", "KA", "Kakheti");
		super.addEntity("06", "KK", "KK", "Kvemo Kartli");
		super.addEntity("07", "MM", "MM", "Mtskheta-Mtianeti");
		super.addEntity("08", "RL", "RL", "Racha-Lechkhumi and Kvemo Svaneti");
		super.addEntity("09", "SJ", "SJ", "Samtskhe-Javakheti");
		super.addEntity("10", "SK", "SK", "Shida Kartli");
		super.addEntity("11", "SZ", "SZ", "Samegrelo-Zemo Svaneti");
		super.addEntity("12", "TB", "TB", "Tbilisi");
		
		
		

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
