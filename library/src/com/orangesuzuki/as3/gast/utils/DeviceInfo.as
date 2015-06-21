package com.orangesuzuki.as3.gast.utils
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;

	public class DeviceInfo
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		public static const CHROME:String = "chrome";
		public static const SAFARI:String = "safari";
		public static const OPERA:String = "opera";
		public static const FIREFOX:String = "firefox";
		
		public static const IE11:String = "ie11";
		public static const IE10:String = "ie10";
		public static const IE9:String = "ie9";
		public static const IE8:String = "ie8";
		public static const IE7:String = "ie7";
		public static const IE6:String = "ie6";
		public static const IE_UNKNOWN:String = "ie_unknown";
		
		/**
		 * singleton
		 */
		private static var _instance:DeviceInfo;

		public static function get instance():DeviceInfo
		{
			return _instance ||= new DeviceInfo(new SingletonEnforcer());
		}

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function DeviceInfo(enforcer:SingletonEnforcer)
		{
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		public function get isBrowser():Boolean
		{
			return !(isStandAlone || isExternal);
		}

		public function get isExternal():Boolean
		{
			return Capabilities.playerType.indexOf("External") >= 0;
		}

		public function get isMac():Boolean
		{
			return Capabilities.os.indexOf("Mac") >= 0;
		}

		public function get isStandAlone():Boolean
		{
			return Capabilities.playerType.indexOf("StandAlone") >= 0;
		}
		
		/**
		 * ブラウザの種類とバージョンを返します 
		 * @param logFunc: trace関数などを代入
		 * @param addVersion: バージョンを返すかどうか(デフォルトfalse)
		 * falseのとき、「chrome」と返します。ただし、IEのみ「ie11」となります。
		 * trueのとき、「chrome/42.0.2311.90」と返します。 
		 * @return 
		 * 
		 */		
		public function detectBrowser(addVersion:Boolean=false, logFunc:Function = null):String
		{
			if (!ExternalInterface.available)
			{
				if (logFunc!=null)
					logFunc("ExternalInterface.unavailable");
				return "";
			}
			
			try
			{
				var ua:String = ExternalInterface.call("window.navigator.userAgent.toLowerCase");
				var version:String = ExternalInterface.call("window.navigator.appVersion.toLowerCase");
				var browser:String = "unknown";
				
				if (ua.indexOf("msie") != -1)
				{
					if (version.indexOf("msie 6.") != -1)
						browser = DeviceInfo.IE6;
					else if (version.indexOf("msie 7.") != -1)
						browser = DeviceInfo.IE7;
					else if (version.indexOf("msie 8.") != -1)
						browser = DeviceInfo.IE8;
					else if (version.indexOf("msie 9.") != -1)
						browser = DeviceInfo.IE9;
					else if (version.indexOf("msie 10.") != -1)
						browser = DeviceInfo.IE10;
					else
						browser = DeviceInfo.IE_UNKNOWN;
				}
				else if (ua.indexOf("trident/7") != -1)
					browser = DeviceInfo.IE11;
				else if (ua.indexOf(DeviceInfo.CHROME) != -1)
					browser = DeviceInfo.CHROME;
				else if (ua.indexOf(DeviceInfo.SAFARI) != -1)
					browser = DeviceInfo.SAFARI;
				else if (ua.indexOf(DeviceInfo.OPERA) != -1)
					browser = DeviceInfo.OPERA;
				else if (ua.indexOf(DeviceInfo.FIREFOX) != -1)
					browser = DeviceInfo.FIREFOX;
				
				if (logFunc!=null)
				{
					logFunc(browser);
					logFunc(version);
				}
				
				// バージョンも追加する場合
				if(addVersion){
					var versionSet:Array = ua.split(" ");
					for each (var v:String in versionSet)
					{
						if (v.indexOf(browser) >= 0)
						{
							//log(v);						
							return v;
						}
					}
				}
			}
			catch (error:Error)
			{
			}
			
			return browser;
		}
	}
}

class SingletonEnforcer
{
}
