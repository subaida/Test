import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MadagascarRegionsMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MadagascarRegionsMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MadagascarRegionsMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("MG.TM.AO", "AO", "AO", "Alaotra-Mangoro");		
		super.addEntity("MG.FI.AM", "AM", "AM", "Amoron'i Mania");		
		super.addEntity("MG.AV.AG", "AG", "AG", "Analamanga");		
		super.addEntity("MG.TM.AN", "AN", "AN", "Analanjirofo");		
		super.addEntity("MG.TL.AD", "AD", "AD", "Andory");		
		super.addEntity("MG.TL.AY", "AY", "AY", "Anosy");		
	    super.addEntity("MG.TL.AF", "AF", "AF", "Atsimo Andrefana");
		super.addEntity("MG.FI.AA", "AA", "AA", "Atsimo Atsinanana");
		super.addEntity("MG.TM.AI", "AI", "AI", "Atsinanana");
		super.addEntity("MG.MA.BE", "BE", "BE", "Betsiboka");
		super.addEntity("MG.MA.BO", "BO", "BO", "Boeny");
		super.addEntity("MG.AV.BN", "BN", "BN", "Bongolava");
		super.addEntity("MG.AS.DI", "DI", "DI", "Diana");
		super.addEntity("MG.FI.HM", "HM", "HM", "Haute Matsiatra");
		super.addEntity("MG.FI.HO", "HO", "HO", "Ihorombe");
		super.addEntity("MG.AV.IT", "IT", "IT", "Itasy");
		super.addEntity("MG.MA.ML", "ML", "ML", "Melaky");
		super.addEntity("MG.TL.ME", "ME", "ME", "Menabe");
		super.addEntity("MG.AS.SV", "SV", "SV", "Sava");
		super.addEntity("MG.MA.SF", "SF", "SF", "Sofia");
		super.addEntity("MG.AV.VA", "VA", "VA", "Vakinankaratra");
		super.addEntity("MG.FI.VF", "VF", "VF", "vatovavy Fitovinany");
		
		
		
		
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
