import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AfricaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AfricaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AfricaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "DZ", "Algeria");
		super.addEntity("002", "002", "AO", "Angola");
		super.addEntity("003", "003", "BJ", "Benin");
		super.addEntity("004", "004", "BW", "Botswana");
		super.addEntity("005", "005", "BF", "Burkina Faso");
		super.addEntity("006", "006", "BI", "Burundi");
		super.addEntity("007", "007", "CM", "Cameroon");
		super.addEntity("008", "008", "CV", "Cape Verde");
		super.addEntity("009", "009", "CR", "Central African Republic");
		super.addEntity("010", "010", "TD", "Chad");
		super.addEntity("011", "011", "KM", "Comoros");
		super.addEntity("012", "012", "CI", "Cote D'ivoire");
		super.addEntity("013", "013", "CD", "Democratic Republic of the Congo");
		super.addEntity("014", "014", "DJ", "Djibouti");
		super.addEntity("015", "015", "EG", "Egypt");
		super.addEntity("016", "016", "GQ", "Equatorial Guinea");
		super.addEntity("017", "017", "ER", "Eritrea");
		super.addEntity("018", "018", "ET", "Ethiopia");
		super.addEntity("019", "019", "GA", "Gabon");
		super.addEntity("020", "020", "GH", "Ghana");
		super.addEntity("021", "021", "GN", "Guinea");
		super.addEntity("022", "022", "GW", "Guinea-Bissau");
		super.addEntity("023", "023", "KE", "Kenya");
		super.addEntity("024", "024", "LS", "Lesotho");
		super.addEntity("025", "025", "LI", "Liberia");
		super.addEntity("026", "026", "LR", "Libya");
		super.addEntity("027", "027", "MG", "Madagascar");
		super.addEntity("028", "028", "MW", "Malawi");
		super.addEntity("029", "029", "ML", "Mali");
		super.addEntity("030", "030", "MR", "Mauritania");
		//super.addEntity("031", "031", "MY", "Mayotte");
		super.addEntity("032", "032", "MA", "Morocco");
		super.addEntity("033", "033", "MZ", "Mozambique");
		super.addEntity("034", "034", "NA", "Namibia");
		super.addEntity("035", "035", "NE", "Niger");
		super.addEntity("036", "036", "NG", "Nigeria");
		//super.addEntity("037", "037", "RC", "Republic of the Congo");
		super.addEntity("038", "038", "RW", "Rwanda");
		//super.addEntity("039", "039", "SH", "Saint Helena");
		super.addEntity("040", "040", "ST", "Sao Tome and Principe");
		super.addEntity("041", "041", "SN", "Senegal");
		super.addEntity("042", "042", "SY", "Seychelles");
		super.addEntity("043", "043", "SL", "Sierra Leone");
		super.addEntity("044", "044", "SO", "Somalia");
		super.addEntity("045", "045", "ZA", "South Africa");
		super.addEntity("046", "046", "SD", "Sudan");
		super.addEntity("047", "047", "SZ", "Swaziland");
		super.addEntity("048", "048", "TZ", "Tanzania");
		super.addEntity("049", "049", "TG", "Togo");
		//super.addEntity("050", "050", "TO", "Togo");
		super.addEntity("051", "051", "TN", "Tunisia");
		super.addEntity("052", "052", "UG", "Uganda");
		super.addEntity("053", "053", "WS", "Western Sahara");
		super.addEntity("054", "054", "ZM", "Zambia");
		super.addEntity("055", "055", "ZW", "Zimbabwe");
		super.addEntity("056", "056", "GM", "Gambia");
		super.addEntity("057", "057", "CG", "Congo");
		super.addEntity("058", "058", "MU", "Mauritius");
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
