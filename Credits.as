package  {
	
	import flash.display.SimpleButton;
	import flash.events.*;
	
	public class Credits extends SimpleButton {
		public var world:Space_shooter;
		
		public function Credits(_world:Space_shooter) {
			//Give World
			world = _world;
			this.addEventListener(MouseEvent.CLICK,isClicked);
		}
		/**
		*Open the credits Screen on click
		**/
		public function isClicked(e:Event):void{
			world.openCredits();
		}
	}
	
}
