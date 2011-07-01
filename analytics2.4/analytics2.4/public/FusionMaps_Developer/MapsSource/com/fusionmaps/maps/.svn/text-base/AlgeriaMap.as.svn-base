import com.fusionmaps.core.Map;
class com.fusionmaps.maps.AlgeriaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "AlgeriaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function AlgeriaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("DZ.AR", "AR", "AR", "Adrar");		
		super.addEntity("DZ.AD", "AD", "AD", "Ain Defla");		
		super.addEntity("DZ.AT", "AT", "AT", "Ain Temouchent");		
		super.addEntity("DZ.AL", "AL", "AL", "Alger");		
		super.addEntity("DZ.AN", "AN", "AN", "Annaba");		
		super.addEntity("DZ.BT", "BT", "BT", "Batna");		
	    super.addEntity("DZ.BC", "BC", "BC", "Bechar");
		super.addEntity("DZ.BJ", "BJ", "BJ", "Bejaia");
		super.addEntity("DZ.BS", "BS", "BS", "Biskra");
		super.addEntity("DZ.BL", "BL", "BL", "Blida");
		super.addEntity("DZ.BB", "BB", "BB", "Bordj Bou Arreridj");
		super.addEntity("DZ.BU", "BU", "BU", "Bouira");
		super.addEntity("DZ.BM", "BM", "BM", "Boumerdes");
		super.addEntity("DZ.CH", "CH", "CH", "Chlef");
		super.addEntity("DZ.CO", "CO", "CO", "Constantine");
		super.addEntity("DZ.DJ", "DJ", "DJ", "Djelfa");
		super.addEntity("DZ.EB", "EB", "EB", "El Bayadh");
		super.addEntity("DZ.EO", "EO", "EO", "El Oued");
		super.addEntity("DZ.ET", "ET", "ET", "El Tarf");
		super.addEntity("DZ.GR", "GR", "GR", "Ghardaia");
		super.addEntity("DZ.GL", "GL", "GL", "Guelma");
		super.addEntity("DZ.IL", "IL", "IL", "Illizi");
		super.addEntity("DZ.JJ", "JJ", "JJ", "Jijel");
		super.addEntity("DZ.KH", "KH", "KH", "Khenchela");
		super.addEntity("DZ.LG", "LG", "LG", "Laghouat");
		super.addEntity("DZ.MC", "MC", "MC", "Mascara");
		super.addEntity("DZ.MD", "MD", "MD", "Medea");
		super.addEntity("DZ.ML", "ML", "ML", "Mila");
		super.addEntity("DZ.MG", "MG", "MG", "Mostaganem");
		super.addEntity("DZ.MS", "MS", "MS", "Msila");
		super.addEntity("DZ.NA", "NA", "NA", "Naama");
		super.addEntity("DZ.OR", "OR", "OR", "Oran");
		super.addEntity("DZ.OG", "OG", "OG", "Ouargla");
		super.addEntity("DZ.OB", "OB", "OB", "Oum el-Bouaghi");
		super.addEntity("DZ.RE", "RE", "RE", "Relizane");
		super.addEntity("DZ.SD", "SD", "SD", "Saida");
		super.addEntity("DZ.SF", "SF", "SF", "Setif");
		super.addEntity("DZ.SB", "SB", "SB", "Sidi Bel Abbes");
		super.addEntity("DZ.SK", "SK", "SK", "Skikda");
		super.addEntity("DZ.SA", "SA", "SA", "Souk Ahras");
		super.addEntity("DZ.TM", "TM", "TM", "Tamanghasset");
		super.addEntity("DZ.TB", "TB", "TB", "Tebessa");
		super.addEntity("DZ.TR", "TR", "TR", "Tiaret");
		super.addEntity("DZ.TN", "TN", "TN", "Tindouf");
		super.addEntity("DZ.TP", "TP", "TP", "Tipaza");
		super.addEntity("DZ.TS", "TS", "TS", "Tissemsilt");
		super.addEntity("DZ.TO", "TO", "TO", "Tizi Ouzou");
		super.addEntity("DZ.TL", "TL", "TL", "Tlemcen");
		
		
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
