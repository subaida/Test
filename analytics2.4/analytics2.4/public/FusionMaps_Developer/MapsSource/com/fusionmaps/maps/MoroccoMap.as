import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MoroccoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MoroccoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MoroccoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("MA.CO", "CO", "CO", "Chaouia-Ouardigha");
		super.addEntity("MA.DA ","DA", "DA", "Doukkala-Abda");
		super.addEntity("MA.FB", "FB", "FB", "Fès Boulemane");
		super.addEntity("MA.GB", "GB", "GB", "Gharb Chrarda Béni Hssen");
		super.addEntity("MA.GC", "GC", "GC", "Grand Casablanca");
		super.addEntity("MA.GE", "GE", "GE", "Guelmim Es Semara");
		super.addEntity("MA.LB", "LB", "LB", "Laâyoune Boujdour Sakia El Hamra");
		super.addEntity("MA.MK", "MK", "MK", "Marrakech Tensift Al Haouz");
		super.addEntity("MA.MT", "MT", "MT", "Meknès Tafilalet");
		super.addEntity("MA.OR", "OR", "OR", "Oriental");
		super.addEntity("MA.OL", "OL", "OL", "Oued Ed Dahab Lagouira");
		super.addEntity("MA.RZ", "RZ", "RZ", "Rabat Salé Zemmour Zaer");
		super.addEntity("MA.SM", "SM", "SM", "Souss Massa Draâ");
		super.addEntity("MA.TD", "TD", "TD", "Tadla Azilal");
		super.addEntity("MA.TO", "TO", "TO", "Tanger Tétouan");
		super.addEntity("MA.TH", "TH", "TH", "Taza Al Hoceima Taounate");
		
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
