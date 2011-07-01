import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CentralAmerica2Map extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CentralAmerica2Map";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CentralAmerica2Map(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("CE.BZ", "BZ", "BZ", "Belize");
		super.addEntity("CE.CR", "CR", "CR", "Costa Rica");
		super.addEntity("CE.SV", "SV", "SV", "El Salvador");
		super.addEntity("CE.GT", "GT", "GT", "Guatemala");
		super.addEntity("CE.HN", "HN", "HN", "Honduras");
		super.addEntity("CE.NI", "NI", "NU", "Nicaragua");
		super.addEntity("CE.PA", "PA", "PA", "Panama");
		super.addEntity("CE.CU", "CU", "CU", "Cuba");
		super.addEntity("CE.BS", "BS", "BS", "Bahamas");
		super.addEntity("CE.KY", "KY", "KY", "Cayman Islands");
		super.addEntity("CE.JM", "JM", "JM", "Jamaica");
		super.addEntity("CE.HT", "HT", "HT", "Haiti");
		super.addEntity("CE.DO", "DO", "DO", "Dominican Republic");
		super.addEntity("CE.PR", "PR", "PR", "Puerto Rico");
		super.addEntity("CE.KN", "KN", "KN", "St.Kitts and Nevis");
		super.addEntity("CE.AG", "AG", "AG", "Antigua and Barbados");
		super.addEntity("CE.DM", "DM", "DM", "Dominica");
		super.addEntity("CE.LC", "LC", "LC", "St.Lucia");
		super.addEntity("CE.VC", "VC", "VC", "St.Vincent and the Grenadlines");
		super.addEntity("CE.BB", "BB", "BB", "Barbados");
		super.addEntity("CE.GD", "GD", "GD", "Grenada");
		super.addEntity("CE.TT", "TT", "TT", "Trinidad & Tobago");
		super.addEntity("CE.VG", "VG", "VG", "Virgin Islands,British");
		super.addEntity("CE.VI", "VI", "VI", "Virgin Islands,U.S.");
		 
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
