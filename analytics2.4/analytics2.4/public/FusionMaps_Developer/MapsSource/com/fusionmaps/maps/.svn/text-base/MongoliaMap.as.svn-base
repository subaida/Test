import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MongoliaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MongoliaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MongoliaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("MN.AR", "AR", "AR", "Arkhangai");
		super.addEntity("MN.BH", "BH", "BH", "Bayankhongor");
		super.addEntity("MN.BO", "BO", "BO", "Bayan Olgii");
		super.addEntity("MN.BU", "BU", "BU", "Bulgan");
		super.addEntity("MN.DA", "DA", "DA", "Darkhan Uul");
		super.addEntity("MN.DD", "DD", "DD", "Dornod");
		super.addEntity("MN.DG", "DG", "DG", "Dornogovi");
		super.addEntity("MN.DU", "DU", "DU", "Dundgovi");
		super.addEntity("MN.GA", "GA", "GA", "Govi Altai");
		super.addEntity("MN.GS", "GS", "GS", "Govisumber");
		super.addEntity("MN.HN", "HN", "HN", "Khentii");
		super.addEntity("MN.HD", "HD", "HD", "Khovd");
		super.addEntity("MN.HG", "HG", "HG", "Khovsgol");
		super.addEntity("MN.OG", "OG", "OG", "Omnogovi");
		super.addEntity("MN.ER", "ER", "ER", "Orkhon");
		super.addEntity("MN.OH", "OH", "OH", "Ovorkhangai");
		super.addEntity("MN.SL", "SL", "SL", "Selenge");
		super.addEntity("MN.SB", "SB", "SB", "Sukhbaatar");
		super.addEntity("MN.TO", "TO", "TO", "Tov");
		super.addEntity("MN.UB", "UB", "UB", "Ulan Bator");
		super.addEntity("MN.UV", "UV", "UV", "Uvs");
		super.addEntity("MN.DZ", "DZ", "DZ", "Zavkhan");
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
