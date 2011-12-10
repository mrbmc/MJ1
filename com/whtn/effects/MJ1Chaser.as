﻿package com.whtn.effects {	import com.whtn.Effect;	import com.whtn.TubeEvent;	import com.whtn.TubeSet;	import com.whtn.MJ1UI;	import com.whtn.Picker;	public class MJ1Chaser extends Effect {		public function MJ1Chaser ():void {			super("mj1_chaser");			device="mj1";			hotKey = "Q";			trail = 0;			speed = 1;			channel = false;			var frames = 8;			var framesteps = 4;			var rot_inc = Math.ceil(MJ1UI.MAX_ROTATION / (framesteps-1));			var col = null;			var display:Array = [];			for(i=0;i<16;i++) display.push(new TubeSet(i,0));			sequence.push(display);			for(frame=0;frame<8;frame++) {				display = [];				for(tube=0;tube<8;tube++) {						display[tube] = new TubeSet(frame,0,-1);						display[(tube+8)] = new TubeSet(frame,0,-1);				}					display[(frame%8)].brightness = 100;					display[(frame%8)+8].brightness = 100;				sequence.push(display);//				trace(sequence[frame][0].brightness);			}			display = [];			for(i=0;i<16;i++) display.push(new TubeSet(i,0));			sequence.push(display);/*			for(i=0;i<frames;i++) {				for(j=0;j<framesteps;j++) {					var rot = j * rot_inc;					var display = new Array();					for(k=0;k<16;k++) {						var ii = i+8;						var r = 0;						if(k>=8) {							r = (ii < k) ? 0 : (ii > k) ? MJ1UI.MAX_ROTATION : rot;						} else 							r = (i < k) ? 0 : (i > k) ? MJ1UI.MAX_ROTATION : rot;						display.push(new TubeEvent(k,100,r,col));					}					sequence.push(new TubeEvent(display));				}			}			for(i=(frames-1);i>=0;i--) {				for(j=(framesteps-1);j>=0;j--) {					rot = j * rot_inc;					display = new Array();					for(k=0;k<16;k++) {						ii = i+8;						if(k>=8) {							r = (ii < k) ? 0 : (ii > k) ? MJ1UI.MAX_ROTATION : rot;						} else 							r = (i < k) ? 0 : (i > k) ? MJ1UI.MAX_ROTATION : rot;						display.push(new TubeEvent(k,100,r,col));					}					sequence.push(new TubeEvent(display));				}			}*/		}//constructor	}//class}//package