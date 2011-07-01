/**
 * @class MarkerShape
 * @author InfoSoft Global (P) Ltd. www.InfoSoftGlobal.com
 * @version 3.0.3
 *
 * Copyright (C) InfoSoft Global Pvt. Ltd. 2005-2006
 * MarkerShape represents a single marker shape to be drawn on the map.
*/
import com.fusionmaps.helper.FCEnum;
import com.fusionmaps.helper.FCError;
import com.fusionmaps.helper.Utils;
import com.fusionmaps.helper.Logger;
//Extensions
import com.fusionmaps.extensions.ColorExt;
import com.fusionmaps.extensions.DrawingExt;
class com.fusionmaps.helper.MarkerShape{
	//Movie clip holder for this group
	public var mc:MovieClip;
	//Object to store properties of the shape
	private var prop:Object;
	//X and Y Position
	private var x:Number;
	private var y:Number;
	//Scaling that we've to apply
	private var scale:Number;	
	/**
	 * Constructor function for AnnotationGroup.
	 *	@param	mc			Movie clip holder in which the entire group
	 *						will be rendered.
	 *	@param	x			X Position of the shape
	 *	@param	y			Y Position of the shape
	 *	@param	prop		Object containing properties for the marker shape.
	 *	@param	scale		Scaling to be applied.
	*/
	function MarkerShape(mc:MovieClip, x:Number, y:Number, prop:Object, scale:Number){
		//Store parameters
		this.mc = mc;
		this.x = x;
		this.y = y;
		this.prop = prop;
		this.scale = scale;
	}	
	/**
	 * draw method draws all the items in this annotation group, after applying
	 * proper scaling, shifting etc.
	*/
	public function draw(){
		//Temporary storage variables
		var x:Number, y:Number, radius:Number, innerRadius:Number;
		//Fetch values
		x = this.x;
		y = this.y;
		//Apply proper scaling to radius and inner radius
		radius = this.prop.radius * this.scale;
		innerRadius = this.prop.innerRadius * this.scale;
		//Set the alpha of the entire movie clip
		this.mc._alpha = this.prop.alpha;		
		//Start drawing based on type of the item.
		switch (this.prop.type){				
			case "circle":
				//Set the cosmectic properties					
				this.mc.lineStyle(this.prop.borderThickness, parseInt(this.prop.borderColor,16), this.prop.borderAlpha);					
				//Keep the center of gradient at left side
				this.mc.beginGradientFill(this.prop.fillPattern, this.prop.fillColor, this.prop.fillAlpha, this.prop.fillRatio, {matrixType:"box", x:-radius, y:-radius, w:radius*2, h:radius*2, r:((360-this.prop.fillAngle)/180)*Math.PI});
				//Draw keeping 0,0 as registration point at center
				DrawingExt.drawCircle(this.mc, 0, 0, radius, radius, 0, 360);
				//End fill
				this.mc.endFill();
				//Set the X and Y of container movie clip
				this.mc._x = x;
				this.mc._y = y; 
				break;
			case "polygon":
				//Set the cosmectic properties					
				this.mc.lineStyle(this.prop.borderThickness, parseInt(this.prop.borderColor,16), this.prop.borderAlpha);					
				//Keep the center of gradient at left side
				this.mc.beginGradientFill(this.prop.fillPattern, this.prop.fillColor, this.prop.fillAlpha, this.prop.fillRatio, {matrixType:"box", x:-radius, y:-radius, w:radius*2, h:radius*2, r:((360-this.prop.fillAngle)/180)*Math.PI});
				//Draw keeping 0,0 as registration point at center
				DrawingExt.drawPoly(this.mc, 0, 0, this.prop.sides, radius, this.prop.startAngle);
				//End fill
				this.mc.endFill();
				//Set the X and Y of container movie clip
				this.mc._x = x;
				this.mc._y = y; 
				break;
			case "arc":
				//Store end points
				var ax:Number, ay:Number;
				var bx:Number, by:Number;
				ax = Math.cos(this.prop.endAngle/180*Math.PI)*innerRadius;
				ay = Math.sin(-this.prop.endAngle/180*Math.PI)*innerRadius;
				bx = Math.cos(this.prop.startAngle/180*Math.PI)*radius;
				by = Math.sin(-this.prop.startAngle/180*Math.PI)*radius;
				//We'll draw the border and fill separately because of the strange
				//behavior in beginFill which connects to the start point, irrespective
				//of specifying all co-ordinates.
				
				//Get the sweep angle
				var sweepAngle:Number = Math.abs(this.prop.endAngle-this.prop.startAngle);																				
				//First, draw the fill without any border.
				//--------------------------------------------------------------//
				this.mc.lineStyle();
				this.mc.beginGradientFill(this.prop.fillPattern, this.prop.fillColor, this.prop.fillAlpha, this.prop.fillRatio, {matrixType:"box", x:-radius, y:-radius, w:radius*2, h:radius*2, r:((360-this.prop.fillAngle)/180)*Math.PI});
				//DrawingExt.drawArc(this.mc, 0, 0, this.prop.startAngle, this.prop.endAngle-this.prop.startAngle, radius, radius)
				DrawingExt.drawCircle(this.mc, 0, 0, radius, radius, this.prop.startAngle, this.prop.endAngle-this.prop.startAngle);
				this.mc.lineTo(ax , ay);
				//DrawingExt.drawArc(this.mc, 0, 0, this.prop.endAngle, -(this.prop.endAngle-this.prop.startAngle), innerRadius, innerRadius);
				DrawingExt.drawCircle(this.mc, 0, 0, innerRadius, innerRadius, this.prop.endAngle, -(this.prop.endAngle-this.prop.startAngle));
				this.mc.lineTo(bx, by);
				this.mc.endFill();
				//--------------------------------------------------------------//
				//Now, draw the border only.					
				if (this.prop.showBorder){						
					//Set the cosmectic properties					
					this.mc.lineStyle(this.prop.borderThickness, parseInt(this.prop.borderColor,16), this.prop.borderAlpha);										
					//Draw the outer arc
					//DrawingExt.drawArc(this.mc, 0, 0, this.prop.startAngle, this.prop.endAngle-this.prop.startAngle, radius, radius)
					DrawingExt.drawCircle(this.mc, 0, 0, radius, radius, this.prop.startAngle, this.prop.endAngle-this.prop.startAngle);
					//Move to left side start of inner circle
					//If it's more than 360, we do not draw any internal line connectors.
					if (sweepAngle<360) {							
						this.mc.lineTo(ax, ay);
					}
					//Draw inner circle
					//DrawingExt.drawArc(this.mc, 0, 0, this.prop.endAngle, -(this.prop.endAngle-this.prop.startAngle), innerRadius, innerRadius);
					DrawingExt.drawCircle(this.mc, 0, 0, innerRadius, innerRadius, this.prop.endAngle, -(this.prop.endAngle-this.prop.startAngle));
					//Join with outer circle
					if (sweepAngle<360) {
						this.mc.lineStyle(this.prop.borderThickness, parseInt(this.prop.borderColor,16), this.prop.borderAlpha);						
						this.mc.lineTo(bx, by);
					}
				}					
				//Set the X and Y of container movie clip
				this.mc._x = x;
				this.mc._y = y; 
				break;				
			case "image":
				//We'll create an instance of the Movie Clip loader to load
				//the image / SWF file
				//We create a sub-movie clip inside the main movie clip
				var imgMC:MovieClip = this.mc.createEmptyMovieClip("ImageHolder",1);
				var mcl:MovieClipLoader = new MovieClipLoader();					
				//Reference to self
				var classRef = this;
				//Movie clip loader listener object for case of image.
				var mclL:Object = new Object();
				//Store scaling in local variables
				var xs:Number = this.scale * this.prop.xScale;
				var ys:Number = this.scale * this.prop.yScale;
				//Vertical align position of image
				var val:String = this.prop.vAlign;
				//Define the listener to re-position the image once its loaded.
				mclL.onLoadInit = function(target_mc:MovieClip){					
					//Set scale
					target_mc._xscale = xs;
					target_mc._yscale = ys;
					//Based on vertical align position, re-position the image
					switch(val){
						case "top":
							target_mc._y = target_mc._y - target_mc._height;
							break;
						case "middle":
							target_mc._y = target_mc._y - (target_mc._height/2);	
							break;
						case "bottom":
							//Nothing to do, as it's originally registered at top
							break;
					}
					//Set the image to center registration point horizontally
					target_mc._x = target_mc._x - (target_mc._width/2);					
				}
				mcl.addListener(mclL);
				//Load the image
				mcl.loadClip(this.prop.url, imgMC);
				//Set the X and Y of container movie clip
				this.mc._x = x;
				this.mc._y = y; 
				break;
		}
	}	
	/**
	 * destroy method destroys the instance of this shape class.
	*/
	public function destroy():Void{
		//Remove the movie clip which was created for this shape
		this.mc.removeMovieClip();
	}
}