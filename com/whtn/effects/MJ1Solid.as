package com.whtn.effects {	import com.whtn.Effect;	import com.whtn.TubeSet;	public class MJ1Solid extends Effect {		public function MJ1Solid ():void {			super("mj1_solid");			device = "mj1";			hotKey = "O";			trail = 0;			speed = 1;			channel = false;			var display:Array = [];
			var bright:Number = 1;
			var inc:int = 1;

			for(i=0;i<16;i++) display.push(new TubeSet(i,100));			for(f=0;f<8;f++) sequence.push(display);
			display = [];
			for(i=0;i<16;i++) display.push(new TubeSet(i,0));
			//sequence.push(display);		}//constructor	}}