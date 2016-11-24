package  {
	import flash.display.Stage;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class LevelManager {
		private var world:Space_shooter;
		private var currentLevel:Level = new Level(1);
		private var nextLevel:Level;
		
		private var enemySpawned:int = 0;
		
		private var timer:Timer;

		public function LevelManager(_world:Space_shooter) {
			//Give stage
			world = _world;
			//Start level
			progressLevel();
		}
		/**
		*Spawn an enemy on timer event
		**/
		private function timerListener (e:TimerEvent):void{
				var enemy = currentLevel.getEnemies()[enemySpawned];
				world.stage.addChild(enemy);
				enemySpawned++;
		}
		/**
		*Return if stage contains enemies
		**/
		public function checkEnemies():Boolean{
			for each(var enemy:Enemy in currentLevel.getEnemies()){
				if(world.stage.contains(enemy)){
					return true;
				}
			}
			return false;
		}
		/**
		*Check if all enemies exploded
		*if so go to next level
		**/
		public function checkLevel(){
			if(world.getSubScore() == world.getRound() * 50){
				world.addRound(1);
				progressLevel();
			}
		}
		/**
		*Set the level by round
		**/
		public function setNextLevel(){
			nextLevel = new Level(world.getRound());
		}
		/**
		*Go to next level
		*reset timer event
		*start timer event
		**/
		public function progressLevel(){
			setNextLevel();
			currentLevel = nextLevel;
			enemySpawned = 0;
			world.resetSubScore();
			timer = new Timer(1000, currentLevel.getEnemies().length);
			timer.addEventListener(TimerEvent.TIMER, timerListener);
			timer.start();
		}
		/**
		*Get current level
		**/
		public function getLevel():Level{
			return currentLevel;
		}
	}
}
