import com.fusionmaps.core.Map;
class com.fusionmaps.maps.EnglandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "EnglandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function EnglandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "BE", "Bedfordshire");
		super.addEntity("002", "002", "BR", "Berkshire");
		super.addEntity("003", "003", "BU", "Buckinghamshire");
		super.addEntity("004", "004", "CA", "Cambridgeshire");
		super.addEntity("005", "005", "CH", "Cheshire");
		super.addEntity("006", "006", "CO", "Cornwall");
		super.addEntity("007", "007", "CU", "Cumbria");
		super.addEntity("008", "008", "DE", "Derbyshire");
		super.addEntity("009", "009", "DV", "Devon");
		super.addEntity("010", "010", "DO", "Dorset");
		super.addEntity("011", "011", "DU", "Durham");
		super.addEntity("012", "012", "ES", "Essex");
		super.addEntity("013", "013", "GL", "Gloucestershire");
		super.addEntity("014", "014", "HA", "Hampshire");
		super.addEntity("015", "015", "HE", "Herefordshire");
		super.addEntity("016", "016", "HR", "Hertfordshire");
		//super.addEntity("017", "017", "HU", "Huntingdonshire");
		super.addEntity("018", "018", "KE", "Kent");
		super.addEntity("019", "019", "LA", "Lancashire");
		super.addEntity("020", "020", "LE", "Leicestershire");
		super.addEntity("021", "021", "LI", "Lincolnshire");
		super.addEntity("022", "022", "LO", "London");
		//super.addEntity("023", "023", "MI", "Middlesex");
		super.addEntity("024", "024", "NO", "Norfolk");
		super.addEntity("025", "025", "NR", "Northamptonshire");
		super.addEntity("026", "026", "NT", "Northumberland");
		super.addEntity("027", "027", "NG", "Nottinghamshire");
		super.addEntity("028", "028", "OX", "Oxfordshire");
		super.addEntity("030", "030", "SH", "Shropshire");
		super.addEntity("031", "031", "SO", "Somerset");
		super.addEntity("032", "032", "ST", "Staffordshire");
		super.addEntity("033", "033", "SU", "Suffolk");
		super.addEntity("034", "034", "SR", "Surrey");
		super.addEntity("035", "035", "ES", "E.Sussex");
		super.addEntity("036", "036", "WA", "Warwickshire");
		super.addEntity("038", "038", "WI", "Wiltshire");
		super.addEntity("039", "039", "WO", "Worcestershire");
		super.addEntity("040", "040", "NY", "N.Yorkshire");
		super.addEntity("041", "041", "TW", "Tyne and Wear");
		super.addEntity("042", "042", "MS", "Mersey");
		super.addEntity("043", "043", "GM", "G.Manchester");
		super.addEntity("044", "044", "WM", "W.Midlands");
		super.addEntity("045", "045", "RN", "Rutland");
		super.addEntity("046", "046", "IW", "Isle of Wight");
		super.addEntity("047", "047", "WS", "W.Sussex");
		super.addEntity("048", "048", "EY", "E.Yorkshire");
		super.addEntity("049", "049", "SY", "S.Yorkshire");
		super.addEntity("050", "050", "WY", "W.Yorkshire");
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
