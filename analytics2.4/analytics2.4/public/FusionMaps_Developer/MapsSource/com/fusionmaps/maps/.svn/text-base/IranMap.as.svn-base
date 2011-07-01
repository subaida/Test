import com.fusionmaps.core.Map;
class com.fusionmaps.maps.IranMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "IranMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function IranMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String){
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
		super.addEntity("IR.AR", "AR", "AR", "Ardebil");
		super.addEntity("IR.BS", "BS", "BS", "Bushehr");
		super.addEntity("IR.CM", "CM", "CM", "Chahar Mahall and Bakhtiari");
		super.addEntity("IR.EA", "EA", "EA", "East Azarbaijan");
		super.addEntity("IR.ES", "ES", "ES", "Esfahan");
		super.addEntity("IR.FA", "FA", "FA", "Fars");
		super.addEntity("IR.GI", "GI", "GI", "Gilan");
		super.addEntity("IR.GO", "GO", "GO", "Golestan");
		super.addEntity("IR.HD", "HD", "HD", "Hamadan");
		super.addEntity("IR.HG", "HG", "HG", "Hormozgan");
		super.addEntity("IR.IL", "IL", "IL", "Ilam");
		super.addEntity("IR.KE", "KE", "KE", "Kerman");
		super.addEntity("IR.BK", "BK", "BK", "Kermanshah");
		super.addEntity("IR.KZ", "KZ", "KZ", "Khuzestan");
		super.addEntity("IR.KB", "KB", "KB", "Kohgiluyeh and Buyer Ahmed");
		super.addEntity("IR.KD", "KD", "KD", "Kordestan");
		super.addEntity("IR.LO", "LO", "LO", "Lorestan");
		super.addEntity("IR.MK", "MK", "MK", "Markazi");
		super.addEntity("IR.MN", "MN", "MN", "Mazandaran");
		super.addEntity("IR.KS", "KS", "KS", "North Khorasan");
		super.addEntity("IR.QZ", "QZ", "QZ", "Qazvin");
		super.addEntity("IR.QM", "QM", "QM", "Qom");
		super.addEntity("IR.KV", "KV", "KV", "Razavi Khorasan");
		super.addEntity("IR.SM", "SM", "SM", "Semnan");
		super.addEntity("IR.SB", "SB", "SB", "Sistan and Baluchestan");
		super.addEntity("IR.KJ", "KJ", "KJ", "South Khorasan");
		super.addEntity("IR.TH", "TH", "TH", "Tehran");
		super.addEntity("IR.WA", "WA", "WA", "West Azarbaijan");
		super.addEntity("IR.YA", "YA", "YA", "Yazd");
		super.addEntity("IR.ZA", "ZA", "ZA", "Zanjan");
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
