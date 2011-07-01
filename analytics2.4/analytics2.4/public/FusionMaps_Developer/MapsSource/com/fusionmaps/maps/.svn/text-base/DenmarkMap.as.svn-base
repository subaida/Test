import com.fusionmaps.core.Map;
class com.fusionmaps.maps.DenmarkMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "DenmarkMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function DenmarkMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AR", "Århus");
		super.addEntity("002", "002", "BO", "Bornholm");
		super.addEntity("003", "003", "FR", "Frederiksberg");
		super.addEntity("004", "004", "FE", "Frederiksborg");
		super.addEntity("005", "005", "FY", "Fyn");
		super.addEntity("006", "006", "KO", "Københavns Amt");
		super.addEntity("007", "007", "KB", "København");
		super.addEntity("008", "008", "NO", "Nordjylland");
		super.addEntity("009", "009", "RI", "Ribe");
		super.addEntity("010", "010", "RN", "Ringkjøbing");
		super.addEntity("011", "011", "RO", "Roskilde");
		super.addEntity("012", "012", "SO", "Sønderjylland");
		super.addEntity("013", "013", "ST", "Storstrøm");
		super.addEntity("014", "014", "VE", "Vejle");
		super.addEntity("015", "015", "VS", "Vestsjælland");
		super.addEntity("016", "016", "VI", "Viborg ");
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
