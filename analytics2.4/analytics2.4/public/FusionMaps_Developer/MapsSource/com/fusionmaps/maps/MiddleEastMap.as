import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MiddleEastMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MiddleEastMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MiddleEastMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AF", "AF", "Afghanistan");
		super.addEntity("02", "BA", "BA", "Bahrain ");
		super.addEntity("03", "IN", "IN", "Iran");
		super.addEntity("04", "IZ", "IZ", "Iraq");
		super.addEntity("05", "IS", "IS", "Israel");
		super.addEntity("06", "JO", "JO", "Jordan");
		super.addEntity("07", "KU", "KU", "Kuwait");
		super.addEntity("08", "KG", "KG", "Kyrgyzstan");
		super.addEntity("09", "LE", "LE", "Lebanon");
		super.addEntity("10", "MU", "MU", "Oman");
		super.addEntity("11", "PK", "PK", "Pakistan");
		super.addEntity("12", "QA", "QA", "Qatar");
		super.addEntity("13", "SA", "SA", "Saudi Arabia");
		super.addEntity("14", "SY", "SY", "Syria");
		super.addEntity("15", "TI", "TI", "Tajikistan");
		super.addEntity("16", "TU", "TU", "Turkey ");
		super.addEntity("17", "TX", "TX", "Turkmenistan");
		super.addEntity("18", "AE", "AE", "United Arab Emirates");
		super.addEntity("19", "UZ", "UZ", "Uzbekistan");
        super.addEntity("20", "YM", "YM", "Yemen");
       
		 
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
