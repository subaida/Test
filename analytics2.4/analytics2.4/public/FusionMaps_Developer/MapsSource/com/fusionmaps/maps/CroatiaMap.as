import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CroatiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CroatiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CroatiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "BB", "BB", "Bjelovarsko-Bilogorska");
		super.addEntity("02", "SP", "SP", "Brodsko-Posavska");
		super.addEntity("03", "DN", "DN", "Dubrovačko-Neretvanska");
		super.addEntity("04", "IS", "IS", "Istarska");
		super.addEntity("05", "KA", "KA", "Karlovačka");
		super.addEntity("06", "KK", "KK", "Koprivničko-Križevačka ");
		super.addEntity("07", "KZ", "KZ", "Krapinsko-Zagorska");
		super.addEntity("08", "LS", "LS", "Ličko-Senjska");
		super.addEntity("09", "ME", "ME", "Međimurska");
		super.addEntity("10", "OB", "OB", "Osječko-Baranjska ");
		super.addEntity("11", "PS", "PS", "Požeško-Slavonska");
		super.addEntity("12", "PG", "PG", "Primorsko-Goranska");
		super.addEntity("13", "SB", "SB", "Šibensko-Kninska ");
		super.addEntity("14", "SM", "SM", "Sisačko-Moslavačka");
		super.addEntity("15", "SD", "SD", "Splitsko-Dalmatinska");
		super.addEntity("16", "VA", "VA", "Varaždinska");
		super.addEntity("17", "VP", "VP", "Virovitičko-Podravska");
		super.addEntity("18", "VS", "VS", "Vukovarsko-Srijemska");
		super.addEntity("19", "ZD", "ZD", "Zadarska");
		super.addEntity("20", "ZG", "ZG", "Zagrebačka ");
		super.addEntity("21", "GZ", "GZ", "Grad Zagreb");
		
		
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
