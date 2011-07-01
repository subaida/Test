import com.fusionmaps.core.Map;
class com.fusionmaps.maps.KazakhstanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "KazakhstanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function KazakhstanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("KZ.AA", "AA", "AA", "Almaty");
		super.addEntity("KZ.AC", "AC", "AC", "Almaty City");
		super.addEntity("KZ.AM", "AM", "AM", "Aqmola");
		super.addEntity("KZ.AT", "AT", "AT", "Aqtobe");
		super.addEntity("KZ.AS", "AS", "AS", "Astana");
		super.addEntity("KZ.AR", "AR", "AR", "Atyrau");
		super.addEntity("KZ.BY", "BY", "BY", "Bayqonyr");
		super.addEntity("KZ.EK", "EK", "EK", "East Kazakhstan");
		super.addEntity("KZ.MG", "MG", "MG", "Mangghystau");
		super.addEntity("KZ.NK", "NK", "NK", "North Kazakhstan");
		super.addEntity("KZ.PA", "PA", "PA", "Pavlodar");
		super.addEntity("KZ.QG", "QG", "QG", "Qaraghandy");
		super.addEntity("KZ.QS", "QS", "QS", "Qostanay");
		super.addEntity("KZ.QO", "QO", "QO", "Qyzylorda");
		super.addEntity("KZ.SK", "SK", "SK", "South Kazakhstan");
		super.addEntity("KZ.WK", "WK", "WK", "West Kazakhstan");
		super.addEntity("KZ.ZM", "ZM", "ZM", "Zhambyl");
		
		
		

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
