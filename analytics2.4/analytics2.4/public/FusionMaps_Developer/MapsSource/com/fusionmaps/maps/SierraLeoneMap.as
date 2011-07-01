import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SierraLeoneMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SierraLeoneMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SierraLeoneMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("SL.SO.BO", "BO", "BO", "Bo");
		super.addEntity("SL.NO.BM", "BM", "BM", "Bombali");
		super.addEntity("SL.SO.BN","BN","BN","Bonthe");
		super.addEntity("SL.EA.KL", "KL", "KL", "Kailahun");
		super.addEntity("SL.NO.KM", "KM", "KM", "Kambia");
		super.addEntity("SL.EA.KE", "KE", "KE", "Kenema");
		super.addEntity("SL.NO.KD", "KD", "KD", "Koinadugu");
		super.addEntity("SL.EA.KN", "KN", "KN", "Kono");
		super.addEntity("SL.SO.MO", "MO", "MO", "Moyamba");
		super.addEntity("SL.NO.PL", "PL", "PL", "Port Loko");
		super.addEntity("SL.SO.PU", "PU", "PU", "Pujehun");
		super.addEntity("SL.NO.TO", "TO", "TO", "Tonkolili");
		super.addEntity("SL.WE.WR", "WR", "WR", "Western Area Rural ");
		super.addEntity("SL.WE.WU", "WU", "WU", "Western Area Urban");
		
		
		
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
