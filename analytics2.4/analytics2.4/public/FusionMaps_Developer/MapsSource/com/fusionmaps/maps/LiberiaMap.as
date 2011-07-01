import com.fusionmaps.core.Map;
class com.fusionmaps.maps.LiberiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "LiberiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function LiberiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("LR.BM", "BM", "BM", "Bomi");		
		super.addEntity("LR.BG", "BG", "BG", "Bong");		
		super.addEntity("LR.GP", "GP", "GP", "Gbarpolu");		
		super.addEntity("LR.GB", "GB", "GB", "Grand Bassa");		
		super.addEntity("LR.CM", "CM", "CM", "Grand Cape Mount");		
		super.addEntity("LR.GD", "GD", "GD", "Grand Gedeh");		
	    super.addEntity("LR.GK", "GK", "GK", "Grand Kru");
		super.addEntity("LR.LF", "LF", "LF", "Lofa");
		super.addEntity("LR.MG", "MG", "MG", "Margibi");
		super.addEntity("LR.MY", "MY", "MY", "Maryland");
		super.addEntity("LR.MO", "MO", "MO", "Montserrado");
		super.addEntity("LR.NI", "NI", "NI", "Nimba");
		super.addEntity("LR.RI", "RI", "RI", "Rivercess");
		super.addEntity("LR.RG", "RG", "RG", "River Gee");
		super.addEntity("LR.SI", "SI", "SI", "Sinoe");
		
		
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
