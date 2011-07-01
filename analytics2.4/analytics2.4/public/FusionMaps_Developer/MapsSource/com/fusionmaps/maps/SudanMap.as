import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SudanMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SudanMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SudanMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("SD.GZ", "GZ", "GZ", "Al Jazirah (Gezira)");
		super.addEntity("SD.GD", "GD", "GD", "Al Qadarif (Gedarif)");
		super.addEntity("SD.BN", "BN", "BN", "Blue Nile");
		super.addEntity("SD.BG", "BG", "BG", "Central Equatoria");
		super.addEntity("SD.EE", "EE", "EE", "East Equatoria");
		super.addEntity("SD.JG", "JG", "JG", "Jungoli");
		super.addEntity("SD.KA", "KA", "KA", "Kassala");
		super.addEntity("SD.KH", "KH", "KH", "Khartoum");
		super.addEntity("SD.EB", "EB", "EB", "Lakes");
		super.addEntity("SD.NB", "NB", "NB", "North Bahr Al Ghazal");
		super.addEntity("SD.ND", "ND", "ND", "North Darfur");
		super.addEntity("SD.NK", "NK", "NK", "North Kurdufan");
		super.addEntity("SD.NO", "NO", "NO", "Northern");
		super.addEntity("SD.RS", "RS", "RS", "Red Sea");
		super.addEntity("SD.RN", "RN", "RN", "River Nile");
		super.addEntity("SD.SI", "SI", "SI", "Sennar");
		super.addEntity("SD.SD", "SD", "SD", "South Darfur");
		super.addEntity("SD.SK", "SK", "SK", "South Kurdufan");
		super.addEntity("SD.WH", "WH", "WH", "Unity");
		super.addEntity("SD.UN", "UN", "UN", "Upper Nile");
		super.addEntity("SD.WR", "WR", "WR", "Warab");
		super.addEntity("SD.WB", "WB", "WB", "West Bahr Al Ghazal");
		super.addEntity("SD.WD", "WD", "WD", "West Darfur");
		super.addEntity("SD.WE", "WE", "WE", "West Equatoria");
		super.addEntity("SD.WK", "WK", "WK", "West Kurdufan");
		super.addEntity("SD.WN", "WN", "WN", "White Nile");
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
