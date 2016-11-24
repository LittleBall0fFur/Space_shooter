package  {
	
	import flash.display.SimpleButton;
	import flash.events.*;
	
	public class StartGame extends SimpleButton {
		public var world:Space_shooter;
		
		public function StartGame(_world:Space_shooter) {
			//Give world
			world = _world;
			this.addEventListener(MouseEvent.CLICK,isClicked);
		}
		/**
		*Start the game on click
		**/
		public function isClicked(e:Event):void{
			world.startGame();
		}
	}
}
