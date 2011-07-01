import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PolandCountiesMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PolandCountiesMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PolandCountiesMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("PL.LU.BM", "LBM", "LBM", "Biala-Podlaska");
		super.addEntity("PL.PD.BM", "PBM", "PBM", "Bialystok");
		super.addEntity("PL.SL.BM", "SBM", "SBM", "Bielsko-Biala");
		super.addEntity("PL.KP.BM", "KBM", "KBM", "Bydgoszcz");
		super.addEntity("PL.MZ.CI", "MCI", "MCI", "Cieckanow");
		super.addEntity("PL.LU.CM", "LCM", "LCM", "Chelm");
		super.addEntity("PL.SL.CM", "SCM", "SCM", "Czestochowa");
		super.addEntity("PL.WN.EM", "WEM", "WEM", "Elblag");
		super.addEntity("PL.PM.GM", "PGM", "PGM", "Gdansk");
		super.addEntity("PL.LB.GM", "LGM", "LGM", "Gorzow Wielkopolski");
		super.addEntity("PL.DS.JM", "DJM", "DJM", "Jelenia Gora");
		super.addEntity("PL.WP.KM", "WKM", "WKM", "Kalisz");
		super.addEntity("PL.SL.KA", "SKA", "SKA", "Katowice");
		super.addEntity("PL.WP.KO", "WKO", "WKO", "Konin");
		super.addEntity("PL.ZP.KM", "ZKM", "ZKM", "Koszalin");
		super.addEntity("PL.SK.KM", "SKM", "SKM", "Kielce");
		super.addEntity("PL.MA.KM", "MKM", "MKM", "Krakow");
		super.addEntity("PL.PK.KM", "PKM", "PKM", "Krosno");
		super.addEntity("PL.WP.LE", "WLE", "WLE", "Leszno");
		super.addEntity("PL.DS.LM", "DLM", "DLM", "Legnica");
		super.addEntity("PL.LD.LO", "LLO", "LLO", "Lodz");
		super.addEntity("PL.PD.LM", "PLM", "PLM", "Lomza");
		super.addEntity("PL.LU.LM", "LLM", "LLM", "Lublin");
		super.addEntity("PL.MA.NM", "MNM", "MNM", "Nowy Sacz");
		super.addEntity("PL.WN.OM", "WOM", "WOM", "Olsztyn");
		super.addEntity("PL.OP.OM", "OOM", "OOM", "Opole");
		super.addEntity("PL.MZ.OM", "MOM", "MOM", "Ostroleka");
		super.addEntity("PL.WP.PI", "WPI", "WPI", "Pila");
		super.addEntity("PL.WP.PM", "WPM", "WPM", "Poznan");
		super.addEntity("PL.MZ.PM", "MPM", "MPM", "Plock");
		super.addEntity("PL.PK.PM", "PPM", "PPM", "Przemysl");
		super.addEntity("PL.LD.PM", "LPM", "LPM", "Piotrkow Trybunalski");
		super.addEntity("PL.MZ.RM", "MRM", "MRM", "Radom");
		super.addEntity("PL.PK.RM", "PRM", "PRM", "Rzeszow");
		super.addEntity("PL.MZ.SM", "MSM", "MSM", "Siedlce");
		super.addEntity("PL.LD.SI", "LSI", "LSI", "Sieradz");
		super.addEntity("PL.LD.SM", "LSM", "LSM", "Skierniewice");
		super.addEntity("PL.PD.SM", "PSM", "PSM", "Suwalki");
		super.addEntity("PL.PM.SL", "PSL", "PSL", "Slupsk");
		super.addEntity("PL.ZP.SM", "ZSM", "ZSM", "Szczecin");
		super.addEntity("PL.MA.TM", "MTM", "MTM", "Tarnow");
		super.addEntity("PL.TH", "LTH", "LTH", "Thrun");
		super.addEntity("PL.PK.TM", "PTM", "PTM", "Tarnobrzeg");
		super.addEntity("PL.DS.WM", "DWM", "DWM", "Walbrzych");
		super.addEntity("PL.MZ.WA", "MWA", "MWA", "Warszawa");
		super.addEntity("PL.DS.WR", "DWR", "DWR", "Wroclaw");
		super.addEntity("PL.KP.WL", "KWL", "KWL", "Wloclawek");
		super.addEntity("PL.LU.ZM", "LZM", "LZM", "Zamosc");
		super.addEntity("PL.LB.ZM", "BZM", "BZM", "Zielona Gora");
		
		
		
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
