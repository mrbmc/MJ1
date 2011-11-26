// ActionScript file
package com.phidgets
{
	internal class PhidgetServoParameters
	{
		public var servoType:int;
		public var minUs:Number;
		public var maxUs:Number;
		public var usPerDegree:Number;
		public var maxUsPerS:Number;
		
		public function PhidgetServoParameters(servoType:int, minUs:Number, maxUs:Number, usPerDegree:Number, maxUsPerS:Number){
			this.servoType = servoType;
			this.minUs = minUs;
			this.maxUs = maxUs;
			this.usPerDegree = usPerDegree;
			this.maxUsPerS = maxUsPerS;
		}
		
		public function usToDegrees(us:Number):Number
		{
			return (us - minUs) / usPerDegree; 
		}
		public function degreesToUs(degrees:Number):Number
		{
			return (degrees + (minUs / usPerDegree)) * usPerDegree;
		}
		public function usToDegreesVel(us:Number):Number
		{
			return us / usPerDegree; 
		}
		public function degreesToUsVel(degrees:Number):Number
		{
			return degrees * usPerDegree;
		}
		
		public function toString():String{
			return servoType+","+minUs+","+maxUs+","+usPerDegree+","+maxUsPerS;
		}
		
		static public function getServoParams(servoType:int):PhidgetServoParameters
		{
			switch(servoType)
			{	
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_DEFAULT:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_DEFAULT,			23 * 128/12.0,	243 * 128/12.0,		128/12.0,		50/12.0*16384);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_RAW_us_MODE:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_RAW_us_MODE,		0,				10000,				1,				50/12.0*16384);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS322HD:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS322HD,	630,			2310,				1680/180.0,		1680/180.0*316);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS5245MG:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS5245MG,	765,			2185,				1420/145.0,		1420/145.0*400);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_805BB:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_805BB,		650,			2350,				1700/180.0,		1700/180.0*316);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS422:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS422,		650,			2450,				1800/180.0,		1800/180.0*286);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_TOWERPRO_MG90:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_TOWERPRO_MG90,	485,			2335,				1850/175.0,		1850/175.0*545);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HSR1425CR:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HSR1425CR,	1300,			1740,				440/100.0,		440/100.0*500);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS785HB:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS785HB,	700,			2550,				1850/2880.0,	1850/2880.0*225);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS485HB:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS485HB,	580,			2400,				1820/180.0,		1820/180.0*272);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS645MG:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS645MG,	580,			2330,				1750/180.0,		1750/180.0*300);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_815BB:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_815BB,		980,			2050,				1070/180.0,		1070/180.0*250);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_30_50_06_R:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_30_50_06_R,		1000,			2000,				1000/30.0,		1000/30.0*23);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_50_100_06_R:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_50_100_06_R,		1000,			2000,				1000/50.0,		1000/50.0*12);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_50_210_06_R:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_50_210_06_R,		1000,			2000,				1000/50.0,		1000/50.0*5);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_100_50_06_R:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_100_50_06_R,		1000,			2000,				1000/100.0,		1000/100.0*23);
				case com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_100_100_06_R:
					return new PhidgetServoParameters(com.phidgets.PhidgetAdvancedServo.PHIDGET_SERVO_FIRGELLI_L12_100_100_06_R,	1000,			2000,				1000/100.0,		1000/100.0*12);
				default:
					throw new com.phidgets.PhidgetError(com.phidgets.Constants.EPHIDGET_OUTOFBOUNDS);
			}
		}
	}
}