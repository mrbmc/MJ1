﻿package com.wcp {	import flash.display.Sprite; 	public class Drawing extends Sprite { 		public static function drawBox(obj:Sprite=null,w:int=100,h:int=60,bgcolor:Number=0x333333,bgalpha:Number=1,lncolor=0xFFFFFF,lnalpha:Number=1):Sprite {			if(obj == null) {				obj = new Sprite();				//addChild(obj);			} else {				obj.graphics.lineStyle(0,lncolor,lnalpha);				obj.graphics.beginFill(bgcolor,bgalpha);				obj.graphics.drawRoundRect(0,0,w,h,5);				obj.graphics.endFill();			}			return obj;		}		public static function setColor(obj:Sprite=null,c:Number=0xFFFFFF,a:Number=1):void {			obj.graphics.lineStyle(0,0xffffff,.5);			obj.graphics.beginFill(c,a);			obj.graphics.drawRect(0,0,obj.width-2,obj.height-2);			obj.graphics.endFill();		}	}}