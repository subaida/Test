import com.fusionmaps.core.Map;
class com.fusionmaps.maps.RussiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "RussiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function RussiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("03", "03", "BU", "Buriatia");
		super.addEntity("04", "04", "AL", "Altay Republic");
		super.addEntity("11", "11", "KO", "Komia");
		super.addEntity("14", "14", "YA", "Yakutia");
		super.addEntity("17", "17", "TA", "Tuva");
		super.addEntity("19", "19", "KH", "Khakassia");
		super.addEntity("22", "22", "AT", "Altay Territory");
		super.addEntity("24", "24", "KY", "Krasnoyarsk Territory");
		super.addEntity("25", "25", "MA", "Primosk");
		super.addEntity("27", "27", "KS", "Khabarovsk Territory");
		super.addEntity("28", "28", "AM", "Amur Region");
		super.addEntity("29", "29", "AR", "Arkhangelsk Region");
		super.addEntity("38", "38", "IK", "Irkutsk Region");
		super.addEntity("41", "41", "KA", "Kamchatka Region");
		super.addEntity("42", "42", "KE", "Kemerovo Region");
		super.addEntity("45", "45", "KU", "Kurgan Region");
		super.addEntity("49", "49", "MG", "Magadan Region");
		super.addEntity("54", "54", "NV", "Novosibirsk Region");
		super.addEntity("55", "55", "OR", "Omsk Region");
		super.addEntity("59", "59", "PR", "Perm Region");
		super.addEntity("65", "65", "SA", "Sakhalin Region");
		super.addEntity("66", "66", "SV", "Sverdlovsk Region");
		super.addEntity("70", "70", "TO", "Tomsk Region");
		super.addEntity("72", "72", "TY", "Tyumen Region");
		super.addEntity("74", "74", "CH", "Chelyabinsk Region");
		super.addEntity("75", "75", "CR", "Chita Region");
		super.addEntity("79", "79", "JE", "Jewish Autonomous Region");
		super.addEntity("80", "80", "AG", "Aghin Buriatia");
		super.addEntity("81", "81", "PE", "Perm’s Komia");
		super.addEntity("82", "82", "KK", "Koryakia");
		super.addEntity("83", "83", "NE", "Nenetsia");
		super.addEntity("84", "84", "TR", "Taymyria");
		super.addEntity("85", "85", "US", "Ust-Ord Buriatia");
		super.addEntity("86", "86", "KD", "Khantia-Mansia");
		super.addEntity("87", "87", "CU", "Chukchia");
		super.addEntity("88", "88", "EV", "Evenkia");
		super.addEntity("89", "89", "YM", "Yamal Nenetsia");
		super.addEntity("01", "01", "AD", "Adygeya");
		super.addEntity("02", "02", "BA", "Bashkiria");
		super.addEntity("05", "05", "DA", "Daghestan");
		super.addEntity("06", "06", "IN", "Ingushia");
		super.addEntity("07", "07", "KB", "Kabard-Balkaria");
		super.addEntity("08", "08", "KL", "Kalmykia");
		super.addEntity("09", "09", "KC", "Karachay-Cherkessia");
		super.addEntity("10", "10", "KI", "Karelia");
		//super.addEntity("11", "11", "KM", "Komia");
		super.addEntity("12", "12", "MI", "Mariy-El");
		super.addEntity("13", "13", "MD", "Mordovia");
		super.addEntity("15", "15", "NO", "North Ossetia");
		super.addEntity("16", "16", "TT", "Tataria (or Tartary)");
		super.addEntity("18", "18", "UD", "Udmurtia");
		super.addEntity("20", "20", "CC", "Chechenia");
		super.addEntity("21", "21", "CS", "Chuvashia");
		super.addEntity("23", "23", "KT", "Krasnodar Territory");
		super.addEntity("26", "26", "ST", "Stavropol Territory");
		//super.addEntity("29", "29", "AI", "Arkhangelsk Region");
		super.addEntity("30", "30", "AA", "Astrakhan Region");
		super.addEntity("31", "31", "BG", "Belgorod Region");
		super.addEntity("32", "32", "BR", "Bryansk Region");
		super.addEntity("33", "33", "VL", "Vladimir Region");
		super.addEntity("34", "34", "VO", "Volgograd Region");
		super.addEntity("35", "35", "VR", "Vologda Region");
		super.addEntity("36", "36", "VZ", "Voronezh Region");
		super.addEntity("37", "37", "IR", "Ivanovo Region");
		super.addEntity("39", "39", "KN", "Kaliningrad Region");
		super.addEntity("40", "40", "KG", "Kaluga Region");
		super.addEntity("43", "43", "KV", "Kirov Region");
		super.addEntity("44", "44", "KR", "Kostroma Region");
		super.addEntity("46", "46", "K1", "Kursk Region");
		super.addEntity("47", "47", "LR", "Leningrad Region");
		super.addEntity("48", "48", "LP", "Lipetsk Region");
		super.addEntity("50", "50", "MC", "Moscow Region");
		super.addEntity("51", "51", "MM", "Murmansk Region");
		super.addEntity("52", "52", "NZ", "Nizhniy Novgorod Region");
		super.addEntity("53", "53", "NG", "Novgorod Region");
		super.addEntity("56", "56", "OB", "Orenburg Region");
		super.addEntity("57", "57", "OE", "Orel Region");
		super.addEntity("58", "58", "PE", "Penza Region");
		super.addEntity("60", "60", "PS", "Pskov Region");
		super.addEntity("61", "61", "RR", "Rostov Region");
		super.addEntity("62", "62", "RY", "Ryazan Region");
		super.addEntity("63", "63", "SG", "Samara Region");
		super.addEntity("64", "64", "SR", "Saratov Region");
		super.addEntity("67", "67", "SM", "Smolensk Region");
		super.addEntity("68", "68", "TM", "Tambov Region");
		super.addEntity("69", "69", "TV", "Tver Region");
		super.addEntity("71", "71", "TU", "Tula Region");
		super.addEntity("73", "73", "UL", "Ulyanovsk Region");
		super.addEntity("76", "76", "YR", "Yaroslavl Region");
		super.addEntity("77", "77", "MO", "Moscow City");
		super.addEntity("78", "78", "SP", "Saint Petersburg City");
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
