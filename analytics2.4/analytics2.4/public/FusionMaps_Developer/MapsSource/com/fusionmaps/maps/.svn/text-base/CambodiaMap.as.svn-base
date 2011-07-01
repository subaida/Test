import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CambodiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CambodiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CambodiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("KH.OM", "OM", "OM", "Banteay Meanchey");
		super.addEntity("KH.BA", "BA", "BA", "Battambang");
		super.addEntity("KH.KM", "KM", "KM", "Kampong Cham");
		super.addEntity("KH.KG", "KG", "KG", "Kampong Chhnang");
		super.addEntity("KH.KS", "KS", "KS", "Kampong Spe");
		super.addEntity("KH.KT", "KT", "KT", "Kampong Thom");
		super.addEntity("KH.KP", "KP", "KP", "Kampot");
		super.addEntity("KH.KN", "KN", "KN", "Kandal");
		super.addEntity("KH.KK", "KK", "KK", "Koh Kong");
		super.addEntity("KH.KH", "KH", "KH", "Kratie");
		super.addEntity("KH.KB", "KB", "KB", "Kep");
		super.addEntity("KH.MK", "MK", "MK", "Mondulkiri");
		super.addEntity("KH.OC", "OC", "OC", "Oddar Meancheay");
		super.addEntity("KH.PL", "PL", "PL", "Pailin");
		super.addEntity("KH.PP", "PP", "PP", "Phnom Penh");
		super.addEntity("KH.PO", "PO", "PO", "Pursat");
		super.addEntity("KH.PH", "PH", "PH", "Preah Vihear");
		super.addEntity("KH.PY", "PY", "PY", "Prey Veng");
		super.addEntity("KH.RO", "RO", "RO", "Ratanakiri");
		super.addEntity("KH.SI", "SI", "SI", "Siem Reap");
		super.addEntity("KH.KA", "KA", "KA", "Sihanoukville");
		super.addEntity("KH.ST", "ST", "ST", "Stung Treng");
		super.addEntity("KH.SR", "SR", "SR", "Svay Rieng");
		super.addEntity("KH.TA", "TA", "TA", "Takeo");
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
