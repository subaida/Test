import com.fusionmaps.core.Map;
class com.fusionmaps.maps.TanzaniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "TanzaniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function TanzaniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("TZ.AS", "AS", "AS", "Arusha");		
		super.addEntity("TZ.DS", "DS", "DS", "Dar es Salaam");		
		super.addEntity("TZ.DO", "DO", "DO", "Dodoma");		
		super.addEntity("TZ.IR", "IR", "IR", "Iringa");		
		super.addEntity("TZ.KR", "KR", "KR", "Kagera");		
		super.addEntity("TZ.KM", "KM", "KM", "Kigoma");		
	    super.addEntity("TZ.KL", "KL", "KL", "Kilimanjaro");
		super.addEntity("TZ.LI", "LI", "LI", "Lindi");
		super.addEntity("TZ.MY", "MY", "MY", "Manyara");
		super.addEntity("TZ.MA", "MA", "MA", "Mara");
		super.addEntity("TZ.MB", "MB", "MB", "Mbeya");
		super.addEntity("TZ.MO", "MO", "MO", "Morogoro");
		super.addEntity("TZ.MT", "MT", "MT", "Mtwara");
		super.addEntity("TZ.MW", "MW", "MW", "Mwanza");
		super.addEntity("TZ.PN", "PN", "PN", "Pemba North");
		super.addEntity("TZ.PS", "PS", "PS", "Pemba South");
		super.addEntity("TZ.PW", "PW", "PW", "Pwani");
		super.addEntity("TZ.RK", "RK", "RK", "Rukwa");
		super.addEntity("TZ.RV", "RV", "RV", "Ruvuma");
		super.addEntity("TZ.SH", "SH", "SH", "Shinyanga");
		super.addEntity("TZ.SD", "SD", "SD", "Singida");
		super.addEntity("TZ.TB", "TB", "TB", "Tabora");
		super.addEntity("TZ.TN", "TN", "TN", "Tanga");
		super.addEntity("TZ.ZN", "ZN", "ZN", "Zanzibar North");
		super.addEntity("TZ.ZS", "ZS", "ZS", "Zanzibar Central and South");
		super.addEntity("TZ.ZW", "ZW", "ZW", "Zanzibar West (Urban)");
		
		
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
