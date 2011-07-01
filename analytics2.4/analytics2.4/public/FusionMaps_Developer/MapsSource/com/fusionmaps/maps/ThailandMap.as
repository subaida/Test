import com.fusionmaps.core.Map;
class com.fusionmaps.maps.ThailandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "ThailandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function ThailandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("TH.AC", "AC", "AC", "Amnat Chareon");
		super.addEntity("TH.AT", "AT", "AT", "Ang Thong");
		//super.addEntity("40", "BM", "BM", "Bangkok Metropolis");
		super.addEntity("TH.BR", "BR", "BR", "Buri Ram");
		super.addEntity("TH.CC", "CC", "CC", "Chachoengsao");
		super.addEntity("TH.CN", "CN", "CN", "Chai Nat");
		super.addEntity("TH.CY", "CY", "CY", "Chaiyaphum");
		super.addEntity("TH.CT", "CT", "CT", "Chanthaburi");
		super.addEntity("TH.CM", "CM", "CM", "Chiang Mai");
		super.addEntity("TH.CR", "CR", "CR", "Chiang Rai");
		super.addEntity("TH.CB", "CB", "CB", "Chon Buri");
		super.addEntity("TH.CP", "CP", "CP", "Chumphon");
		super.addEntity("TH.KL", "KL", "KL", "Kalasin");
		super.addEntity("TH.KP", "KP", "KP", "Kamphaeng Phet");
		super.addEntity("TH.KN", "KN", "KN", "Kanchanaburi");
		super.addEntity("TH.KK", "KK", "KK", "Khon Kaen");
		super.addEntity("TH.KR", "KR", "KR", "Krabi");
		super.addEntity("TH.LG", "LG", "LG", "Lampang");
		super.addEntity("TH.LN", "LN", "LN", "Lamphun");
        super.addEntity("TH.LE", "LE", "LE", "Loei");
        super.addEntity("TH.LB", "LB", "LB", "Lop Buri");
        super.addEntity("TH.MH", "MH", "MH", "Mae Hong Son");
        super.addEntity("TH.MS", "MS", "MS", "Maha Sarakham");
        super.addEntity("TH.MD", "MD", "MD", "Mukdahan");
        super.addEntity("TH.NN", "NN", "NN", "Nakhon Nayok");
		super.addEntity("TH.NP", "NP", "NP", "Nakhon Pathom");
		super.addEntity("TH.NF", "NF", "NF", "Nakhon Phanom");
		super.addEntity("TH.NR", "NR", "NR", "Nakhon Ratchasima");
		super.addEntity("TH.NS", "NS", "NS", "Nakhon Sawan");
		super.addEntity("TH.NT", "NT", "NT", "Nakhon Si Thammarat");
		super.addEntity("TH.NA", "NA", "NA", "Nan");
		super.addEntity("TH.NW", "NW", "NW", "Narathiwat");
		super.addEntity("TH.NB", "NB", "NB", "Nong Bua Lam Phu");
		super.addEntity("TH.NK", "NK", "NK", "Nong Khai");
		super.addEntity("TH.NO", "NO", "NO", "Nonthaburi");
		super.addEntity("TH.PT", "PT", "PT", "Pathum Thani");
		super.addEntity("TH.PI", "PI", "PI", "Pattani");
		super.addEntity("TH.PG", "PG", "PG", "Phangnga");
		super.addEntity("TH.PL", "PL", "PL", "Phatthalung");
		super.addEntity("TH.PY", "PY", "PY", "Phayao");
		super.addEntity("TH.PH", "PH", "PH", "Phetchabun");
		super.addEntity("TH.PE", "PE", "PE", "Phetchaburi");
		super.addEntity("TH.PC", "PC", "PC", "Phichit");
	    super.addEntity("TH.PS", "PS", "PS", "Phitsanulok");
		super.addEntity("TH.PR", "PR", "PR", "Phrae");
		//super.addEntity("TH.PA", "PA", "PA", "Phra Nakhon Si Ayutthaya");
		super.addEntity("TH.PU", "PU", "PU", "Phuket");
		//super.addEntity("TH.PB", "PB", "PB", "Prachin Buri");
		super.addEntity("TH.PK", "PK", "PK", "Prachuap Khiri Khan");
		super.addEntity("TH.RN", "RN", "RN", "Ranong");
		super.addEntity("TH.RT", "RT", "RT", "Ratchaburi");
		super.addEntity("TH.RY", "RY", "RY", "Rayong");
		super.addEntity("TH.RE", "RE", "RE", "Roi Et");
		super.addEntity("TH.SK", "SK", "SK", "Sa Kaeo");
		super.addEntity("TH.SN", "SN", "SN", "Sakon Nakhon");
		super.addEntity("TH.SP", "SP", "SP", "Samut Prakan");
		super.addEntity("TH.SS", "SS", "SS", "Samut Sakhon");
		super.addEntity("TH.SM", "SM", "SM", "Samut Songkhram");
		super.addEntity("TH.SR", "SR", "SR", "Saraburi");
		super.addEntity("TH.SA", "SA", "SA", "Satun");
		super.addEntity("TH.SB", "SB", "SB", "Sing Buri");
		super.addEntity("TH.SI", "SI", "SI", "Si Sa Ket");
		super.addEntity("TH.SG", "SG", "SG", "Songkhla"); 
		super.addEntity("TH.SO", "SO", "SO", "Sukhothai");
		super.addEntity("TH.SH", "SH", "SH", "Suphan Buri");
		super.addEntity("TH.ST", "ST", "ST", "Surat Thani");
		super.addEntity("TH.SU", "SU", "SU", "Surin");
		super.addEntity("TH.TK", "TK", "TK", "Tak"); 
		super.addEntity("TH.TG", "TG", "TG", "Trang");
		super.addEntity("TH.TT", "TT", "TT", "Trat"); 
		super.addEntity("TH.UR", "UR", "UR", "Ubon Ratchathani");
		super.addEntity("TH.UN", "UN", "UN", "Udon Thani");
		super.addEntity("TH.UT", "UT", "UT", "Uthai Thani");
	 	super.addEntity("TH.UD", "UD", "UD", "Uttaradit");
		super.addEntity("TH.YL", "YL", "YL", "Yala"); 
		super.addEntity("TH.YS", "YS", "YS", "Yasothon");
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
