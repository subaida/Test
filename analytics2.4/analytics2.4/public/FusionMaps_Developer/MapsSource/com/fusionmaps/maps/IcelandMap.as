import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IcelandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IcelandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IcelandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("03", "AR", "AR", "Árnessýsla ");
		super.addEntity("04", "AB", "AB", "Austur-Barðastrandarsýsla");
		super.addEntity("05", "AH", "AH", "Austur-Húnavatnssýsla");
		super.addEntity("06", "AS", "AS", "Austur-Skaftafellssýsla");
		super.addEntity("07", "BO", "BO", "Borgarfjarðarsýsla");
		super.addEntity("08", "DA", "DA", "Dalasýsla");
		super.addEntity("09", "EY", "EY", "Eyjafjarðarsýsla");
		super.addEntity("10", "GU", "GU", "Gullbringusýsla");
		super.addEntity("15", "KJ", "KJ", "Kjósarsýsla");
		super.addEntity("17", "MY", "MY", "Mýrasýsla");
		super.addEntity("19", "NI", "NI", "Norður-Ísafjarðarsýsla");
		super.addEntity("20", "NM", "NM", "Norður-Múlasýsla");
		super.addEntity("21", "NO", "NO", "Norður-Þingeyjarsýsla");
		super.addEntity("23", "RA", "RA", "Rangárvallasýsla");
		super.addEntity("28", "SK", "SK", "Skagafjarðarsýsla");
		super.addEntity("29", "SH", "SH", "Snæfellsnes-og Hnappadalssýsla");
		super.addEntity("30", "ST", "ST", "Strandasýsla");
		super.addEntity("31", "SM", "SM", "Suður-Múlasýsla");
		super.addEntity("32", "SU", "SU", "Suður-Þingeyjarsýsla");
        super.addEntity("34", "VB", "VB", "Vestur-Barðastrandarsýsla");
        super.addEntity("35", "VH", "VH", "Vestur-Húnavatnssýsla");
        super.addEntity("36", "VI", "VI", "Vestur-Ísafjarðarsýsla");
        super.addEntity("37", "VS", "VS", "Vestur-Skaftafellssýsla");
        
		 
		

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
