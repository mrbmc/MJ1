﻿package com.wcp.effects {	import com.wcp.Effect;	public class Spiral extends Effect {		public function Spiral ():void {			super("spiral");			sequence = new Array(60);			for(i=0;i<60;i++) {				j=(i%12)*5;				index = j+Math.floor(i/12);				sequence[i] = new Array(index+"");			}		}	}}