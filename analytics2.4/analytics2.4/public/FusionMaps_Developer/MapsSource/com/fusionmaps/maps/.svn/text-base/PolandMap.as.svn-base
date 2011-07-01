import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PolandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PolandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PolandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("72", "DS", "DS", "Dolnośląskie");
		super.addEntity("73", "KP", "KP", "Kujawsko-Pomorskie");
		super.addEntity("74", "LD", "LD", "Łódzkie");
		super.addEntity("75", "LU", "LU", "Lubelskie");
		super.addEntity("76", "LB", "LB", "Lubuskie");
		super.addEntity("77", "MA", "MA", "Małopolskie");
		super.addEntity("78", "MZ", "MZ", "Mazowieckie");
		super.addEntity("79", "OP", "OP", "Opolskie");
		super.addEntity("80", "PK", "PK", "Podkarpackie");
		super.addEntity("81", "PD", "PD", "Podlaskie");
		super.addEntity("82", "PM", "PM", "Pomorskie");
		super.addEntity("83", "SL", "SL", "Śląskie");
		super.addEntity("84", "SK", "SK", "Świętokrzyskie");
		super.addEntity("85", "WN", "WN", "Warmińsko-Mazurskie");
		super.addEntity("86", "WP", "WP", "Wielkopolskie");
		super.addEntity("87", "ZP", "ZP", "Zachodniopomorskie");
		
		
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
