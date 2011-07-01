import com.fusionmaps.core.Map;
class com.fusionmaps.maps.QatarMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "QatarMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function QatarMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("QA.DA", "DA", "DA", "Ad Dawhah");
		super.addEntity("QA.GH", "GH", "GH", "Al Ghuwariyah");
		super.addEntity("QA.JU", "JU", "JU", "Al Jumaliyah");
		super.addEntity("QA.KH", "KH", "KH", "Al Khawr");
		super.addEntity("QA.WA", "WA", "WA", "Al Wakrah");
		super.addEntity("QA.RA", "RA", "RA", "Ar Rayyan");
		super.addEntity("QA.JB", "JB", "JB", "Jariyan Al Batnah");
		super.addEntity("QA.MS", "MS", "MS", "Madinat Ach Shamal");
		super.addEntity("QA.US", "US", "US", "Umm Salal");
		super.addEntity("QA.ME", "ME", "ME", "Mesaieed");
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
