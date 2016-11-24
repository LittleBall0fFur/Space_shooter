package  {
	
	import flash.display.MovieClip;
	
	
	public class Menu extends MovieClip {
		public var start:StartGame;
		public var credits:Credits;

		
		public function Menu(_world:Space_shooter) {
			// constructor code
			setStart(_world);
			setCredits(_world);
		}
		/**
		*Place the start button in menu
		**/
		public function setStart(_world){
			start = new StartGame(_world);
			start.x = 1300;
			start.y = 700;
			addChild(start);
		}
		/**
		*Place the credits button in menu
		**/
		public function setCredits(_world){
			credits = new Credits(_world);
			credits.x = 720;
			credits.y = 800;
			addChild(credits);
		}
	}
}
