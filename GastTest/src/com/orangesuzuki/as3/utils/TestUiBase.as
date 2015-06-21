package com.orangesuzuki.as3.utils
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	public class TestUiBase extends Sprite
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function TestUiBase()
		{
			super();

			Style.embedFonts = false;
			Style.fontName = "_ゴシック";
			Style.fontSize = 12;
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		protected var console:TextField;
		protected var inputField:TextField;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		protected function log(... arg):void
		{
			for (var i:int = 0; i < arg.length; i++)
			{
				if (console)
					console.appendText(arg[i] + "\n");
			}
		}
		
		protected function addButton(x:Number = 0, y:Number = 0, width:Number=0, height:Number=0, label:String = "", callback:Function = null, ... args):PushButton
		{
			var btn:PushButton = new PushButton(this, 0, 0, label, function(e:MouseEvent):void {
				if (callback != null)
					callback.apply(this, args);
			});
			btn.x = x;
			btn.y = y;
			btn.width = width>0? width: 150;
			btn.height = height>0? height: 20;
			return btn;
		}
		
		protected function addInputTextField(x:Number = 0, y:Number = 0, width:Number = 400, height:Number = 400):TextField
		{
			return addTextField(x, y, width, height, TextFieldType.INPUT);
		}

		protected function addTextField(x:Number = 0, y:Number = 0, width:Number = 400, height:Number = 400, type:String = TextFieldType.DYNAMIC):TextField
		{
			var tf:TextField = new TextField();
			tf.x = x;
			tf.y = y;
			tf.width = width;
			tf.height = height;
			tf.border = true;
			tf.wordWrap = true;
			tf.type = type;
			addChild(tf);
			return tf;
		}

		protected function addLabel(x:Number = 0, y:Number = 0, label:String = ""):Label
		{
			var item:Label = new Label(this, x, y, label);
			return item;
		}

		protected function addInput(x:Number = 0, y:Number = 0, label:String = "", width:Number = -1, height:Number = -1):InputText
		{
			var item:InputText = new InputText(this, x, y);
			if (width > 0)
				item.width = width;
			if (height > 0)
				item.height = height;
			item.text = label;
			return item;
		}

		protected function addCombobox(target:DisplayObjectContainer, x:Number = 0, y:Number = 0, label:String = "", items:Array = null, selectedIndex:int = 0, callback:Function = null, ... args):ComboBox
		{
			var comboBox:ComboBox = new ComboBox(target, x, y, label, items);

			// Comboboxの準備
			comboBox.numVisibleItems = items.length;
			comboBox.selectedIndex = selectedIndex;
			comboBox.addEventListener(Event.SELECT, function(e:Event):void {
				if (callback != null)
					callback.apply(this, args);
			});
			addChild(comboBox);
			return comboBox
		}
	}
}
