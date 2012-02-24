package com.whtn {	import flash.display.Sprite;	import flash.geom.ColorTransform;	import com.whtn.DebugEvent;	public class Drawing extends Sprite { 		public static function drawBox(obj:Sprite=null,w:int=100,h:int=60,bgcolor:Number=0x333333,bgalpha:Number=1,lncolor=0xFFFFFF,lnalpha:Number=1):Sprite {			if(obj == null) {				obj = new Sprite();				//addChild(obj);			} else {				obj.graphics.lineStyle(0,lncolor,lnalpha);				obj.graphics.beginFill(bgcolor,bgalpha);				obj.graphics.drawRoundRect(0,0,w,h,5);				obj.graphics.endFill();			}			return obj;		}		public static function setColor(obj:Sprite=null,c:Number=0xFFFFFF,a:Number=1):void {			var myColor:ColorTransform = obj.transform.colorTransform;				myColor.color = c;				obj.transform.colorTransform = myColor;				return;			obj.graphics.lineStyle(0,0xffffff,.5);			obj.graphics.beginFill(c,a);			obj.graphics.drawRect(0,0,obj.width-2,obj.height-2);			obj.graphics.endFill();		}		public static function hex2rgb (hex):Object {			var red = hex>>16;			var greenBlue = hex-(red<<16)			var green = greenBlue>>8;			var blue = greenBlue - (green << 8);			//trace("r: " + red + " g: " + green + " b: " + blue);			return({r:red, g:green, b:blue});		}
		public static function rgb2hex (rgb:Object):uint{
			var hex = rgb.r << 16 ^ rgb.g << 8 ^ rgb.b;
			return hex;
		}
		public static function hsv2rgb(hsv:Object):Object {
			var red, grn, blu, i, f, p, q, t;
			hsv.h%=360;
			if(hsv.v==0) {return({r:0,g:0,b:0});}
			hsv.s/=100;
			hsv.v/=100;
			hsv.h/=60;
			i = Math.floor(hsv.h);
			f = hsv.h-i;
			p = hsv.v*(1-hsv.s);
			q = hsv.v*(1-(hsv.s*f));
			t = hsv.v*(1-(hsv.s*(1-f)));
			if (i==0) {red=hsv.v; grn=t; blu=p;}
			else if (i==1) {red=q; grn=hsv.v; blu=p;}
			else if (i==2) {red=p; grn=hsv.v; blu=t;}
			else if (i==3) {red=p; grn=q; blu=hsv.v;}
			else if (i==4) {red=t; grn=p; blu=hsv.v;}
			else if (i==5) {red=hsv.v; grn=p; blu=q;}
			red = Math.floor(red*255);
			grn = Math.floor(grn*255);
			blu = Math.floor(blu*255);
			return ({r:red,g:grn,b:blu});
		}
		public static function rgb2hsv(rgb:Object):Object {
		 var x, f, i, hue, sat, val;
		 rgb.r/=255;
		 rgb.g/=255;
		 rgb.b/=255;
		 x = Math.min(Math.min(rgb.r, rgb.g), rgb.b);
		 val = Math.max(Math.max(rgb.r, rgb.g), rgb.b);
		 if (x==val){
		  return({h:0,s:0,v:(val*100)});
		 }
		 f = (rgb.r == x) ? rgb.g-rgb.b : ((rgb.g == x) ? rgb.b-rgb.r : rgb.r-rgb.g);
		 i = (rgb.r == x) ? 3 : ((rgb.g == x) ? 5 : 1);
		 hue = Math.floor((i-f/(val-x))*60)%360;
		 sat = Math.floor(((val-x)/val)*100);
		 val = Math.floor(val*100);
		 return({h:hue,s:sat,v:val});
		}
		
		public static function hsv2hex(hsv:Object):uint{
		 var rgb=hsv2rgb(hsv);
		 return(rgb2hex(rgb));
		}
		
		public static function hex2hsv(hex:Object):Object{
		 var rgb=hex2rgb(hex);
		 return(rgb2hsv(rgb));
		}

	}}