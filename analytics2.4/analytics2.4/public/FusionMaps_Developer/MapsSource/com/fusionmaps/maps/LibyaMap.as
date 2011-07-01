import com.fusionmaps.core.Map;
class com.fusionmaps.maps.LibyaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "LibyaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function LibyaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("LY.AJ", "AJ", "AJ", "Ajdabiya");
		super.addEntity("LY.BU", "BU", "BU", "Al Butnan");
		super.addEntity("LY.HZ", "HZ", "HZ", "Al Hizam Al Akhdar");
		super.addEntity("LY.JA", "JA", "JA", "Al Jabal Al Akhdar");
		super.addEntity("LY.JI", "JI", "JI", "Al Jfara");
		super.addEntity("LY.JU", "JU", "JU", "Al Jufrah");
		super.addEntity("LY.KF", "KF", "KF", "Al Kufrah");
		super.addEntity("LY.MJ", "MJ", "MJ", "Al Marj");
		super.addEntity("LY.MB", "MB", "MB", "Al Margab");
		super.addEntity("LY.NQ", "NQ", "NQ", "An Nuqat Al Khams");
		super.addEntity("LY.QB", "QB", "QB", "Al Qubbah");
		super.addEntity("LY.WA", "WA", "WA", "Al Wahah");
		super.addEntity("LY.ZA", "ZA", "ZA", "Az Zawiyah");
		super.addEntity("LY.BA", "BA", "BA", "Benghazi");
		super.addEntity("LY.BW", "BW", "BW", "Bani Walid");
		super.addEntity("LY.DR", "DR", "DR", "Darnah");
		super.addEntity("LY.GT", "GT", "GT", "Ghat");
		super.addEntity("LY.GD", "GD", "GD", "Ghadamis");
		super.addEntity("LY.GR", "GR", "GR", "Gharyan");
		super.addEntity("LY.MQ", "MQ", "MQ", "Murzuq");
		super.addEntity("LY.MZ", "MZ", "MZ", "Mizdah");
		super.addEntity("LY.MI", "MI", "MI", "Misratah");
		super.addEntity("LY.NL", "NL", "NL", "Nalut");
		super.addEntity("LY.TN", "TN", "TN", "Tajura Wa Al Nawahi Al Arba");
		super.addEntity("LY.TM", "TM", "TM", "Tarhunah Masallatah");
		super.addEntity("LY.TB", "TB", "TB", "Tarabulus");
		super.addEntity("LY.SB", "SB", "SB", "Sabha");
		super.addEntity("LY.SR", "SR", "SR", "Surt");
		super.addEntity("LY.SS", "SS", "SS", "Sabratha Surman");
		super.addEntity("LY.WD", "WD", "WD", "Wadi Al Hayat");
		super.addEntity("LY.SH", "SH", "SH", "Ash Shati");
		super.addEntity("LY.YJ", "YJ", "YJ", "Yafran-Jadu");
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
