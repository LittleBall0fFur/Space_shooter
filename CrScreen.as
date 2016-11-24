package  {
	
	import flash.display.MovieClip;
	
	public class CrScreen extends MovieClip {
		public var back:BackB;
		
		public function CrScreen(_world:Space_shooter) {
			// constructor code
			setBack(_world);
		}
		/**
		*Place the back button
		**/
		public function setBack(_world){
			back = new BackB(_world);
			back.x = 760;
			back.y = 800;
			addChild(back);
		}
	}
}
