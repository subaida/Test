import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IndiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IndiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IndiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AN", "Andaman and Nicobar Islands");
		super.addEntity("002", "002", "AP", "Andhra Pradesh");
		super.addEntity("003", "003", "AR", "Arunachal Pradesh");
		super.addEntity("004", "004", "AS", "Assam");
		super.addEntity("005", "005", "BI", "Bihar");
		//super.addEntity("006", "006", "CH", "Chandigarh");
		super.addEntity("007", "007", "CA", "Chhattisgarh");
		//super.addEntity("008", "008", "DN", "Dadra and Nagar Haveli");
		//super.addEntity("009", "009", "DD", "Daman and Diu");
		super.addEntity("010", "010", "DE", "Delhi");
		super.addEntity("011", "011", "GO", "Goa");
		super.addEntity("012", "012", "GU", "Gujarat");
		super.addEntity("013", "013", "HA", "Haryana");
		super.addEntity("014", "014", "HP", "Himachal Pradesh");
		super.addEntity("015", "015", "JK", "Jammu and Kashmir");
		super.addEntity("016", "016", "JH", "Jharkhand");
		super.addEntity("017", "017", "KA", "Karnataka");
		super.addEntity("018", "018", "KE", "Kerala");
		super.addEntity("019", "019", "LA", "Lakshadweep");
		super.addEntity("020", "020", "MP", "Madhya Pradesh");
		super.addEntity("021", "021", "MA", "Maharashtra");
		super.addEntity("022", "022", "MN", "Manipur");
		super.addEntity("023", "023", "ME", "Meghalaya");
		super.addEntity("024", "024", "MI", "Mizoram");
		super.addEntity("025", "025", "NA", "Nagaland");
		super.addEntity("026", "026", "OR", "Orissa");
		//super.addEntity("027", "027", "PO", "Pondicherry");
		super.addEntity("028", "028", "PU", "Punjab");
		super.addEntity("029", "029", "RA", "Rajasthan");
		super.addEntity("030", "030", "SI", "Sikkim");
		super.addEntity("031", "031", "TN", "Tamil Nadu");
		super.addEntity("032", "032", "TR", "Tripura");
		super.addEntity("033", "033", "UP", "Uttar Pradesh");
		super.addEntity("034", "034", "UT", "Uttaranchal");
		super.addEntity("035", "035", "WB", "West Bengal ");
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
