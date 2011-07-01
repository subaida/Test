import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MarylandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MarylandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MarylandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "AL", "AL", "Allegany");
		super.addEntity("003", "AN", "AN", "Anne Arundel");
		super.addEntity("510", "BA", "BA", "Baltimore City");
		super.addEntity("005", "BL", "BL", "Baltimore");
		super.addEntity("009", "CA", "CA", "Calvert");
		super.addEntity("011", "CR", "CR", "Caroline");
		super.addEntity("013", "CO", "CO", "Carroll");
		super.addEntity("015", "CE", "CE", "Cecil");
		super.addEntity("017", "CH", "CH", "Charles");
		super.addEntity("019", "DO", "DO", "Dorchester");
		super.addEntity("021", "FR", "FR", "Frederick");
		super.addEntity("023", "GA", "GA", "Garrett");
		super.addEntity("025", "HA", "HA", "Harford");
		super.addEntity("027", "HO", "HO", "Howard");
		super.addEntity("029", "KE", "KE", "Kent");
		super.addEntity("031", "MO", "MO", "Montgomery");
		super.addEntity("033", "PG", "PG", "Prince George's");
		super.addEntity("035", "QA", "QA", "Queen Anne's");
		super.addEntity("037", "SM", "SM", "St.Mary's");
		super.addEntity("039", "SO", "SO", "Somerset");
		super.addEntity("041", "TA", "TA", "Talbot");
		super.addEntity("043", "WA", "WA", "Washington");
		super.addEntity("045", "WI", "WI", "Wicomico");
		super.addEntity("047", "WO", "WO", "Worchester");
		
		
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
