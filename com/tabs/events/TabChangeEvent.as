package com.tabs.events{
	import flash.events.Event;
	import com.tabs.adapter.TabHandler;

	public class TabChangeEvent extends Event 
	{
		
		public static const TABCHANGED_EVENT:String = "tabChanged";
		
		public var tabName:String;
		public var tabHandler:TabHandler;

		public function TabChangeEvent( type:String, bubbles:Boolean, _tabName:String, _tabHandler:TabHandler ) {
			super( TabChangeEvent.TABCHANGED_EVENT, true );
			this.tabName = _tabName;
			this.tabHandler = _tabHandler;
		}

        public override function clone():Event
        {
            return new TabChangeEvent(TabChangeEvent.TABCHANGED_EVENT, true, this.tabName, this.tabHandler);
        } 
	}
}