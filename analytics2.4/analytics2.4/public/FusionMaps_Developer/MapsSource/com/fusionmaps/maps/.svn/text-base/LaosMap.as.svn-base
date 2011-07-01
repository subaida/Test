import com.fusionmaps.core.Map;
class com.fusionmaps.maps.LaosMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "LaosMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function LaosMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("LA.AT", "AT", "AT", "Attapu");
		super.addEntity("LA.BK", "BK", "BK", "Bokeo");
		super.addEntity("LA.BL", "BL", "BL", "Bolikhamxai");
		super.addEntity("LA.CH", "CH", "CH", "Champasak");
		super.addEntity("LA.HO", "HO", "HO", "Houaphan");
		super.addEntity("LA.KH", "KH", "KH", "Khammouan");
		super.addEntity("LA.LM", "LM", "LM", "Louang Namtha");
		super.addEntity("LA.LP", "LP", "LP", "Louangphabang");
		super.addEntity("LA.OU", "OU", "OU", "Oudomxai");
		super.addEntity("LA.PH", "PH", "PH", "Phongsali");
		super.addEntity("LA.SL", "SL", "SL", "Salavan");
		super.addEntity("LA.SV", "SV", "SV", "Savannakhet");
		super.addEntity("LA.VI", "VI", "VI", "Vientiane Province");
		super.addEntity("LA.VT", "VT", "VT", "Vientiane Prefecture");
		super.addEntity("LA.XA", "XA", "XA", "Xaignabouli");
		super.addEntity("LA.XS", "XS", "XS", "Xaisomboun");
		super.addEntity("LA.XE", "XE", "XE", "Xekong");
		super.addEntity("LA.XI", "XI", "XI", "Xiangkhoang");
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
