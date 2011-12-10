﻿package com.whtn {	import flash.events.Event;	import flash.utils.Timer;	import flash.utils.getTimer;	import flash.events.TimerEvent;	import com.whtn.Effect;	import com.whtn.EffectEvent;	import com.whtn.LightEvent;	import com.whtn.DebugEvent;	public class Engine extends Timer {		public var display:Array = [];		public var fx:Object = {'sn1':null,'mj1':null};		private var interval:int = 100;		private var time:Number = getTimer();		private var fps:int = 30;		private var _trail:int = 0;		private var _reflect:Boolean = false;		private var _reverse:Boolean = false;		public var loop:Boolean = false;		public function Engine () {			this.addEventListener(TimerEvent.TIMER, this.iteration);			this.speed = 120;			super((1000/fps));			time = getTimer();			this.start();		}				public function set speed (bpm:int) {			//convert BPM to BPS, quadrouple it for 16th notes			var bps = (bpm/60)*4;			//convert BPS to ms			interval = (1000/bps);		}		public function get speed ():int {			return Math.round((1000/interval)/4*60);		}				public function get frames():int {			var cellCount = (this.reflect) ? (effect.sequence.length*2) : effect.sequence.length;			return (this.loops>0) ? cellCount : cellCount + trail;		}		public function get loops():int {			return (effect.loops) ? effect.loops : 0;		}		public function get trail():int {			return _trail;			//return (_trail>0) ? _trail : effect.trail;		}		public function set trail(n:int):void {			this._trail = n;		}		public function set reverse(b:Boolean):void {			this._reverse = b;		}		public function get reverse():Boolean {			//if(effect)			//	return (this._reverse || effect.reverse);			//else				return this._reverse;		}		public function set reflect(b:Boolean):void {			this._reflect = b;		}		public function get reflect():Boolean {			//if(effect)			//	return (this._reflect || effect.reflect);			//else				return this._reflect;		}		public function go (_effect:Effect=null):Boolean {			if(_effect==null) return;			var f:Object = {				effect:_effect,				loops:0,				loop:0,				trail:0,				frames:0,				frame:0,				time:0			}			f.trail = ((trail > 0) ? trail : _effect.trail);			f.loops = ((_effect.loops) ? _effect.loops : 0);			var cellCount = _effect.sequence.length * (this.reflect + 1);			f.frames = (f.loops>0) ? cellCount : cellCount + trail;			fx[_effect.device] = f;		}		private function processor (f:Object=null) {			if(f==null || f.effect==null) return;			if((getTimer() - f.time) < (interval / f.effect.speed))				return;			f.time = getTimer();						var _cells = f.effect.sequence.length * (reflect + 1);			var _frames = (f.loops>0) ? _cells : _cells + trail;			var _trail = ((trail > 0) ? trail : f.effect.trail);			var forward = f.effect.sequence.slice(0);			var reversed = f.effect.sequence.slice(0).reverse();			var pattern = (reflect) ? (reverse ? reversed.concat(forward) : forward.concat(reversed) ) : ((reverse) ? reversed : forward);			if(f.effect.device=="mj1") {				display = pattern[f.frame];				dispatchEvent(new TubeEvent(display));			} else {				display = [];				for(i=0;i<60;i++) display[i]=0;				//loop through the trail iterations				for(i=0;i<=_trail;i++){					var tgt = f.frame - i;					if(tgt<0 || tgt>=pattern.length) continue;					//loop through LEDs					for(var j=0;j<pattern[tgt].length;j++) {						if(pattern[tgt][j] is Array) {							index = pattern[tgt][j][0];							brightness = pattern[tgt][j][1];						}else {							index = pattern[tgt][j];							brightness = (100-(100/(_trail+1)*i));						}						display[index] = brightness * (f.effect.brightness/100);					}				}				dispatchEvent(new LightEvent(-1,0,display));			}			f.frame++;			if(f.frame >= _frames) {				if(f.effect.device=='mj1') {					//fx[f.effect.device] = null;					//dispatchEvent(new EffectEvent(EffectEvent.COMPLETED,f.effect));					f.frame = 0;					return;				}				//trace(f.frame+"/"+f.frames+"/"+f.loop+"/"+f.loops);				if(f.loop < f.loops || loop) {					f.frame = 0;//time=0;					if(!loop) f.loop++;				} else {					if(_trail>0 && f.frame <= (_frames + _trail)) {						//_frame=0;time=0;					} else {						fx[f.effect.device] = null;						dispatchEvent(new EffectEvent(EffectEvent.COMPLETED,f.effect));						//this.stop();					}				}			}		}		private function iteration (t:TimerEvent) {			if(fx.mj1!=null) this.processor(fx.mj1);			if(fx.sn1!=null) this.processor(fx.sn1);		}		public function blackout() {			fx.mj1 = null;			fx.sn1 = null;			dispatchEvent(new TubeEvent([]));		}		private function randomizer() {			var en = Math.floor(Math.random()*effect.effects.length);			return effect.effects[en];		}		public function listener (e:EffectEvent) {			//trace(e.effect.name+":"+e.action);			if(e.action==EffectEvent.PLAY) {				dispatchEvent(new DebugEvent(e.effect.name));				this.go(e.effect);			} else if(e.action==EffectEvent.STOP) {				this.effect = null;				for(i=0;i<60;i++) {					dispatchEvent(new LightEvent(i,0));				}			} else if(e.action==EffectEvent.CHANGED) {				if(this.effect==null || this.effect.name==e.effect.name)					this.effect = e.effect;			}			return true;		}	}}