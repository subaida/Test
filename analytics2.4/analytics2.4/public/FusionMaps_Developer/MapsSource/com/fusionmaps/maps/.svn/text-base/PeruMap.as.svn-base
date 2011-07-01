import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PeruMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PeruMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PeruMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AMA", "AMA", "Amazonas");
		super.addEntity("02", "ANC", "ANC", "Ancash");
		super.addEntity("03", "APU", "APU", "Apurimac");
		super.addEntity("04", "ARE", "ARE", "Arequipa");
		super.addEntity("05", "AYA", "AYA", "Ayacucho");
		super.addEntity("06", "CAJ", "CAJ", "Cajamarca");
		super.addEntity("07", "CAL", "CAL", "Callao");
		super.addEntity("08", "CUS", "CUS", "Cusco");
		super.addEntity("09", "HUV", "HUV", "Huancavelica");
		super.addEntity("10", "HUC", "HUC", "Huanuco");
		super.addEntity("11", "ICA", "ICA", "Ica");
		super.addEntity("12", "JUN", "JUN", "Junin");
		super.addEntity("13", "LAL", "LAL", "La Libertad");
		super.addEntity("14", "LAM", "LAM", "Lambayeque");
		super.addEntity("26", "LP", "LP", "Lima Metropolitan");
		super.addEntity("15", "LIM", "LIM", "Lima");
		super.addEntity("16", "LOR", "LOR", "Loreto");
		super.addEntity("17", "MDD", "MDD", "Madre de Dios");
		super.addEntity("18", "MOQ", "MOQ", "Moquegua");
		super.addEntity("19", "PAS", "PAS", "Pasco");
		super.addEntity("20", "PIU", "PIU", "Piura");
        super.addEntity("21", "PUN", "PUN", "Puno");
        super.addEntity("22", "SAM", "SAM", "San Martin");
        super.addEntity("23", "TAC", "TAC", "Tacna");
        super.addEntity("24", "TUM", "TUM", "Tumbes");
        super.addEntity("25", "UCA", "UCA", "Ucayali");
        
		 
		

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
