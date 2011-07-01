import com.fusionmaps.core.Map;
class com.fusionmaps.maps.VietnamMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "VietnamMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function VietnamMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("VN.AG", "AG", "AG", "An Giang");		
		super.addEntity("VN.BG", "BG", "BG", "Bac Giang");		
		super.addEntity("VN.BK", "BK", "BK", "Bac Can");		
		super.addEntity("VN.BL", "BL", "BL", "Bac Lieu");		
		super.addEntity("VN.BN", "BN", "BN", "Bac Ninh");		
		super.addEntity("VN.BV", "BV", "BV", "BaRia-VungTau");		
	    super.addEntity("VN.BR", "BR", "BR", "Ben Tre");
		super.addEntity("VN.BD", "BD", "BD", "Binh Dinh");
		super.addEntity("VN.BI", "BI", "BI", "Binh Duong");
		super.addEntity("VN.BP", "BP", "BP", "Binh Phuoc");
		super.addEntity("VN.BU", "BU", "BU", "Binh Thuan");
		super.addEntity("VN.CM", "CM", "CM", "Ca Mau");
		super.addEntity("VN.CN", "CN", "CN", "Can Tho");
		super.addEntity("VN.CB", "CB", "CB", "Cao Bang");
		super.addEntity("VN.DA", "DA", "DA", "Da Nang");
		super.addEntity("VN.DC", "DC", "DC", "Dac Lac");
		super.addEntity("VN.DO", "DO", "DO", "Dak Nang");
		super.addEntity("VN.DB", "DB", "DB", "Dien Bien");
		super.addEntity("VN.DN", "DN", "DN", "Dong Nai");
		super.addEntity("VN.DT", "DT", "DT", "Dong Thap");
		super.addEntity("VN.GL", "GL", "GL", "Gia Lai");
		super.addEntity("VN.HG", "HG", "HG", "Ha Giang");
		super.addEntity("VN.HM", "HM", "HM", "Ha Nam");
		super.addEntity("VN.HN", "HN", "HN", "Hanoi");
		super.addEntity("VN.HA", "HA", "HA", "Ha Tay");
		super.addEntity("VN.HT", "HT", "HT", "Ha Tinh");
		super.addEntity("VN.HD", "HD", "HD", "Hai Duong");
		super.addEntity("VN.HP", "HP", "HP", "Haiphong");
		super.addEntity("VN.HU", "HU", "HU", "Hau Giang");
		super.addEntity("VN.HC", "HC", "HC", "Ho Chi Minh");
		super.addEntity("VN.HO", "HO", "HO", "Hoa Binh");
		super.addEntity("VN.HY", "HY", "HY", "Hung Yen");
		super.addEntity("VN.KH", "KH", "KH", "Khanh Hoa");
		super.addEntity("VN.KG", "KG", "KG", "Kien Giang");
		super.addEntity("VN.KT", "KT", "KT", "Kon Tum");
		super.addEntity("VN.LI", "LI", "LI", "Lai Chau");
		super.addEntity("VN.LD", "LD", "LD", "Lam Dong");
		super.addEntity("VN.LS", "LS", "LS", "Lang Son");
		super.addEntity("VN.LO", "LO", "LO", "Lao Cai");
		super.addEntity("VN.LA", "LA", "LA", "Long An");
		super.addEntity("VN.ND", "ND", "ND", "Nam Dinh");
		super.addEntity("VN.NA", "NA", "NA", "Nghe An");
		super.addEntity("VN.NB", "NB", "NB", "Ninh Binh");
		super.addEntity("VN.NT", "NT", "NT", "Ninh Thuan");
		super.addEntity("VN.PT", "PT", "PT", "Phu Tho");
		super.addEntity("VN.PY", "PY", "PY", "Phu Yen");
		super.addEntity("VN.QB", "QB", "QB", "Quang Binh");
		super.addEntity("VN.QM", "QM", "QM", "Quang Nam");
		super.addEntity("VN.QG", "QG", "QG", "Quang Ngai");
		super.addEntity("VN.QN", "QN", "QN", "Quang Ninh");
		super.addEntity("VN.QT", "QT", "QT", "Quang Tri");
		super.addEntity("VN.ST", "ST", "ST", "Soc Trang");
		super.addEntity("VN.SL", "SL", "SL", "Son La");
		super.addEntity("VN.TN", "TN", "TN", "Tay Ninh");
		super.addEntity("VN.TB", "TB", "TB", "Thai Binh");
		super.addEntity("VN.TY", "TY", "TY", "Thai Nguyen");
		super.addEntity("VN.TH", "TH", "TH", "Thanh Hoa");
		super.addEntity("VN.TT", "TT", "TT", "Thua Thien Hue");
		super.addEntity("VN.TG", "TG", "TG", "Tien Giang");
		super.addEntity("VN.TV", "TV", "TV", "Tra Vinh");
		super.addEntity("VN.TQ", "TQ", "TQ", "Tuyen Quang");
		super.addEntity("VN.VL", "VL", "VL", "Vinh Long");
		super.addEntity("VN.VC", "VC", "VC", "Vinh Phuc");
		super.addEntity("VN.YB", "YB", "YB", "Yen Bai");
		
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
