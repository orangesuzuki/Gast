package com.orangesuzuki.as3.gast.events
{
	import flash.events.Event;

	/**
	 * 
	 * @author Katsushi.Suzuki
	 * 
	 */	
	public class GastEvent extends Event
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------
		
		
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		
		public static const PARSE_ERROR:String = "parseError";
		public static const IO_ERROR:String = "ioError";
		public static const SECURITY_ERROR:String = "securityError";

		public var data:String;
		
		public function GastEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
