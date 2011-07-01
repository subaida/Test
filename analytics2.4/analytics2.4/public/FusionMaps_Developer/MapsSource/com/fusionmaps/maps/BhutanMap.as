import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BhutanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BhutanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BhutanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("BT.BU", "BU", "BU", "Bumthang");
		super.addEntity("BT.CK", "CK", "CK", "Chhukha");
		super.addEntity("BT.CR", "CR", "CR", "Chirang");
		super.addEntity("BT.DA", "DA", "DA", "Daga");
		super.addEntity("BT.GA", "GA", "GA", "Gasa");
		super.addEntity("BT.GE", "GE", "GE", "Geylegphug");
		super.addEntity("BT.HA", "HA", "HA", "Ha");
		super.addEntity("BT.LH", "LH", "LH", "Lhuntshi");
		super.addEntity("BT.MO", "MO", "MO", "Mongar");
		super.addEntity("BT.PR", "PR", "PR", "Paro");
		super.addEntity("BT.PM", "PM", "PM", "Pemagatsel");
		super.addEntity("BT.PN", "PN", "PN", "Punakha");
		super.addEntity("BT.SM", "SM", "SM", "Samchi");
		super.addEntity("BT.SJ", "SJ", "SJ", "Samdrup Jongkhar");
		super.addEntity("BT.SG", "SG", "SG", "Shemgang");
		super.addEntity("BT.TA", "TA", "TA", "Tashigang");
		super.addEntity("BT.TM", "TM", "TM", "Thimphu");
		super.addEntity("BT.TO", "TO", "TO", "Tongsa");
		super.addEntity("BT.TY", "TY", "TY", "Tashi Yangtse");
		super.addEntity("BT.WP", "WP", "WP", "Wangdi Phodrang");
		
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
