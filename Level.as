package  {
	
	public class Level {
		private var enemies:Array;
		
		public function Level(_round:int) {
			// constructor code
			enemies = new Array();
			//Generate enemies to round
			generateEnemies(_round);
		}
		/**
		*Generate the enemies to round times 5
		**/
		private function generateEnemies(_round:int){
			for (var i:int = 0; i < _round * 5 ; i++){
				enemies.push(new Enemy());
			}
		}
		/**
		*Give the array from enemies
		**/
		public function getEnemies():Array{
			return enemies;
		}
	}
}
