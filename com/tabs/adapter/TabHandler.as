package com.tabs.adapter
{

	import flash.display.*;
	import flash.utils.getQualifiedClassName;
	import flash.events.MouseEvent;

	public class TabHandler extends Sprite 
	{
		private var _tabItem : tabItem;
	
		private var _holder : MovieClip;
	
		private var activeSection : MovieClip;
		public var initial:Boolean = true;
		
		public function TabHandler() 
		{
			_holder = new MovieClip();
			_holder.name =  "_holder";
			this.addChild( _holder );
			this._holder.x = 23;
			this._holder.y = 35;
			
		}
	
		public function addTab():tabItem {
			_tabItem = new tabItem();
			return _tabItem;
		}
		public function getTab():tabItem {
			return _tabItem;
		}
		
		public function addChildren(obj:DisplayObjectContainer):void
		{
			var tabContent : MovieClip = this.getChildByName( "_holder" ) as MovieClip;
			tabContent.addChild(obj)
		}
		
		public function disposeTab():void {
			var tabContent : MovieClip = this.getChildByName( "_holder" ) as MovieClip;
			tabContent.mouseChildren = false;
			tabContent.visible = false;
		}
		public function createTab():void {
			var tabContent : MovieClip = this.getChildByName( "_holder" ) as MovieClip;
			tabContent.mouseChildren = true;
			tabContent.visible = true;
		}
		
	}
}