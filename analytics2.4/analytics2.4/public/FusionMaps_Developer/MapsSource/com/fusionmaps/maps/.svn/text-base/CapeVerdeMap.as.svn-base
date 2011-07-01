import com.fusionmaps.core.Map;
class com.fusionmaps.maps.CapeVerdeMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "CapeVerdeMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function CapeVerdeMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("CV.RG", "RG", "RG", "Ribeira Grande");
		super.addEntity("CV.PA", "PA", "PA", "Paul");
		super.addEntity("CV.PN", "PN", "PN", "Porto Novo");
		super.addEntity("CV.MO", "MO", "MO", "Mosteiros");
		super.addEntity("CV.SF", "SF", "SF", "Sao Filipe");
		super.addEntity("CV.SV", "SV", "SV", "Sao Vicente");
		super.addEntity("CV.SN", "SN", "SN", "Sao Nicolau");
		super.addEntity("CV.SL", "SL", "SL", "Sal");
		super.addEntity("CV.BV", "BV", "BV", "Boa Vista");
		super.addEntity("CV.MA", "MA", "MA", "Maio");
		super.addEntity("CV.BR", "BR", "BR", "Brava");
		super.addEntity("CV.TF", "TF", "TF", "Tarrafal");
		super.addEntity("CV.SM", "SM", "SM", "Sao Miguel");
		super.addEntity("CV.SZ", "SZ", "SZ", "Santa Cruz");
		super.addEntity("CV.SD", "SD", "SD", "Sao Domingos");
		super.addEntity("CV.PI", "PI", "PI", "Praia");
		super.addEntity("CV.SC", "SC", "SC", "Santa Catarina");
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
