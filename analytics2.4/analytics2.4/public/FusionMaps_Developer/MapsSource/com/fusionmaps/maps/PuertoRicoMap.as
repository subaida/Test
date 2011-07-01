import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PuertoRicoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PuertoRicoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PuertoRicoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "AJ", "AJ", "Adjuntas");
		super.addEntity("03", "AD", "AD", "Aguada");
		super.addEntity("05", "AL", "AL", "Aguadilla");
		super.addEntity("07", "AB", "AB", "Aguas Buenas");
		super.addEntity("09", "AI", "AI", "Aibonito");
		super.addEntity("11", "AN", "AN", "Añasco");
		super.addEntity("13", "AC", "AC", "Arecibo");
		super.addEntity("15", "AR", "AR", "Arroyo");
		super.addEntity("17", "BC", "BC", "Barceloneta");
		super.addEntity("19", "BQ", "BQ", "Barranquitas");
		super.addEntity("21", "BY", "BY", "Bayamón");
		super.addEntity("23", "CR", "CR", "Cabo Rojo");
		super.addEntity("25", "CG", "CG", "Caguas");
		super.addEntity("27", "CA", "CA", "Camuy");
		super.addEntity("29", "CV", "CV", "Canóvanas");
		super.addEntity("31", "CN", "CN", "Carolina");
		super.addEntity("33", "CT", "CT", "Cataño");
		super.addEntity("35", "CY", "CY", "Cayey");
		super.addEntity("37", "CB", "CB", "Ceiba");
        super.addEntity("39", "CL", "CL", "Ciales");
        super.addEntity("41", "CD", "CD", "Cidra");
        super.addEntity("43", "CO", "CO", "Coamo");
        super.addEntity("45", "CM", "CM", "Comerío");
        super.addEntity("47", "CZ", "CZ", "Corozal");
        super.addEntity("49", "CU", "CU", "Culebra");
		super.addEntity("51", "DO", "DO", "Dorado");
		super.addEntity("53", "FJ", "FJ", "Fajardo");
		super.addEntity("54", "FL", "FL", "Florida");
		super.addEntity("55", "GC", "GC", "Guánica");
		super.addEntity("57", "GM", "GM", "Guayama");
		super.addEntity("59", "GL", "GL", "Guayanilla");
		super.addEntity("61", "GB", "GB", "Guaynabo");
		super.addEntity("63", "GR", "GR", "Gurabo");
		super.addEntity("65", "HA", "HA", "Hatillo");
		super.addEntity("67", "HO", "HO", "Hormigueros ");
		super.addEntity("69", "HU", "HU", "Humacao");
		super.addEntity("71", "IS", "IS", "Isabela");
		super.addEntity("73", "JY", "JY", "Jayuya");
		super.addEntity("75", "JD", "JD", "Juana Díaz");
		super.addEntity("77", "JC", "JC", "Juncos");
		super.addEntity("79", "LJ", "LJ", "Lajas");
		super.addEntity("81", "LR", "LR", "Lares");
		super.addEntity("83", "LM", "LM", "Las Marías");
	     super.addEntity("85", "LP", "LP", "Las Piedras");
		 super.addEntity("87", "LZ", "LZ", "Loíza");
		 super.addEntity("89", "LQ", "LQ", "Luquillo");
		 super.addEntity("91", "MT", "MT", "Manatí");
		 super.addEntity("93", "MR", "MR", "Maricao");
		 super.addEntity("95", "MB", "MB", "Maunabo");
		 super.addEntity("97", "MG", "MG", "Mayagüez");
		 super.addEntity("99", "MC", "MC", "Moca");
		 super.addEntity("101", "MV", "MV", "Morovis");
		 super.addEntity("103", "NG", "NG", "Nagüabo");
		 super.addEntity("105", "NR", "NR", "Naranjito");
		 super.addEntity("107", "OR", "OR", "Orocovis");
		 super.addEntity("109", "PT", "PT", "Patillas");
		 super.addEntity("111", "PN", "PN", "Peñuelas");
		 super.addEntity("113", "PO", "PO", "Ponce");
		 super.addEntity("115", "QB", "QB", "Quebradillas");
		 super.addEntity("117", "RC", "RC", "Rincón");
		 super.addEntity("119", "RG", "RG", "Río Grande");
		 super.addEntity("121", "SB", "SB", "Sabana Grande");
		 super.addEntity("123", "SA", "SA", "Salinas"); 
		 super.addEntity("125", "SG", "SG", "San Germán");
		 super.addEntity("127", "SJ", "SJ", "San Juan (capital)");
		 super.addEntity("129", "SL", "SL", "San Lorenzo");
		 super.addEntity("131", "SS", "SS", "San Sebastián");
		 super.addEntity("133", "SI", "SI", "Santa Isabel "); 
		 super.addEntity("135", "TA", "TA", "Toa Alta");
		 super.addEntity("137", "TB", "TB", "Toa Baja"); 
		 super.addEntity("139", "TJ", "TJ", "Trujillo Alto");
		 super.addEntity("141", "UT", "UT", "Utuado");
		 super.addEntity("143", "VA", "VA", "Vega Alta");
		 super.addEntity("145", "VB", "VB", "Vega Baja");
		 super.addEntity("147", "VQ", "VQ", "Vieques"); 
		 super.addEntity("149", "VL", "VL", "Villalba");
		 super.addEntity("151", "YB", "YB", "Yabucoa");
		 super.addEntity("153", "YU", "YU", "Yauco");
		  
		

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
