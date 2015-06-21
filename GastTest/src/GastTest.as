package 
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.orangesuzuki.as3.gast.Gast;
	import com.orangesuzuki.as3.gast.data.GastData;
	import com.orangesuzuki.as3.utils.TestUiBase;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;

	/**
	 * データ送受信テスト用UI
	 * @author suzuki
	 * 
	 */	
	public class GastTest extends TestUiBase
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function GastTest(stage:Stage=null, target:DisplayObject=null)
		{
			//===========================
			// 初期化
			//===========================
			var url:String = "https://script.google.com/macros/s/XXXX/exec";
			var defaultSheet:String = "sheetName";
			Gast.initialize( url, defaultSheet );
			
			// テストUI
			setUpUI(stage, target);
		}

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------
		private function send():void
		{
			log("sending...");
			
			//===========================
			// データ送信
			//===========================
			Gast.send(new GastData(
			{
				game0: int(Math.random() * 100000),
				game1: "abc",
				game2: JSON.stringify({param0: 1, param1: 100, param2: -123, param3: 0.568}),
				stageW: stage.stageWidth,
				stageH: stage.stageHeight
			}
			))
			.done(function(result:String):void {
				log(result);
			})
			.fail(function(result:String):void {
				log(result);
			});
		}

		private function fetch(row:int):void
		{
			log("fetching... id = " + row);

			//===========================
			// データ取得
			//===========================
			Gast.fetch(row)
			.done(function(result:String):void {
				log(result);
			})
			.fail(function(result:String):void {
				log(result);
			});
		}

		private function setUpUI(stage:Stage=null, target:DisplayObject=null):void
		{
			// データ追加
			addButton(0, 0, 150, 0, "データ送信", send);

			// データ取得
			var optionText:InputText = addInput(50, 50, "1");
			var optionLabel:Label = addLabel(0, 50, "行番号：");
			addButton(0, 75, 0, 0, "データ取得", function():void {
				fetch(int(optionText.text));
			});

			x = y = 20;
			console = addTextField(170, 0, 600, 300);
			console.background = true;
		}
		
	}
}
