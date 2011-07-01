import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NorthIrelandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NorthIrelandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NorthIrelandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AN", "AN", "Antrim");
		super.addEntity("02", "AD", "AD", "Ards");
		super.addEntity("03", "AM", "AM", "Armarg");
		super.addEntity("04", "BL", "BL", "Ballymena");
		super.addEntity("05", "BY", "BY", "Ballymoney");
		super.addEntity("06", "BB", "BB", "Banbridge");
		super.addEntity("07", "BF", "BF", "Belfast");
		super.addEntity("08", "CF", "CF", "Carrickfergus");
		super.addEntity("09", "CS", "CS", "Castlereagh");
		super.addEntity("10", "CL", "CL", "Coleraine");
		super.addEntity("11", "CK", "CK", "Cookstown");
		super.addEntity("12", "CR", "CR", "Craigavon");
		super.addEntity("13", "LD", "LD", "Derry");
		super.addEntity("14", "DW", "DW", "Down");
		super.addEntity("15", "DN", "DN", "Dungannon and South Tyrone");
		super.addEntity("16", "FE", "FE", "Fermanagh");
		super.addEntity("17", "LR", "LR", "Larne");
		super.addEntity("18", "LM", "LM", "Limavady");
		super.addEntity("19", "LB", "LB", "Lisburn");
        super.addEntity("20", "MF", "MF", "Magherafelt");
        super.addEntity("21", "MY", "MY", "Moyle");
        super.addEntity("22", "NM", "NM", "Newry and Mourne");
        super.addEntity("23", "NW", "NW", "Newtownabbey");
        super.addEntity("24", "ND", "ND", "North Down");
        super.addEntity("25", "OM", "OM", "Omagh");
		super.addEntity("26", "SB", "SB", "Strabane");
		
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
