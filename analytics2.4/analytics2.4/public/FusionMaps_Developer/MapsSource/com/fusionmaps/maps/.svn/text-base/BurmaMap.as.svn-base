import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BurmaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BurmaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BurmaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String  ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("MM.AY", "AY", "AY", "Ayeyarwady Division");
		super.addEntity("MM.BA", "BA", "BA", "Bago Division");
		super.addEntity("MM.CH", "CH", "CH", "Chin State");
		super.addEntity("MM.KC", "KC", "KC", "Kachin State");
		super.addEntity("MM.KH", "KH", "KH", "Kayah State");
		super.addEntity("MM.KN", "KN", "KN", "Kayin State");
		super.addEntity("MM.MG", "MG", "MG", "Magway Division");
		super.addEntity("MM.MD", "MD", "MD", "Mandalay Division");
		super.addEntity("MM.MO", "MO", "MO", "Mon State");
		super.addEntity("MM.RA", "RA", "RA", "Rakhine State");
		super.addEntity("MM.SA", "SA", "SA", "Sagaing Division");
		super.addEntity("MM.SH", "SH", "SH", "Shan State");
		super.addEntity("MM.TN", "TN", "TN", "Tanintharyi Division");
		super.addEntity("MM.YA", "YA", "YA", "Yangon Division");
		
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
