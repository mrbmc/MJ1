﻿package com.whtn.effects {
			var bright:Number = 1;
			var inc:int = 1;

			for(i=0;i<16;i++) display.push(new TubeSet(i,100));
			display = [];
			for(i=0;i<16;i++) display.push(new TubeSet(i,0));
			//sequence.push(display);