import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SwedenMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SwedenMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SwedenMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("02", "K", "K", "Blekinge");
		super.addEntity("10", "W", "W", "Dalarnas");
		super.addEntity("03", "X", "X", "Gävleborg");
		super.addEntity("05", "I", "I", "Gotlands");
		super.addEntity("06", "N", "N", "Hallands");
		super.addEntity("07", "Z", "Z", "Jämtland");
		super.addEntity("08", "F", "F", "Jönköping");
		super.addEntity("12", "G", "G", "Kronobergs");
		super.addEntity("14", "BD", "BD", "Norrbottens");
		super.addEntity("15", "T", "T", "Örebro");
		super.addEntity("16", "E", "E", "Östergötland");
		super.addEntity("09", "H", "H", "Kalmar");
		super.addEntity("27", "M", "M", "Skåne ");
		super.addEntity("18", "D", "D", "Södermanland");
		super.addEntity("26", "AB", "AB", "Stockholms");
		super.addEntity("21", "C", "C", "Uppsala");
		super.addEntity("22", "S", "S", "Värmland ");
		super.addEntity("23", "AC", "AC", "Västerbotten");
		super.addEntity("24", "Y", "Y", "Västernorrland");
		super.addEntity("25", "U", "U", "Västmanland");
		super.addEntity("28", "O", "O", "Västra Götaland ");
	  
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
