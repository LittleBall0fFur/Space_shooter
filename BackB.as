package  {
	
	import flash.display.SimpleButton;
	import flash.events.*;
	
	public class BackB extends SimpleButton {
		public var world:Space_shooter;
		
		public function BackB(_world:Space_shooter) {
			// constructor code
			world = _world;
			this.addEventListener(MouseEvent.CLICK,isClicked);
		}
		public function isClicked(e:Event):void{
			world.backMenu();
		}
	}
}
