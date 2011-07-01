import com.fusionmaps.core.Map;
class com.fusionmaps.maps.EgyptMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "EgyptMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function EgyptMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "DK", "DK", "Ad Daqahliyah");
		super.addEntity("02", "BA", "BA", "Al Bahr al Ahmar");
		super.addEntity("03", "BH", "BH", "Al Buhayrah");
		super.addEntity("04", "FY", "FY", "Al Fayyum");
		super.addEntity("05", "GH", "GH", "Al Gharbiyah");
		super.addEntity("06", "IK", "IK", "Al Iskandariyah");
		super.addEntity("07", "IS", "IS", "Al Isma'iliyah");
		super.addEntity("08", "JZ", "JZ", "Al Jizah");
		super.addEntity("09", "MF", "MF", "Al Minufiyah");
		super.addEntity("10", "MN", "MN", "Al Minya");
		super.addEntity("11", "QH", "QH", "Al Qahirah");
		super.addEntity("12", "QL", "QL", "Al Qalyubiyah");
		super.addEntity("25", "UQ", "UQ", "Al Uqsur");
		super.addEntity("13", "WJ", "WJ", "Al Wadi al Jadid");
		super.addEntity("14", "SQ", "SQ", "Ash Sharqiyah");
		super.addEntity("15", "SW", "SW", "As Suways");
		super.addEntity("16", "AN", "AN", "Aswan");
		super.addEntity("17", "AT", "AT", "Asyut");
		super.addEntity("18", "BN", "BN", "Bani Suwayf");
        super.addEntity("19", "BS", "BS", "Bur Sa'id");
        super.addEntity("20", "DT", "DT", "Dumyat");
        super.addEntity("26", "JS", "JS", "Janub Sina'");
        super.addEntity("21", "KS", "KS", "Kafr ash Shaykh");
        super.addEntity("22", "MT", "MT", "Matruh");
        super.addEntity("23", "QN", "QN", "Qina");
		super.addEntity("27", "SS", "SS", "Shamal Sina'");
		super.addEntity("24", "SJ", "SJ", "Suhaj");
		 
		

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
