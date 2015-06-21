package com.orangesuzuki.as3.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import by.blooddy.crypto.Base64;

	/**
	 * 
	 * @author Katsushi.Suzuki
	 * 
	 */	
	public class BitmapUtil
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		/**
		 * キャプチャしたビットマップのBase64文字列を返します
		 * @param d
		 * @param width
		 * @param height
		 * @param ratio
		 * @return
		 *
		 */
		public static function toBase64(d:DisplayObject, width:Number, height:Number, ratio:Number = 0.25, parent:DisplayObjectContainer=null):String
		{
			d.scaleX = d.scaleY = ratio;
			var _parent:DisplayObjectContainer = d.parent || parent;
			var childIndex:int = _parent.getChildIndex(d);

			var s:Sprite = new Sprite();
			s.addChild(d);

			// 転写
			var bmd:BitmapData = getBitmapData(s, s.width, s.height);
			// Base64化
			var encoded:String = Base64.encode(bmd.getPixels(bmd.rect));

			// 戻す
			d.scaleX = d.scaleY = 1;
			_parent.addChildAt(d, childIndex);
			
			// BitmapData破棄
			if (bmd)
			{
				bmd.dispose();
				bmd = null;
			}
			return encoded;
		}

		/**
		 * Base64文字列を元にビットマップを返します
		 * @param encoded
		 * @param width
		 * @param height
		 * @param ratio
		 * @return
		 *
		 */
		public static function fromBase64(encoded:String, width:Number, height:Number, ratio:Number = 0.25):Bitmap
		{
			var bmd:BitmapData = new BitmapData(width * ratio, height * ratio, true, 0);

			var decoded:ByteArray = Base64.decode(encoded);
			decoded.position = 0;
			bmd.setPixels(bmd.rect, decoded);

			var bmp:Bitmap = new Bitmap(bmd);
			return bmp;
		}

		private static function getBitmapData(target:IBitmapDrawable, width:Number, height:Number, smoothing:Boolean = true):BitmapData
		{
			var bmd:BitmapData = new BitmapData(width, height, true, 0xFFFFFF);
			bmd.draw(target, new Matrix(), new ColorTransform(), "normal", null, smoothing);
			return bmd;
		}
	}
}
