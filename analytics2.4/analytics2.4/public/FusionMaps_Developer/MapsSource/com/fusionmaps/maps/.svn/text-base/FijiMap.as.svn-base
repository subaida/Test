import com.fusionmaps.core.Map;
class com.fusionmaps.maps.FijiMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "FijiMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function FijiMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("FJ.WE.BA", "BA", "BA", "Ba");
		super.addEntity("FJ.NO.BU", "BU", "BU", "Bua");
		super.addEntity("FJ.NO.CK", "CK", "CK", "Cakaudrova");
		super.addEntity("FJ.EA.KD", "KD", "KD", "Kadavu");
		super.addEntity("FJ.EA.LU", "LU", "LU", "Lau");
		super.addEntity("EJ.WE.LT", "LT", "LT", "Lautoka");
		super.addEntity("EJ.EA.LM", "LM", "LM", "Lomaiviti");
		super.addEntity("FJ.NO.MC", "MC", "MC", "Macuata");
		super.addEntity("FJ.WE.NN", "NN", "NN", "Nadroga-Navosa");
		super.addEntity("FJ.WE.ND", "ND", "ND", "Nandi");
		super.addEntity("FJ.CE.NT", "NT", "NT", "Naitasiri");
		super.addEntity("FJ.CE.NM", "NM", "NM", "Namosi");
		super.addEntity("FJ.WE.RA", "RA", "RA", "Ra");
		super.addEntity("FJ.CE.RW", "RW", "RW", "Rewa");
		super.addEntity("FJ.CE.SR", "SR", "SR", "Serua");
		super.addEntity("FJ.CE.TL", "TL", "TL", "Tailevu");
		super.addEntity("FJ.TH.EA", "EA", "EA", "Tholo East");
		super.addEntity("FJ.TH.NO", "NO", "NO", "Tholo North");
		super.addEntity("FJ.TH.WE", "WE", "WE", "Tholo west");
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
