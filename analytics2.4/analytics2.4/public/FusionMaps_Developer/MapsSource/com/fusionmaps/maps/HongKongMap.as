import com.fusionmaps.core.Map;
class com.fusionmaps.maps.HongKongMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "HongKongMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function HongKongMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("HK.CW", "CW", "CW", "Central and Western");
		super.addEntity("HK.EA", "EA", "EA", "Eastern");
		super.addEntity("HK.IS", "IS", "IS", "Islands");
		super.addEntity("HK.KC", "KC", "KC", "Kowloon City");
		super.addEntity("HK.KI", "KI", "KI", "Kwai Tsing");
		super.addEntity("HK.KU", "KU", "KU", "Kwun Tong");
		super.addEntity("HK.NO", "NO", "NO", "North");
		super.addEntity("HK.SK", "SK", "SK", "Sai Kung");
		super.addEntity("HK.SS", "SS", "SS", "Sham Shui Po");
		super.addEntity("HK.ST", "ST", "ST", "Sha Tin");
		super.addEntity("HK.SO", "SO", "SO", "Southern");
		super.addEntity("HK.TP", "TP", "TP", "Tai Po");
		super.addEntity("HK.TW", "TW", "TW", "Tsuen Wan");
		super.addEntity("HK.TM", "TM", "TM", "Tuen Mun");
		super.addEntity("HK.WC", "WC", "WC", "Wan Chai");
		super.addEntity("HK.WT", "WT", "WT", "Wong Tai Sin");
		super.addEntity("HK.YT", "YT", "YT", "Yan Tsim Mong");
		super.addEntity("HK.YL", "YL", "YL", "Yuen Long");
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
