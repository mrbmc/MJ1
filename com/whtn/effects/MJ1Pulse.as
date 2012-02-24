package com.whtn.effects {	import com.whtn.Effect;	import com.whtn.TubeSet;	public class MJ1Pulse extends Effect {		public function MJ1Pulse ():void {			super("mj1_pulse");			device = "mj1";			hotKey = "Q";			trail = 0;			speed = 1;			channel = false;			var display:Array = [];
			var bright:Number = 1;
			var inc:int = 1;			for(i=0;i<16;i++) display.push(new TubeSet(i,0));//			sequence.push(display);
			var frame = 0;
			while(bright < 100) {			//for(frame=0;frame<16;frame++) {				bright *= 1.3;
				display = [];				var ff = frame-8;
				for(tube=0;tube<8;tube++) {					//var bright = (tube <= frame && tube > ff) ? 100 : 0;
//					if(bright >= 100 || bright <= 0) inc *= -1;
					display[tube] = new TubeSet(frame,bright);					display[(tube+8)] = new TubeSet(frame,bright);				}				sequence.push(display);				frame++;
			}
			var rev:Array = sequence.slice();
			while( rev.length) {
				sequence.push(rev.pop());
			}

		}//constructor	}}