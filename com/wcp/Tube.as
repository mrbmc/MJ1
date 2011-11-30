﻿package com.wcp {	import flash.display.MovieClip;	import flash.display.Stage;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.text.TextFormat;	import flash.text.TextField;	import fl.motion.Color;	import com.wcp.TubeEvent;	import com.wcp.PalButton;	public class Tube extends MovieClip {		public var steps:Number = 8;		//components		public var index:String;		public var bg:MovieClip;		public var lite:MovieClip;		public var spot:MovieClip;		public var lit:Boolean = false;		public var lbl:TextField;		public var _switch:PalButton;				private var w:Number = 40;		private var h:Number = 180;		private var t:Number = 5;		//values		public var angle:Number = 0;		public var level:Number = 0.80;		public var color:Number = 0xFF0000;		var myFont:FontDIN = new FontDIN();		var myTextFormat:TextFormat = new TextFormat();		public function Tube (i:Object,l:Number=80,a:Number=0,c:Number=0x000000) {			super();			this.index = i;			//this.id = "tube" + i;			this.name = "tube" + i;			this.angle = a;			this.level = l;			this.color = c;			this.bg = this.drawBox(w,h,0x000000,1,0,0);			bg.x=bg.y=0;			this.bg.name = "background";			this.lite = this.drawBox(w,this.t,this.color);			this.lite.name = "lite";			this.lite.alpha = l/100;			this.lite.y = (this.angle/360) * (this.h-this.t);			//trace(a + ":" + this.lite.y);			lbl = new TextField();			lbl.text = i;			lbl.x = 0;			lbl.y = h+1;			lbl.textColor = 0x999999;			lbl.selectable = false;			this.addChild(lbl);			myTextFormat.font = myFont.fontName;			myTextFormat.size = 10;			lbl.setTextFormat(myTextFormat);			lbl.embedFonts = true;			lbl.selectable = false;					this.spot = this.drawBox(w,h,0xFF0FF,0,0,0);			this.spot.buttonMode = true;			this.spot.useHandCursor = true;			this.spot.name = "handle";			this.spot.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);									_switch = new PalButton(i,w,w,0x000000,true);			_switch.y = h+21;			addChild(_switch);			_switch.spot.addEventListener(MouseEvent.MOUSE_DOWN,triggerClick);			_switch.spot.addEventListener(MouseEvent.MOUSE_UP,triggerClick);			_switch.spot.addEventListener(MouseEvent.MOUSE_MOVE,triggerClick);			_switch.spot.addEventListener(MouseEvent.MOUSE_OUT,triggerClick);		}		private function triggerClick(e:MouseEvent):void {			var bLit = (e.currentTarget.parent.lit) ? 1 : (e.buttonDown * (e.type!=MouseEvent.MOUSE_OUT) * 1);			if(e.type==MouseEvent.MOUSE_UP) {				e.currentTarget.parent.lit = !e.currentTarget.parent.lit;				bLit = e.currentTarget.parent.lit * 1;			}			e.currentTarget.parent.lite.alpha = bLit;		}		private function moveHandler(e:MouseEvent) {			if(e.buttonDown) {				p = e.currentTarget.parent;				a = (e.localY / p.h) * 360;				p.angle = a;				p.lbl.text = a;				p.lite.y = (p.angle/360) * (p.h - p.t);				e.updateAfterEvent();			}		}		private function drawBox(w:int,h:int,bgcolor=0X333333,bgalpha:Number=1,lncolor=0xFFFFFF,lnalpha:Number=1){			var obj = new MovieClip();			this.addChild(obj);			obj.graphics.lineStyle(1,lncolor,lnalpha);			obj.graphics.beginFill(bgcolor,bgalpha);			obj.graphics.drawRoundRect(0,0,w,h,5);			obj.graphics.endFill();			return obj;		}		private function LEDOverHandler(event:MouseEvent):void {			var idx = event.currentTarget.parent.index;			if(event.buttonDown==true) {				dispatchEvent(new TubeEvent(idx,100));			}		}		private function LEDOutHandler(event:MouseEvent):void {			var idx = event.currentTarget.parent.index;			dispatchEvent(new TubeEvent(idx,0));		}	}}