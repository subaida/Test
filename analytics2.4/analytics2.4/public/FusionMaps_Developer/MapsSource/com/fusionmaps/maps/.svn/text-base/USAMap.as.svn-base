import com.fusionmaps.core.Map;
class com.fusionmaps.maps.USAMap extends Map {
	//Version number (if different from super Map class)
	//private var _version:String = "3.0.0";
	//MapId represents the identifier name of the map movie clip
	private var mapId:String = "USAMap";
	/**
	* Constructor function. We invoke the super class'
	* constructor and then set the objects for this map.
	*/
	function USAMap(targetMC:MovieClip, depth:Number, width:Number, height:Number, x:Number, y:Number, debugMode:Boolean, lang:String ,scaleMode: String, registerWithJS: Boolean, DOMId:String) {
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
		super.addEntity("AL", "AL", "AL", "Alabama");
		super.addEntity("AK", "AK", "AK", "Alaska");
		super.addEntity("AZ", "AZ", "AZ", "Arizona");
		super.addEntity("AR", "AR", "AR", "Arkansas");
		super.addEntity("CA", "CA", "CA", "California");
		super.addEntity("CO", "CO", "CO", "Colorado");
		super.addEntity("CT", "CT", "CT", "Connecticut");
		super.addEntity("DE", "DE", "DE", "Delaware");
		super.addEntity("FL", "FL", "FL", "Florida");
		super.addEntity("GA", "GA", "GA", "Georgia");
		super.addEntity("HI", "HI", "HI", "Hawaii");
		super.addEntity("ID", "ID", "ID", "Idaho");
		super.addEntity("IL", "IL", "IL", "Illinois");
		super.addEntity("IN", "IN", "IN", "Indiana");
		super.addEntity("IA", "IA", "IA", "Iowa");
		super.addEntity("KS", "KS", "KS", "Kansas");
		super.addEntity("KY", "KY", "KY", "Kentucky");
		super.addEntity("LA", "LA", "LA", "Louisiana");
		super.addEntity("ME", "ME", "ME", "Maine");
		super.addEntity("MD", "MD", "MD", "Maryland");
		super.addEntity("MA", "MA", "MA", "Massachusetts");
		super.addEntity("MI", "MI", "MI", "Michigan");
		super.addEntity("MN", "MN", "MN", "Minnesota");
		super.addEntity("MS", "MS", "MS", "Mississippi");
		super.addEntity("MO", "MO", "MO", "Missouri");
		super.addEntity("MT", "MT", "MT", "Montana");
		super.addEntity("NE", "NE", "NE", "Nebraska");
		super.addEntity("NV", "NV", "NV", "Nevada");
		super.addEntity("NH", "NH", "NH", "New Hampshire");
		super.addEntity("NJ", "NJ", "NJ", "New Jersey");
		super.addEntity("NM", "NM", "NM", "New Mexico");
		super.addEntity("NY", "NY", "NY", "New York");
		super.addEntity("NC", "NC", "NC", "North Carolina");
		super.addEntity("ND", "ND", "ND", "North Dakota");
		super.addEntity("OH", "OH", "OH", "Ohio");
		super.addEntity("OK", "OK", "OK", "Oklahoma");
		super.addEntity("OR", "OR", "OR", "Oregon");
		super.addEntity("PA", "PA", "PA", "Pennsylvania");
		super.addEntity("RI", "RI", "RI", "Rhode Island");
		super.addEntity("SC", "SC", "SC", "South Carolina");
		super.addEntity("SD", "SD", "SD", "South Dakota");
		super.addEntity("TN", "TN", "TN", "Tennessee");
		super.addEntity("TX", "TX", "TX", "Texas");
		super.addEntity("UT", "UT", "UT", "Utah");
		super.addEntity("VT", "VT", "VT", "Vermont");
		super.addEntity("VA", "VA", "VA", "Virginia");
		super.addEntity("WA", "WA", "WA", "Washington");
		super.addEntity("WV", "WV", "WV", "West Virginia");
		super.addEntity("WI", "WI", "WI", "Wisconsin");
		super.addEntity("WY", "WY", "WY", "Wyoming");
		super.addEntity("DC", "DC", "DC", "District of Columbia");
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
