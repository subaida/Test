import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MexicoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MexicoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MexicoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AG", "Aguascalientes");
		super.addEntity("002", "002", "BA", "Baja California");
		super.addEntity("003", "003", "BC", "Baja California Sur");
		super.addEntity("004", "004", "CA", "Campeche");
		super.addEntity("005", "005", "CH", "Chiapas");
		super.addEntity("006", "006", "CI", "Chihuahua");
		super.addEntity("007", "007", "CO", "Coahuila de Zaragoza");
		super.addEntity("008", "008", "CL", "Colima");
		super.addEntity("009", "009", "DU", "Durango");
		super.addEntity("010", "010", "GU", "Guanajuato");
		super.addEntity("011", "011", "GE", "Guerrero");
		super.addEntity("012", "012", "HI", "Hidalgo");
		super.addEntity("013", "013", "JA", "Jalisco");
		super.addEntity("014", "014", "ME", "Mexico");
		super.addEntity("015", "015", "MI", "Michoacan de Ocampo");
		super.addEntity("016", "016", "MO", "Morelos");
		super.addEntity("017", "017", "NA", "Nayarit");
		super.addEntity("018", "018", "NU", "Nuevo Leon");
		super.addEntity("019", "019", "OA", "Oaxaca");
		super.addEntity("020", "020", "PU", "Puebla");
		super.addEntity("021", "021", "QU", "Queretaro de Arteaga");
		super.addEntity("022", "022", "QR", "Quintana Roo");
		super.addEntity("023", "023", "SA", "San Luis Potosi");
		super.addEntity("024", "024", "SI", "Sinaloa");
		super.addEntity("025", "025", "SO", "Sonora");
		super.addEntity("026", "026", "TA", "Tabasco");
		super.addEntity("027", "027", "TM", "Tamaulipas");
		super.addEntity("028", "028", "TL", "Tlaxcala");
		super.addEntity("029", "029", "VE", "Veracruz-Llave");
		super.addEntity("030", "030", "YU", "Yucatan");
		super.addEntity("031", "031", "ZA", "Zacatecas");
		super.addEntity("032", "032", "DI", "Distrito Federal");
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
