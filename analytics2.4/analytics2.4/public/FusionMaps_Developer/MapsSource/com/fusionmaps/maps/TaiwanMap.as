import com.fusionmaps.core.Map;
class com.fusionmaps.maps.TaiwanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "TaiwanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function TaiwanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "CG", "CG", "Changhua");
		super.addEntity("02", "CH", "CH", "Chiayi");
		super.addEntity("03", "CS", "CS", "Chiayi(City)");
		super.addEntity("04", "HH", "HH", "Hsinchu");
		super.addEntity("05", "HS", "HS", "Hsinchu(City)");
		super.addEntity("06", "HL", "HL", "Hualien");
		super.addEntity("07", "KH", "KH", "Kaohsiung(City)");
		super.addEntity("08", "KC", "KC", "Kaohsiung");
		super.addEntity("09", "CL", "CL", "Keelung (City)");
		super.addEntity("10", "KM", "KM", "Kinmen");
		super.addEntity("11", "LK", "LK", "Lienchiang");
		super.addEntity("12", "ML", "ML", "Miaoli");
		super.addEntity("13", "NT", "NT", "Nantou");
		super.addEntity("14", "PH", "PH", "Penghu");
		super.addEntity("15", "PT", "PT", "Pingtung");
		super.addEntity("16", "TH", "TH", "Taichung");
		super.addEntity("17", "TG", "TG", "Taichung (City)");
		super.addEntity("18", "TA", "TA", "Tainan");
		super.addEntity("19", "TN", "TN", "Tainan (City)");
        super.addEntity("20", "TP", "TP", "Taipei");
        super.addEntity("21", "TC", "TC", "Taipei (City)");
        super.addEntity("22", "TT", "TT", "Taitung");
        super.addEntity("23", "TY", "TY", "Taoyuan");
        super.addEntity("24", "IL", "IL", "Yilan");
        super.addEntity("25", "YL", "YL", "Yunlin");
		

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
