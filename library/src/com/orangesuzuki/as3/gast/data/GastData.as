package com.orangesuzuki.as3.gast.data
{
	import com.orangesuzuki.as3.gast.utils.GastUtil;
	
	import flash.net.URLVariables;

	/**
	 * Gast :Google App Script Tracker
	 * 送信データ
	 * @author suzuki
	 *
	 */
	public class GastData
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function GastData(saveData:Object, actionParam:uint = 0, sheetName:String = "")
		{
			this.saveData = saveData;
			this.actionParam = actionParam;
			this.sheetName = sheetName;
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		// アクション
		public var action:String = GastActionType.ACTION_TYPE_APPEND;

		// オプション引数
		public var actionParam:uint;

		public function get hasSheetName():Boolean
		{
			return sheetName != "";
		}

		// 送信データ
		public var saveData:Object;

		// シートの指定
		public var sheetName:String;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		public function getURLVariables(url:String=""):URLVariables
		{
			var variables:URLVariables = new URLVariables();
			variables["action"] = action;
			variables["sheetName"] = sheetName;
			variables["actionParam"] = actionParam;
			// システム情報の追加
			GastUtil.setSystemInfo(saveData);
			// 文字列化
			variables["saveData"] = JSON.stringify(saveData);
			// プロキシー用
			variables["url"] = url;

			return variables;
		}
	}
}
