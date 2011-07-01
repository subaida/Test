import com.fusionmaps.core.Map;
class com.fusionmaps.maps.BulgariaMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "BulgariaMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function BulgariaMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("38", "E", "E", "Blagoevgrad");
		super.addEntity("39", "A", "A", "Burgas");
		super.addEntity("40", "TX", "TX", "Dobrich");
		super.addEntity("41", "EB", "EB", "Gabrovo");
		super.addEntity("42", "CO", "CO", "Grad Sofiya");
		super.addEntity("43", "X", "X", "Haskovo");
		super.addEntity("44", "K", "K", "Kurdzhali");
		super.addEntity("45", "KH", "KH", "Kyustendil");
		super.addEntity("46", "OB", "OB", "Lovech");
		super.addEntity("47", "M", "M", "Montana");
		super.addEntity("48", "PA", "PA", "Pazardzhik");
		super.addEntity("49", "PK", "PK", "Pernik");
		super.addEntity("50", "EH", "EH", "Pleven");
		super.addEntity("51", "PB", "PB", "Plovdiv");
		super.addEntity("52", "PP", "PP", "Razgrad");
		super.addEntity("53", "P", "P", "Ruse");
		super.addEntity("54", "H", "H", "Shumen");
		super.addEntity("55", "CC", "CC", "Silistra");
		super.addEntity("56", "CH", "CH", "Sliven");
        super.addEntity("57", "CM", "CM", "Smolyan");
        super.addEntity("58", "C", "C", "Sofiya");
        super.addEntity("59", "CT", "CT", "Stara Zagora");
        super.addEntity("60", "T", "T", "Turgovishte");
        super.addEntity("61", "B", "B", "Varna");
        super.addEntity("62", "BT", "BT", "Veliko Turnovo");
		super.addEntity("63", "BH", "BH", "Vidin");
		super.addEntity("64", "BP", "BP", "Vratsa");
		super.addEntity("65", "Y", "Y", "Yambol");
		
		

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
