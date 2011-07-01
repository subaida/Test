import com.fusionmaps.core.Map;
class com.fusionmaps.maps.EthiopiaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "EthiopiaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function EthiopiaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("ET.AA", "AA", "AA", "Addis Ababa");		
		super.addEntity("ET.AF", "AF", "AF", "Afar");		
		super.addEntity("ET.AM", "AM", "AM", "Amhara");		
		super.addEntity("ET.BE", "BE", "BE", "Benshangul Gumaz");		
		super.addEntity("ET.DD", "DD", "DD", "Dire Dawa");		
		super.addEntity("ET.GA", "GA", "GA", "Gambela Peoples");		
	    super.addEntity("ET.HA", "HA", "HA", "Harari People");
		super.addEntity("ET.OR", "OR", "OR", "Oromia");
		super.addEntity("ET.SO", "SO", "SO", "Somali");
		super.addEntity("ET.SN", "SN", "SN", "Southern (Nations,Nationalities and People's Region)");
		super.addEntity("ET.TI", "TI", "TI", "Tigray");
		
		
		
		
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
