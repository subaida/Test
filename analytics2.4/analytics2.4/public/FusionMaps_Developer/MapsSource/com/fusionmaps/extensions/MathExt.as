/**
 * @class MathExt
 * @author InfoSoft Global (P) Ltd.
 * @version 3.0
 *
 * Copyright (C) InfoSoft Global Pvt. Ltd. 2006
 
 * MathExt class bunches a group of mathematical functions
 * which will be used by other classes. All the functions in
 * this class are declared as static, as the methods do not
 * relate to any specific instance.
 */
class com.fusionmaps.extensions.MathExt {
	/**
	 * Private constructor function so that instances of 
	 * this class cannot be initialized.
	*/
	private function MathExt() {
		//Nothing to do.
	}
	/**
	 * numDecimals method returns the number of decimal places provided
	 * in the given number.
	 *	@param	num	Number for which we've to find the decimal places.
	 *	@return	Number of decimal places found.
	*/
	public static function numDecimals(num:Number):Number {
		//Absolute value (to avoid floor disparity for negative num)
		num = Math.abs(num);
		//Get decimals
		var decimal:Number = num-Math.floor(num);
		//Number of decimals
		var numDecimals:Number = (String(decimal).length-2);
		//For integral values
		numDecimals = (numDecimals<0) ? 0 : numDecimals;
		//Return the length of string minus "0."
		return numDecimals;
	}	
	/**
	 * toRadians method converts angle from degrees to radians
	 * @param	angle	The numeric value of the angle in 
	 * 					degrees
	 * @return			The numeric value of the angle in radians
	 */
	public static function toRadians(angle:Number):Number {
		return (angle/180)*Math.PI;
	}
}
