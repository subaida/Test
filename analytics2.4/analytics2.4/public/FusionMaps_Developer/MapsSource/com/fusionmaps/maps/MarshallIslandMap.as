import com.fusionmaps.core.Map;
class com.fusionmaps.maps.MarshallIslandMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "MarshallIslandMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function MarshallIslandMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("MH.MH.AI", "AI", "AI", "Ailinglapalap");
		super.addEntity("MH.MH.AR", "AR", "AR", "Arno ");
		super.addEntity("MH.MH.BR", "BR", "BR", "Bikar");
		super.addEntity("MH.MH.BN", "BN", "BN", "Bikini");
		super.addEntity("MH.MH.EE", "EE", "EE", "Ebeya");
		super.addEntity("MH.MH.EB", "EB", "EB", "Ebon");
		super.addEntity("MH.MH.EN", "EN", "EN", "Enewetak");
		super.addEntity("MH.MH.ER", "ER", "ER", "Erikub");
		super.addEntity("MH.MH.JL", "JL", "JL", "Jaluit");
		super.addEntity("MH.MH.KO", "KO", "KO", "Kosrae");
		super.addEntity("MH.MH.KN", "KN", "KN", "Knox");
		super.addEntity("MH.MH.KW", "KW", "KW", "Kwajalein");
		super.addEntity("MH.MH.LK", "LK", "LK", "Likiep");
		super.addEntity("MH.MH.MJ", "MJ", "MJ", "Majuro");
		super.addEntity("MH.MH.ML", "ML", "ML", "Maloelap");
		super.addEntity("MH.MH.ME", "ME", "ME", "Mejit");
		super.addEntity("MH.MH.MI", "MI", "MI", "Mili");
		super.addEntity("MH.MH.NK", "NK", "NK", "Namorik");
		super.addEntity("MH.MH.NU", "NU", "NU", "Namu");
		super.addEntity("MH.MH.RL", "RL", "RL", "Rongelap");
		super.addEntity("MH.MH.RR", "RR", "RR", "Rongrik");
		super.addEntity("MH.MH.TA", "TA", "TA", "Taongi");
		super.addEntity("MH.MH.TO", "TO", "TO", "Toke");
		super.addEntity("MH.MH.UJ", "UJ", "UJ", "Ujae");
		super.addEntity("MH.MH.UL", "UL", "UL", "Ujelang");
		super.addEntity("MH.MH.UT", "UT", "UT", "Utirik");
		super.addEntity("MH.MH.WH", "WH", "WH", "Wotho");
		super.addEntity("MH.MH.WJ", "WJ", "WJ", "Wotje");
		
		
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
