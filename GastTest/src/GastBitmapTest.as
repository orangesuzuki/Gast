package 
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.orangesuzuki.as3.gast.Gast;
	import com.orangesuzuki.as3.gast.data.GastData;
	import com.orangesuzuki.as3.utils.BitmapUtil;
	import com.orangesuzuki.as3.utils.TestUiBase;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * データ送受信テスト用UI
	 * @author suzuki
	 * 
	 */	
	public class GastBitmapTest extends TestUiBase
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function GastBitmapTest(stage:Stage=null, target:DisplayObject=null)
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
			
			
			addButton(0, 185, 0, 0, "エラー発生", errorTest);
			if(stage){
				stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent):void{
					if(e.keyCode==Keyboard.E)
						errorTest();
					else if(e.keyCode==Keyboard.D)
						decodeTest(int(optionText.text));
				});
			}
			
			var self:DisplayObjectContainer = this;			
			function errorTest():void
			{
//				a.length;
//				var a:Array = [];
								
				// ブラウザ再生時にエラー内容を送信します
				Gast.send(new GastData({
//						error: evt.error,
						mouseX: stage.mouseX,
						mouseY: stage.mouseY,
						stageW: stage.stageWidth,
						stageH: stage.stageHeight,
						// 画面キャプチャー
						capture: BitmapUtil.toBase64(self, 800, 600, 0.2, stage)
					}, 0, "errors"));
			}
			
			addButton(0, 155, 0, 0, "キャプチャー取得", function():void{		
				decodeTest(int(optionText.text));
			});
			
			function decodeTest(row:int=1):void
			{
				Gast.fetch(row, "errors")
				.done(function(result:String):void {
					var obj:Object = JSON.parse(result);
					var bmp:Bitmap = BitmapUtil.fromBase64(obj.capture, 800, 600, 0.2);
					bmp.y = 300;
					addChild( bmp );
				});
			}
		}
		
	}
}
