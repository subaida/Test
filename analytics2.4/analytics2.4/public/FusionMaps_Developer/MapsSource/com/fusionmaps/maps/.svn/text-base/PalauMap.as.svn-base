import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PalauMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PalauMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PalauMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("PW.AM", "AM", "AM", "Aimeliik");		
		super.addEntity("PW.AR", "AR", "AR", "Airai");
		super.addEntity("PW.AN", "AN", "AN", "Angaur");		
		super.addEntity("PW.HA", "HA", "HA", "Hatohobei");
		super.addEntity("PW.KA", "KA", "KA", "Kayangal");		
		super.addEntity("PW.KO", "KO", "KO", "Koror");
		super.addEntity("PW.ME", "ME", "ME", "Melekeok");		
		super.addEntity("PW.ND", "ND", "ND", "Ngaraard");
		super.addEntity("PW.NC", "NC", "NC", "Ngarchelong");		
		super.addEntity("PW.NM", "NM", "NM", "Ngardmau");
		super.addEntity("PW.NP", "NP", "NP", "Ngatpang");		
		super.addEntity("PW.NS", "NS", "NS", "Ngchesar");
		super.addEntity("PW.NL", "NL", "NL", "Ngeremlengui");
		super.addEntity("PW.NW", "NW", "NW", "Ngiwal");		
		super.addEntity("PW.PE", "PE", "PE", "Peleliu");
		super.addEntity("PW.SO", "SO", "SO", "Sonsorol");
				
		
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
