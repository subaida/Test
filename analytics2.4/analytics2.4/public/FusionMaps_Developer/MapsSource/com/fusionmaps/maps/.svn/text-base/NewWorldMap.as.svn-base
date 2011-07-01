import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NewWorldMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NewWorldMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NewWorldMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AG", "AG", "Antigua and Barbuda");
		super.addEntity("02", "BS", "BS", "Bahamas");
		super.addEntity("03", "BB", "BB", "Barbados");
		super.addEntity("04", "BZ", "BZ", "Belize");
		super.addEntity("05", "CA", "CA", "Canada");
		super.addEntity("06", "CR", "CR", "Costa Rica");
		super.addEntity("07", "CU", "CU", "Cuba");
		super.addEntity("08", "DM", "DM", "Dominica");
		super.addEntity("09", "DO", "DO", "Dominican Republic");
		super.addEntity("10", "SV", "SV", "El Salvador");
		super.addEntity("11", "GD", "GD", "Grenada");
		super.addEntity("12", "GT", "GT", "Guatemala");
		super.addEntity("13", "HT", "HT", "Haiti");
		super.addEntity("14", "HN", "HN", "Honduras");
		super.addEntity("15", "JM", "JM", "Jamaica");
		super.addEntity("16", "MX", "MX", "Mexico");
		super.addEntity("17", "NI", "NI", "Nicaragua");
		super.addEntity("18", "PA", "PA", "Panama");
		super.addEntity("19", "KN", "KN", "St.Kitts & Nevis");
        super.addEntity("20", "LC", "LC", "St.Lucia");
        super.addEntity("21", "VC", "VC", "St.Vincent & the Grenadines");
        super.addEntity("22", "TT", "TT", "Trinidad & Tobago");
        super.addEntity("23", "US", "US", "United States");
        super.addEntity("24", "GL", "GL", "Greenland");
        super.addEntity("25", "AR", "AR", "Argentina");
		super.addEntity("26", "BO", "BO", "Bolivia");
		super.addEntity("27", "BR", "BR", "Brazil");
		super.addEntity("28", "CL", "CL", "Chile");
		super.addEntity("29", "CO", "CO", "Colombia");
		super.addEntity("30", "EC", "EC", "Ecuador");
		super.addEntity("31", "FK", "FK", "Falkland Islands");
		super.addEntity("32", "GF", "GF", "French Guiana");
		super.addEntity("33", "GY", "GY", "Guyana");
		super.addEntity("34", "PY", "PY", "Paraguay");
		super.addEntity("35", "PE", "PE", "Peru");
		super.addEntity("36", "SR", "SR", "Suriname");
		super.addEntity("37", "UY", "UY", "Uruguay");
		super.addEntity("38", "VE", "VE", "Venezuela");
		super.addEntity("39", "DZ", "DZ", "Algeria");
		super.addEntity("40", "AO", "AO", "Angola");
		super.addEntity("41", "BJ", "BJ", "Benin");
		super.addEntity("42", "BW", "BW", "Botswana");
		super.addEntity("43", "BF", "BF", "Burkina Faso");
		super.addEntity("44", "BI", "BI", "Burundi");
		super.addEntity("45", "CM", "CM", "Cameroon");
		super.addEntity("46", "CV", "CV", "Cape Verde");
		super.addEntity("47", "CP", "CP", "Central African Republic");
		super.addEntity("48", "TD", "TD", "Chad");
		super.addEntity("49", "KM", "KM", "Comoros");
		super.addEntity("50", "CI", "CI", "Cote d Ivoire");
		super.addEntity("51", "CD", "CD", "Democratic Republic of the Congo");
		super.addEntity("52", "DJ", "DJ", "Djibouti");
		super.addEntity("53", "EG", "EG", "Egypt");
		super.addEntity("54", "GQ", "GQ", "Equatorial Guinea");
		super.addEntity("55", "ER", "ER", "Eritrea");
		super.addEntity("56", "ET", "ET", "Ethiopia");
		super.addEntity("57", "GA", "GA", "Gabon");
		super.addEntity("58", "GH", "GH", "Ghana");
		super.addEntity("59", "GN", "GN", "Guinea");
		super.addEntity("60", "GW", "GW", "Guinea-Bissau");
		super.addEntity("61", "KE", "KE", "Kenya");
		super.addEntity("62", "LS", "LS", "Lesotho");
		super.addEntity("63", "LI", "LI", "Liberia");
		super.addEntity("64", "LR", "LR", "Libya");
		super.addEntity("65", "MS", "MS", "Madagascar");
		super.addEntity("66", "MW", "MW", "Malawi");
		super.addEntity("67", "ML", "ML", "Mali");
		super.addEntity("68", "MR", "MR", "Mauritania");
		super.addEntity("69", "MA", "MA", "Morocco");
		super.addEntity("70", "MZ", "MZ", "Mozambique");
		super.addEntity("71", "NA", "NA", "Namibia");
		super.addEntity("72", "NE", "NE", "Niger");
		super.addEntity("73", "NG", "NG", "Nigeria");
		super.addEntity("74", "RW", "RW", "Rwanda");
		super.addEntity("75", "ST", "ST", "Sao Tome and Principe");
		super.addEntity("76", "SN", "SN", "Senegal");
		super.addEntity("77", "SC", "SC", "Seycelles");
		super.addEntity("78", "SL", "SL", "Sierra Leone");
		super.addEntity("79", "SO", "SO", "Somalia");
		super.addEntity("80", "ZA", "ZA", "South Africa");
		super.addEntity("81", "SD", "SD", "Sudan");
		super.addEntity("82", "SZ", "SZ", "Swaziland");
		super.addEntity("83", "TZ", "TZ", "Tanzania");
		super.addEntity("84", "TG", "TG", "Togo");
		super.addEntity("85", "TN", "TN", "Tunisia");
		super.addEntity("86", "UG", "UG", "Uganda");
		super.addEntity("87", "WA", "WA", "Western Sahara");
		super.addEntity("88", "ZM", "ZM", "Zambia");
		super.addEntity("89", "ZW", "ZW", "Zimbabwe");
		super.addEntity("90", "GM", "GM", "Gambia");
		super.addEntity("91", "CG", "CG", "Congo");
		super.addEntity("92", "MI", "MI", "Mauritius");
		super.addEntity("93", "AF", "AF", "Afghanistan");
		super.addEntity("94", "AM", "AM", "Armenia");
		super.addEntity("95", "AZ", "AZ", "Azerbaijan");
		super.addEntity("96", "BD", "BD", "Bangladesh");
		super.addEntity("97", "BT", "BT", "Bhutan");
		super.addEntity("98", "BN", "BN", "Brunei");
		super.addEntity("99", "MM", "MM", "Burma (Myanmar)");
		super.addEntity("100", "KH", "KH", "Cambodia");
		super.addEntity("101", "CN", "CN", "China");
		super.addEntity("102", "TP", "TP", "East Timor");
		super.addEntity("103", "GE", "GE", "Georgia");
		super.addEntity("104", "IN", "IN", "India");
		super.addEntity("105", "ID", "ID", "Indonesia");
		super.addEntity("106", "IA", "IA", "Iran");
		super.addEntity("107", "JP", "JP", "Japan");
		super.addEntity("108", "KZ", "KZ", "Kazakhstan");
		super.addEntity("109", "KP", "KP", "Korea (north)");
		super.addEntity("110", "KR", "KR", "Korea (south)");
		super.addEntity("111", "KG", "KG", "Kyrgyzstan");
		super.addEntity("112", "LA", "LA", "Laos");
		super.addEntity("113", "MY", "MY", "Malaysia");
		super.addEntity("114", "MN", "MN", "Mongolia");
		super.addEntity("115", "NP", "NP", "Nepal");
		super.addEntity("116", "PK", "PK", "Pakistan");
		super.addEntity("117", "PH", "PH", "Philippines");
		super.addEntity("118", "RU", "RU", "Russian Federation");
		super.addEntity("119", "SG", "SG", "Singapore");
		super.addEntity("120", "LK", "LK", "Sri Lanka");
		super.addEntity("121", "TJ", "TJ", "Tajikistan");
		super.addEntity("122", "TH", "TH", "Thailand");
		super.addEntity("123", "TM", "TM", "Turkmenistan");
		super.addEntity("124", "UZ", "UZ", "Uzbekistan");
		super.addEntity("125", "VN", "VN", "Vietnam");
		super.addEntity("126", "TW", "TW", "Taiwan");
		super.addEntity("127", "HK", "HK", "Hong Kong");
		super.addEntity("128", "MO", "MO", "Macau");
		super.addEntity("129", "AL", "AL", "Albania");
		super.addEntity("130", "AD", "AD", "Andorra");
		super.addEntity("131", "AT", "AT", "Austria");
		super.addEntity("132", "BY", "BY", "Belarus");
		super.addEntity("133", "BE", "BE", "Belgium");
		super.addEntity("134", "BH", "BH", "Bosnia and Herzegovina");
		super.addEntity("135", "BG", "BG", "Bulgaria");
		super.addEntity("136", "HY", "HY", "Croatia");
		super.addEntity("137", "CZ", "CZ", "Czech Republic");
		super.addEntity("138", "DK", "DK", "Denmark");
		super.addEntity("139", "EE", "EE", "Estonia");
		super.addEntity("140", "FI", "FI", "Finland");
		super.addEntity("141", "FR", "FR", "France");
		super.addEntity("142", "DE", "DE", "Germany");
		super.addEntity("143", "GR", "GR", "Greece");
		super.addEntity("144", "HU", "HU", "Hungary");
		super.addEntity("145", "IS", "IS", "Iceland");
		super.addEntity("146", "IR", "IR", "Ireland");
		super.addEntity("147", "IT", "IT", "Italy");
		super.addEntity("148", "LV", "LV", "Latvia");
		super.addEntity("149", "LN", "LN", "Liechtenstein");
		super.addEntity("150", "LT", "LT", "Lithuania");
		super.addEntity("151", "LU", "LU", "Luxembourg");
		super.addEntity("152", "MK", "MK", "Macedonia");
		super.addEntity("153", "MT", "MT", "Malta");
		super.addEntity("154", "MV", "MV", "Moldova");
		super.addEntity("155", "MC", "MC", "Monaco");
		super.addEntity("156", "MG", "MG", "Montenegro");
		super.addEntity("157", "NL", "NL", "Netherlands");
		super.addEntity("158", "NO", "NO", "Norway");
		super.addEntity("159", "PL", "PL", "Poland");
		super.addEntity("160", "PT", "PT", "Portugal");
		super.addEntity("161", "RO", "RO", "Romania");
		super.addEntity("162", "SM", "SM", "San Marino");
		super.addEntity("163", "CS", "CS", "Serbia");
		super.addEntity("164", "SK", "SK", "Slovakia");
		super.addEntity("165", "SI", "SI", "Slovenia");
		super.addEntity("166", "ES", "ES", "Spain");
		super.addEntity("167", "SE", "SE", "Sweden");
		super.addEntity("168", "CH", "CH", "Switzerland");
		super.addEntity("169", "UA", "UA", "Ukraine");
		super.addEntity("170", "UK", "UK", "United Kingdom");
		super.addEntity("171", "VA", "VA", "Vatican City");
		super.addEntity("172", "CY", "CY", "Cyprus");
		super.addEntity("173", "TK", "TK", "Turkey");
		super.addEntity("174", "RU", "RU", "Russia");
		super.addEntity("175", "AU", "AU", "Australia");
		super.addEntity("176", "FJ", "FJ", "Fiji");
		super.addEntity("177", "KI", "KI", "Kiribati");
		super.addEntity("178", "MH", "MH", "Marshall Islands");
		super.addEntity("179", "FM", "FM", "Micronesia");
		super.addEntity("180", "NR", "NR", "Nauru");
		super.addEntity("181", "NZ", "NZ", "New Zealand");
		super.addEntity("182", "PW", "PW", "Palau");
		super.addEntity("183", "PG", "PG", "Papua New Guinea");
		super.addEntity("184", "WS", "WS", "Samoa");
		super.addEntity("185", "SB", "SB", "Solomon Islands");
		super.addEntity("186", "TO", "TO", "Tonga");
		super.addEntity("187", "TV", "TV", "Tuvalu");
		super.addEntity("188", "VU", "VU", "Vanuatu");
		super.addEntity("189", "NC", "NC", "New Caledonia");
		super.addEntity("190", "BA", "BA", "Bahrain");
		super.addEntity("191", "IZ", "IZ", "Iraq");
		super.addEntity("192", "IE", "IE", "Israel");
		super.addEntity("193", "JO", "JO", "Jordan");
		super.addEntity("194", "KU", "KU", "Kuwait");
		super.addEntity("195", "LB", "LB", "Lebanon");
		super.addEntity("196", "OM", "OM", "Oman");
		super.addEntity("197", "QA", "QA", "Qatar");
		super.addEntity("198", "SA", "SA", "Saudi Arabia");
		super.addEntity("199", "SY", "SY", "Syria");
		super.addEntity("200", "AE", "AE", "United Arab Emirates");
		super.addEntity("201", "YM", "YM", "Yemen");
		super.addEntity("202", "PR", "PR", "Puerto Rico");
		super.addEntity("203", "KY", "KY", "Cayman Islands");
		
		
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
