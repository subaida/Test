import com.fusionmaps.core.Map;
class com.fusionmaps.maps.NewCaledoniaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "NewCaledoniaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function NewCaledoniaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("NC.NO.BE", "BE", "BE", "Bélep");
		super.addEntity("NC.SU.BP", "BP", "BP", "Boulouparis");
		super.addEntity("NC.SU.BR", "BR", "BR", "Bourail");
		super.addEntity("NC.NO.CA", "CA", "CA", "Canala");
		super.addEntity("NC.SU.DU", "DU", "DU", "Dumbéa ");
		super.addEntity("NC.SU.FA", "FA", "FA", "Farino");
		super.addEntity("NC.NO.HI", "HI", "HI", "Hienghène");
		super.addEntity("NC.NO.HO", "HO", "HO", "Houaïlou ");
		super.addEntity("NC.SU.IP", "IP", "IP", "L'Île-des-Pins");
		super.addEntity("NC.NO.KG", "KG", "KG", "Kaala-Gomen");
		super.addEntity("NC.NO.KN", "KN", "KN", "Koné");
		super.addEntity("NC.NO.KA", "KA", "KA", "Kouaoua ");
		super.addEntity("NC.NO.KM", "KM", "KM", "Koumac");
		super.addEntity("NC.SU.LF", "LF", "LF", "La Foa");
		super.addEntity("NC.IL.LI", "LI", "LI", "Lifou");
		super.addEntity("NC.IL.MA", "MA", "MA", "Maré");
		super.addEntity("NC.SU.MO", "MO", "MO", "Moindou");
		super.addEntity("NC.SU.MD", "MD", "MD", "Mont-Dore");
		super.addEntity("NC.SU.NO", "NO", "NO", "Nouméa");
		super.addEntity("NC.NO.OG", "OG", "OG", "Ouégoa");
		super.addEntity("NC.IL.OV", "OV", "OV", "Ouvéa");
		super.addEntity("NC.SU.PA", "PA", "PA", "Païta");
		super.addEntity("NC.NO.PD", "PD", "PD", "Poindimié");
		super.addEntity("NC.NO.PH", "PH", "PH", "Ponérihouen");
		super.addEntity("NC.NO.PB", "PB", "PB", "Pouébo");
		super.addEntity("NC.NO.PM", "PM", "PM", "Poum");
		super.addEntity("NC.NO.PT", "PT", "PT", "Pouembout");
		super.addEntity("NC.NO.PY", "PY", "PY", "Poya");
		super.addEntity("NC.SU.SA", "SA", "SA", "Sarraméa");
		super.addEntity("NC.SU.TH", "TH", "TH", "Thio");
		super.addEntity("NC.NO.TO", "TO", "TO", "Touho");
		super.addEntity("NC.NO.VO", "VO", "VO", "Voh");
		super.addEntity("NC.SU.YA", "YA", "YA", "Yaté");

	
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
