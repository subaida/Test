import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NamibiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NamibiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NamibiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("NA.CA", "CA", "CA", "Caprivi");		
		super.addEntity("NA.ER", "ER", "ER", "Erongo");		
		super.addEntity("NA.HA", "HA", "HA", "Hardap");		
		super.addEntity("NA.KA", "KA", "KA", "Karas");		
		super.addEntity("NA.KH", "KH", "KH", "Khomas");		
		super.addEntity("NA.KU", "KU", "KU", "Kunene");		
	    super.addEntity("NA.OW", "OW", "OW", "Ohangwena");
		super.addEntity("NA.OK", "OK", "OK", "Okavango");
		super.addEntity("NA.OH", "OH", "OH", "Omaheke");
		super.addEntity("NA.OS", "OS", "OS", "Omusati");
		super.addEntity("NA.ON", "ON", "ON", "Oshana");
		super.addEntity("NA.OT", "OT", "OT", "Oshikoto");
		super.addEntity("NA.OD", "OD", "OD", "Otjozondjupa");
		
		
		
		
		
		
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
