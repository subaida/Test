import com.fusionmaps.core.Map;
class com.fusionmaps.maps.GuineaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "GuineaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function GuineaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("GN.BE", "BE", "BE", "Beyla");
		super.addEntity("GN.BF", "BF", "BF", "Boffa");
		super.addEntity("GN.BK", "BK", "BK", "Boke");
		super.addEntity("GN.CK", "CK", "CK", "Conakry");
		super.addEntity("GN.CO", "CO", "CO", "Coyah");
		super.addEntity("GN.DB", "DB", "DB", "Dabola");
		super.addEntity("GN.DL", "DL", "DL", "Dalaba");
		super.addEntity("GN.DI", "DI", "DI", "Dinguiraye");
		super.addEntity("GN.DU", "DU", "DU", "Dubreka");
		super.addEntity("GN.FA", "FA", "FA", "Faranah");
		super.addEntity("GN.FO", "FO", "FO", "Forecariah");
		super.addEntity("GN.FR", "FR", "FR", "Fria");
		super.addEntity("GN.GA", "GA", "GA", "Gaoual");
		super.addEntity("GN.GU", "GU", "GU", "Gueckedou");
		super.addEntity("GN.KA", "KA", "KA", "Kankan");
		super.addEntity("GN.KE", "KE", "KE", "Kerouane");
		super.addEntity("GN.KD", "KD", "KD", "Kindia");
		super.addEntity("GN.KS", "KS", "KS", "Kissidougou");
		super.addEntity("GN.KB", "KB", "KB", "Koubia");
		super.addEntity("GN.KN", "KN", "KN", "Koundara");
		super.addEntity("GN.KO", "KO", "KO", "Kouroussa");
		super.addEntity("GN.LA", "LA", "LA", "Labe");
		super.addEntity("GN.LE", "LE", "LE", "Lelouma");
		super.addEntity("GN.LO", "LO", "LO", "Lola");
		super.addEntity("GN.MC", "MC", "MC", "Macenta");
		super.addEntity("GN.ML", "ML", "ML", "Mali");
		super.addEntity("GN.MM", "MM", "MM", "Mamou");
		super.addEntity("GN.MD", "MD", "MD", "Mandiana");
		super.addEntity("GN.NZ", "NZ", "NZ", "Nzerekore");
		super.addEntity("GN.PI", "PI", "PI", "Pita");
		super.addEntity("GN.SI", "SI", "SI", "Siguiri");
		super.addEntity("GN.TE", "TE", "TE", "Telimele");
		super.addEntity("GN.TO", "TO", "TO", "Tougue");
		super.addEntity("GN.YO", "YO", "YO", "Yomou");
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
