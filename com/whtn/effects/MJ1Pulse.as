﻿package com.whtn.effects {
			var bright:Number = 1;
			var inc:int = 1;

			while(bright < 100) {
//				inc *= 1.3;
			//for(frame=0;frame<16;frame++) {
				for(tube=0;tube<8;tube++) {
//					if(bright >= 100 || bright <= 0) inc *= -1;
					display[tube] = new TubeSet(frame,bright);
			}
	//		var s = 
//			sequence.push(s);