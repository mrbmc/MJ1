﻿package com.wcp.effects {	import com.wcp.Effect;	public class Clock extends Effect {		public function Clock ():void {			super("clock");			trail = 3;			row = new Array();			for(i=0;i<60;i++) {				row.push(i);				if(i%5==4) {					sequence.push(row);					row = new Array();				}			}		}	}}