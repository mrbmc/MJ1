﻿package com.wcp {	import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.text.TextFormat;	import flash.text.TextField;	import fl.controls.Slider;	import fl.controls.SliderDirection;	import fl.controls.NumericStepper;	import fl.controls.CheckBox;	import com.wcp.Tube;	public class MJ1UI extends MovieClip {		var myFormat:TextFormat = new TextFormat();		public function MJ1UI ():void {			super();			myFormat.font = "_sans";			myFormat.size = 10;			myFormat.color = 0xFFFFFF;			var tube:Tube;// = new MovieClip();			var w = 10;			var h = 40;			var row = 0;			var rows = 8;			var steps = 12;			for (i=0;i<(rows*2);i++) {				var c = (i<8) ? 0xFF0000 : 0x0000FF				tube = new Tube(i,100,90,c)				//tube.id = "tube" + i;				tube.x = (Math.floor(i/rows)*(320));				tube.y = (i%rows)*(h+5);				addChild(tube);				tube.addEventListener("tube",tubeHandler);			}			function tubeHandler(e:TubeEvent) {				//dispatchEvent(e);//not needed thanks to event bubbling			}						var cbSyncBanks:CheckBox = new CheckBox();				cbSyncBanks.move(240,-30);				cbSyncBanks.label = "synch banks";				cbSyncBanks.addEventListener(MouseEvent.CLICK, synchHandler);				cbSyncBanks.setStyle("textFormat", myFormat);			addChild(cbSyncBanks);			function synchHandler(e:MouseEvent) {			}						var cbLockSlidersL:CheckBox = new CheckBox();				cbLockSlidersL.move(0,-30);				cbLockSlidersL.label = "lock";				cbLockSlidersL.addEventListener(MouseEvent.CLICK, lockSliders);				cbLockSlidersL.setStyle("textFormat", myFormat);			addChild(cbLockSlidersL);			var cbLockSlidersR:CheckBox = new CheckBox();				cbLockSlidersR.move(320,-30);				cbLockSlidersR.label = "lock";				cbLockSlidersR.addEventListener(MouseEvent.CLICK, lockSliders);				cbLockSlidersR.setStyle("textFormat", myFormat);			addChild(cbLockSlidersR);			function lockSliders(e:MouseEvent) {			}									var pickerL:Picker = new Picker('colorLeft',0xFFFFFF,245,50);				pickerL.y = (h+5) * rows;				pickerL.x = 0;				pickerL.addEventListener("color",onColor);				addChild(pickerL);			var pickerR:Picker = new Picker('colorRight',0xFFFFFF,245,50);				pickerR.y = (h+5) * rows;				pickerR.x = 320;				pickerR.addEventListener("color",onColor);				addChild(pickerR);						function onColor (e:ColorEvent) {				var max = (e.targetName=="colorLeft") ? 8 : 16;					var min = (e.targetName=="colorLeft") ? 0 : 8;				for(i = min;i < max;i++) {					var target_mc = getChildByName('tube' + i);						target_mc.color = e.color;					Drawing.setColor(target_mc.lite,e.color);				}			}		}		public function update (e:TubeEvent):void {			if(e.display!=null){				for(i in e.display) {					_brightness = (i<60) ? (e.display[i]/100*globalBrightness) : e.display[i];					getChildByName('tube' + i).trigger.lite.alpha = _brightness/100;				}			} else {				_brightness = (e.index<60) ? (e.brightness / 100 * globalBrightness) : e.brightness;				getChildByName('tube' + e.index).trigger.lite.alpha = _brightness/100;			}		}	}}