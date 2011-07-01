import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PapuaNewGuineaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PapuaNewGuineaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PapuaNewGuineaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("PG.CE", "CE", "CE", "Central");
		super.addEntity("PG.CH", "CH", "CH", "Chimbu");
		super.addEntity("PG.EH", "EH", "EH", "Eastern Highlands");
		super.addEntity("PG.EN", "EN", "EN", "East New Britain");
		super.addEntity("PG.ES", "ES", "ES", "East Sepik");
		super.addEntity("PG.EG", "EG", "EG", "Enga");
		super.addEntity("PG.GU", "GU", "GU", "Gulf");
		super.addEntity("PG.MD", "MD", "MD", "Madang");
		super.addEntity("PG.MN", "MN", "MN", "Manus");
		super.addEntity("PG.MB", "MB", "MB", "Milne Bay");
		super.addEntity("PG.MR", "MR", "MR", "Morobe");
		super.addEntity("PG.NC", "NC", "NC", "National Capital District");
		super.addEntity("PG.NI", "NI", "NI", "New Ireland");
		super.addEntity("PG.NO", "NO", "NO", "Northern");
		super.addEntity("PG.NS", "NS", "NS", "North Solomons");
		super.addEntity("PG.SA", "SA", "SA", "Sanduan");
		super.addEntity("PG.SH", "SH", "SH", "Southern Highlands");
		super.addEntity("PG.WE", "WE", "WE", "Western");
		super.addEntity("PG.WH", "WH", "WH", "Western Highlands");
		super.addEntity("PG.WN", "WN", "WN", "West New Britain");
		
		
		
		
	
		
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
