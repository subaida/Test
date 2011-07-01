import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ParaguayMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ParaguayMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ParaguayMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("23", "AG", "AG", "Alto Paraguay");
		super.addEntity("01", "AA", "AA", "Alto Paraná");
		super.addEntity("02", "AM", "AM", "Amambay");
		super.addEntity("22", "AS", "AS", "Asunción Capitol District");
		super.addEntity("24", "BQ", "BQ", "Boquerón");
		super.addEntity("04", "CG", "CG", "Caaguazú");
		super.addEntity("05", "CZ", "CZ", "Caazapá");
		super.addEntity("19", "CY", "CY", "Canindeyú");
		super.addEntity("06", "CE", "CE", "Central");
		super.addEntity("07", "CN", "CN", "Concepción");
		super.addEntity("08", "CR", "CR", "Cordillera");
		super.addEntity("10", "GU", "GU", "Guairá");
		super.addEntity("11", "IT", "IT", "Itapúa");
		super.addEntity("12", "MI", "MI", "Misiones");
		super.addEntity("13", "NE", "NE", "Ñeembucú");
		super.addEntity("15", "PG", "PG", "Paraguarí");
		super.addEntity("16", "PH", "PH", "Presidente Hayes");
		super.addEntity("17", "SP", "SP", "San Pedro");
			

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
