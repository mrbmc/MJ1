﻿package com.wcp {	import fl.controls.Button;	import fl.controls.Slider;	import fl.controls.NumericStepper;	import fl.controls.CheckBox;	import fl.controls.RadioButton;	import fl.controls.RadioButtonGroup;	import fl.events.SliderEvent;	import flash.display.MovieClip;	import flash.text.TextFormat;	import flash.text.TextField;	import flash.events.MouseEvent;	import flash.events.Event;	import com.wcp.Effect;	import com.wcp.EffectFactory;	import com.wcp.EffectEvent;	public class Channel extends MovieClip {		private var reflectControl:CheckBox;		private var reverseControl:CheckBox;		private var loopControl:NumericStepper;		private var trailControl:NumericStepper;		private var speedControl:RadioButtonGroup;		public var brightnessControl:Slider;		private var triggerControl:Button;		public var factory:EffectFactory=new EffectFactory();		public var effect:Effect;		public var effectName:String;		private var size = 40;		private var steps:Array = new Array();		public function Channel (_effectName,hotkey) {			super();			var margin = 5;			effect = factory.make(_effectName);			triggerControl = new Button();			triggerControl.setSize(70,size);			triggerControl.move(0,0);			triggerControl.label = effect.name;			if(hotkey!=null) triggerControl.label += " ("+hotkey+")";			triggerControl.name = effect.name;			triggerControl.addEventListener (MouseEvent.CLICK,channelListener);			triggerControl.useHandCursor = true;			addChild(triggerControl);var myTextFormat:TextFormat = new TextFormat();	myTextFormat.bold = false;	myTextFormat.color = 0x333333;triggerControl.setStyle("textFormat", myTextFormat);						reverseControl = new CheckBox();			reverseControl.label = "";			reverseControl.x = triggerControl.x+triggerControl.width+margin;			reverseControl.y = 10;			reverseControl.selected = effect.reverse;			reverseControl.addEventListener(MouseEvent.CLICK,parameterHandler);			addChild(reverseControl);						reflectControl = new CheckBox();			reflectControl.label = "";			reflectControl.x = reverseControl.x+18+margin;			reflectControl.y = 10;			reflectControl.selected = effect.reflect;			reflectControl.addEventListener(MouseEvent.CLICK,parameterHandler);			addChild(reflectControl);						trailControl = new NumericStepper();			trailControl.move(reflectControl.x+20+margin,10);			trailControl.setSize(35,20);			trailControl.value = effect.trail;			trailControl.addEventListener(Event.CHANGE,parameterHandler);			addChild(trailControl);						loopControl = new NumericStepper();			loopControl.move(trailControl.x+trailControl.width+margin,10);			loopControl.setSize(35,20);			loopControl.value = effect.loops;			loopControl.addEventListener(Event.CHANGE,parameterHandler);			addChild(loopControl);			speedControl = new RadioButtonGroup("speed");			speedControl.addEventListener(Event.CHANGE,parameterHandler);			var speedQrtr = new RadioButton();				speedQrtr.label=0.25;				speedQrtr.group = speedControl;				speedQrtr.move(loopControl.x+loopControl.width+5,10);			addChild(speedQrtr);			var speedHalf = new RadioButton();				speedHalf.label=0.5;				speedHalf.group = speedControl;				speedHalf.move(speedQrtr.x+20,10);			addChild(speedHalf);			var speedNormal = new RadioButton();				speedNormal.label="1";				speedNormal.group = speedControl;				speedNormal.move(speedHalf.x+20,10);				speedNormal.selected = true;			addChild(speedNormal);			var speedDouble = new RadioButton();				speedDouble.label=2;				speedDouble.group = speedControl;				speedDouble.move(speedNormal.x+20,10);			addChild(speedDouble);			var speedFast = new RadioButton();				speedFast.label=4;				speedFast.group = speedControl;				speedFast.move(speedDouble.x+20,10);			addChild(speedFast);			switch(effect.speed+"") {				case "0.5":					speedControl.selection = speedHalf;				break;				case "1":					speedControl.selection = speedNormal;				break;				case "2":				case "4":					speedControl.selection = speedFast;				break;			}			brightnessControl = new Slider();			brightnessControl.setSize(210,20);			brightnessControl.move(speedFast.x+25,20);			brightnessControl.liveDragging = true;			brightnessControl.minimum = 0;			brightnessControl.maximum = 100;			brightnessControl.snapInterval = 1;			brightnessControl.tickInterval = 5;			brightnessControl.value = effect.brightness;			brightnessControl.addEventListener(SliderEvent.CHANGE, parameterHandler);			addChild(brightnessControl);			for(i=0;i<8;i++) {				btn = new PalButton((i+1),size,size,0x444444);				btn.x = (brightnessControl.x+brightnessControl.width+10+margin)+(i*(size+5));				btn.y = 0;				btn.spot.addEventListener(MouseEvent.MOUSE_DOWN, StepOverHandler);				btn.spot.addEventListener(MouseEvent.MOUSE_OVER, StepOverHandler);				btn.spot.addEventListener(MouseEvent.MOUSE_UP, StepOutHandler);				btn.spot.addEventListener(MouseEvent.MOUSE_OUT, StepOutHandler);				steps.push(btn);				addChild(btn);			}					}		function parameterHandler(event:*):void {			if(brightnessControl===null)				return;			effect.trail = trailControl.value;			effect.loops = loopControl.value;			effect.reverse = reverseControl.selected;			effect.reflect = reflectControl.selected;			effect.brightness = brightnessControl.value;			effect.speed = speedControl.selection.label;			dispatchEvent(new EffectEvent(EffectEvent.CHANGED,this.effect));		}		private function channelListener(e:Event):void {			dispatchEvent(new EffectEvent(EffectEvent.PLAY,this.effect));		}		public function go(o:*=null) {			dispatchEvent(new EffectEvent(EffectEvent.PLAY,this.effect));		}		private function StepOverHandler(e:MouseEvent):void {			if(e.buttonDown==true) {				dispatchEvent(new EffectEvent(EffectEvent.QUEUE_ADD,this.effect,e.target.parent.index));			}		}		private function StepOutHandler(e:MouseEvent):void {		}		private function updateSequencer (obj:Object,index:int,array:Array):Boolean {		};		public function queueHandler(e:Event) {			if(e.action!=EffectEvent.QUEUE_CHANGE)				return;			for(index in e.effectName) {				obj = e.effectName[index];				if(obj==null) {					steps[index].lite.alpha = 0;				} else {					steps[index].lite.alpha = (obj.name==this.effect.name) ? 62 : 0;				}			}		}	}}