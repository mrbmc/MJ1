﻿package com.whtn {	import flash.display.Sprite;	import flash.display.Stage;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.text.TextFormat;	import flash.text.TextField;	import com.whtn.TubeEvent;	import com.whtn.PalButton;	public class Tube extends Sprite {		public var steps:Number = 8;		//components		public var index:String;		public var bg:Sprite = new Sprite();		public var lite:Sprite = new Sprite();		public var spot:Sprite = new Sprite();		public var lit:Boolean = false;		public var lbl:TextField;		public var trigger:PalButton;				private var w:Number = 180;		private var h:Number = 40;		private var increments:Number = 9;		private var maxRotation:Number = MJ1UI.MAX_ROTATION;		private var t:Number = Math.max(w / increments,5);//handle width		//properties		public var brightness:Number = 80;		public var color:Number = 0xFF0000;		private var _angle:Number = 90;		public function set angle(n:Number) {			this._angle = Math.round((n/maxRotation)*increments) * (maxRotation/increments);		}		public function get angle():Number {			return this._angle;		}		var myFont:FontDIN = new FontDIN();		var myTextFormat:TextFormat = new TextFormat();		public function Tube (i:Object,l:Number=80,a:Number=0,c:Number=0x000000) {			super();			this.index = i;			this.name = "tube" + i;			this.angle = a;			this.brightness = l;			this.color = c;			addChild(this.bg);			Drawing.drawBox(this.bg,w,h,0x000000,1,0,0);			bg.x=bg.y=0;			this.bg.name = "background";			addChild(lite);			Drawing.drawBox(this.lite,this.t,this.h,c);			lite.name = "lite";			lite.alpha = this.brightness / 100;			lite.x = (this.angle/this.maxRotation) * (this.w - this.t);			lbl = new TextField();			lbl.name = "label";			lbl.text = i;			lbl.x = w+1;			lbl.y = 0+1;			lbl.textColor = 0x999999;			lbl.selectable = false;			this.addChild(lbl);			myTextFormat.font = myFont.fontName;			myTextFormat.size = 10;			lbl.setTextFormat(myTextFormat);			lbl.embedFonts = true;			lbl.selectable = false;			addChild(spot);			Drawing.drawBox(this.spot,w,h,0xFF0FF,0,0,0);			spot.buttonMode = true;			spot.useHandCursor = true;			spot.name = "target";			spot.addEventListener(MouseEvent.MOUSE_DOWN, moveHandler);			spot.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);									trigger = new PalButton(i,h,h,0x000000,true);			trigger.x = (w)+21;			trigger.name = "trigger";			trigger.spot.addEventListener(MouseEvent.MOUSE_DOWN,triggerClick);			trigger.spot.addEventListener(MouseEvent.MOUSE_UP,triggerClick);			trigger.spot.addEventListener(MouseEvent.MOUSE_MOVE,triggerClick);			trigger.spot.addEventListener(MouseEvent.MOUSE_OUT,triggerClick);			addChild(trigger);		}		private function triggerClick(e:MouseEvent):void {			var bLit = (e.currentTarget.parent.lit) ? true : (e.buttonDown && (e.type!=MouseEvent.MOUSE_OUT));			if(e.type==MouseEvent.MOUSE_UP) {				e.currentTarget.parent.lit = !e.currentTarget.parent.lit;				bLit = e.currentTarget.parent.lit * 1;			}			e.currentTarget.parent.lite.alpha = bLit;			dispatchEvent(new TubeEvent(this.index,(bLit ? this.brightness : 0),this.angle,this.color));		}		private function moveHandler(e:MouseEvent) {			if(e.buttonDown) {				p = e.currentTarget.parent;				a = (e.localX / p.w) * this.maxRotation;				p.angle = a;				p.lbl.text = this.angle;				p.lite.x = (p.angle/this.maxRotation) * (p.w - p.t);				dispatchEvent(new TubeEvent(this.index,this.brightness,this.angle,this.color));				e.updateAfterEvent();			}		}		private function LEDOverHandler(event:MouseEvent):void {			var idx = event.currentTarget.parent.index;			if(event.buttonDown==true) {				dispatchEvent(new TubeEvent(idx,100));			}		}		private function LEDOutHandler(event:MouseEvent):void {			var idx = event.currentTarget.parent.index;			dispatchEvent(new TubeEvent(this.index,100,this.c));		}		public function update(e:TubeEvent) {			this.color = e.color;			this.angle = e.rotation;			this.brightness = e.brightness;			Drawing.setColor(this.lite, e.color);			this.lite.x = (this.angle / this.maxRotation) * (this.w - this.t);			//this.lite.alpha = e.brightness / 100;		}	}}