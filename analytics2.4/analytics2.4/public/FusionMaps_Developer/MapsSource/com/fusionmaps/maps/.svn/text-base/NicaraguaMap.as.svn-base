import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NicaraguaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NicaraguaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NicaraguaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "BO", "BO", "Boaco");
		super.addEntity("02", "CA", "CA", "Carazo");
		super.addEntity("03", "CI", "CI", "Chinandega");
		super.addEntity("04", "CO", "CO", "Chontales");
		super.addEntity("05", "ES", "ES", "Estelí");
		super.addEntity("06", "GR", "GR", "Granada");
		super.addEntity("07", "JI", "JI", "Jinotega");
		super.addEntity("08", "LE", "LE", "León");
		super.addEntity("09", "MD", "MD", "Madriz");
		super.addEntity("10", "MN", "MN", "Managua");
		super.addEntity("11", "MS", "MS", "Masaya");
		super.addEntity("12", "MT", "MT", "Matagalpa");
		super.addEntity("13", "NS", "NS", "Nueva Segovia");
		super.addEntity("15", "RI", "RI", "Rivas");
		super.addEntity("14", "SJ", "SJ", "Río San Juan");
		super.addEntity("17", "AN", "AN", "Región Autónoma del Atlántico Norte");
		super.addEntity("18", "AS", "AS", "Región Autónoma del Atlántico Sur");
			

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
