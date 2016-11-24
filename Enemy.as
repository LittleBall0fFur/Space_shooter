package  {
	import flash.display.MovieClip;
	
	public class Enemy extends Spaceship {
		private var sprite: MovieClip;
		
		//spawns
		private var spawnPointLT:Vector2;
		private var spawnPointLM:Vector2;
		private var spawnPointLB:Vector2;
		private var spawnPointMT:Vector2;
		private var spawnPointMB:Vector2;
		private var spawnPointRT:Vector2;
		private var spawnPointRM:Vector2;
		private var spawnPointRB:Vector2;
		
		private var spawnPoints:Array;
		
		//movement
		private var position:Vector2;
		private var playerPosition:Vector2;
		private var mouse:Vector2;
		private var dir:Vector2;
		
		public function Enemy() {
			//Give Sprite image
			sprite = new EnemyImg();
			this.addChild(sprite);
			//Initialize variables
			super.setHealth(1);
			super.setDamage(1);
			speed = 20;
			spawnPoints = new Array();
			position = new Vector2();
			dir = new Vector2();
			//Get start position
			spawnLocations();
			selectSpawnLocation();
		}
		/**
		*Set spawn positions
		**/
		private function spawnLocations(){
			spawnPointLT = new Vector2(100, 100);
			spawnPointLM = new Vector2(100, 540);
			spawnPointLB = new Vector2(100, 980);
			spawnPointMT = new Vector2(990, 100);
			spawnPointMB = new Vector2(990, 980);
			spawnPointRT = new Vector2(1820, 100);
			spawnPointRM = new Vector2(1820, 540);
			spawnPointRB = new Vector2(1820, 980);
			spawnPoints.push(spawnPointLT);
			spawnPoints.push(spawnPointLM);
			spawnPoints.push(spawnPointLB);
			spawnPoints.push(spawnPointMT);
			spawnPoints.push(spawnPointMB);
			spawnPoints.push(spawnPointRT);
			spawnPoints.push(spawnPointRM);
			spawnPoints.push(spawnPointRB);
		}
		/**
		*Select a spawn position
		*Transform enemy position to spawnpoint
		**/
		private function selectSpawnLocation(){
			var location:Vector2 = spawnPoints[Math.floor(Math.random() * (7 + 1))];
			this.x = location.x;
			this.y = location.y;
		}
		/**
		*Give enemy the player position
		**/
		public function setPlayerPos(plX, plY){
			playerPosition = new Vector2(plX, plY);
		}
		/**
		*Movement
		**/
		public function enemyMovement(){
			position = new Vector2(this.x, this.y);
			dir.create(position, playerPosition);
			this.rotation = dir.getAngle();
			var angle:Number = this.rotation * Math.PI / 180;
			this.x = this.x - speed * Math.cos(angle);
			this.y = this.y - speed * Math.sin(angle);
		}
	}	
}
