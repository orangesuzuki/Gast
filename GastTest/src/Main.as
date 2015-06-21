package
{
	import flash.display.Sprite;
	

	[SWF(backgroundColor = "0xFFFFFF", frameRate = "60", width = "800", height = "750")]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.scaleMode = "noScale";
			stage.align = "TL";
			addChild( new GastTest(stage) );
		}
	}
}