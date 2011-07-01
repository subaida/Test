/**
 * @class AnnotationManager
 * @author InfoSoft Global (P) Ltd. www.InfoSoftGlobal.com
 * @version 3.0.3
 *
 * Copyright (C) InfoSoft Global Pvt. Ltd. 2005-2006
 * AnnotationManager helps manange the annotations for a given
 * movie. It is the central unit that:
 * - Parses annotations XML. Handles error for invalid entries.
 * - Creates AnnotationGroup instances to represent them
 * - Renders them on-demand 
 * - Delegates event back to parent class on required occasions.
 * - Manages them together
*/
//Parent Map Class
import com.fusionmaps.core.Map;
//Annotation Group Class
import com.fusionmaps.helper.AnnotationGroup;
//Other necessary classes
import com.fusionmaps.helper.FCEnum;
import com.fusionmaps.helper.FCError;
import com.fusionmaps.helper.Utils;
import com.fusionmaps.helper.Logger;
class com.fusionmaps.helper.AnnotationManager{
	//Array to store all annotation groups
	private var group:Array;
	//Number of annotation groups
	private var numGroups:Number;
	//Reference to parent map class
	private var mapRef:Map;
	//Movie clip references that will contain the groups
	private var belowMC:MovieClip;
	private var aboveMC:MovieClip;
	//Current Stage width and height
	private var stageW:Number;	
	private var stageH:Number;
	//Original width and height of stage with whose respect the
	//co-ordinates are being given.
	private var origW:Number;
	private var origH:Number;
	//Whether to auto scale w.r.t orignal W and H
	private var autoScale:Boolean;
	//Whether to do a constrained scaling.
	private var constrainedScale:Boolean;
	//Whether to auto-scale images too?
	private var scaleImages:Boolean;
	//Wheter to auto-scale text?
	private var scaleText:Boolean;
	//X and Y Shift for the entire group (for correction purposes mainly)
	private var xShift:Number;
	private var yShift:Number;
	//Short forms for common function names
	private var getFV:Function;
	private var getFN:Function;
	private var toBoolean:Function;
	/*
	 * Constructor function.
	 *	@param	belowMC		Movie clip reference in which we'll plot items that
	 *						are to appear below other elements.
	 *	@param	aboveMC		Movie clip reference in which we'll plot items that
	 *						are to appear above other elements.
	 *	@param	mapRef		Reference to parent map class. We need a reference
	 *						so that we can log messages to the parent class.
 	 *	@param	stageW		Current width of the stage in which all annotation
	 *						group would be present.
	 *	@param	stageH		Current height of the stage in which all annotation
	 *						groups would be present.
	*/
	//(mapRef:Map)
	function AnnotationManager(belowMC:MovieClip, aboveMC:MovieClip, stageW:Number, stageH:Number){
		//Short forms for common function names.
		this.getFV = Utils.getFirstValue;
		this.getFN = Utils.getFirstNumber;
		this.toBoolean = Utils.toBoolean;
		//Store reference to map class
		this.mapRef = mapRef;
		//Reference to movie clips
		this.belowMC = belowMC;
		this.aboveMC = aboveMC;
		//Store current stage width and height
		this.stageW = stageW;
		this.stageH = stageH;
		//Initialize groups storage array and count
		this.group = new Array();
		this.numGroups = 0;
	}
	/**
	 * parseXML method parses the annotation XML from the passed XML node.
	 *	@param	annotationNode		<annotation> node and its child-nodes
	*/
	public function parseXML(annotationNode:XMLNode){
		//Loop variables
		var i:Number, j:Number;
		//Get attributes array
		var atts:Array = Utils.getAttributesArray(annotationNode);
		//Store the attributes
		this.origW = getFN(atts["origw"], this.stageW);
		this.origH = getFN(atts["origh"], this.stageH);
		this.autoScale = toBoolean(getFN(atts["autoscale"], 1));
		this.constrainedScale = toBoolean(getFN(atts["constrainedscale"],1));
		this.scaleImages = toBoolean(getFN(atts["scaleimages"],0));
		this.scaleText = toBoolean(getFN(atts["scaletext"],0));
		this.xShift = getFN(atts["xshift"],0);
		this.yShift = getFN(atts["yshift"],0);
		//Search for annotationGroup Nodes now
		for (i=0; i<annotationNode.childNodes.length; i++){
			//If it's annotationGroup node (or objectGroup, for backward compatibility)
			if (annotationNode.childNodes[i].nodeName.toUpperCase()=="ANNOTATIONGROUP" || annotationNode.childNodes[i].nodeName.toUpperCase()=="OBJECTGROUP"){
				//We deal with the group, only if the group has any child nodes
				if (annotationNode.childNodes[i].childNodes.length>0){
					//Update count of annotation groups
					this.numGroups++;
					//Extract attributes of Annotation group
					var anAtts:Array = Utils.getAttributesArray(annotationNode.childNodes[i]);
					var grpX:Number = getFN(anAtts["x"],anAtts["xpos"],0);
					var grpY:Number = getFN(anAtts["y"],anAtts["ypos"],0);
					var grpAlpha:Number = getFN(anAtts["alpha"],100);
					var grpXScale:Number = getFN(anAtts["xscale"],100);
					var grpYScale:Number = getFN(anAtts["yscale"],100);
					var grpOrigW:Number = getFN(anAtts["origw"], this.origW);
					var grpOrigH:Number = getFN(anAtts["origh"], this.origH);
					var grpAutoScale:Boolean = toBoolean(getFN(anAtts["autoscale"], this.autoScale?1:0));
					var grpConstrainedScale:Boolean = toBoolean(getFN(anAtts["constrainedscale"],this.constrainedScale?1:0));
					var grpScaleImages:Boolean = toBoolean(getFN(anAtts["scaleimages"],this.scaleImages?1:0));
					var grpScaleText:Boolean = toBoolean(getFN(anAtts["scaletext"],this.scaleText?1:0));
					var grpXShift:Number = getFN(anAtts["xshift"],this.xShift);
					var grpYShift:Number = getFN(anAtts["yshift"],this.yShift);
					//Whether to show below or above
					var showBelow:Boolean = toBoolean(getFN(anAtts["showbelow"],anAtts["showbelowchart"],1));
					trace(showBelow);
					//We need to store this annotation group as an AnnotationGroup instance.
					//Before that, based on whether we've to show the group below or above, we'll
					//need to create appropriate movie clips.
					var grpMC:MovieClip;
					if (showBelow){
						grpMC = belowMC.createEmptyMovieClip("AnnotationGrp_"+this.numGroups, belowMC.getNextHighestDepth());
					}else{
						grpMC = aboveMC.createEmptyMovieClip("AnnotationGrp_"+this.numGroups, aboveMC.getNextHighestDepth());
					}
					
					var anGrp:AnnotationGroup = new AnnotationGroup(grpMC, grpX, grpY, grpXScale, grpYScale, grpAlpha, this.stageW, this.stageH, grpOrigW, grpOrigH, grpAutoScale, grpConstrainedScale, grpScaleImages, grpScaleText, grpXShift, grpYShift);
					//Add to our group array
					this.group[this.numGroups] = anGrp;
					//Now, we need to iterate through each of the <annotation> node within <annotationGroup> node
					//and add them as items of annotation group.
					for (j=0; j<annotationNode.childNodes[i].childNodes.length; j++){
						//Add the node if it's Annotation (or Object node, for backward compatibility)
						if (annotationNode.childNodes[i].childNodes[j].nodeName.toUpperCase()=="ANNOTATION" || annotationNode.childNodes[i].childNodes[j].nodeName.toUpperCase()=="OBJECT"){
							try{
								anGrp.addItem(annotationNode.childNodes[i].childNodes[j]);
							} catch (e : com.fusionmaps.helper.FCError)
							{
								//If the control comes here, that means the given annotation type
								//identifier is invalid. So, we log the error message to the
								//logger.
								this.mapRef.log (e.name, e.message, e.level);								
							}
						}
					}
				}
			}
		}
	}
	/** 
	 * render method draws all the annotations on-screen.
	*/
	public function render():Void{
		//Iterate through all groups and call their draw function
		var i:Number;
		for (i=1; i<=this.numGroups; i++){
			this.group[i].draw();
			
			this.group[i].mc._xscale = 0;
			this.group[i].mc._yscale = 0;
			this.group[i].mc.onEnterFrame = function(){
				this._xscale++;
				this._yscale++;
				if (this._yscale==100){
					delete this.onEnterFrame;
				}
			}
		}
	}
	/** 
	 * destroy method removes all the annotations from memory.
	*/
	public function destroy():Void{
		//Iterate through all groups and call their destroy function
		var i:Number;
		for (i=1; i<=this.numGroups; i++){
			this.group[i].destroy();
		}		
	}
}