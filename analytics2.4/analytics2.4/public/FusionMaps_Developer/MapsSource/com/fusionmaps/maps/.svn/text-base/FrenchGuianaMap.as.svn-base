import com.fusionmaps.core.Map;
class com.fusionmaps.maps.FrenchGuianaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "FrenchGuianaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function FrenchGuianaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("GF.SL.AP", "AP", "AP", "Apatou");
		super.addEntity("GF.SL.AY", "AY", "AY", "Awala Yalimapo");
		super.addEntity("GF.CY.CM", "CM", "CM", "Camopi");
		super.addEntity("GF.CY.CY", "CY", "CY", "Cayenne");
		super.addEntity("GF.SL.GS", "GS", "GS", "Grand Santi");
		super.addEntity("GF.CY.IR", "IR", "IR", "Iracoubo");
		super.addEntity("GF.CY.KR", "KR", "KR", "Kourou");
		super.addEntity("GF.CY.MC", "MC", "MC", "Macouria");
		super.addEntity("GF.SL.MN", "MN", "MN", "Mana");
		super.addEntity("GF.SL.MP", "MP", "MP", "Maripasoula");
		super.addEntity("GF.CY.MY", "MY", "MY", "Matoury");
		super.addEntity("GF.CY.MT", "MT", "MT", "Montsinery Tonnegrande");
		super.addEntity("GF.CY.OU", "OU", "OU", "Ouanary");
		super.addEntity("GF.SL.PA", "PA", "PA", "Papaichton");
		super.addEntity("GF.CY.RK", "RK", "RK", "Regina");
		super.addEntity("GF.CY.RM", "RM", "RM", "Remire Montjoly");
		super.addEntity("GF.CY.RO", "RO", "RO", "Roura");
		super.addEntity("GF.CY.SE", "SE", "SE", "Saint Elie");
		super.addEntity("GF.CY.SG", "SG", "SG", "Saint Georges");
		super.addEntity("GF.SL.SL", "SL", "SL", "Saint Laurent");
		super.addEntity("GF.SL.SA", "SA", "SA", "Saul");
		super.addEntity("GF.CY.SI", "SI", "SI", "Sinnamary");
		
		

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
