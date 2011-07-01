﻿/** --- AppMessages.as ---
 * Copyright 2005 InfoSoft Global Private Ltd. and its licensors.  All Rights Reserved.
 *
 * Use and/or redistribution of this file, in whole or in part, is subject
 * to the License Files, which was distributed with this component.
 *
 * This file contains display messages that we show to the end user
 * at various events. 
 *
 * For each language that you want to support, add the messages for that
 * language in the respective arrays.
 * 
 * Example, if you want to add french as an option, add the
 * messages in french as under, where FR is 2-letter ISO code for France,
 * which will be passed by the calling function
 *
 * _appMsgLoadingMap["FR"] = "Diagramme De Chargement. Svp Attente";
 * _appMsgRetrievingData["FR"] = "Recherche Des Données. Svp Attente.";
 * _appMsgReadingData["FR"] = "Données De Lecture. Svp Attente.";
 * _appMsgRenderingMap["FR"] = "Rendu Du Diagramme. Svp Attente.";
 * _appMsgNoData["FR"] = "Aucunes données à montrer.";
 * _appMsgLoadError["FR"] = "Erreur dans des données de chargement.";
 * _appMsgInvalidXML["FR"] = "Données inadmissibles de XML.";
*/
//Declare arrays of strings for various messages
var _appMsgLoadingMap:Array = new Array();
var _appMsgRetrievingData:Array = new Array();
var _appMsgReadingData:Array = new Array();
var _appMsgRenderingMap:Array = new Array();
var _appMsgNoData:Array = new Array();
var _appMsgLoadError:Array = new Array();
var _appMsgInvalidXML:Array = new Array();
//Store messages in English
_appMsgLoadingMap["EN"] = getFirstValue(this.PBarLoadingText, "Loading Map. Please Wait");
_appMsgRetrievingData["EN"] = getFirstValue(this.XMLLoadingText, "Retrieving Data. Please Wait");
_appMsgReadingData["EN"] = getFirstValue(this.ParsingDataText, "Reading Data. Please Wait");
_appMsgRenderingMap["EN"] = "Rendering Map. Please Wait";
_appMsgNoData["EN"] = getFirstValue(this.ChartNoDataText, "No data to display.");
_appMsgLoadError["EN"] = "Error in loading data.";
_appMsgInvalidXML["EN"] = "Invalid XML data.";
/**
 * getAppStr method gets the application string for that title
 * and language
*/
_global.getAppMessage = function(strTitle:String, strLang:String):String  {
	//Convert the language code to upper case
	strLang = strLang.toUpperCase();
	//Now, based on what string the user has requested, return
	switch (strTitle.toUpperCase()) {
	case "LOADINGMAP" :
		return _appMsgLoadingMap[strLang];
		break;
	case "RETRIEVINGDATA" :
		return _appMsgRetrievingData[strLang];
		break;
	case "READINGDATA" :
		return _appMsgReadingData[strLang];
		break;
	case "RENDERINGMAP" :
		return _appMsgRenderingMap[strLang];
		break;
	case "NODATA" :
		return _appMsgNoData[strLang];
		break;
	case "LOADERROR" :
		return _appMsgLoadError[strLang];
		break;
	case "INVALIDXML" :
		return _appMsgInvalidXML[strLang];
		break;
	}
};