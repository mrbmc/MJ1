package com.whtn {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.text.TextFormat;	import flash.text.TextField;	import fl.controls.Slider;	import fl.controls.SliderDirection;	import fl.controls.NumericStepper;	import fl.controls.CheckBox;	import fl.controls.RadioButton;	import fl.controls.RadioButtonGroup;	import com.whtn.Tube;	import com.whtn.Sequencer;	import com.whtn.DebugEvent;	public class MJ1UI extends MovieClip {		var myFormat:TextFormat = new TextFormat();		public static var MAX_ROTATION:Number = 180;		public var globalBrightness = 100;		public var sequencer:Sequencer = new Sequencer();		public var cbBlank:RadioButton = new RadioButton();		public var cbSyncBanks:RadioButton = new RadioButton();		public var cbReflectBanks:RadioButton = new RadioButton();		public var rbgBanks:RadioButtonGroup = new RadioButtonGroup("bankGroup");				public var cbLoop:CheckBox = new CheckBox();		public var cbReflect:CheckBox = new CheckBox();		public var cbReverse:CheckBox = new CheckBox();		public var cbLockSlidersL:CheckBox = new CheckBox();		public var cbLockSlidersR:CheckBox = new CheckBox();
		public var cbEngageL:CheckBox = new CheckBox();
		public var cbEngageR:CheckBox = new CheckBox();

		public var cbColorShift:CheckBox = new CheckBox();
		public var cbColorSync:CheckBox = new CheckBox();
		public var nsColorSpeed:NumericStepper = new NumericStepper();				public var loop:Boolean = false;		public var reflect:Boolean = false;		public var reverse:Boolean = false;		public var aColorShift:Array = new Array();
		private function _trace (o:Object):void {			dispatchEvent(new DebugEvent(o));		}		public function MJ1UI ():void {			super();
			sequencer.device = 'mj1';			sequencer.addEventListener('blackout',blackout);			myFormat.font = "_sans";			myFormat.size = 10;			myFormat.color = 0xFFFFFF;

			var instructions:TextField = new TextField();
			instructions.x = 240;
			instructions.y = 180;
			instructions.selectable = false;
			instructions.background = false;
			
			var sInstructions:String = "";					sInstructions += "Q = Fade\n";					sInstructions += "W = Curtain x 4\n";					sInstructions += "E = Curtain x 2\n";					sInstructions += "R = Wipe x 4\n";					sInstructions += "T = Wipe x 2\n";					sInstructions += "Y = Wipe x 1\n";					sInstructions += "U = Chaser\n";					sInstructions += "I = Strobe\n";
					sInstructions += "O = Solid";
			instructions.text = sInstructions;
			instructions.setTextFormat(myFormat);
			addChild(instructions);
			
						
			
			var tube:Tube;// = new MovieClip();			var w = 180;			var h = 33;			var row = 0;			var rows = 8;			var steps = 12;			for (i=0;i<(rows*2);i++) {				var c = (i<8) ? 0xFF0000 : 0x0000FF				tube = new Tube(i,w,h,90,c)				//tube.id = "tube" + i;				tube.x = (Math.floor(i/rows)*(320));				tube.y = (i%rows)*(h+5);				addChild(tube);				tube.addEventListener("tube",tubeEventHandler);			}				cbBlank.move(240,0);				cbBlank.label = "Break";				cbBlank.setStyle("textFormat", myFormat);				cbBlank.addEventListener(MouseEvent.CLICK, parameterHandler);			addChild(cbBlank);				cbSyncBanks.move(240,20);				cbSyncBanks.label = "Sync";				cbSyncBanks.addEventListener(MouseEvent.CLICK, parameterHandler);				cbSyncBanks.setStyle("textFormat", myFormat);				cbSyncBanks.selected = true;			addChild(cbSyncBanks);				cbReflectBanks.move(240,40);				cbReflectBanks.label = "Reflect";				cbReflectBanks.addEventListener(MouseEvent.CLICK, parameterHandler);				cbReflectBanks.setStyle("textFormat", myFormat);			addChild(cbReflectBanks);			cbBlank.group = cbSyncBanks.group = cbReflectBanks.group = rbgBanks; 				cbLoop.move(240,90);				cbLoop.label = "Loop - [L]";				cbLoop.addEventListener(MouseEvent.CLICK, parameterHandler);				cbLoop.setStyle("textFormat", myFormat);			addChild(cbLoop);				cbReflect.move(240,120);				cbReflect.label = "Reflect [K]";				cbReflect.addEventListener(MouseEvent.CLICK, parameterHandler);				cbReflect.setStyle("textFormat", myFormat);			addChild(cbReflect);				cbReverse.move(240,150);				cbReverse.label = "Reverse [J]";				cbReverse.addEventListener(MouseEvent.CLICK, parameterHandler);				cbReverse.setStyle("textFormat", myFormat);			addChild(cbReverse);
				cbLockSlidersL.move(0,-30);				cbLockSlidersL.label = "lock";				cbLockSlidersL.addEventListener(MouseEvent.CLICK, lockSliders);				cbLockSlidersL.setStyle("textFormat", myFormat);				cbLockSlidersL.selected = true;			addChild(cbLockSlidersL);				cbLockSlidersR.move(320,-30);				cbLockSlidersR.label = "lock";				cbLockSlidersR.addEventListener(MouseEvent.CLICK, lockSliders);				cbLockSlidersR.setStyle("textFormat", myFormat);				cbLockSlidersR.selected = true;			addChild(cbLockSlidersR);			function lockSliders(e:MouseEvent) {			}
			cbEngageL.move(50,-30);
			cbEngageL.label = "engage";
			cbEngageL.setStyle("textFormat", myFormat);
			cbEngageL.selected = false;
			cbEngageL.addEventListener(MouseEvent.CLICK, parameterHandler);
			addChild(cbEngageL);

			cbEngageR.move(370,-30);
			cbEngageR.label = "engage";
			cbEngageR.setStyle("textFormat", myFormat);
			cbEngageR.selected = false;
			cbEngageR.addEventListener(MouseEvent.CLICK, parameterHandler);
			addChild(cbEngageR);
						var pickerL:Picker = new Picker('colorLeft',0xFFFFFF,230,100);				pickerL.y = (h+5) * rows;				pickerL.x = 0;				pickerL.addEventListener("color",onColor);				addChild(pickerL);			var pickerR:Picker = new Picker('colorRight',0xFFFFFF,230,100);				pickerR.y = (h+5) * rows;				pickerR.x = 320;				pickerR.addEventListener("color",onColor);				addChild(pickerR);


				cbColorShift.move(0,420);
				cbColorShift.label = "Auto-Shift";
				cbColorShift.addEventListener(MouseEvent.CLICK, parameterHandler);				cbColorShift.setStyle("textFormat", myFormat);			addChild(cbColorShift);				cbColorSync.move(240,320);
				cbColorSync.label = "Sync";
				cbColorSync.addEventListener(MouseEvent.CLICK, parameterHandler);				cbColorSync.setStyle("textFormat", myFormat);			addChild(cbColorSync);
				nsColorSpeed.move(160,420);
				nsColorSpeed.width = 50;
				nsColorSpeed.maximum = 60;				nsColorSpeed.minimum = 1;				nsColorSpeed.stepSize = 1;
				nsColorSpeed.value = 1;
				nsColorSpeed.addEventListener(MouseEvent.CLICK, parameterHandler);			addChild(nsColorSpeed);
			var colorShifterRB:Sprite = Drawing.drawGradient([Drawing.hsv2hex({h:220,s:100,v:100}),Drawing.hsv2hex({h:359,s:100,v:100})],50,30);				colorShifterRB.y = 450;				colorShifterRB.x = 0;				colorShifterRB.addEventListener(MouseEvent.MOUSE_UP,doColorShift);				addChild(colorShifterRB);			var colorShifterRY:Sprite = Drawing.drawGradient([0xFF0000,0xFFFF00],50,30);				colorShifterRY.y = 450;				colorShifterRY.x = 60;				colorShifterRY.addEventListener(MouseEvent.MOUSE_UP,doColorShift);				addChild(colorShifterRY);			var colorShifterBG:Sprite = Drawing.drawGradient([0x0000FF,0x00FF00],50,30);				colorShifterBG.y = 450;				colorShifterBG.x = 120;				colorShifterBG.addEventListener(MouseEvent.MOUSE_UP,doColorShift);				addChild(colorShifterBG);
			var colorShifterRGB:Sprite = Drawing.drawGradient(Picker.COLORS,50,30);				colorShifterRGB.y = 450;				colorShifterRGB.x = 180;				colorShifterRGB.addEventListener(MouseEvent.MOUSE_UP,doColorShift);				addChild(colorShifterRGB);
		}		function parameterHandler(e:MouseEvent) {			dispatchEvent(new Event("change"));		}		function doColorShift (e:Event) {
			aColorShift = e.currentTarget.name.split(",");
			cbColorShift.selected = true;//!cbColorShift.selected;
			dispatchEvent(new Event("change"));		}

		function onColor (e:ColorEvent) {			var min = (e.targetName=="colorLeft" || cbColorSync.selected) ? 0 : 8;			var max = (e.targetName=="colorRight" || cbColorSync.selected) ? 16 : 8;			var display = [];
			
			cbColorShift.selected = false;//!cbColorShift.selected;
			dispatchEvent(new Event("change"));			for(i = min;i < max;i++) {				var target_mc = getChildByName('tube' + i);					target_mc.color = e.color;				Drawing.setColor(target_mc.LED,e.color);				display.push(new TubeSet(i,-1,-1,e.color));			}			//trace(Math.abs(Drawing.hex2hsv(e.color).h));			dispatchEvent(new TubeEvent(display));		}		function bankHandler(e:TubeEvent) {		}
		function tubeEventHandler(e:TubeEvent) {
			if(e.index is Array) {				return trace("Whoa whoa whoa");			}			var min = e.index * 1;			var max = e.index * 1;			var comp = false;			if(this.cbSyncBanks.selected) {				min = 0;				max = 15;				comp = true;			} else if(cbReflectBanks.selected) {				min = 0;				max = 15;			} else if (e.index<8 && cbLockSlidersL.selected) {				min = 0;				max = 7;				comp = true;			} else if(e.index >= 8 && cbLockSlidersR.selected) {				min = 8;				max = 15;				comp = true;			}			//if(comp) {				e.stopPropagation();				var display = [];				for(i=min;i<=max;i++) {					var pos = e.settings.position;					if(cbReflectBanks.selected) {						pos = ((e.index<8 && i>=8) || (e.index>=8 && i<8)) ? Math.abs(e.settings.position - MJ1UI.MAX_ROTATION) : e.settings.position;					}					display[i] = new TubeSet(i,e.settings.brightness,pos,e.settings.color);
					getChildByName('tube'+i).update(display[i]);				}
				display[e.index].lit = e.settings.lit;				dispatchEvent(new TubeEvent(display));			//}		}				public function blackout (e:Event):void {			var display = [];			for(i=0;i<16;i++) {				getChildByName('tube'+i).trigger.lite.alpha = 0;				display.push(new TubeSet(i,-1,90,0x000000));			}			dispatchEvent(new TubeEvent(display));		}		public function update (e:TubeEvent):void {			if(e.index is Array){				for(i in e.index) {					getChildByName('tube' + i).update(e.index[i]);				}			} else if (e.index is TubeSet) {				getChildByName('tube' + e.index).update(e);			}		}	}//class}