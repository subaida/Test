import com.fusionmaps.core.Map;
class com.fusionmaps.maps.TurkeyMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "TurkeyMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function TurkeyMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("81", "AA", "AA", "Adana");
		super.addEntity("02", "AD", "AD", "Adiyaman");
		super.addEntity("03", "AF", "AF", "Afyonkarahisar");
		super.addEntity("04", "AG", "AG", "Ağrı");
		super.addEntity("75", "AK", "AK", "Aksaray");
		super.addEntity("05", "AM", "AM", "Amasya");
		super.addEntity("68", "AN", "AN", "Ankara");
		super.addEntity("07", "AL", "AL", "Antalya");
		super.addEntity("86", "AR", "AR", "Ardahan");
		super.addEntity("08", "AV", "AV", "Artvin");
		super.addEntity("09", "AY", "AY", "Aydin");
		super.addEntity("10", "BK", "BK", "Balikesir");
		super.addEntity("87", "BR", "BR", "Bartin");
		super.addEntity("76", "BM", "BM", "Batman");
		super.addEntity("77", "BB", "BB", "Bayburt");
		super.addEntity("11", "BC", "BC", "Bilecik");
		super.addEntity("12", "BG", "BG", "Bingöl");
		super.addEntity("13", "BT", "BT", "Bitlis");
		super.addEntity("14", "BL", "BL", "Bolu");
        super.addEntity("15", "BD", "BD", "Burdur");
        super.addEntity("16", "BU", "BU", "Bursa");
        super.addEntity("17", "CK", "CK", "Çanakkale");
        super.addEntity("82", "CI", "CI", "Çankırı");
        super.addEntity("19", "CM", "CM", "Çorum");
        super.addEntity("20", "DN", "DN", "Denizli");
		super.addEntity("21", "DY", "DY", "Diyarbakır");
		super.addEntity("93", "DU", "DU", "Düzce");
		super.addEntity("22", "ED", "ED", "Edirne");
		super.addEntity("23", "EG", "EG", "Elazığ");
		super.addEntity("24", "EN", "EN", "Erzincan");
		super.addEntity("25", "EM", "EM", "Erzurum");
		super.addEntity("26", "ES", "ES", "Eskişehir");
		super.addEntity("83", "GA", "GA", "Gaziantep");
		super.addEntity("28", "GI", "GI", "Giresun");
		super.addEntity("69", "GU", "GU", "Gümüşhane");
		super.addEntity("70", "HK", "HK", "Hakkari");
		super.addEntity("31", "HT", "HT", "Hatay");
		super.addEntity("88", "IG", "IG", "Iğdır");
		super.addEntity("33", "IP", "IP", "Isparta");
		super.addEntity("34", "IB", "IB", "İstanbul");
		super.addEntity("35", "IZ", "IZ", "İzmir");
		super.addEntity("46", "KM", "KM", "Kahramanmaraş");
		super.addEntity("89", "KB", "KB", "Karabük");
	     super.addEntity("78", "KR", "KR", "Karaman");
		 super.addEntity("84", "KA", "KA", "Kars");
		 super.addEntity("37", "KS", "KS", "Kastamonu");
		 super.addEntity("38", "KY", "KY", "Kayseri");
		 super.addEntity("90", "KI", "KI", "Kilis");
		 super.addEntity("79", "KK", "KK", "Kırıkkale");
		 super.addEntity("39", "KL", "KL", "Kırklareli");
		 super.addEntity("40", "KH", "KH", "Kırşehir");
		 super.addEntity("41", "KC", "KC", "Kocaeli");
		 super.addEntity("71", "KO", "KO", "Konya");
		 super.addEntity("43", "KU", "KU", "Kütahya");
		 super.addEntity("44", "ML", "ML", "Malatya");
		 super.addEntity("45", "MN", "MN", "Manisa");
		 super.addEntity("72", "MR", "MR", "Mardin");
		 super.addEntity("32", "IC", "IC", "Mersin");
		 super.addEntity("48", "MG", "MG", "Muğla");
		 super.addEntity("49", "MS", "MS", "Muş");
		 super.addEntity("50", "NV", "NV", "Nevşehir");
		 super.addEntity("73", "NG", "NG", "Niğde");
		 super.addEntity("52", "OR", "OR", "Ordu"); 
		 super.addEntity("91", "OS", "OS", "Osmaniye");
		 super.addEntity("53", "RI", "RI", "Rize");
		 super.addEntity("54", "SK", "SK", "Sakarya");
		 super.addEntity("55", "SS", "SS", "Samsun");
		 super.addEntity("63", "SU", "SU", "Şanlıurfa"); 
		 super.addEntity("74", "SI", "SI", "Siirt");
		 super.addEntity("57", "SP", "SP", "Sinop"); 
		 super.addEntity("80", "SR", "SR", "Şırnak");
		 super.addEntity("58", "SV", "SV", "Sivas");
		 super.addEntity("59", "TG", "TG", "Tekirdağ");
		 super.addEntity("60", "TT", "TT", "Tokat");
		 super.addEntity("61", "TB", "TB", "Trabzon"); 
		 super.addEntity("62", "TC", "TC", "Tunceli");
		 super.addEntity("64", "US", "US", "Uşak");
		 super.addEntity("65", "VA", "VA", "Van");
		 super.addEntity("92", "YL", "YL", "Yalova");
		 super.addEntity("66", "YZ", "YZ", "Yozgat"); 
		 super.addEntity("85", "ZO", "ZO", "Zonguldak");
		 
		 
		

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
