import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ScotlandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ScotlandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ScotlandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AB", "Aberdeenshire");
		super.addEntity("002", "002", "AN", "Angus");
		super.addEntity("003", "003", "AR", "Argyll ");
		super.addEntity("004", "004", "AY", "Ayrshire");
		super.addEntity("005", "005", "BA", "Banffshire");
		super.addEntity("006", "006", "BE", "Berwickshire");
		super.addEntity("007", "007", "BU", "Bute");
		super.addEntity("008", "008", "CA", "Caithness");
		super.addEntity("009", "009", "CL", "Clackmannanshire");
		super.addEntity("010", "010", "DM", "Dumbartonshire");
		super.addEntity("011", "011", "DU", "Dumfriesshire");
		super.addEntity("012", "012", "EA", "East Lothian");
		super.addEntity("013", "013", "FI", "Fife");
		super.addEntity("014", "014", "IS", "Inverness-shire");
		super.addEntity("015", "015", "KC", "Kincardineshire");
		super.addEntity("016", "016", "KN", "Kinross-shire");
		super.addEntity("017", "017", "KI", "Kirkcudbrightshire");
		super.addEntity("018", "018", "LA", "Lanarkshire");
		super.addEntity("019", "019", "MI", "Midlothian");
		super.addEntity("020", "020", "MO", "Moray");
		super.addEntity("021", "021", "NA", "Nairnshire");
		super.addEntity("022", "022", "OR", "Orkney ");
		super.addEntity("023", "023", "PB", "Peeblesshire");
		super.addEntity("024", "024", "PE", "Perthshire");
		super.addEntity("025", "025", "RE", "Renfrewshire");
		super.addEntity("026", "026", "RC", "Ross & Cromarty");
		super.addEntity("027", "027", "RO", "Roxburghshire");
		super.addEntity("028", "028", "SE", "Selkirkshire");
		super.addEntity("029", "029", "SH", "Shetland");
		super.addEntity("030", "030", "ST", "Stirlingshire");
		super.addEntity("031", "031", "SU", "Sutherland");
		super.addEntity("032", "032", "WE", "West Lothian");
		super.addEntity("033", "033", "WI", "Wigtonshire");
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
