import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MalawiMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MalawiMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MalawiMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("MW.DE", "DE", "DE", "Dedza");
		super.addEntity("MW.DO", "DO", "DO", "Dowa");
		super.addEntity("MW.KS", "KS", "KS", "Kasungu");
		super.addEntity("MW.LI", "LI", "LI", "Lilongwe");
		super.addEntity("MW.MC", "MC", "MC", "Mchinji");
		super.addEntity("MW.NK", "NK", "NK", "Nkhotakota");
		super.addEntity("MW.NU", "NU", "NU", "Ntcheu");
		super.addEntity("MW.NI", "NI", "NI", "Ntchisi");
		super.addEntity("MW.SA", "SA", "SA", "Salima");
		super.addEntity("MW.CT", "CT", "CT", "Chitipa");
		super.addEntity("MW.KR", "KR", "KR", "Karonga");
		super.addEntity("MW.LK", "LK", "LK", "Likoma");
		super.addEntity("MW.MZ", "MZ", "MZ", "Mzimba");
		super.addEntity("MW.NA", "NA", "NA", "Nkhata Bay");
		super.addEntity("MW.RU", "RU", "RU", "Rumphi");
		super.addEntity("MW.BA", "BA", "BA", "Balaka");
		super.addEntity("MW.BL", "BL", "BL", "Blantyre");
		super.addEntity("MW.CK", "CK", "CK", "Chikwawa");
		super.addEntity("MW.CR", "CR", "CR", "Chiradzulu");
		super.addEntity("MW.MA", "MA", "MA", "Machinga");
		super.addEntity("MW.MG", "MG", "MG", "Mangochi");
		super.addEntity("MW.MJ", "MJ", "MJ", "Mulanje");
		super.addEntity("MW.MW", "MW", "MW", "Mwanza");
		super.addEntity("MW.NS", "NS", "NS", "Nsanje");
		super.addEntity("MW.TH", "TH", "TH", "Thyolo");
		super.addEntity("MW.PH", "PH", "PH", "Phalombe");
		super.addEntity("MW.ZO", "ZO", "ZO", "Zomba");
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
