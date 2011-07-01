import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BrazilMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BrazilMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BrazilMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("001", "001", "AC", "Acre");
		super.addEntity("002", "002", "AL", "Alagoas");
		super.addEntity("003", "003", "AP", "Amapa");
		super.addEntity("004", "004", "AM", "Amazonas");
		super.addEntity("005", "005", "BA", "Bahia");
		super.addEntity("006", "006", "CE", "Ceara");
		super.addEntity("007", "007", "DF", "Distrito Federal");
		super.addEntity("008", "008", "ES", "Espirito Santo");
		super.addEntity("009", "009", "GO", "Goias");
		super.addEntity("010", "010", "MA", "Maranhao");
		super.addEntity("011", "011", "MT", "Mato Grosso");
		super.addEntity("012", "012", "MS", "Mato Grosso do Sul");
		super.addEntity("013", "013", "MG", "Minas Gerais");
		super.addEntity("014", "014", "PA", "Para");
		super.addEntity("015", "015", "PB", "Paraiba");
		super.addEntity("016", "016", "PR", "Parana");
		super.addEntity("017", "017", "PE", "Pernambuco");
		super.addEntity("018", "018", "PI", "Piaui");
		super.addEntity("019", "019", "RJ", "Rio de Janeiro");
		super.addEntity("020", "020", "RN", "Rio Grande do Norte");
		super.addEntity("021", "021", "RS", "Rio Grande do Sul");
		super.addEntity("022", "022", "RO", "Rondonia");
		super.addEntity("023", "023", "RR", "Roraima");
		super.addEntity("024", "024", "SC", "Santa Catarina");
		super.addEntity("025", "025", "SP", "Sao Paulo");
		super.addEntity("026", "026", "SE", "Sergipe");
		super.addEntity("027", "027", "TO", "Tocantins");
		//super.addEntity("028", "028", "CP", "Ceara/Piaui");
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
