// ===================================================================
// Author: Christopher Manciero <cmanciero@gmail.com>
// WWW: http://www.chrismanciero.com/
//
// NOTICE: You may use this code for any purpose, commercial or
// private, without any further permission from the author. You may
// remove this notice from your final code if you wish, however it is
// appreciated by the author if at least my web site address is kept.
//
// You may *NOT* re-distribute this code in any way except through its
// use. That means, you can include it in your product, or your web
// site, or any other form where the code is actually being used. You
// may not put the plain javascript up on your site for download or
// include it in your javascript libraries for download. 
// If you wish to share this code with others, please just point them
// to the URL instead.
// Please DO NOT link directly to my .js files from your site. Copy
// the files to your server and use them there. Thank you.
// ===================================================================

/*
    AutoSuggest variables
        arrResults - array that holds the results from the database
        arrSuggest - holds the matches from the text entered
        autobox - autosuggest dropdown list
        textbox - textbox
        currentPosition - the highlight result position in the autosuggest dropdown list
*/
var arrResults = new Array();
var arrSuggest = new Array();
var autobox = null;
var textbox = null;
var currentPosition = -1;

/*
    Add event listeners
    The function below adds the event listeners to the passed element
    Parameters
        element - the element to add an event to
        eventType - the type of event to add (Example: "click" for the onclick event)
        functionName - the name of the function the event will call
*/
AutoSuggest.prototype.AddEvent = function (element, eventType, functionName)
{
	if (element.addEventListener) /* Adds events for Mozilla browsers */ {
		element.addEventListener(eventType, functionName, false);
		return true;
	}
	else if (element.attachEvent) /* Adds events for IE browsers */{
		var r = element.attachEvent('on' + eventType, functionName);
		return r;
	}
	else {
		element['on' + eventType] = functionName;
	}
};

/*
    This object creates an autosuggest box for the given textbox
    Parameters
        textBoxToAddAutoSuggestTo - the textbox to add the autosuggest dropdown to
*/   
function AutoSuggest(TextBoxToAddAutoSuggestTo, AutoSuggestCssClass,resource)
{
    textbox = document.getElementById(TextBoxToAddAutoSuggestTo);
    textbox.focus();
    GetSuggestions(resource);
    this.Load(AutoSuggestCssClass);
	
}

/*
    Loading the autosuggest box
    This function below creates keyup, keydown and keypress events for the given textbox
    and creates the autosuggest dropdown and assigns mousedown, mouseover and mouseup events.
*/
AutoSuggest.prototype.Load = function(AutoSuggestCssClass)
{   
    this.AddEvent(textbox, "keyup", this.ShowSuggest);
    this.AddEvent(textbox, "blur", this.HideSuggestions);
    
    var divAuto = document.getElementById("divAuto");
    autobox = document.createElement("div");
    autobox.id = "divSuggest";
    autobox.className = AutoSuggestCssClass;
    autobox.style.display = "none";
	
    autobox.onmousedown =
    autobox.onmouseup = 
    autobox.onmouseover = function (oEvent) {
        oEvent = oEvent || window.event;
        oTarget = oEvent.target || oEvent.srcElement;
        if (oEvent.type == "mousedown") {
            textbox.value = oTarget.firstChild.nodeValue;
            AutoSuggest.prototype.HideSuggestions();
        } else if (oEvent.type == "mouseover") {
            AutoSuggest.prototype.HighlightSuggestion(oTarget);
        } else {
            textbox.focus();
        }
    };     
    
    divAuto.appendChild(autobox);
};

/*
    Highlighting the suggestions
    This function highlights the suggestion in the autosuggest dropdown
    Parameters
        suggestion - the suggestion to highlight
*/
AutoSuggest.prototype.HighlightSuggestion = function(suggestion)
{
    for (var i=0; i < autobox.childNodes.length; i++) {
        var oNode = autobox.childNodes[i];
        if (oNode == suggestion) {
            oNode.className = "current";
            currentPosition = i;
        } else if (oNode.className == "current") {
            oNode.className = "";
        }
    }
};

/*
    Hiding the suggestions
    This function hides the suggestion when a selection is made or if no matches are found
*/
AutoSuggest.prototype.HideSuggestions = function()
{
    autobox.style.visibility = "hidden";
    autobox.style.display = "none";
};

/*
    Highlights the next suggestion in the dropdown and
    places the suggestion into the textbox.
 */
AutoSuggest.prototype.NextSuggestion = function () {
    var cSuggestionNodes = autobox.childNodes;
    if (cSuggestionNodes.length > 0 && currentPosition < cSuggestionNodes.length-1) {
        var oNode = cSuggestionNodes[++currentPosition];
        AutoSuggest.prototype.HighlightSuggestion(oNode);
        textbox.value = oNode.firstChild.nodeValue; 
    }
};

/*
    Highlights the previous suggestion in the dropdown and
    places the suggestion into the textbox.
 */
AutoSuggest.prototype.PreviousSuggestion = function () {
    var cSuggestionNodes = autobox.childNodes;

    if (cSuggestionNodes.length > 0 && currentPosition > 0) {
        var oNode = cSuggestionNodes[--currentPosition];
        AutoSuggest.prototype.HighlightSuggestion(oNode);
        textbox.value = oNode.firstChild.nodeValue;   
    }
};

/*
    Find position of textbox
    This function finds the position of the given textbox to know where to create
    the autosuggest dropdown
    Parameters
        obj - the textbox to create the autosuggest dropdown under
*/
AutoSuggest.prototype.FindPos = function(obj)
{
	var curleft = 0;
	var curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft
		curtop = obj.offsetTop
		while (obj == obj.offsetParent) {
			curleft += obj.offsetLeft
			curtop += obj.offsetTop
		}
	}
	return [curtop,curleft];
};

/*
    Show the suggestions
    This function fills the autosuggest dropdown with results that match the
    text that was entered in the given textbox.
*/
AutoSuggest.prototype.ShowSuggest = function(e)
{
    var keycode;
    if (window.event) /* IE */
    {
        keycode = window.event.keyCode;
    }
    else if (e) /* Mozilla */
    {
        keycode = e.which;
    }
    
    if(keycode == 38 || keycode == 40 || keycode == 13)
    {
        switch(keycode)
        {
            case 38:
                AutoSuggest.prototype.PreviousSuggestion();
                break;
            case 40:
                AutoSuggest.prototype.NextSuggestion();
                break;
            case 13:
                AutoSuggest.prototype.HideSuggestions();
                break;
        }        
    }
    else
    {        
        currentPosition = -1;
        var suggest = null;
        autobox.innerHTML = "";
        
        var location = AutoSuggest.prototype.FindPos(textbox);
        var diffTop = location[0] - textbox.offsetTop;
        var diffLeft = location[1] - textbox.offsetLeft;
           
        autobox.style.top = location[0] - diffTop + textbox.offsetHeight + "px"; 
        autobox.style.left = location[1] - diffLeft + "px";   
        autobox.style.width = textbox.style.width;
        
        arrSuggest = new Array();
        
        if(textbox.value.length > 0)
        {
            for (var i=0; i < arrResults.length; i++)
            {
                if (arrResults[i].toLowerCase().indexOf(textbox.value.toLowerCase()) == 0)
                {
					
                    arrSuggest.push(arrResults[i]);
                }
            }
            
            if(arrSuggest.length > 0)
            {
                for(var j = 0; j< arrSuggest.length; j++)
                {
                    suggest = document.createElement("div");
                    suggest.style.padding = "5px";
					suggest.style.borderBottom = "solid #EFEFEF 1px";
					suggest.style.borderRight = "solid #EFEFEF 1px";
					suggest.style.borderLeft = "solid #EFEFEF 1px";
                    suggest.appendChild(document.createTextNode(arrSuggest[j]));
                                    
                    autobox.style.visibility = "visible";
                    autobox.style.display = "block";
                    
                    /* 
                        This is a hack that I put in to make the auto suggest box work on my site (style wise).
                        The reason for this hack is because of my styles that when the auto suggest box is created
                        in Interner Explorer it was shifted to the left 30px so I added this quick fix.
                    */
                    if (window.event) 
                    {                 
                        autobox.style.width = "100%";
						autobox.style.left = "190px";
						autobox.style.top = "322px";
						autobox.style.border = "none";
						
						if ((screen.width<=1024) && (screen.height<=768))
						{
 							autobox.style.left = "62px";
						}
						
						var x = navigator;
						if (x.appName == 'Netscape') 
						{
						autobox.style.width = "auto";
						autobox.style.top = "314px";
						autobox.style.left = "191px";
						}
						else{} 
						
					}
					else
					{
					autobox.style.width = "auto";
					}
                    
                    autobox.appendChild(suggest);
                }
            }
            else
            {
                AutoSuggest.prototype.HideSuggestions();
            }
        }
        else    
        {
            AutoSuggest.prototype.HideSuggestions();
        }
    }
};

/*
    Find position of textbox
    This function finds the position of the given textbox to know where to create
    the autosuggest dropdown
    Parameters
        obj - the textbox to create the autosuggest dropdown under
*/
AutoSuggest.prototype.FindPos = function(obj)
{
	var curleft = 0;
	var curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft
		curtop = obj.offsetTop
		while (obj == obj.offsetParent) {
			curleft += obj.offsetLeft
			curtop += obj.offsetTop
		}
	}
	return [curtop,curleft];
};

/*
    Show the suggestions
    This function fills the autosuggest dropdown with results that match the
    text that was entered in the given textbox.
*/
AutoSuggest.prototype.ShowSuggest = function(e)
{
    var keycode;
    if (window.event) /* IE */
    {
        keycode = window.event.keyCode;
    }
    else if (e) /* Mozilla */
    {
        keycode = e.which;
    }
    
    if(keycode == 38 || keycode == 40 || keycode == 13)
    {
        switch(keycode)
        {
            case 38:
                AutoSuggest.prototype.PreviousSuggestion();
                break;
            case 40:
                AutoSuggest.prototype.NextSuggestion();
                break;
            case 13:
                AutoSuggest.prototype.HideSuggestions();
                break;
        }        
    }
    else
    {        
        currentPosition = -1;
        var suggest = null;
        autobox.innerHTML = "";
        
        var location = AutoSuggest.prototype.FindPos(textbox);
        var diffTop = location[0] - textbox.offsetTop;
        var diffLeft = location[1] - textbox.offsetLeft;
           
        autobox.style.top = location[0] - diffTop + textbox.offsetHeight + "px"; 
        autobox.style.left = location[1] - diffLeft + "px";   
        autobox.style.width = textbox.style.width;
        
        arrSuggest = new Array();
        
        if(textbox.value.length > 0)
        {
            for (var i=0; i < arrResults.length; i++)
            {
                if (arrResults[i].toLowerCase().indexOf(textbox.value.toLowerCase()) == 0)
                {
                    arrSuggest.push(arrResults[i]);
                }
            }
            
            if(arrSuggest.length > 0)
            {
                for(var j = 0; j< arrSuggest.length; j++)
                {
                    suggest = document.createElement("div");
                    suggest.style.padding = "5px";
                    suggest.appendChild(document.createTextNode(arrSuggest[j]));
                                    
                    autobox.style.visibility = "visible";
                    autobox.style.display = "block";
                    
                    /* 
                        This is a hack that I put in to make the auto suggest box work on my site (style wise).
                        The reason for this hack is because of my styles that when the auto suggest box is created
                        in Interner Explorer it was shifted to the left 30px so I added this quick fix.
                    */
                    if (window.event) 
                    {                 
                        autobox.style.marginLeft = "-30px";
                    }
                    
                    autobox.appendChild(suggest);
                }
            }
            else
            {
                AutoSuggest.prototype.HideSuggestions();
            }
        }
        else    
        {
            AutoSuggest.prototype.HideSuggestions();
        }
    }
};

/*
    Gets the suggestions
    This functions calls a webservice and return the values that match the text being entered
    Parameters
        text - text being entered in the textbox
*/
function GetSuggestions(resourceName)
{
    var common = new Common();
    var url = "/admin_analytic/autosuggest?resource="+resourceName;
    try
    {
        var objXml = common.CreateXmlHttpRequest();
        objXml.open("get", url, true);
        objXml.onreadystatechange = function(){
            if(objXml.readyState == 4)
            {
                if(objXml.status == 200)
                {
                    var entities = objXml.responseXML.getElementsByTagName("entities");
                    arrResults = new Array();
                    
                    for(var st = 0; st < entities.length; st++)
                    {
                        var entityNames = entities[st].getElementsByTagName("entityname");                        
                        arrResults[st] = entityNames[0].firstChild.data;
                    }
						//arrResults.push(['Deleted','Approved','Active','InActive','Paused'])					
                }
            }
        };
        
        objXml.send(null);
    }
    catch(Error)
    {
        alert(Error);
    }
}

