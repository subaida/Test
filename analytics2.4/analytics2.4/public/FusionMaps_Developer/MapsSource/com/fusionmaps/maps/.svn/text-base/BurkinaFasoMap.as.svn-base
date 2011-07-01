import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BurkinaFasoMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BurkinaFasoMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BurkinaFasoMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("BF.BA", "BA", "BA", "Balé");
		super.addEntity("BF.BM", "BM", "BM", "Bam");
		super.addEntity("BF.BW", "BW", "BW", "Banwa");
		super.addEntity("BF.BZ", "BZ", "BZ", "Bazèga");
		super.addEntity("BF.BB", "BB", "BB", "Bougouriba");
		super.addEntity("BF.BL", "BL", "BL", "Boulgou");
		super.addEntity("BF.BK", "BK", "BK", "Boulkiemde");
		super.addEntity("BF.GZ", "GZ", "GZ", "Ganzourgou");
		super.addEntity("BF.GG", "GG", "GG", "Gnagna");
		super.addEntity("BF.GM", "GM", "GM", "Gourma");
		super.addEntity("BF.HO", "HO", "HO", "Houet");
		super.addEntity("BF.IO", "IO", "IO", "Ioba");
		super.addEntity("BF.KA", "KA", "KA", "Kadiogo");
		super.addEntity("BF.KM", "KM", "KM", "Komoé");
		super.addEntity("BF.KN", "KN", "KN", "Kénédougou");
		super.addEntity("BF.KJ", "KJ", "KJ", "Komondjari");
		super.addEntity("BF.KP", "KP", "KP", "Kompienga");
		super.addEntity("BF.KS", "KS", "KS", "Kossi");
		super.addEntity("BF.KL", "KL", "KL", "Koulpélogo");
		super.addEntity("BF.KR", "KR", "KR", "Kouritenga");
        super.addEntity("BF.KW", "KW", "KW", "Kourwéogo");
        super.addEntity("BF.LE", "LE", "LE", "Léraba");
        super.addEntity("BF.LO", "LO", "LO", "Loroum");
        super.addEntity("BF.MO", "MO", "MO", "Mouhoun");
        super.addEntity("BF.NM", "NM", "NM", "Namentenga");
        super.addEntity("BF.NR", "NR", "NR", "Nahouri");
		super.addEntity("BF.NY", "NY", "NY", "Nayala");
		super.addEntity("BF.NB", "NB", "NB", "Noumbiel");
		super.addEntity("BF.OB", "OB", "OB", "Oubritenga");
		super.addEntity("BF.OD", "OD", "OD", "Oudalan");
        super.addEntity("BF.PA", "PA", "PA", "Passoré");
        super.addEntity("BF.PO", "PO", "PO", "Poni");
        super.addEntity("BF.SG", "SG", "SG", "Sanguié");
        super.addEntity("BF.ST", "ST", "ST", "Sanmatenga");
		super.addEntity("BF.SE", "SE", "SE", "Séno");
		super.addEntity("BF.SS", "SS", "SS", "Sissili");
		super.addEntity("BF.SM", "SM", "SM", "Soum");
		super.addEntity("BF.SR", "SR", "SR", "Sourou");
        super.addEntity("BF.TA", "TA", "TA", "Tapoa");
        super.addEntity("BF.TU", "TU", "TU", "Tuy");
        super.addEntity("BF.YG", "YG", "YG", "Yagha");
		super.addEntity("BF.YT", "YT", "YT", "Yatenga");
		super.addEntity("BF.ZR", "ZR", "ZR", "Ziro");
		super.addEntity("BF.ZM", "ZM", "ZM", "Zondoma");
		super.addEntity("BF.ZW", "ZW", "ZW", "Zoundwéogo");
		
		 
		 
		

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
