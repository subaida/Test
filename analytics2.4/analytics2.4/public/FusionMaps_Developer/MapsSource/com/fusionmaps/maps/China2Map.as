import com.fusionmaps.core.Map;
class com.fusionmaps.maps.China2Map extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "China2Map";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function China2Map(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("CN.AH", "AH", "AH", "Anhui");
		super.addEntity("CN.BJ", "BJ", "BJ", "Beijing");
		super.addEntity("CN.CQ", "CQ", "CQ", "Chongqing");
		super.addEntity("CN.FJ", "FJ", "FJ", "Fujian");
		super.addEntity("CN.GS", "GS", "GS", "Gansu");
		super.addEntity("CN.GD", "GD", "GD", "Guangdong");
		super.addEntity("CN.GX", "GX", "GX", "Guangxi Zhuang");
		super.addEntity("CN.GZ", "GZ", "GZ", "Guizhou");
		super.addEntity("CN.HA", "HA", "HA", "Hainan");
		super.addEntity("CN.HB", "HB", "HB", "Hebei");
		super.addEntity("CN.HE", "HE", "HE", "Henan");
		super.addEntity("CN.HU", "HU", "HU", "Hubei");
		super.addEntity("CN.HL", "HL", "HL", "Heilongjiang");
		super.addEntity("CN.HN", "HN", "HN", "Hunan");
		super.addEntity("CN.JS", "JS", "JS", "Jiangsu");
		super.addEntity("CN.JX", "JX", "JX", "Jiangxi");
		super.addEntity("CN.JL", "JL", "JL", "Jilin");
		super.addEntity("CN.LN", "LN", "LN", "Liaoning");
		super.addEntity("CN.NM", "NM", "NM", "Nei Mongol");
		super.addEntity("CN.NX", "NX", "NX", "Ningxia Hui");
		super.addEntity("CN.QH", "QH", "QH", "Qinghai");
		super.addEntity("CN.SA", "SA", "SA", "Shaanxi");
		super.addEntity("CN.SD", "SD", "SD", "Shandong");
		super.addEntity("CN.SH", "SH", "SH", "Shanghai");
		super.addEntity("CN.SX", "SX", "SX", "Shanxi");
		super.addEntity("CN.SC", "SC", "SC", "Sichuan");
		super.addEntity("CN.TJ", "TJ", "TJ", "Tianjin");
		super.addEntity("CN.XJ", "XJ", "XJ", "Xinjiang Uygur");
		super.addEntity("CN.XZ", "XZ", "XZ", "Xizang");
		super.addEntity("CN.YN", "YN", "YN", "Yunnan");
		super.addEntity("CN.ZJ", "ZJ", "ZJ", "Zhejiang");
		super.addEntity("CN.MA", "MA", "MA", "Macao");
		super.addEntity("CN.HK", "HK", "HK", "HongKong");
		super.addEntity("CN.TA", "TA", "TA", "Taiwan");
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
