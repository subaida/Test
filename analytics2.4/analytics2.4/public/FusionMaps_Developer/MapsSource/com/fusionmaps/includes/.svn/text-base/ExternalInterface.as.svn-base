/** --- ExternalInterface.as ---
 * Copyright 2005 InfoSoft Global Private Ltd. and its licensors.  All Rights Reserved.
 * 
 * Use and/or redistribution of this file, in whole or in part, is subject
 * to the License Files, which was distributed with this component.
 * 
 * Data loading and parsing functions
 * This file contains functions and constant definitions only, and is not 
 * associated with a class/movie clip.
*/
//If the movie is registered with JS (or other external script), we need to invoke
//the required external function FC_Loaded
if (_registerWithJS) {
	//We check the availability of ExternalInterface
	if (!ExternalInterface.available) {
		//Add the message to logger
		map.log("WARNING", "Cannot register map with external script. You need to allow script access for this map.", Logger.LEVEL.ERROR);
	} else {
		//Call FC_Loaded JavaScript function to register
		//the load event of this map i.e., the map has
		//been downloaded to end user's computer and is
		//ready for any further actions.
		//If you want to return any value from the external interface call
		//uncomment line 1 below and comment line 2 (referential line no.s)
		//var objReturn:Object = ExternalInterface.call("FC_Loaded", _DOMId);
		ExternalInterface.call("FC_Loaded", _DOMId);
		//Also log the message based on existence of _DOMId
		if (_DOMId == "") {
			map.log("INFO", "Map registered with external script. However, the DOM Id of map has not been defined. You need to define it if you want to interact with the map using external scripting.", Logger.LEVEL.INFO);
		} else {
			map.log("INFO", "Map registered with external script. DOM Id of map is "+_DOMId, Logger.LEVEL.INFO);
		}
	}
	//Register the setDataURL and setDataXML methods with external script 
	var exDU:Boolean = ExternalInterface.addCallback("setDataURL", this, setDataURL);
	var exDX:Boolean = ExternalInterface.addCallback("setDataXML", this, setDataXML);
	var exRS:Boolean = ExternalInterface.addCallback ("resizeMap", this, resizeMap);
}
//Also expose the map to FlashInterface for Flex/Laszlo Mode.
import com.fusionmaps.helper.FlashInterface;
//Publish the movie for FlashInterface
if (_loadModeExternal){
	//Register this SWF with FlashInterface to allow Flash 8 to Flash 9 communication
	FlashInterface.publish(_root, true);
}