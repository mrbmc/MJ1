﻿package com.whtn {	import flash.events.Event;	public class TubeEvent extends Event {		public var index:Object;		public var settings:TubeSet = new TubeSet();		public function TubeEvent (_index:Object=null,_settings:TubeSet=null) {			this.index = _index;			this.settings = _settings;			super('tube',true);		}	}}