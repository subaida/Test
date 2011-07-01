import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CoteDivoireMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CoteDivoireMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CoteDivoireMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("CI.AG", "AG", "AG", "Agneby");		
		super.addEntity("CI.BF", "BF", "BF", "Bafing");		
		super.addEntity("CI.BS", "BS", "BS", "Bas Sassandra");		
		super.addEntity("CI.DE", "DE", "DE", "Denguele");		
		super.addEntity("CI.DH", "DH", "DH", "Dix Huit Montagnes");		
		super.addEntity("CI.FR", "FR", "FR", "Fromager");		
	    super.addEntity("CI.HT", "HT", "HT", "Haut Sassandra");
		super.addEntity("CI.LC", "LC", "LC", "Lacs");
		super.addEntity("CI.LG", "LG", "LG", "Lagunes");
		super.addEntity("CI.MR", "MR", "MR", "Marahoue");
		super.addEntity("CI.MV", "MV", "MV", "Moyen Cavally");
		super.addEntity("CI.MC", "MC", "MC", "Moyen Comoe");
		super.addEntity("CI.NC", "NC", "NC", "N'zi Comoe");
		super.addEntity("CI.SV", "SV", "SV", "Savanes");
		super.addEntity("CI.SB", "SB", "SB", "Sud Bandama");
		super.addEntity("CI.SC", "SC", "SC", "Sud Comoe");
		super.addEntity("CI.VB", "VB", "VB", "Vallee du Bandama");
		super.addEntity("CI.WR", "WR", "WR", "Worodougou");
		super.addEntity("CI.ZA", "ZA", "ZA", "Zanzan");
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
