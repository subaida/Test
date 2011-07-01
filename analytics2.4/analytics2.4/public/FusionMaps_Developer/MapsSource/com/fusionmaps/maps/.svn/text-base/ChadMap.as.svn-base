import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ChadMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ChadMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ChadMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("TD.BA", "BA", "BA", "Batha");
		super.addEntity("TD.BT", "BT", "BT", "Borkou-Ennedi-Tibesti");
		super.addEntity("TD.CG", "CG", "CG", "Chari-Baguirmi");
		super.addEntity("TD.GR", "GR", "GR", "Guera");
		super.addEntity("TD.HD", "HD", "HD", "Hadjer-Lamis");
		super.addEntity("TD.KA", "KA", "KA", "Kanem");
		super.addEntity("TD.LC", "LC", "LC", "Lac");
		super.addEntity("TD.LO", "LO", "LO", "Logone Occidental");
		super.addEntity("TD.LR", "LR", "LR", "Logone Oriental");
		super.addEntity("TD.MA", "MA", "MA", "Mandoul");
		super.addEntity("TD.ME", "ME", "ME", "Mayo-Kebbi Est");
		super.addEntity("TD.MW", "MW", "MW", "Mayo-Kebbi Ouest");
		super.addEntity("TD.MO", "MO", "MO", "Moyen-Chari");
		super.addEntity("TD.OD", "OD", "OD", "Ouaddaï");
		super.addEntity("TD.SA", "SA", "SA", "Salamat");
		super.addEntity("TD.TA", "TA", "TA", "Tandjile");
		super.addEntity("TD.BI", "BI", "BI", "Wadi Fira");
		super.addEntity("TD.NJ", "NJ", "NJ", "Ville De NDjamena");
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
