import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SerbiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SerbiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SerbiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("RS.BG", "BG", "BG", "Belgrade");
		super.addEntity("RS.BO", "BO", "BO", "Bor");
		super.addEntity("RS.BR", "BR", "BR", "Branicevo");
		super.addEntity("RS.SD", "SD", "SD", "Central Banat");
		super.addEntity("RS.PD", "PD", "PD", "Danube");
		super.addEntity("RS.JA", "JA", "JA", "Jablanica");
		super.addEntity("RS.KB", "KB", "KB", "Kolubara");
		super.addEntity("RS.KO", "KO", "KO", "Kosovski");
		super.addEntity("RS.KM", "KM", "KM", "Kosovsko Mitrovacki");
		super.addEntity("RS.KP", "KP", "KP", "Kosovsko Pomoravsk");
		super.addEntity("RS.MA", "MA", "MA", "Macva");
		super.addEntity("RS.MR", "MR", "MR", "Morava");
		super.addEntity("RS.NS", "NS", "NS", "Nisava");
		super.addEntity("RS.SC", "SC", "SC", "North Backa");
		super.addEntity("RS.SN", "SN", "SN", "North Banat");
		super.addEntity("RS.PC", "PC", "PC", "Pcinja");
		super.addEntity("RS.PE", "PE", "PE", "Pecki");
		super.addEntity("RS.PI", "PI", "PI", "Pirot");
		super.addEntity("RS.PM", "PM", "PM", "Pomoravlje");
		super.addEntity("RS.PZ", "PZ", "PZ", "Prizrenski");
		super.addEntity("RS.RN", "RN", "RN", "Rasina");
		super.addEntity("RS.RS", "RS", "RS", "Raska");
		super.addEntity("RS.JC", "JC", "JC", "South Backa");
		super.addEntity("RS.JN", "JN", "JN", "South Banat");
		super.addEntity("RS.SM", "SM", "SM", "Srem");
		super.addEntity("RS.SU", "SU", "SU", "Sumadija");
		super.addEntity("RS.TO", "TO", "TO", "Toplica");
		super.addEntity("RS.ZC", "ZC", "ZC", "West Backa");
		super.addEntity("RS.ZJ", "ZJ", "ZJ", "Zajecar");
		super.addEntity("RS.ZL", "ZL", "ZL", "Zlatibor");
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
