import com.fusionmaps.core.Map;
class com.fusionmaps.maps.TunisiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "TunisiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function TunisiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("TN.AN", "AN", "AN", "Ariana");
		super.addEntity("TN.BJ", "BJ", "BJ", "Beja");
		super.addEntity("TN.BA", "BA", "BA", "Ben Arous");
		super.addEntity("TN.BZ", "BZ", "BZ", "Bizerte");
		super.addEntity("TN.GB", "GB", "GB", "Gabes");
		super.addEntity("TN.GF", "GF", "GF", "Gafsa");
		super.addEntity("TN.JE", "JE", "JE", "Jendouba");
		super.addEntity("TN.KR", "KR", "KR", "Kairouan");
		super.addEntity("TN.KS", "KS", "KS", "Kasserine");
		super.addEntity("TN.KB", "KB", "KB", "Kebili");
		super.addEntity("TN.KF", "KF", "KF", "Kef");
		super.addEntity("TN.MH", "MH", "MH", "Mahdia");
		super.addEntity("TN.MN", "MN", "MN", "Manouba");
		super.addEntity("TN.ME", "ME", "ME", "Medenine");
		super.addEntity("TN.MS", "MS", "MS", "Monastir");
		super.addEntity("TN.NB", "NB", "NB", "Nabeul");
		super.addEntity("TN.SF", "SF", "SF", "Sfax");
		super.addEntity("TN.SZ", "SZ", "SZ", "Sidi Bou Zid");
		super.addEntity("TN.SL", "SL", "SL", "Siliana");
		super.addEntity("TN.SS", "SS", "SS", "Sousse");
		super.addEntity("TN.TA", "TA", "TA", "Tataouine");
		super.addEntity("TN.TO", "TO", "TO", "Tozeur");
		super.addEntity("TN.TU", "TU", "TU", "Tunis");
		super.addEntity("TN.ZA", "ZA", "ZA", "Zaghouan");
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
