package com.orangesuzuki.as3.gast.loader
{
	import com.orangesuzuki.as3.gast.data.GastData;
	import com.orangesuzuki.as3.gast.events.GastEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	/**
	 *
	 * @author Katsushi.Suzuki
	 *
	 */
	public class GastLoader extends EventDispatcher
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function GastLoader(target:IEventDispatcher)
		{
			super(target);
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// doneFunc 
		//--------------------------------------

		private var _doneFunc:Function;

		public function set doneFunc(value:Function):void
		{
			_doneFunc = value;
		}

		//--------------------------------------
		// failFunc 
		//--------------------------------------

		private var _failFunc:Function;

		public function set failFunc(value:Function):void
		{
			_failFunc = value;
		}

		private var urlLoader:URLLoader;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		/**
		 * ロードを開始します
		 * @param gastData
		 * @param url
		 *
		 */
		public function load(gastData:GastData, url:String, proxyUrl:String = "", method:String=URLRequestMethod.POST):void
		{
			var request:URLRequest = new URLRequest(url);

			// プロキシー設定時
			if (proxyUrl != "")
				request.url = proxyUrl;
			
			// パラメータ
			request.data = gastData.getURLVariables(url);
			request.method = method;

			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			addListeners();
			urlLoader.load(request);
		}

		/**
		 * 破棄
		 *
		 */
		public function dispose():void
		{
			removeListeners();
			_doneFunc = null;
			_failFunc = null;
			urlLoader = null;
		}

		/**
		 * 終了処理
		 *
		 */
		protected function exit(event:GastEvent):void
		{
			removeListeners();
			dispose();
			dispatchEvent(event);
		}

		protected function urlLoader_completeHandler(event:Event):void
		{
			var data:String = urlLoader.data;
			data = data.replace(/\\/g, '"');
			data = data.replace(/\"\"/g, '\"');

			if (_doneFunc != null)
				_doneFunc(data);

			var gastEvent:GastEvent = new GastEvent(GastEvent.COMPLETE);
			gastEvent.data = data;
			exit(gastEvent);
		}

		protected function urlLoader_ioErrorEventHandler(event:IOErrorEvent):void
		{
			if (_failFunc != null)
				_failFunc(event.text);

			var gastEvent:GastEvent = new GastEvent(GastEvent.IO_ERROR);
			gastEvent.data = event.text;
			exit(gastEvent);
		}

		protected function urlLoader_securityErrorHandler(event:SecurityErrorEvent):void
		{
			if (_failFunc != null)
				_failFunc(event.text);

			var gastEvent:GastEvent = new GastEvent(GastEvent.SECURITY_ERROR);
			gastEvent.data = event.text;
			exit(gastEvent);
		}

		private function addListeners():void
		{
			if (urlLoader)
			{
				urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorEventHandler);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
				//			urlLoader.addEventListener(flash.events.Event.OPEN, urlLoader_openHandler);
				//			urlLoader.addEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			}
		}

		private function removeListeners():void
		{
			if (urlLoader)
			{
				urlLoader.removeEventListener(Event.COMPLETE, urlLoader_completeHandler);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorEventHandler);
				urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
				//			urlLoader.removeEventListener(flash.events.Event.OPEN, urlLoader_openHandler);
				//			urlLoader.removeEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			}
		}
	}
}
