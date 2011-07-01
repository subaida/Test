import com.fusionmaps.core.Map;
class com.fusionmaps.maps.UkraineMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "UkraineMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function UkraineMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "CK", "CK", "Cherkasy");
		super.addEntity("02", "CH", "CH", "Chernihiv");
		super.addEntity("03", "CV", "CV", "Chernivtsi");
		super.addEntity("11", "KR", "KR", "Crimea");
		super.addEntity("04", "DP", "DP", "Dnipropetrovsk");
		super.addEntity("05", "DT", "DT", "Donetsk");
		super.addEntity("06", "IF", "IF", "Ivano-Frankivsk");
		super.addEntity("07", "KK", "KK", "Kharkiv");
		super.addEntity("08", "KS", "KS", "Kherson");
		super.addEntity("09", "KM", "KM", "Khmelnytskyi");
		super.addEntity("10", "KH", "KH", "Kirovohrad");
		super.addEntity("13", "KV", "KV", "Kiev Oblast");
		super.addEntity("14", "LH", "LH", "Luhansk");
		super.addEntity("15", "LV", "LV", "Lviv");
		super.addEntity("16", "MY", "MY", "Mykolaiv");
		super.addEntity("17", "OD", "OD", "Odessa");
		super.addEntity("18", "PL", "PL", "Poltava");
		super.addEntity("19", "RV", "RV", "Rivne");
		super.addEntity("21", "SM", "SM", "Sumy");
        super.addEntity("22", "TP", "TP", "Ternopil");
        super.addEntity("23", "VI", "VI", "Vinnytsia");
        super.addEntity("24", "VO", "VO", "Volyn");
        super.addEntity("25", "ZK", "ZK", "Zakarpattia");
        super.addEntity("26", "ZP", "ZP", "Zaporizhia");
        super.addEntity("27", "ZT", "ZT", "Zhytomyr");
		
		
		

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
