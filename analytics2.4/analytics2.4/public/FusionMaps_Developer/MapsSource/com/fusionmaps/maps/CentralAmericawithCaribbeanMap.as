import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CentralAmericawithCaribbeanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CentralAmericawithCaribbeanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CentralAmericawithCaribbeanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String, scaleMode:String, registerWithJS:Boolean, DOMId:String) {
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
		super.addEntity("01", "BH", "BH", "Belize");
		super.addEntity("02", "CS", "CS", "Costa Rica");
		super.addEntity("03", "ES", "ES", "El Salvador");
		super.addEntity("04", "GT", "GT", "Guatemala");
		super.addEntity("05", "HO", "HO", "Honduras");
		super.addEntity("06", "NU", "NU", "Nicaragua");
		super.addEntity("07", "PM", "PM", "Panama");
		super.addEntity("08", "CU", "CU", "Cuba");
		super.addEntity("09", "BS", "BS", "Bahamas");
		super.addEntity("10", "KY", "KY", "Cayman Islands");
		super.addEntity("11", "JM", "JM", "Jamaica");
		super.addEntity("12", "HT", "HT", "Haiti");
		super.addEntity("13", "DO", "DO", "Dominican Republic");
		super.addEntity("14", "PR", "PR", "Puerto Rico");
		super.addEntity("15", "KN", "KN", "St.Kitts and Nevis");
		super.addEntity("16", "AG", "AG", "Antigua");
		super.addEntity("17", "DM", "DM", "Dominica");
		super.addEntity("18", "LC", "LC", "St.Lucia");
		super.addEntity("19", "VC", "VC", "St.Vincent and the Grenadlines");
		super.addEntity("20", "BB", "BB", "Barbados");
		super.addEntity("21", "GD", "GD", "Grenada");
		super.addEntity("22", "TT", "TT", "Trinidad & Tobago");
		 
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
