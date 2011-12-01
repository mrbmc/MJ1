﻿package com.wcp {	import flash.display.MovieClip;	import flash.display.Stage;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.text.TextFormat;	import flash.text.TextField;	import fl.motion.Color;	import com.wcp.TubeEvent;	import com.wcp.PalButton;	import flash.display.BitmapData;	import flash.geom.ColorTransform;	public class Tube extends MovieClip {		public var steps:Number = 8;		//components		public var index:String;		public var bg:MovieClip;		public var lite:MovieClip;		public var spot:MovieClip;		public var lit:Boolean = false;		public var lbl:TextField;		public var _switch:PalButton;				private var w:Number = 180;		private var h:Number = 40;		private var t:Number = 5;		//values		public var angle:Number = 0;		public var level:Number = 0.80;		public var color:Number = 0xFF0000;		var myFont:FontDIN = new FontDIN();		var myTextFormat:TextFormat = new TextFormat();		public function Tube (i:Object,l:Number=80,a:Number=0,c:Number=0x000000) {			super();			this.index = i;			this.name = "tube" + i;			this.angle = a;			this.level = l;			this.color = c;			this.bg = this.drawBox(w,h,0x000000,1,0,0);			bg.x=bg.y=0;			this.bg.name = "background";			//lite = drawLite(c);			this.spot = this.drawBox(w,h,0xFF0FF,0,0,0);			this.spot.buttonMode = true;			this.spot.useHandCursor = true;			this.spot.name = "target";			this.spot.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);									_switch = new PalButton(i,h,h,0x000000,true);			addChild(_switch);			_switch.x = w+21;			_switch.name = "trigger";			_switch.spot.addEventListener(MouseEvent.MOUSE_DOWN,triggerClick);			_switch.spot.addEventListener(MouseEvent.MOUSE_UP,triggerClick);			_switch.spot.addEventListener(MouseEvent.MOUSE_MOVE,triggerClick);			_switch.spot.addEventListener(MouseEvent.MOUSE_OUT,triggerClick);			lbl = new TextField();			lbl.name = "label";			lbl.text = i;			lbl.x = w+1;			lbl.y = 0+1;			lbl.textColor = 0x999999;			lbl.selectable = false;			this.addChild(lbl);			myTextFormat.font = myFont.fontName;			myTextFormat.size = 10;			lbl.setTextFormat(myTextFormat);			lbl.embedFonts = true;			lbl.selectable = false;				}		private function triggerClick(e:MouseEvent):void {			var bLit = (e.currentTarget.parent.lit) ? 1 : (e.buttonDown * (e.type!=MouseEvent.MOUSE_OUT) * 1);			if(e.type==MouseEvent.MOUSE_UP) {				e.currentTarget.parent.lit = !e.currentTarget.parent.lit;				bLit = e.currentTarget.parent.lit * 1;			}			e.currentTarget.parent.lite.alpha = bLit;		}		private function moveHandler(e:MouseEvent) {			if(e.buttonDown) {				p = e.currentTarget.parent;				a = (e.localX / p.w) * 360;				p.angle = a;				p.lbl.text = a;				p.lite.x = (p.angle/360) * (p.w - p.t);				e.updateAfterEvent();			}		}		public function drawLite(c:Number=0x000000) {			if(this.lite != null)				removeChild(this.lite);			lite = this.drawBox(this.t,this.h,c);			lite.name = "lite";			lite.alpha = this.level / 100;			lite.x = (this.angle/360) * (this.w - this.t);		}		private function drawBox(w:int,h:int,bgcolor=0X333333,bgalpha:Number=1,lncolor=0xFFFFFF,lnalpha:Number=1){			var obj = new MovieClip();			this.addChild(obj);			obj.name = "mc";			obj.graphics.lineStyle(1,lncolor,lnalpha);			obj.graphics.beginFill(bgcolor,bgalpha);			obj.graphics.drawRoundRect(0,0,w,h,5);			obj.graphics.endFill();			return obj;		}		private function LEDOverHandler(event:MouseEvent):void {			var idx = event.currentTarget.parent.index;			if(event.buttonDown==true) {				dispatchEvent(new TubeEvent(idx,100));			}		}		private function LEDOutHandler(event:MouseEvent):void {			var idx = event.currentTarget.parent.index;			dispatchEvent(new TubeEvent(idx,0));		}	}}