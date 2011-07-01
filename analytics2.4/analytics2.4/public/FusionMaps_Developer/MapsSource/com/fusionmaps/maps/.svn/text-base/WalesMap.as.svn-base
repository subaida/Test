import com.fusionmaps.core.Map;
class com.fusionmaps.maps.WalesMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "WalesMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function WalesMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "BG", "BG", "Blaenau Gwent");
		super.addEntity("02", "BB", "BB", "Bridgend");
		super.addEntity("03", "CP", "CP", "Caerphilly");
		super.addEntity("04", "CA", "CA", "Cardiff");
		super.addEntity("05", "CI", "CI", "Carmarthenshire");
		super.addEntity("06", "CG", "CG", "Ceredigion");
		super.addEntity("07", "CW", "CW", "Conwy");
		super.addEntity("08", "DB", "DB", "Denbighshire");
		super.addEntity("09", "FL", "FL", "Flintshire");
		super.addEntity("10", "GD", "GD", "Gwynedd");
		super.addEntity("11", "AY", "AY", "Isle of Anglesey");
		super.addEntity("12", "MM", "MM", "Monmouthshire");
		super.addEntity("13", "MT", "MT", "Merthyr Tydfil");
		super.addEntity("14", "NP", "NP", "Neath Port Talbot");
		super.addEntity("15", "NO", "NO", "Newport");
		super.addEntity("16", "PE", "PE", "Pembrokeshire");
		super.addEntity("17", "PO", "PO", "Powys");
		super.addEntity("18", "RT", "RT", "Rhondda Cynon Taff");
		super.addEntity("19", "SW", "SW", "Swansea");
		super.addEntity("20", "TF", "TF", "Torfaen");
		super.addEntity("21", "VG", "VG", "Vale of Glamorgan");
		super.addEntity("22", "WX", "WX", "Wrexham");
		
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
