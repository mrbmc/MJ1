package com.tabs
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import com.tabs.adapter.*;
	import com.tabs.events.*;
	
	[Event( name="TabChangeEvent", type="Events.TabChangeEvent" )]
	public class TabManager extends Sprite
	{
		// private variables 
		private var _tabArray : Array;
		private var _tabItem : tabItem;
		private var _tabControl : MovieClip;
		public var _tabHandler : TabHandler;
		//static variables
		static var activeTab : Number = 1
		
		public function TabManager( tabControl:MovieClip ) 
		{
			_tabArray = new Array();
			_tabControl = tabControl
			
		}
		public function addTab( tabText:String ) : void 
		{
			_tabHandler = new TabHandler()
			_tabHandler.name = "tabHandler"+(tabCount()+1);
			_tabControl.addChild( _tabHandler )
			_tabItem = _tabHandler.addTab()
			_tabItem.name = "tab"+(tabCount()+1);
			_tabItem.txt.embedFonts = true;
			_tabItem.txt.text = tabText;
			_tabItem.indexNum = tabCount()+1;
			_tabControl.addChildAt( _tabItem,0 );
			if(_tabArray.length <= 0 )
			{
				_tabItem.x = 5;
				_tabItem.y = -3.4;
				
			}
			else{
				var prevTab:MovieClip = _tabControl.getChildByName("tab"+tabCount()) as MovieClip;
				_tabItem.x = prevTab.x + prevTab.width 
				_tabItem.y = -3.4;
				_tabItem.gotoAndStop("s2")
			}
			_tabItem.mouseChildren = false;
			_tabItem.addEventListener(MouseEvent.CLICK, handleTabClick);
			_tabArray.push( _tabHandler );
		}
		/**
		 * Returns the total Tab counts
		 * 
		 * @returns 			Number of Tabs				
		 */		
		private function tabCount() : Number
		{
			return _tabArray.length;
		}
		
		// tab events
		private function handleTabClick( event:MouseEvent ) : void
		{
			activeTab =  event.target.indexNum;
			event.target.gotoAndPlay("s2")
			this.dispatchEvent( new TabChangeEvent( TabChangeEvent.TABCHANGED_EVENT, true,event.target.name,  _tabArray[activeTab-1] ) );
			deActivateTabs( event.target as MovieClip );
		}
		/**
		 * Clears all the Tab contents
		 * Creates the contents for the active Tab
		 * 
		 * @Param 			Active Tab reference				
		 */
		private function deActivateTabs( target_mc:MovieClip ) : void
		{
			for( var i:int; i < tabCount(); i++)
			{
				if( target_mc != _tabArray[i].getTab())
				{
					_tabArray[i].getTab().gotoAndStop("s2")
					_tabArray[i].disposeTab();
				}
				else
				{
					_tabArray[i].createTab();
				}
			}
		}
		/**
		 * Returns the active tab reference
		 * 
		 * @returns 			Active Tab reference				
		 */		
		public function getActiveTab() : TabHandler
		{
			return _tabControl.getChildByName("tabHandler"+activeTab) as TabHandler;
		}
		
	}
}