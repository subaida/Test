import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NauruMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NauruMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NauruMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("NR.AI", "AI", "AI", "Aiwo");
		super.addEntity("NR.AB", "AB", "AB", "Anabar");
		super.addEntity("NR.AT", "AT", "AT", "Anetan");
		super.addEntity("NR.AR", "AR", "AR", "Anibare");
		super.addEntity("NR.BA", "BA", "BA", "Baiti");
		super.addEntity("NR.BO", "BO", "BO", "Boe");
		super.addEntity("NR.BU", "BU", "BU", "Buada");
		super.addEntity("NR.DE", "DE", "DE", "Denigomodu");
		super.addEntity("NR.EW", "EW", "EW", "Ewa");
		super.addEntity("NR.IJ", "IJ", "IJ", "Ijuw");
		super.addEntity("NR.ME", "ME", "ME", "Meneng");
		super.addEntity("NR.NI", "NI", "NI", "Nibok");
		super.addEntity("NR.UA", "UA", "UA", "Uaboe");
		super.addEntity("NR.YA", "YA", "YA", "Yaren");
		
		
		
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
