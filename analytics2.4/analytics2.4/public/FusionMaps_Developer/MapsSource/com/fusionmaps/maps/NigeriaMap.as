import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NigeriaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NigeriaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NigeriaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("NG.AB", "AB", "AB", "Abia");
		super.addEntity("NG.FC", "FC", "FC", "Abuja");
		super.addEntity("NG.AD", "AD", "AD", "Adamawa");
		super.addEntity("NG.AK", "AK", "AK", "Akwa Ibom");
		super.addEntity("NG.AN", "AN", "AN", "Anambra");
		super.addEntity("NG.BA", "BA", "BA", "Bauchi");
		super.addEntity("NG.BY", "BY", "BY", "Bayelsa");
		super.addEntity("NG.BE", "BE", "BE", "Benue");
		super.addEntity("NG.BO", "BO", "BO", "Borno");
		super.addEntity("NG.CR", "CR", "CR", "Cross River");
		super.addEntity("NG.DE", "DE", "DE", "Delta");
		super.addEntity("NG.EB", "EB", "EB", "Ebonyi");
		super.addEntity("NG.ED", "ED", "ED", "Edo");
		super.addEntity("NG.EK", "EK", "EK", "Ekiti");
		super.addEntity("NG.EN", "EN", "EN", "Enugu");
		super.addEntity("NG.GO", "GO", "GO", "Gombe");
		super.addEntity("NG.IM", "IM", "IM", "Imo");
		super.addEntity("NG.JI", "JI", "JI", "Jigawa");
		super.addEntity("NG.KD", "KD", "KD", "Kaduna");
		super.addEntity("NG.KN", "KN", "KN", "Kano");
		super.addEntity("NG.KT", "KT", "KT", "Katsina");
		super.addEntity("NG.KE", "KE", "KE", "Kebbi");
		super.addEntity("NG.KO", "KO", "KO", "Kogi");
		super.addEntity("NG.KW", "KW", "KW", "Kwara");
		super.addEntity("NG.LA", "LA", "LA", "Lagos");
		super.addEntity("NG.NA", "NA", "NA", "Nassarawa");
		super.addEntity("NG.NI", "NI", "NI", "Niger");
		super.addEntity("NG.OG", "OG", "OG", "Ogun");
		super.addEntity("NG.ON", "ON", "ON", "Ondo");
		super.addEntity("NG.OS", "OS", "OS", "Osun");
		super.addEntity("NG.OY", "OY", "OY", "Oyo");
		super.addEntity("NG.PL", "PL", "PL", "Plateau");
		super.addEntity("NG.RI", "RI", "RI", "Rivers");
		super.addEntity("NG.SO", "SO", "SO", "Sokoto");
		super.addEntity("NG.TA", "TA", "TA", "Taraba");
		super.addEntity("NG.YO", "YO", "YO", "Yobe");
		super.addEntity("NG.ZA", "ZA", "ZA", "Zamfara");
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
