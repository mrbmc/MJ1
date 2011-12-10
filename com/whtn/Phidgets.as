﻿package com.whtn {	import com.phidgets.*;	import com.phidgets.events.*;	import com.whtn.DebugEvent;	import flash.events.Event;	import flash.display.Sprite;	public class Phidgets extends Sprite {		//our devices		private var ceiling:PhidgetLED = new PhidgetLED();		private var wallLed:PhidgetLED = new PhidgetLED();		private var wallServoL:PhidgetAdvancedServo = new PhidgetAdvancedServo();		private var wallServoR:PhidgetAdvancedServo = new PhidgetAdvancedServo();		//Archives stores the last animation frame. Used to prevent repeat commands.		private var aLightArchive = new Array(64);		private var aTubeArchive = new Array(16);		//Animation defaults		public var globalBrightness:Number = 100;		protected var nServoResetPosition:Number = 90;		public function Phidgets ():void {			initPhidget(ceiling,114519);			initPhidget(wallLed,115226);			initPhidget(wallServoL,169402);//			initPhidget(wallServoR,169423);			for(i=0;i<60;i++){				aLightArchive[i] = (0);			}			for(i=0;i<60;i++){				aTubeArchive[i] = {					'brightness':0,					'position':nServoResetPosition,					'color':0xff0000					};			}		}		private function _trace (o:Object):void {			dispatchEvent(new DebugEvent(o));		}				private function initPhidget(p:Phidget, serial:int=0x7FFFFFFF):void {			p.addEventListener(PhidgetEvent.CONNECT, this.onConnect);			p.addEventListener(PhidgetEvent.DISCONNECT, onDisconnect);			p.addEventListener(PhidgetEvent.DETACH,	this.onDetach);			p.addEventListener(PhidgetEvent.ATTACH,	this.onAttach);			p.addEventListener(PhidgetErrorEvent.ERROR, this.onError);			p.addEventListener(PhidgetDataEvent.POSITION_CHANGE, onPositionChange);			p.open("localhost", 5001, null, serial);		}		private function onConnect(e:PhidgetEvent):void {			_trace(e + " to webservice");		}		private function onDisconnect(e:PhidgetEvent):void {			_trace(e + " to webservice");		}		private function onAttach(e:PhidgetEvent):void {			_trace("attached: " +				   e.Device.Name + ":" + e.Device.Type + 				   " serial# " + e.Device.serialNumber + 				   " v" + e.Device.Version				   );			if(e.Device.Type == "PhidgetLED") {				/*				UV: 3.5v (max 4.1) / < 350mA				WHITE: 3.3v (max 3.8) / < 30mA				*/				e.Device.CurrentLimit = 1;				e.Device.Voltage = 2.0;				_trace("current:"+e.Device.CurrentLimit + " / voltage:"+e.Device.Voltage);			} else if (e.Device.Type == "PhidgetAdvancedServo") {				for(i=0;i<8;i++) {					e.Device.setServoType(i, PhidgetAdvancedServo.PHIDGET_SERVO_HITEC_HS422);					e.Device.setEngaged(i, true);					e.Device.setPosition(i, nServoResetPosition);					e.Device.setVelocityLimit(i, 75);				}			}		}		private function onDetach(e:PhidgetEvent):void {			_trace(e);		}				private function onError(e:PhidgetErrorEvent):void {			_trace(e);		}		private function onPositionChange(e:PhidgetEvent):void {			//		}				public function sn1 (e:LightEvent):void {			if(!ceiling.isAttached)				return;			var _brightness:int = 0;			if(e.display!=null){				for(i in e.display) {					_brightness = (i<60) ? (e.display[i]/100*globalBrightness) : e.display[i];					if(aLightArchive[i] != _brightness || _brightness<=0)						ceiling.setDiscreteLED( i, _brightness );					aLightArchive[i]=_brightness;				}			} else {				_brightness = (e.index<60) ? (e.brightness/100*globalBrightness) : e.brightness;				ceiling.setDiscreteLED( e.index, _brightness );				aLightArchive[e.index] = _brightness;			}			return;		}		private function updateMJ1 (i,o:Object) {			if(o is TubeSet) {			} else 				return;			var _brightness = (i < 16) ? (o.brightness / 100 * globalBrightness) : o.brightness;			//_trace('updateMJ1.'+i+":"+o);			//_trace("tube:"+i+"("+rgb.r+","+rgb.g+","+rgb.b+") / " + o.position);			//optimize events sent to phidgets by not sending dupes			if(aTubeArchive[i].brightness != _brightness || aTubeArchive[i].color!=o.color) {				if(wallLed.isAttached && o.color!=null) {					//prepare color					var rgb = Drawing.hex2rgb(o.color);					var ii = i*3;					wallLed.setDiscreteLED( ii, (rgb.r/255) * _brightness);					wallLed.setDiscreteLED( ii+1, (rgb.g/255) * _brightness * .92);					wallLed.setDiscreteLED( ii+2, (rgb.b/255) * _brightness * .88);				}			}			aTubeArchive[i].brightness = _brightness;			aTubeArchive[i].color = o.color;			//servo update			//trace('phidget->'+o.position);			if(aTubeArchive[i].rotaton != o.position && o.position!=null) {				var pos = (o.position*.667) + 30;				if(i < 8 && wallServoL.isAttached) {					wallServoL.setPosition( i, pos );				} else if(i >=8 && wallServoR.isAttached) 					wallServoR.setPosition( i, pos );			}		}		public function MJ1 (e:TubeEvent):void {			//_trace(e.index+":"+e.brightness+":"+e.color);			if(e.index is Array){				for(i in e.index) {					updateMJ1(i,e.index[i]);				}			} else {				updateMJ1(e.index,e);			}		}				public function blackout() {			for(i=0;i<64;i++) {				ceiling.setDiscreteLED( i, 0 );			}			for(i=0;i<48;i++) {				wallLed.setDiscreteLED( i, 0 );			}			for(i=0;i<16;i++) {				if(i<8) {					//wallServoL.setPosition( i, nServoResetPosition );				} else {					//wallServoR.setPosition( i, nServoResetPosition );				}			}		}				public function listener (e:Event) {			if(e is TubeEvent) {				this.MJ1(e);			} else if (e is LightEvent) {				this.sn1(e);			}		}	}}