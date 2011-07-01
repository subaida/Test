import com.fusionmaps.core.Map;
class com.fusionmaps.maps.OntarioMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "OntarioMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function OntarioMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AL", "AL", "Algoma");
		super.addEntity("02", "BR", "BR", "Brant");
		super.addEntity("03", "BU", "BU", "Bruce");
		super.addEntity("04", "CK", "CK", "Chatham-Kent");
		super.addEntity("05", "CO", "CO", "Cochrane");
		super.addEntity("06", "DU", "DU", "Dufferin");
		super.addEntity("07", "DR", "DR", "Durham");
		super.addEntity("08", "EL", "EL", "Elgin");
		super.addEntity("09", "ES", "ES", "Essex");
		super.addEntity("10", "FR", "FR", "Frontenac");
		super.addEntity("11", "GS", "GS", "Greater Sudbury");
		super.addEntity("12", "GR", "GR", "Grey");
		super.addEntity("13", "HA", "HA", "Haldimand");
		super.addEntity("14", "HL", "HL", "Haliburton");
		super.addEntity("15", "HT", "HT", "Halton");
		super.addEntity("16", "HM", "HM", "Hamilton");
		super.addEntity("17", "HS", "HS", "Hastings");
		super.addEntity("18", "HU", "HU", "Huron");
		super.addEntity("19", "KL", "KL", "Kawartha Lakes");
        super.addEntity("20", "KE", "KE", "Kenora");
        super.addEntity("21", "LA", "LA", "Lambton");
        super.addEntity("22", "LN", "LN", "Lanark");
        super.addEntity("23", "LG", "LG", "Leeds and Grenville");
        super.addEntity("24", "LE", "LE", "Lennox and Addington");
        super.addEntity("25", "MA", "MA", "Manitoulin");
		super.addEntity("26", "MI", "MI", "Middlesex");
		super.addEntity("27", "MU", "MU", "Muskoka");
		super.addEntity("28", "NI", "NI", "Niagara");
		super.addEntity("29", "NP", "NP", "Nipissing");
		super.addEntity("30", "NO", "NO", "Norfolk");
		super.addEntity("31", "NR", "NR", "Northumberland");
		super.addEntity("32", "OT", "OT", "Ottawa");
		super.addEntity("33", "OX", "OX", "Oxford");
		super.addEntity("34", "PS", "PS", "Parry Sound");
		super.addEntity("35", "PE", "PE", "Peel");
		super.addEntity("36", "PR", "PR", "Perth");
		super.addEntity("37", "PT", "PT", "Peterborough");
		super.addEntity("38", "PC", "PC", "Prescott and Russell");
		super.addEntity("39", "PN", "PN", "Prince Edward");
		super.addEntity("40", "RA", "RA", "Rainy River");
		super.addEntity("41", "RE", "RE", "Renfrew");
		super.addEntity("42", "SI", "SI", "Simcoe");
		super.addEntity("43", "ST", "ST", "Stormont, Dundas and Glengary");
	    super.addEntity("44", "SU", "SU", "Sudbury ");
		super.addEntity("45", "TB", "TB", "Thunder Bay");
		super.addEntity("46", "TI", "TI", "Timiskaming");
		 super.addEntity("47", "TO", "TO", "Toronto");
		 super.addEntity("48", "WA", "WA", "Waterloo");
		 super.addEntity("49", "WE", "WE", "Wellington");
		 super.addEntity("50", "YO", "YO", "York");
		 
		 
		

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
