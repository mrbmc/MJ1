﻿package com.whtn.effects {	import com.whtn.Effect;	public class Rings extends Effect {		public function Rings ():void {			super("rings");			hotKey = "q";			trail = 2;			//sequence.push(new Array());			for(i=0;i<5;i++) sequence.push(new Array());			var frame = 0;			for(i=0;i<60;i++) {				frame = (i%5);				index = i+(frame*5);				//trace("i:"+i+" frame:"+frame+" index:"+index);				sequence[frame].push(i);			}			sequence.push(new Array());		}	}}