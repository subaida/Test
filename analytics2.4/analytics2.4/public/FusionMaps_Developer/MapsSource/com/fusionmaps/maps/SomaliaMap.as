import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SomaliaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SomaliaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SomaliaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("SO.AW", "AW", "AW", "Awdal");
		super.addEntity("SO.BK", "BK", "BK", "Bakool");
		super.addEntity("SO.BN", "BN", "BN", "Banaadir");
		super.addEntity("SO.BR", "BR", "BR", "Bari");
		super.addEntity("SO.BY", "BY", "BY", "Bay");
		super.addEntity("SO.GA", "GA", "GA", "Galguduud");
		super.addEntity("SO.GE", "GE", "GE", "Gedo");
		super.addEntity("SO.HI", "HI", "HI", "Hiiraan");
		super.addEntity("SO.JD", "JD", "JD", "Jubbada Dhexe");
		super.addEntity("SO.JH", "JH", "JH", "Jubbada Hoose");
		super.addEntity("SO.MU", "MU", "MU", "Mudug");
		super.addEntity("SO.NU", "NU", "NU", "Nugaal");
		super.addEntity("SO.SA", "SA", "SA", "Sanaag");
		super.addEntity("SO.SD", "SD", "SD", "Shabeellaha Dhexe");
		super.addEntity("SO.SH", "SH", "SH", "Shabeellaha Hoose");
		super.addEntity("SO.SO", "SO", "SO", "Sool");
		super.addEntity("SO.TO", "TO", "TO", "Togdheer");
		super.addEntity("SO.WO", "WO", "WO", "Woqooyi Galbeed");
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
