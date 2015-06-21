package com.orangesuzuki.as3.gast.utils
{
	import flash.system.Capabilities;
	import flash.system.System;

	/**
	 * Gast :Google App Script Tracker
	 * ユーティリティークラス
	 * @author suzuki
	 *
	 */
	public class GastUtil
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		/**
		 * システム情報を返します
		 * @param obj
		 * @return
		 *
		 */
		public static function setSystemInfo(obj:Object):Object
		{
			if (obj)
			{
				// バージョン付きのブラウザ
				obj.browser = DeviceInfo.instance.detectBrowser(true);
				obj.OS = Capabilities.os;
				obj.flashplayer = Capabilities.version;
				obj.isDebugger = Capabilities.isDebugger ? 1 : 0;
				obj.resX = Capabilities.screenResolutionX;
				obj.resY = Capabilities.screenResolutionY;
				obj.dpi = Capabilities.screenDPI;
				obj.lang = Capabilities.language;
				obj.cpu = Capabilities.cpuArchitecture;
				obj.totalMemory = int(System.totalMemoryNumber / 1024);
				return obj;
			}
			else
				return new Object();
		}
	}
}
