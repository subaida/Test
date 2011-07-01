import com.fusionmaps.core.Map;
class com.fusionmaps.maps.PhilippinesMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "PhilippinesMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function PhilippinesMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("PH.AB", "AB", "AB", "Abra");
		super.addEntity("PH.AN", "AN", "AN", "Agusan del Norte");
		super.addEntity("PH.AS", "AS", "AS", "Agusan del Sur");
		super.addEntity("PH.AK", "AK", "AK", "Aklan");
		super.addEntity("PH.AL", "AL", "AL", "Albay");
		super.addEntity("PH.AQ", "AQ", "AQ", "Antique");
		super.addEntity("PH.AP", "AP", "AP", "Apayao");
		super.addEntity("PH.AU", "AU", "AU", "Aurora");
		super.addEntity("PH.BS", "BS", "BS", "Basilan");
		super.addEntity("PH.BA", "BA", "BA", "Bataan");
		super.addEntity("PH.BT", "BT", "BT", "Batangas");
		super.addEntity("PH.BG", "BG", "BG", "Benguet");
		super.addEntity("PH.BI", "BI", "BI", "Biliran");
		super.addEntity("PH.BO", "BO", "BO", "Bohol");
		super.addEntity("PH.BK", "BK", "BK", "Bukidnon");
		super.addEntity("PH.BU", "BU", "BU", "Bulacan");
		super.addEntity("PH.CG", "CG", "CG", "Cagayan");
		super.addEntity("PH.CN", "CN", "CN", "Camarines Norte");
		super.addEntity("PH.CS", "CS", "CS", "Camarines Sur");
		super.addEntity("PH.CM", "CM", "CM", "Camiguin");
		super.addEntity("PH.CP", "CP", "CP", "Capiz");
		super.addEntity("PH.CT", "CT", "CT", "Catanduanes");
		super.addEntity("PH.CV", "CV", "CV", "Cavite");
		super.addEntity("PH.CB", "CB", "CB", "Cebu");
		super.addEntity("PH.CL", "CL", "CL", "Compostela Valley");
		super.addEntity("PH.NC", "NC", "NC", "Cotabato");
		super.addEntity("PH.DV", "DV", "DV", "Davao del Norte");
		super.addEntity("PH.DS", "DS", "DS", "Davao del Sur");
		super.addEntity("PH.DO", "DO", "DO", "Davao Oriental");
		super.addEntity("PH.ES", "ES", "ES", "Eastern Samar");
		super.addEntity("PH.GU", "GU", "GU", "Guimaras");
		super.addEntity("PH.IF", "IF", "IF", "Ifugao");
		super.addEntity("PH.IN", "IN", "IN", "Ilocos Norte");
		super.addEntity("PH.IS", "IS", "IS", "Ilocos Sur");
		super.addEntity("PH.II", "II", "II", "Iloilo");
		super.addEntity("PH.IB", "IB", "IB", "Isabela");
		super.addEntity("PH.KA", "KA", "KA", "Kalinga");
		super.addEntity("PH.LG", "LG", "LG", "Laguna");
		super.addEntity("PH.LN", "LN", "LN", "Lanao del Norte");
		super.addEntity("PH.LS", "LS", "LS", "Lanao del Sur");
		super.addEntity("PH.LU", "LU", "LU", "La Union");
		super.addEntity("PH.LE", "LE", "LE", "Leyte");
		super.addEntity("PH.MA", "MA", "MA", "Maguindanao");
		super.addEntity("PH.MQ", "MQ", "MQ", "Marinduque");
		super.addEntity("PH.MB", "MB", "MB", "Masbate");
		super.addEntity("PH.MD", "MD", "MD", "Misamis Occidental");
		super.addEntity("PH.MN", "MN", "MN", "Misamis Oriental");
		super.addEntity("PH.MT", "MT", "MT", "Mountain Provience");
		super.addEntity("PH.ND", "ND", "ND", "Negros Occidental");
		super.addEntity("PH.NR", "NR", "NR", "Negros Oriental");
		super.addEntity("PH.NS", "NS", "NS", "Northern Samar");
		super.addEntity("PH.NE", "NE", "NE", "Nueva Ecija");
		super.addEntity("PH.NV", "NV", "NV", "Nueva Vizcaya");
		super.addEntity("PH.MC", "MC", "MC", "Occidental Mindoro");
		super.addEntity("PH.MR", "MR", "MR", "Oriental Mindoro");
		super.addEntity("PH.PL", "PL", "PL", "Palawan");
		super.addEntity("PH.PM", "PM", "PM", "Pampanga");
		super.addEntity("PH.PN", "PN", "PN", "Pangasinan");
		super.addEntity("PH.QZ", "QZ", "QZ", "Quezon");
		super.addEntity("PH.QR", "QR", "QR", "Quirino");
		super.addEntity("PH.RI", "RI", "RI", "Rizal");
		super.addEntity("PH.RO", "RO", "RO", "Ramblon");
		super.addEntity("PH.SM", "SM", "SM", "Samar");
		super.addEntity("PH.SG", "SG", "SG", "Sarangani");
		super.addEntity("PH.SQ", "SQ", "SQ", "Siquijor");
		super.addEntity("PH.SR", "SR", "SR", "Sorsogon");
		super.addEntity("PH.SC", "SC", "SC", "South Cotabato");
		super.addEntity("PH.SL", "SL", "SL", "Southern Leyte");
		super.addEntity("PH.SK", "SK", "SK", "Sultan Kudarat");
		super.addEntity("PH.SU", "SU", "SU", "Sulu");
		super.addEntity("PH.SS", "SS", "SS", "Surigao del Sur");
		super.addEntity("PH.TR", "TR", "TR", "Tarlac");
		super.addEntity("PH.TT", "TT", "TT", "Tawi-Tawi");
		super.addEntity("PH.ZM", "ZM", "ZM", "Zambales");
		super.addEntity("PH.ZN", "ZN", "ZN", "Zamboanga del Norte");
		super.addEntity("PH.ZS", "ZS", "ZS", "Zamboanga del Sur");
		super.addEntity("PH.ZY", "ZY", "ZY", "Zamboanga Sibugay");
		super.addEntity("PH.SF", "SF", "SF", "Shariff Kabunsuan");
		super.addEntity("PH.ST", "ST", "ST", "Surigao del Norte");
		
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
