import com.fusionmaps.core.Map;
class com.fusionmaps.maps.SriLankaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "SriLankaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function SriLankaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("LK.AP", "AP", "AP", "Ampara");
		super.addEntity("LK.AD", "AD", "AD", "Anuradhapura");
		super.addEntity("LK.BD", "BD", "BD", "Badulla");
		super.addEntity("LK.BC", "BC", "BC", "Batticaloa");
		super.addEntity("LK.CO", "CO", "CO", "Colombo");
		super.addEntity("LK.GL", "GL", "GL", "Galle");
		super.addEntity("LK.GQ", "GQ", "GQ", "Gampaha");
		super.addEntity("LK.HB", "HB", "HB", "Hambantota");
		super.addEntity("LK.JA", "JA", "JA", "Jaffna");
		super.addEntity("LK.KT", "KT", "KT", "Kalutara");
		super.addEntity("LK.KY", "KY", "KY", "Kandy");
		super.addEntity("LK.KE", "KE", "KE", "Kegalle");
		super.addEntity("LK.KL", "KL", "KL", "Kilinochchi");
		super.addEntity("LK.KG", "KG", "KG", "Kurunegala");
		super.addEntity("LK.MB", "MB", "MB", "Mannar");
		super.addEntity("LK.MT", "MT", "MT", "Matale");
		super.addEntity("LK.MH", "MH", "MH", "Matara");
		super.addEntity("LK.MJ", "MJ", "MJ", "Moneragala");
		super.addEntity("LK.MP", "MP", "MP", "Mullailivu");
        super.addEntity("LK.NW", "NW", "NW", "Nuwara Eliya");
        super.addEntity("LK.PR", "PR", "PR", "Polonnaruwa");
        super.addEntity("LK.PX", "PX", "PX", "Puttalam");
        super.addEntity("LK.RN", "RN", "RN", "Ratnapura");
        super.addEntity("LK.TC", "TC", "TC", "Trincomalee");
        super.addEntity("LK.VA", "VA", "VA", "Vavuniya");
		
	
		 
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
