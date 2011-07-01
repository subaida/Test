import com.fusionmaps.core.Map;
class com.fusionmaps.maps.YemenMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "YemenMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function YemenMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("YE.AB", "AB", "AB", "Abyan");
		super.addEntity("YE.AD", "AD", "AD", "Adan");
		super.addEntity("YE.DL", "DL", "DL", "Al Dali");
		super.addEntity("YE.BA", "BA", "BA", "Al Bayda");
		super.addEntity("YE.HU", "HU", "HU", "Al Hudaydah");
		super.addEntity("YE.JA", "JA", "JA", "Al Jawf");
		super.addEntity("YE.MR", "MR", "MR", "Al Mahrah");
		super.addEntity("YE.MW", "MW", "MW", "Ml Mahwit");
		super.addEntity("YE.AM", "AM", "AM", "Amran");
		super.addEntity("YE.DH", "DH", "DH", "Dhamar");
		super.addEntity("YE.HD", "HD", "HD", "Hadramawt");
		super.addEntity("YE.HJ", "HJ", "HJ", "Hajjah");
		super.addEntity("YE.IB", "IB", "IB", "Ibb");
		super.addEntity("YE.LA", "LA", "LA", "Lahij");
		super.addEntity("YE.MA", "MA", "MA", "Marib");
		super.addEntity("YE.SD", "SD", "SD", "Sadah");
		super.addEntity("YE.SN", "SN", "SN", "Sana");
		super.addEntity("YE.SH", "SH", "SH", "Shabwah");
		super.addEntity("YE.TA", "TA", "TA", "Taizz");
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
