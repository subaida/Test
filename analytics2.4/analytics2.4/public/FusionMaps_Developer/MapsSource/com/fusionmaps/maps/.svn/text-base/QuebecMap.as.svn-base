import com.fusionmaps.core.Map;
class com.fusionmaps.maps.QuebecMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "QuebecMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function QuebecMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("08", "AT", "AT", "Abitibi-Témiscamingue");
		super.addEntity("01", "BS", "BS", "Bas-Saint-Laurent");
		super.addEntity("03", "CN", "CN", "Capitale-Nationale");
		super.addEntity("17", "CQ", "CQ", "Centre-du-Québec");
		super.addEntity("12", "CA", "CA", "Chaudière-Appalaches");
		super.addEntity("09", "CO", "CO", "Côte-Nord");
		super.addEntity("05", "ES", "ES", "Estrie");
		super.addEntity("11", "GA", "GA", "Gaspésie-Îles-de-la-Madeleine");
		super.addEntity("14", "LA", "LA", "Lanaudière");
		super.addEntity("15", "LU", "LU", "Laurentides");
		super.addEntity("13", "LV", "LV", "Laval");
		super.addEntity("04", "MA", "MA", "Mauricie");
		super.addEntity("16", "MO", "MO", "Montérégie");
		super.addEntity("06", "MN", "MN", "Montréal");
		super.addEntity("10", "NO", "NO", "Nord-du-Québec");
		super.addEntity("07", "OU", "OU", "Outaouais");
		super.addEntity("02", "SL", "SL", "Saguenay-Lac-Saint-Jean");
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
