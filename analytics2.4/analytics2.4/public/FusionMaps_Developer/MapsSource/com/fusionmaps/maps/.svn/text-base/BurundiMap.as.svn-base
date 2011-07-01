import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BurundiMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BurundiMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BurundiMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("BI.BB", "BB", "BB", "Bubanza");
		super.addEntity("BI.BM", "BM", "BM", "Bujumbura Mairie");
		super.addEntity("BI.BU", "BU", "BU", "Bujumbura Rural");
		super.addEntity("BI.BR", "BR", "BR", "Bururi");
		super.addEntity("BI.CA", "CA", "CA", "Cankuzo");
		super.addEntity("BI.CI", "CI", "CI", "Cibitoke");
		super.addEntity("BI.GI", "GI", "GI", "Gitega");
		super.addEntity("BI.KR", "KR", "KR", "Karuzi");
		super.addEntity("BI.KY", "KY", "KY", "Kayanza");
		super.addEntity("BI.KI", "KI", "KI", "Kirundo");
		super.addEntity("BI.MA", "MA", "MA", "Makamba");
		super.addEntity("BI.MV", "MV", "MV", "Muramvya");
		super.addEntity("BI.MY", "MY", "MY", "Muyinga");
		super.addEntity("BI.MW", "MW", "MW", "Mwaro");
		super.addEntity("BI.NG", "NG", "NG", "Ngozi");
		super.addEntity("BI.RT", "RT", "RT", "Rutana");
		super.addEntity("BI.RY", "RY", "RY", "Ruyigi");
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
