import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ChinaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ChinaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ChinaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AH", "AH", "Anhui");
		super.addEntity("07", "FJ", "FJ", "Fujian");
		super.addEntity("15", "GS", "GS", "Gansu");
		super.addEntity("30", "GD", "GD", "Guangdong ");
		super.addEntity("18", "GZ", "GZ", "Guizhou");
		super.addEntity("31", "HA", "HA", "Hainan");
		super.addEntity("10", "HB", "HB", "Hebei");
		super.addEntity("08", "HL", "HL", "Heilongjiang");
		super.addEntity("09", "HE", "HE", "Henan");
		super.addEntity("12", "HU", "HU", "Hubei");
		super.addEntity("11", "HN", "HN", "Hunan");
		super.addEntity("04", "JS", "JS", "Jiangsu");
		super.addEntity("03", "JX", "JX", "Jiangxi");
		super.addEntity("05", "JL", "JL", "Jilin");
		super.addEntity("19", "LN", "LN", "Liaoning");
		super.addEntity("06", "QH", "QH", "Qinghai");
		super.addEntity("26", "SA", "SA", "Shaanxi");
		super.addEntity("25", "SD", "SD", "Shandong");
		super.addEntity("24", "SX", "SX", "Shanxi");
		super.addEntity("32", "SC", "SC", "Sichuan");
        super.addEntity("29", "YN", "YN", "Yunnan");
        super.addEntity("02", "ZJ", "ZJ", "Zhejiang ");
		super.addEntity("36", "TB", "TB", "Tibet");
		super.addEntity("20", "NM", "NM", "Nei Mongol");
		super.addEntity("13", "XJ", "XJ", "Xinjiang");
		super.addEntity("16", "GX", "GX", "Guangxi");
		super.addEntity("21", "NX", "NX", "Ningxia Hui");
         
		

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
