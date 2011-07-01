import com.fusionmaps.core.Map;
class com.fusionmaps.maps.FranceMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "FranceMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function FranceMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		//super.addEntity("001", "001", "PA", "Paris ");
		super.addEntity("002", "002", "AL", "Alsace");
		super.addEntity("003", "003", "AQ", "Aquitaine");
		super.addEntity("004", "004", "AU", "Auvergne");
		super.addEntity("005", "005", "BR", "Bretagne");
		super.addEntity("006", "006", "BU", "Bourgogne");
		super.addEntity("007", "007", "CE", "Centre");
		super.addEntity("008", "008", "CH", "Champagne-Ardenne");
		super.addEntity("009", "009", "CO", "Corse");
		super.addEntity("010", "010", "FR", "Franche-Comté");
		super.addEntity("011", "011", "LL", "Ile-de-France");
		super.addEntity("012", "012", "LA", "Languedoc-Roussillon");
		super.addEntity("013", "013", "LI", "Limousin");
		super.addEntity("014", "014", "LO", "Lorraine");
		super.addEntity("015", "015", "MI", "Midi-Pyrénées");
		super.addEntity("016", "016", "NO", "Nord-Pas-de-Calais ");
		super.addEntity("017", "017", "NR", "Basse-Normandie");
		super.addEntity("018", "018", "PD", "Pays de la Loire");
		super.addEntity("019", "019", "PI", "Picardie");
		super.addEntity("020", "020", "PC", "Poitou-Charentes");
		super.addEntity("021", "021", "PR", "Provence-Alpes-Côte D'Azur");
		super.addEntity("022", "022", "RH", "Rhône-Alpes  ");
		super.addEntity("023", "023", "HN", "Haute-Normandie");
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
