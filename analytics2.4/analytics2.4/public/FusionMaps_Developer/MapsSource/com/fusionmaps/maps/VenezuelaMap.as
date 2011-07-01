import com.fusionmaps.core.Map;
class com.fusionmaps.maps.VenezuelaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "VenezuelaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function VenezuelaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("01", "Z", "Z", "Amazonas");
		super.addEntity("02", "B", "B", "Anzoátegui");
		super.addEntity("03", "C", "C", "Apure");
		super.addEntity("04", "D", "D", "Aragua");
		super.addEntity("05", "E", "E", "Barinas");
		super.addEntity("06", "F", "F", "Bolívar");
		super.addEntity("07", "G", "G", "Carabobo");
		super.addEntity("08", "H", "H", "Cojedes");
		super.addEntity("09", "Y", "Y", "Delta Amacuro");
		super.addEntity("24", "W", "W", "Dependencies Federal");
		super.addEntity("25", "A", "A", "Distrito Capital");
		super.addEntity("11", "I", "I", "Falcón");
		super.addEntity("12", "J", "J", "Guarico");
		super.addEntity("13", "K", "K", "Lara");
		super.addEntity("14", "L", "L", "Merida");
		super.addEntity("15", "M", "M", "Miranda");
		super.addEntity("16", "N", "N", "Monagas");
		super.addEntity("17", "O", "O", "Nueva Esparta");
		super.addEntity("18", "P", "P", "Portuguesa");
		super.addEntity("19", "R", "R", "Sucre");
		super.addEntity("20", "S", "S", "Tachira");
        super.addEntity("21", "T", "T", "Trujillo");
		super.addEntity("26", "X", "X", "Vargas");
        super.addEntity("22", "U", "U", "Yaracuy");
        super.addEntity("23", "V", "V", "Zulia");
        
        
        
		 
		

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
