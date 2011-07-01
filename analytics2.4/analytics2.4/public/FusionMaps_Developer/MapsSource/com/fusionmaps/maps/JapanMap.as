import com.fusionmaps.core.Map;
class com.fusionmaps.maps.JapanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "JapanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function JapanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("1", "1", "AI", "Aichi");
		super.addEntity("2", "2", "AK", "Akita");
		super.addEntity("3", "3", "AO", "Aomori");
		super.addEntity("4", "4", "CH", "Chiba");
		super.addEntity("5", "5", "EH", "Ehime");
		super.addEntity("6", "6", "FU", "Fukui");
		super.addEntity("7", "7", "FK", "Fukuoka");
		super.addEntity("8", "8", "FS", "Fukushima");
		super.addEntity("9", "9", "GI", "Gifu");
		super.addEntity("10", "10", "GU", "Gumma");
		super.addEntity("11", "11", "HI", "Hiroshima");
		super.addEntity("12", "12", "HO", "Hokkaido");
		super.addEntity("13", "13", "HY", "Hyogo");
		super.addEntity("14", "14", "IB", "Ibaraki");
		super.addEntity("15", "15", "IS", "Ishikawa");
		super.addEntity("16", "16", "IW", "Iwate");
		super.addEntity("17", "17", "KA", "Kagawa");
		super.addEntity("18", "18", "KG", "Kagoshima");
		super.addEntity("19", "19", "KN", "Kanagawa");
		super.addEntity("20", "20", "KO", "Kochi");
		super.addEntity("21", "21", "KU", "Kumamoto");
		super.addEntity("22", "22", "KY", "Kyoto");
		super.addEntity("23", "23", "MI", "Mie");
		super.addEntity("24", "24", "MY", "Miyagi");
		super.addEntity("25", "25", "MA", "Miyazaki");
		super.addEntity("26", "26", "NA", "Nagano");
		super.addEntity("27", "27", "NG", "Nagasaki");
		super.addEntity("28", "28", "NR", "Nara");
		super.addEntity("29", "29", "NI", "Niigata");
		super.addEntity("30", "30", "OI", "Oita");
		super.addEntity("31", "31", "OK", "Okayama");
		super.addEntity("32", "32", "ON", "Okinawa");
		super.addEntity("33", "33", "OS", "Osaka");
		super.addEntity("34", "34", "SA", "Saga");
		super.addEntity("35", "35", "SI", "Saitama");
		super.addEntity("36", "36", "SH", "Shiga");
		super.addEntity("37", "37", "SM", "Shimane");
		super.addEntity("38", "38", "SZ", "Shizouka");
		super.addEntity("39", "39", "TO", "Tochigi");
		super.addEntity("40", "40", "TK", "Tokushima");
		super.addEntity("41", "41", "TY", "Tokyo");
		super.addEntity("42", "42", "TT", "Tottori");
		super.addEntity("43", "43", "TA", "Toyama");
		super.addEntity("44", "44", "WA", "Wakayama");
		super.addEntity("45", "45", "YA", "Yamagata");
		super.addEntity("46", "46", "YM", "Yamaguchi");
		super.addEntity("47", "47", "YN", "Yamanashi");
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
