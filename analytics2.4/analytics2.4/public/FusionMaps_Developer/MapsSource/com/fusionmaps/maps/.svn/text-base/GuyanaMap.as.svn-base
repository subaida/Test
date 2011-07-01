import com.fusionmaps.core.Map;
class com.fusionmaps.maps.GuyanaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "GuyanaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function GuyanaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("GY.BA", "BA", "BA", "Barima-Waini");
		super.addEntity("GY.CU	", "CU", "CU", "Cuyuni-Mazaruni");
		super.addEntity("GY.DE", "DE", "DE", "Demerara-Mahaica");
		super.addEntity("GY.EB", "EB", "EB", "East Berbice-Corentyne");
		super.addEntity("GY.ES", "ES", "ES", "Essequibo Islands-West Demerara");
		super.addEntity("GY.MA", "MA", "MA", "Mahaica-Berbice");
		super.addEntity("GY.PM", "PM", "PM", "Pomeroon-Supenaam ");
		super.addEntity("GY.PT", "PT", "PT", "Potaro-Siparuni");
		super.addEntity("GY.UD", "UD", "UD", "Upper Demerara-Berbice");
		super.addEntity("GY.UT", "UT", "UT", "Upper Takutu-Upper Essequibo");
		
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
