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

// Name of object
function Common(){}

/*
    Loading event listeners
    The function below calls the addEvent function to assign event listeners to controls
*/
Common.prototype.Load = function ()
{
    try
    {
        this.AddEvent(window, 'load', addListeners, true);
    }
    catch (Error)
    {
        alert(Error);
    }
};

/*
    Add event listeners
    The function below adds the event listeners to the passed element
    Parameters
        element - the element to add an event to
        eventType - the type of event to add (Example: "click" for the onclick event)
        functionName - the name of the function the event will call
*/
Common.prototype.AddEvent = function (element, eventType, functionName)
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
    Getting a Cookie
    The function below first checks if a cookie is stored at all in the document.cookie object. 
    If the document.cookie object holds some cookies, then check to see if our specific cookie is stored. 
    If our cookie is found, then return the value, if not - return an empty string.
    Parameters
        c_name - name of cookie
*/
Common.prototype.GetCookie = function (c_name)
{
    if (document.cookie.length>0)
    {
        c_start=document.cookie.indexOf(c_name + "=");
        if (c_start!=-1)
        { 
            c_start=c_start + c_name.length+1;
            c_end=document.cookie.indexOf(";",c_start);
            if (c_end==-1) c_end=document.cookie.length;
                return unescape(document.cookie.substring(c_start,c_end));
        } 
    }
    return "";
};

/*
    Setting a Cookie
    In the function below we first convert the number of days to a valid date, 
    then we add the number of days until the cookie should expire. 
    After that we store the cookie name, cookie value and the expiration date in the document.cookie object.
    Parameters 
        c_name - name of cookie
        value - value of cookie stored on the client computer
        expiredays - number of days until the cookie expires
*/
Common.prototype.SetCookie = function (c_name,value,expiredays)
{
    var exdate=new Date();
    exdate.setDate(exdate.getDate()+expiredays);
    document.cookie=c_name+ "=" + escape(value) + ((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
};

/*
    Deleting a Cookie
    The function below updates the expiration time on the cookie to be a date in the past (01-Jan-1970 00:00:01 GMT).
*/
Common.prototype.DeleteCookie = function (c_name)
{
	if ( this.GetCookie(c_name) ) document.cookie = c_name + "=;expires=Thu, 01-Jan-1970 00:00:01 GMT";
};

// Creating an XMLHttpRequest
Common.prototype.CreateXmlHttpRequest = function ()
{
    // See if browser is not IE
    if(typeof XMLHttpRequest != "undefined")
    {
        return new XMLHttpRequest();
    }
    // Browser is IE
    else if(window.ActiveXObject)
    {
        try
        {
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e)
        {
            xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        return xmlHttp;
    }
    throw new Error("XMLHttp object could not be created");
};