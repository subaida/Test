			var temp_id;
			var ie	= document.all
			var ns6	= document.getElementById&&!document.all
			var isMenu 	= false ;
			
			var menuSelObj = null ;
			var overpopupmenu = false;
			var actionScript = null;
			var flag = false;
			
			   function statusMove(div, url, id, action,xpos,ypos) {
				temp_id = flag ? temp_id : id;	
				actionScript = action;
				if (ns6)
				{
					document.getElementById('menuDiv').style.left = parseInt(xpos)+document.body.scrollLeft+'px';
					document.getElementById('menuDiv').style.top = parseInt(ypos)+document.body.scrollTop+'px';
				} else
				{
					document.getElementById('menuDiv').style.left = parseInt(xpos)+document.body.scrollLeft+'px';
					document.getElementById('menuDiv').style.top = parseInt(ypos)+document.body.scrollTop+'px';
				}
				
				//document.getElementById('menuDiv').style.display = "";
				//document.getElementById('frmStatus').action="javascript:changeStatus("+action+");";
				isMenu = true;
		        if (Element.empty(div)) {
    		      //new Ajax.Updater(div, url, {
            		//method:     'get',
		           // onFailure:  function() {Element.classNames(div).add('failure')},
        		  //  onComplete: function() {new Effect.BlindDown(div, {duration: 0.25})}
		          //});
        		} else {
					flag = flag ? false : true;
		          new Effect[Element.visible(div) ? 
        	    'BlindUp' : 'BlindDown'](div, {duration: 0.25});
		        }
		      }
			  
			  function getAction(){
				  return changeStatus(actionScript);
			  }
			  

			// POP UP MENU
			function ItemSelMenu(e,id,Xpos,Ypos)
			{		
				temp_id = id;	
				if (ns6)
				{
					document.getElementById('menuDiv').style.left = parseInt(Xpos)+document.body.scrollLeft+'px';
					document.getElementById('menuDiv').style.top = parseInt(Ypos)+document.body.scrollTop+'px';
				} else
				{
					document.getElementById('menuDiv').style.pixelLeft = parseInt(Xpos)+document.body.scrollLeft;
					document.getElementById('menuDiv').style.pixelTop = parseInt(Ypos)+document.body.scrollTop;
				}
				document.getElementById('menuDiv').style.display = "";
				isMenu = true;
				return false ;
			}
			
			function getId(){
				return temp_id;
			}
			
			var temp;
			var tempDocument;
			
			function onLoadChange(session,id){
				//alert(session);
				//alert(id);
			if(!session){
				
			tempDocument = document.getElementById("1");
			tempDocument.style.color="#000000";
			tempDocument.style.textDecoration="underline";
			}else{
				
			tempDocument = document.getElementById("1");
			tempDocument.style.color="#000000";
			tempDocument.style.textDecoration="underline";
			}
			}
			function setLinkColor(obj){
			if (tempDocument != null){
			tempDocument.style.color="#666666";
			tempDocument.style.textDecoration="none";
			tempDocument = null;
			}
			if (temp != null){
			temp.style.color="#666666";
			temp.style.textDecoration="none";
			temp = null;
			}
			temp = obj;
			obj.style.color="#000000";
			obj.style.textDecoration="underline";
			}
			
			function setColor(obj)
			{
			obj.style.backgroundColor = "#FFFFDF";
			}
			
			function rem(obj)
			{
			obj.style.backgroundColor="#ffffff";
			 }
		
		
			function keyPress(obj){
			obj.style.color='#000000';
			}
		
			function cancelStatus(){
			document.getElementById('menuDiv').style.display = "none";
			}
			
			function changeStatus(itemNo){
			var tempList = document.frmStatus.selectStatus.options[document.frmStatus.selectStatus.selectedIndex].text;
			var tempText = document.frmStatus.textarea.value;
			
				if(itemNo == 1){
				document.location.href="/manage/campaignlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 2){
					document.location.href="/manage/publisherlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 3){
					document.location.href="/manage/rolelist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 4){
					document.location.href="/manage/adclientlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 5){
					document.location.href="/manageadvertiser/advertiserlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 6){
					document.location.href="/manageadvertiser/adlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 7){
					document.location.href="/supports/supportlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 8){
					document.location.href="/ads/adlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 10){
					document.location.href="/campaigns/campaign_list?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 11){
					document.location.href="/manageadvertiser/adfilterlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}else if(itemNo == 12){
					document.location.href="/publisher/adclient_summary?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}
				else if(itemNo == 13){
					document.location.href="/manage/campaign_list?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}
				else if(itemNo == 14){
					document.location.href="/ads/micrositeList?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}
				else if(itemNo == 15){
					document.location.href="/manage/userlist?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}
				
				else if(itemNo == 16){
					document.location.href="/adfilters/filter_summary?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}
				else if(itemNo == 17){
					document.location.href="/manageadvertiser/micrositeList?changeStatus=true&statusId="+tempList+"&reasonText="+tempText+"&id="+getId();
				}
		
		}
		
		function setBuyButton(n){
			
		var url = "/advertisers/googlebuttons?button="+n;
		
		ajax_loadContent('google',url);
		
		}
		
		function generateRxml(n)
		{
		
		var url = "/adminhome/_loc";
		
		ajax_loadContent('location',url);
		
		}
		
		function generateReport(type)
		{
			//alert(type);
			var reportFor=""+type;
			
			if (reportFor=='admin')
			{
				var url="/adminhome/reportPage";
				//ajax_loadContent('report',url);	
				//alert("ddd"):
			}
			if (reportFor=='advertiser')
			{
				var url="/advertiserhome/reportPage";	
				//alert('advertiser');
				ajax_loadContent('report',url);
			}
			if (reportFor=='publisher')
			{
				//alert("now in publisher");
				var url="/publisher/reportPage";
				ajax_loadContent('report',url);
				//alert("ASDF");
			}
			
		}
		
		function setNaviChange(e){
		e.style.color="#FFFFFF";
		e.style.backgroundColor="#4d4d4d";
		}
		
		function getUrl(){
			var cont = req
		}
		
		<!--
		
		
		
		
		
		
		
		function MM_swapImgRestore() { //v3.0
		  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
		}
		
		function MM_preloadImages() { //v3.0
		  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
			var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
			if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
		}
		
		function MM_findObj(n, d) { //v4.01
		  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
			d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		  if(!x && d.getElementById) x=d.getElementById(n); return x;
		}
		
		function MM_swapImage() { //v3.0
		  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
		   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
		}
		//-->
		
		function selectAll(chk)
		{
		for (var i=0;i < document.form.elements.length; i++)
			{
				elem = document.form.elements[i];
		
				if (elem.type == "checkbox")
				{
					elem.checked = chk.checked;
				}
			}
		}
	
		 
       
	   
		
		
       function CheckAll(chk)
       {
		for (var i=0; i < document.formCheck.elements.length; i++)
       {
	    var e = document.formCheck.elements[i];
        if (e.type == "checkbox")
        {
            e.checked = chk.checked;
        }
        }
         }
       
    	
    

		function hilite(theRow, isOver) 
		{ 
		  theRow.style.backgroundColor = (isOver) ? '#FFFFDF' : '#ffffff'; 
		}
		
		function loadSource(module){
		if(module == 'asp'){
		document.getElementById("aspImg").style.cursor='default';
		document.getElementById("phpImg").style.cursor='pointer';
		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='block';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_o.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		
		
		
		}else if(module == 'php'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='default';
		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='block';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_o.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		}else if(module == 'php5'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='pointer';
		document.getElementById("phpImg5").style.cursor='default';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='block';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_o.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		}else if(module == 'jsp'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='pointer';
 		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='default';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='block';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_o.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		}else if(module == 'ror'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='pointer';
		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='default';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='block';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_o.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		}else if(module == 'aspchash'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='pointer';
		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='default';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='block';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_o.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		}else if(module == 'aspvbdotnet'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='pointer';
		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='default';
		document.getElementById("facebookImg").style.cursor='pointer';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='block';
		document.getElementById("fbook").style.display='none';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_o.gif';
		document.getElementById("facebookImg").src='/images/facebook_n.gif';
		
		}else if(module == 'fbook'){
		
		document.getElementById("aspImg").style.cursor='pointer';
		document.getElementById("phpImg").style.cursor='pointer';
		document.getElementById("phpImg5").style.cursor='pointer';
		document.getElementById("jspImg").style.cursor='pointer';
		document.getElementById("rorImg").style.cursor='pointer';
		document.getElementById("aspchashImg").style.cursor='pointer';
		document.getElementById("aspvbdotnetImg").style.cursor='pointer';
		document.getElementById("facebookImg").style.cursor='default';
		
		document.getElementById("asp").style.display='none';
		document.getElementById("php").style.display='none';
		document.getElementById("php5").style.display='none';
		document.getElementById("jsp").style.display='none';
		document.getElementById("ror").style.display='none';
		document.getElementById("aspchash").style.display='none';
		document.getElementById("aspvbdotnet").style.display='none';
		document.getElementById("fbook").style.display='block';
		
		document.getElementById("aspImg").src='/images/aspsrc_n.gif';
		document.getElementById("phpImg").src='/images/php4_n.gif';
		document.getElementById("phpImg5").src='/images/php5_n.gif';
		document.getElementById("jspImg").src='/images/jspsrc_n.gif';
		document.getElementById("rorImg").src='/images/rorsrc_n.gif';
		document.getElementById("aspchashImg").src='/images/aspdotnetchashsrc_n.gif';
		document.getElementById("aspvbdotnetImg").src='/images/aspdotnetvbdotnetsrc_n.gif';
  		document.getElementById("facebookImg").src='/images/facebook_o.gif';
		
		}else if(module == 'j2me'){
		
		
		document.getElementById("j2meImg").style.cursor='default';
		
		document.getElementById("j2meImg").style.display='block';
		
		document.getElementById("j2meImg").src='/images/j2mesrc_o.gif';
		}
		}
		
		
		function rememberMe(user_username,pass)
		{	

			var userId = user_username; //document.getElementById('username').value
			var password = pass; //document.getElementById('pass').value
			newCookie('theAccountName', userId);    
			newCookie('thePassword', password);   
			
		}
		function newCookie(name,value,days)
		{
		  var days = 7;   
		  //alert("now in newCookie");
		 if (days) 
		 { 	
		   var date = new Date();
		   date.setTime(date.getTime()+(days*24*60*60*7));
		   var expires = "; expires="+date.toGMTString(); 
		 }
		   else var expires = "";
		   document.cookie = name+"="+value+expires+"; path=/";
		   //alert("document.cookie")
		}
		function readCookie(name) {	
		   var nameSG = name + "=";
		   var nuller = '';
		  if (document.cookie.indexOf(nameSG) == -1)
			return nuller;
		
		   var ca = document.cookie.split(';');
		  for(var i=0; i < ca.length; i++)
		  {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameSG) == 0) return c.substring(nameSG.length,c.length);
		   }
		   return null; 
		   }
		   
		function loadAjax(id)
			{
	filelist = "/sms/listbox?val="+id.value;		
	new Ajax.Updater('multiple', filelist, { method:'get' });

}

	/************************************************************************************************************
	(C) www.dhtmlgoodies.com, October 2005
	
	This is a script from www.dhtmlgoodies.com. You will find this and a lot of other scripts at our website.	
	
	Terms of use:
	You are free to use this script as long as the copyright message is kept intact. However, you may not
	redistribute, sell or repost it without our permission.
	
	Thank you!
	
	www.dhtmlgoodies.com
	Alf Magne Kalleland
	
	************************************************************************************************************/
	
	/* You can modify the following javascript variables as you like */
	
	/*var initActiveMenuItem = 0; // 	If one of the menu items should be initially highlighted.(-1 = none, 0 = first item, 1 = second...)
	var activeSmallSquareColor = '#D60808'; // Color of small square at the left of each menu item
	var colorSquareWidth = 2; 	// Width of small square;
	var marginSquare = 1;	// Margin at the right of the small color square at the left of each menu item	
	
	var bgColorLinks = "#E2EBED";	// Background color for menu links
	var degreesToDarkenOrLighten = 5; // How many percent point to darken the color above on mouse over (10-15 percent point is usually enough).
	var darkenOnMouseOver = true;	*/// Darken or Lighten on mouse over (true = darken, false = lighten) 
	/* ABOUT COLORS
	You can use the color schemer at www.dhtmlgoodies.com to find your colors
	
	We use the HSB color system here, The HSB color system is based on three values
	
	* Hue = Which color, i.e. degree on color wheel
	* Saturation = Intensity of the color to use
	* Brightness = Brightness of the color
	
	
	When you use the color schemer at the site, pick a color from the palett or type it into the RGB text box(format #RRGGBB, example #E2EBED)
	Then adjust the value of brightness by typing in a new value in that text box(label "B"). 
	
	*/		
		
	/*var timeStepOpacitySquare = 15;	// Microseconds between each opacity change	-> Lower value = faster
	var opacityChangePerStep = 10;	// Steps - change in opacity - on mouse out	= Higher = faster	
	var timeStepSwitchBgColor = 10;	// Microseconds between each text background change(darken or lighten)	-> Lower value = faster
	var bgColorStep  = 0.75;	*/// lower value = slower bg color fading(Usually, you will always have the value 1 or a little lower)
								// Choose a low value if the number of degrees to darken is low.
	
	/************************************************************************************************************
	* END OF USER VARIABLES
	*
	* Don't change anything below here 
	*
	************************************************************************************************************/
	/*var activeMenuItem = false;
	var activeMenuLink = false;	
	var menuObj;
	var brightnessLink = false; 
	var brightnessLinkMin = false;
	var darkenBrightnessCounter = false; // Darken or lighten - this variable is set manually
	var startHue = false;
	var startSat = false;
	
	
	
	function showMenuItem()
	{
		var hsb = toHSV(this.getAttribute('bgColorItem'));
		if(darkenOnMouseOver){
			var brightness = hsb[2] - (degreesToDarkenOrLighten/100);
		}else{
			var brightness = hsb[2] + (degreesToDarkenOrLighten/100);
		}
		if(brightness<0)brightness=0;
		if(brightness>1)brightness=1;
		var rgb = toRgb(hsb[0],hsb[1],brightness);
		this.style.backgroundColor = rgb;
		this.currentBgColorItem = rgb;
		this.setAttribute('currentBgColorItem',rgb);
		
		var obj = this.parentNode.getElementsByTagName('DIV')[0];
		obj.setAttribute('okToHide','0');
		obj.okToHide = 0;
		this.setAttribute('okToHide','0');
		this.okToHide = 0;
		obj.style.visibility = 'visible';
		
		obj.style.opacity = 0.98;	
		obj.style.filter = 'alpha(opacity=98)';
		

	}
	
	function hideMenuItem()
	{
		if(this.getAttribute('initActive')=='1')return;
		if(this.initActive=='1')return;
		var obj = this.parentNode.getElementsByTagName('DIV')[0];
		obj.setAttribute('okToHide','1');
		obj.okToHide = 1;
		this.setAttribute('okToHide','1');
		this.okToHide = 1;
		obj.style.visibility = 'visible';		
		if(navigator.userAgent.indexOf('Opera')>=0){
			obj.style.visibility = 'hidden';
		}else{
			progressHideSquare(obj.id,(opacityChangePerStep*-1));	
		}		
		progressShowHideBgColor(this.id);	
	}
	
	
	function progressShowHideBgColor(inputId)
	{
		
		var obj = document.getElementById(inputId);
		var currentBgColor = obj.getAttribute('currentBgColorItem');
		if(obj.getAttribute('okToHide')=='0')return;
		if(!currentBgColor)currentBgColor = obj.currentBgColorItem;
		if(currentBgColor){
			var hsb = toHSV(currentBgColor);
			var brightness = hsb[2];			
			brightness+=darkenBrightnessCounter;
			if((brightness>brightnessLink && darkenOnMouseOver) || (brightness<brightnessLink && !darkenOnMouseOver))brightness = brightnessLink;
			var rgb = toRgb(startHue,startSat,brightness);
			obj.style.backgroundColor = rgb;
			obj.currentBgColorItem = rgb;
			obj.setAttribute('currentBgColorItem',rgb);		
			if((hsb[2]<brightness && darkenOnMouseOver) || (hsb[2]>brightness && !darkenOnMouseOver)){
				setTimeout('progressShowHideBgColor(\'' + inputId + '\')',timeStepSwitchBgColor);				
			}else{
				obj.style.backgroundColor = bgColorLinks;
			}
		}			
	}	
	
	function progressHideSquare(inputId,step)
	{
		
		var obj = document.getElementById(inputId);

		if(obj.getAttribute('okToHide')=='0' && step<0)return;
				
		if(document.all){
			var currentOpacity = obj.style.filter.replace(/[^\d]/g,'')/1;

			if(currentOpacity>=99){

			}
			else if(currentOpacity==11){
				obj.style.visibility='hidden';
			}else{
				currentOpacity = currentOpacity + step;
				if(currentOpacity<1)currentOpacity=1;
				if(currentOpacity>99)currentOpacity=9;
				obj.style.filter = 'alpha(opacity=' + currentOpacity + ')';
				setTimeout('progressHideSquare("' + inputId + '",' + (step) + ')',timeStepOpacitySquare);
			}				
		}else{
			step = step / 100;
			var currentOpacity = obj.style.opacity/1;

			if(currentOpacity>=0.99){

			}
			else if(currentOpacity==0.01){
				obj.style.visibility='hidden';
			}else{
				currentOpacity = currentOpacity + step;

				if(currentOpacity<0.01)currentOpacity=0.01;
				if(currentOpacity>0.99)currentOpacity=0.99;
				obj.style.opacity = currentOpacity;
				setTimeout('progressHideSquare("' + inputId + '",' + (step*100) + ')',timeStepOpacitySquare);
			}	
		}		
	}
	
	
	function dhtmlgoodies_initMenu()
	{
		menuObj = document.getElementById('dhtmlgoodies_menu');
		var hsbArray = toHSV(bgColorLinks);
		brightnessLink = hsbArray[2];
		startHue = hsbArray[0];
		startSat = hsbArray[1];
		if(darkenOnMouseOver){
			brightnessLinkMin = Math.max(hsbArray[2] - (degreesToDarkenOrLighten/100),0);
			darkenBrightnessCounter = bgColorStep/100;
		}else{
			brightnessLinkMin = Math.min(hsbArray[2] + (degreesToDarkenOrLighten/100),1);
			darkenBrightnessCounter = (bgColorStep/100)*-1;
		}
		var listItems = menuObj.getElementsByTagName('LI');
		for(var no=0;no<listItems.length;no++){
			listItems[no].id = 'listItem' + no;	
	
			var menuLink = listItems[no].getElementsByTagName('A')[0];
			var height = menuLink.offsetHeight;	
			menuLink.style.display='block';
			menuLink.style.height=height + 'px';
			menuLink.style.lineHeight=height + 'px';
			menuLink.onmouseover = showMenuItem;		
			menuLink.onmouseout = hideMenuItem;		
			menuLink.style.backgroundColor = bgColorLinks;
			menuLink.setAttribute('bgColorItem',bgColorLinks);
			menuLink.bgColorItem = bgColorLinks;
			menuLink.setAttribute('currentBgColorItem',bgColorLinks);
			menuLink.currentBgColorItem = bgColorLinks;
			menuLink.id = 'listLink' + no;
			
			
			
			var colorDiv = document.createElement('DIV');
			colorDiv.innerHTML = '<span><\/span>';
			colorDiv.style.height = height + 'px';
			colorDiv.style.width = colorSquareWidth + 'px';
			colorDiv.style.backgroundColor = activeSmallSquareColor;
			colorDiv.style.marginRight = marginSquare + 'px';
			colorDiv.style.visibility = 'hidden'			
			colorDiv.id = 'colorSquare' + no;
			colorDiv.style.opacity = 0.99;	// Not possible to use 1 because of JS flickering in Firefox
			colorDiv.style.filter = 'alpha(opacity=100)';
			
			if(initActiveMenuItem==no){
				colorDiv.style.visibility = 'visible';
				menuLink.style.backgroundColor = toRgb(startHue,startSat,brightnessLinkMin);
				menuLink.initActive = '1';
				menuLink.setAttribute('initActive','1');
				
			}
			
			listItems[no].appendChild(colorDiv);			
			listItems[no].appendChild(menuLink);

			var clearDiv = document.createElement('DIV');
			clearDiv.style.clear='both';
			listItems[no].appendChild(clearDiv);
						
			var currentWidth = (listItems[no].offsetWidth - colorDiv.offsetWidth - marginSquare);
			menuLink.style.width =  currentWidth + 'px';
			while(listItems[no].offsetHeight>=(menuLink.offsetHeight*2)){		
				currentWidth--;	
				menuLink.style.width =  currentWidth + 'px';
				
			}
		}		
	}
	window.onload = dhtmlgoodies_initMenu;
	*/
function updatephone()
{ 

 if (document.getElementById('get_Phone').checked==true)
 {
	
	new Ajax.Updater('multiple_phone','/ads/phone?select_phone=phone',{ method:'get' }); 
}
 if (document.getElementById('get_Email').checked==true)	
 {
	 
  new Ajax.Updater('multiple','/ads/phone?select=get_email',{ method:'get' });
 }
}

function displaytextbox()
{	
 
 
     if(document.getElementById('get_Email').checked==false)
  {
	  //alert("Email UnChecked");
     //document.getElementById('multiple').style.display='block';
	  
	document.getElementById('getmail').style.display='none';
	 
	    
  }
  else if(document.getElementById('get_Email').checked==true)
  {
	  
    // document.getElementById('multiple').style.display='block';
	 document.getElementById('getmail').style.display='block';
	  
  }
  
   if (document.getElementById('get_Phone').checked==false)
  {
	
   document.getElementById('phonein').style.display='none';
  // document.getElementById('phonein').style.display='block';

  }
    else if (document.getElementById('get_Phone').checked==true)
  {
	 
   //document.getElementById('multiple').style.display='block';
   document.getElementById('phonein').style.display='block';
  }
 
}

function updatephoneadmin()
{ 

 if (document.getElementById('getPhoneadmin').checked==true)
 {
	
	new Ajax.Updater('multiple_phone','/manageadvertiser/phone?select_phone=phone',{ method:'get' }); 
}
 if (document.getElementById('getEmail').checked==true)	
 {
	 
  new Ajax.Updater('multiple','/manageadvertiser/phone?select=get_email',{ method:'get' });
 }
}
function displaytextboxadmin()
{
 
  if (document.getElementById('getPhoneadmin').checked==true)
  {
	
   document.getElementById('phonein').style.display='block';
  // document.getElementById('phonein').style.display='block';

  }
    else if (document.getElementById('getPhoneadmin').checked==false)
  {
	 
   //document.getElementById('multiple').style.display='block';
   document.getElementById('phonein').style.display='none';
  }
     if(document.getElementById('getEmail').checked==false)
  {
	  //alert("Email UnChecked");
     //document.getElementById('multiple').style.display='block';
	  
	  document.getElementById('getmail').style.display='none';
  }
  else if(document.getElementById('getEmail').checked==true)
  {
	  
    // document.getElementById('multiple').style.display='block';
	  document.getElementById('getmail').style.display='block';
  }
 
}

//This method is used for Remember Me in Login page

function getFormValues()
{

	if (readCookie('zr')!=null)
	{		
		if (readCookie('zr')=='on')		
		{
			document.getElementById('checkMe').checked=checked;
		}
		else
		{
			
		}
	}
	
	if (readCookie('zu')!=null)
	{
		
		document.getElementById('user_username').value=readCookie('zu');
	}
	 
	
	if (readCookie('zp')!=null)
	{
		
		document.getElementById('pass').value=readCookie('zp');
	}
	 
}

//calling the getFormValues to get the cookies and display it
setTimeout('getFormValues()',200);



//Function name: getFormValues
//Written by: Asif Ali
//Version: 1.0
//Last modified date: May 10th 2008


function getFormValues()
{
	if (readCookie('zr')!=null)
	{
   		document.getElementById('checkMe').checked=readCookie('zr');
    
	}
	if (readCookie('zu')!=null)
	{
		
		document.getElementById('user_username').value=readCookie('zu');
	}
	 
	
	if (readCookie('zp')!=null)
	{
		
		document.getElementById('pass').value=readCookie('zp');
	}
	 
}

//calling the getFormValues to get the cookies and display it
setTimeout('getFormValues()',200);



//Function name: Store
//Written by: Asif Ali
//Version: 1.0
//Last modified date: May 10th 2008
//Purpose: To store username and password

function storeFormValues(obj)
{
	if (obj.checkMe.checked==true)
	{ 
	//storing default cookie for remember
		createCookie('zr',obj.checkMe.value,10);	
	
	 	if (obj.user_username.value!='')
			createCookie('zu',obj.user_username.value,10);

		if (obj.pass.value!='')
			createCookie('zp',obj.pass.value,10);		 
    }
	else
	{
		 eraseCookie('zu');
         eraseCookie('zp');
		 eraseCookie('zr');
		 	 
	}
	
}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}

function generateXML(adcliet_id,start_on,end_on)
{
	alert(adcliet_id);
	alert(start_on);
	alert(end_on);
}
