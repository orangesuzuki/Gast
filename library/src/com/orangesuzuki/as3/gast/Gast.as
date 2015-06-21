package com.orangesuzuki.as3.gast
{
	import com.orangesuzuki.as3.gast.data.GastActionType;
	import com.orangesuzuki.as3.gast.data.GastData;
	import com.orangesuzuki.as3.gast.loader.GastLoader;

	import flash.events.EventDispatcher;

	/**
	 * Gast :Google App Script Tracker
	 * @author Katsushi.Suzuki
	 *
	 */
	public class Gast extends EventDispatcher
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		/**
		 * Gastツールのバージョン番号です
		 */
		public static const VERSION:String = "0.0.1";

		/**
		 * Gastツールの有効・無効を切り替えます
		 */
		public static var enabled:Boolean = true;
		
		

		private static var _initialized:Boolean;
		private static var _defaultSheet:String;
		private static var _url:String;
		private static var _proxyUrl:String;

		/**
		 * Gastツールを初期化します
		 * @param url：GoogleスプレッドシートのURL
		 * @param defaultSheet：シート名
		 * @param proxyUrl：プロキシー使用時のURL
		 *
		 */
		public static function initialize(url:String, defaultSheet:String, proxyUrl:String = ""):void
		{
			_url = url;
			_proxyUrl = proxyUrl;
			_defaultSheet = defaultSheet;
			_initialized = true;
		}

		/**
		 * データの送信を開始します
		 * @param gastData
		 * @return
		 *
		 */
		public static function send(gastData:GastData):Gast
		{
			var gas:Gast = new Gast();
			gas.send(gastData);
			return gas;
		}

		/**
		 * データの取得を開始します
		 * @param row：スプレッドシートの行番号
		 * @param sheetName
		 * @return
		 *
		 */
		public static function fetch(row:int, sheetName:String = ""):Gast
		{
			var gas:Gast = new Gast();
			gas.fetch(row, sheetName);
			return gas;
		}

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function Gast()
		{
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		private var gastLoader:GastLoader;

		//----------------------------------------------------------	
		//
		//   Function 
		//
		//----------------------------------------------------------

		/**
		 * データの送信を開始します
		 * @param gastData
		 * @return
		 *
		 */
		public function send(gastData:GastData):Gast
		{
			if (!_initialized)
			{
				log("Gast: 初期化されていません。");
				return this;
			}

			if (enabled)
			{
				if (!gastData.hasSheetName)
					gastData.sheetName = _defaultSheet;

				gastLoader = new GastLoader(this);
				gastLoader.load(gastData, _url, _proxyUrl);
			}
			return this;
		}

		/**
		 * データの取得を開始します
		 * @param row：スプレッドシートの行番号
		 * @param sheetName
		 * @return
		 *
		 */
		public function fetch(row:int, sheetName:String = ""):Gast
		{
			if (!_initialized)
			{
				log("Gast: 初期化されていません。");
				return this;
			}

			if (enabled)
			{
				var gastData:GastData = new GastData({}, row, sheetName);
				gastData.action = GastActionType.ACTION_TYPE_FETCH;
				send(gastData);
			}
			return this;
		}

		/**
		 * 通信成功時のコールバック関数を登録します
		 * @param callback
		 * @return
		 *
		 */
		public function done(callback:Function):Gast
		{
			if (gastLoader)
				gastLoader.doneFunc = callback;
			return this;
		}

		/**
		 * 通信失敗時のコールバック関数を登録します
		 * @param callback
		 * @return
		 *
		 */
		public function fail(callback:Function):Gast
		{
			if (gastLoader)
				gastLoader.failFunc = callback;
			return this;
		}

		/**
		 * インスタンスを破棄します
		 *
		 */
		public function dispose():void
		{
			if (gastLoader)
				gastLoader.dispose();
			gastLoader = null;
		}

		protected function log(... arg):void
		{
			trace(arg);
		}
	}
}
