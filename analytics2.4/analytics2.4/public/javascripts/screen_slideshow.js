
var slideshow2_noFading = false;
var slideshow2_timeBetweenSlides = 3000;	// Amount of time between each image(1000 = 3 second)
var slideshow2_fadingSpeed = 10;	// Speed of fading	(Lower value = faster)


var slideshow2_stats = new Array();

var slideshow2_slideIndex = new Array();	// Index of current image shown
var slideshow2_slideIndexNext = new Array();	// Index of next image shown
var slideshow2_imageDivs = new Array();	// Array of image divs(Created dynamically)
var slideshow2_currentOpacity = new Array();	// Initial opacity
var slideshow2_imagesInGallery = new Array();	// Number of images in gallery
var Opera = navigator.userAgent.indexOf('Opera')>=0?true:false;
function createParentDivs(imageIndex,divId)
{
	if(imageIndex==slideshow2_imagesInGallery[divId]){	
		showGallery(divId);
	}else{
		var imgObj = document.getElementById(divId + '_' + imageIndex);	
		if(Opera)imgObj.style.position = 'static';
		if(!slideshow2_imageDivs[divId])slideshow2_imageDivs[divId] = new Array();
		slideshow2_imageDivs[divId][slideshow2_imageDivs[divId].length] =  imgObj;

		imgObj.style.visibility = 'hidden';	
		imageIndex++;
		createParentDivs(imageIndex,divId);	
	}		
}

function showGallery(divId)
{
	if(slideshow2_slideIndex[divId]==-1)slideshow2_slideIndex[divId]=0; else slideshow2_slideIndex[divId]++;	// Index of next image to show
	if(slideshow2_slideIndex[divId]==slideshow2_imageDivs[divId].length)slideshow2_slideIndex[divId]=0;
	slideshow2_slideIndexNext[divId] = slideshow2_slideIndex[divId]+1;	// Index of the next next image
	if(slideshow2_slideIndexNext[divId]==slideshow2_imageDivs[divId].length)slideshow2_slideIndexNext[divId] = 0;

	
	slideshow2_currentOpacity[divId]=100;	// Reset current opacity

	// Displaying image divs
	slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.visibility = 'visible';
	if(Opera)slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.display = 'inline';
	if(navigator.userAgent.indexOf('Opera')<0){
		slideshow2_imageDivs[divId][slideshow2_slideIndexNext[divId]].style.visibility = 'visible';
	}
	
	if(document.all){	// IE rules
		slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.filter = 'alpha(opacity=100)';
		slideshow2_imageDivs[divId][slideshow2_slideIndexNext[divId]].style.filter = 'alpha(opacity=1)';
	}else{
		slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.opacity = 0.99;	// Can't use 1 and 0 because of screen flickering in FF
		slideshow2_imageDivs[divId][slideshow2_slideIndexNext[divId]].style.opacity = 0.01;
	}		
	

	setTimeout('revealImage("' + divId + '")',slideshow2_timeBetweenSlides);		
}

function revealImage(divId)
{

	if(slideshow2_noFading){
		slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.visibility = 'hidden';
		if(Opera)slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.display = 'none';
		showGallery(divId);
		return;
	}
	slideshow2_currentOpacity[divId]--;
	if(document.all){
		slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.filter = 'alpha(opacity='+slideshow2_currentOpacity[divId]+')';
		slideshow2_imageDivs[divId][slideshow2_slideIndexNext[divId]].style.filter = 'alpha(opacity='+(100-slideshow2_currentOpacity[divId])+')';
	}else{
		slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.opacity = Math.max(0.01,slideshow2_currentOpacity[divId]/100);	// Can't use 1 and 0 because of screen flickering in FF
		slideshow2_imageDivs[divId][slideshow2_slideIndexNext[divId]].style.opacity = Math.min(0.99,(1 - (slideshow2_currentOpacity[divId]/100)));
	}
	if(slideshow2_currentOpacity[divId]>0){
		setTimeout('revealImage("' + divId + '")',slideshow2_fadingSpeed);
	}else{
		slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.visibility = 'hidden';	
		if(Opera)slideshow2_imageDivs[divId][slideshow2_slideIndex[divId]].style.display = 'none';		
		showGallery(divId);
	}
}

function initImageGallery(divId)
{
	var slideshow2_galleryContainer = document.getElementById(divId);
	
	
	slideshow2_slideIndex[divId] = -1;
	slideshow2_slideIndexNext[divId] = false;
	
	var galleryImgArray = slideshow2_galleryContainer.getElementsByTagName('IMG');
	for(var no=0;no<galleryImgArray.length;no++){
		galleryImgArray[no].id = divId + '_' + no;
	}
	
	slideshow2_imagesInGallery[divId] = galleryImgArray.length;
	createParentDivs(0,divId);		
	
}