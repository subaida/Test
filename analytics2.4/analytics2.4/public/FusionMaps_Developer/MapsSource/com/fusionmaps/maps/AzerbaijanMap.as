import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AzerbaijanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AzerbaijanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AzerbaijanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AR", "AR", "Abşeron");
		super.addEntity("02", "AC", "AC", "Ağcabədi");
		super.addEntity("03", "AM", "AM", "Ağdam");
		super.addEntity("04", "AS", "AS", "Ağdaş");
		super.addEntity("05", "AF", "AF", "Ağstafa");
		super.addEntity("06", "AU", "AU", "Ağsu");
		super.addEntity("07", "AB", "AB", "Ali Bayramlı");
		super.addEntity("08", "AA", "AA", "Astara");
		super.addEntity("09", "BA", "BA", "Baki");
		super.addEntity("10", "BL", "BL", "Balakan");
		super.addEntity("11", "BR", "BR", "Barda");
		super.addEntity("12", "BQ", "BQ", "Beyləqan");
		super.addEntity("13", "BS", "BS", "Biləsuvar");
		super.addEntity("14", "CB", "CB", "Cəbrayıl");
		super.addEntity("15", "CL", "CL", "Cəlilabad");
		super.addEntity("16", "DS", "DS", "Daşkəsən");
		super.addEntity("17", "DV", "DV", "Dəvəçi");
		super.addEntity("18", "FU", "FU", "Füzuli");
		super.addEntity("19", "GD", "GD", "Gədəbəy");
        super.addEntity("20", "GA", "GA", "Gəncə");
        super.addEntity("21", "GR", "GR", "Goranboy");
        super.addEntity("22", "GY", "GY", "Göyçay");
        super.addEntity("23", "HA", "HA", "Hacıqabul");
        super.addEntity("24", "IM", "IM", "İmişli");
        super.addEntity("25", "IS", "IS", "İsmayıllı");
		super.addEntity("26", "KA", "KA", "Kəlbəcər");
		super.addEntity("27", "KU", "KU", "Kürdəmir");
		super.addEntity("28", "LC", "LC", "Laçın");
		super.addEntity("29", "LN", "LN", "Lənkəran");
		super.addEntity("30", "LA", "LA", "Lənkəran (City)");
		super.addEntity("31", "LE", "LE", "Lerik");
		super.addEntity("32", "MA", "MA", "Masallı");
		super.addEntity("33", "MI", "MI", "Mingəçevir");
		super.addEntity("34", "NA", "NA", "Naftalan(City)");
		super.addEntity("36", "NE", "NE", "Neftçala");
		super.addEntity("37", "OG", "OG", "Oğuz");
		super.addEntity("38", "QA", "QA", "Qəbələ");
		super.addEntity("39", "QX", "QX", "Qax");
		super.addEntity("40", "QZ", "QZ", "Qazax");
		super.addEntity("41", "QO", "QO", "Qobustan");
		super.addEntity("42", "QB", "QB", "Quba");
		super.addEntity("43", "QD", "QD", "Qubadlı");
		super.addEntity("44", "QR", "QR", "Qusar");
	     super.addEntity("45", "ST", "ST", "Saatlı");
		 super.addEntity("46", "SB", "SB", "Sabirabad");
		 super.addEntity("47", "SK", "SK", "Şəki");
		 super.addEntity("48", "SA", "SA", "Şəki (City)");
		 super.addEntity("49", "SL", "SL", "Salyan");
		 super.addEntity("50", "SI", "SI", "Şamaxı");
		 super.addEntity("51", "SM", "SM", "Şəmkir");
		 super.addEntity("52", "SX", "SX", "Samux");
		 super.addEntity("53", "SY", "SY", "Siyəzən");
		 super.addEntity("54", "SQ", "SQ", "Sumqayıt");
		 super.addEntity("55", "SU", "SU", "Şuşa");
		 super.addEntity("56", "SS", "SS", "Şuşa (City)");
		 super.addEntity("57", "TA", "TA", "Tərtər");
		 super.addEntity("58", "TO", "TO", "Tovuz");
		 super.addEntity("59", "UC", "UC", "Ucar");
		 super.addEntity("60", "XZ", "XZ", "Xaçmaz");
		 super.addEntity("61", "XA", "XA", "Xankəndi");
		 super.addEntity("62", "XR", "XR", "Xanlar");
		 super.addEntity("63", "XI", "XI", "Xızı");
		 super.addEntity("64", "XC", "XC", "Xocalı"); 
		 super.addEntity("65", "XD", "XD", "Xocavənd");
		 super.addEntity("66", "YR", "YR", "Yardımlı");
		 super.addEntity("67", "YV", "YV", "Yevlax");
		 super.addEntity("68", "YE", "YE", "Yevlax (City)");
		 super.addEntity("69", "ZG", "ZG", "Zəngilan"); 
		 super.addEntity("70", "ZQ", "ZQ", "Zaqatala ");
		 super.addEntity("71", "ZR", "ZR", "Zərdab");
		 super.addEntity("72", "BB", "BB", "Babək");
		 super.addEntity("73", "CF", "CF", "Culfa");
		 super.addEntity("74", "KN", "KN", "Kəngərli");
		 super.addEntity("35", "NX", "NX", "Naxçıvan Şəhər");
		 super.addEntity("75", "OR", "OR", "Ordubad");
		 super.addEntity("76", "SD", "SD", "Sədərək");
		 super.addEntity("77", "SH", "SH", "Şahbuz");
		 super.addEntity("78", "SR", "SR", "Şərur)");
		 
		 
		 
		

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
