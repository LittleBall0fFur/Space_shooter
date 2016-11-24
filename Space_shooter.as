package  {
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.text.*; 
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Space_shooter extends MovieClip {
		private var player:Player;
		private var enemy:Enemy;
		
		private var levelManager:LevelManager;
			
		private var bullets:Array;
		private var particleSystems:Array;
		
		//Menu
		private var menu:Menu;
		private var crScreen:CrScreen;
		
		//Sounds
		private var explosion:Explosion;
		private var shoot:Shoot;
		private var background:BackgroundMusic;
		private var menuMusic:MenuMusic;
		private var soundChannel:SoundChannel;
		private var soundChannel2:SoundChannel;
		
		//GUI
		private var countDown3:Countdown3 = new Countdown3();
		private var countDown2:Countdown2 = new Countdown2();
		private var countDown1:Countdown1 = new Countdown1();
		private var countDown0:Countdown0 = new Countdown0();
		private var flag:Boolean = true;
		
		private var hud:HUD;
		private var timer:int = 0;
		private var round:int = 1;
		private var score:int = 0;
		private var subScore:int = 0; //score to reset for level progression
		private var propTimer:Number;
		
		private var timerTxt:TextField = new TextField();
		private var min:int = 0;
		private var seconds:String;
		
		private var roundTxt:TextField = new TextField();
		
		private var scoreTxt:TextField = new TextField();
		private var endScoreTxt:TextField = new TextField();
		
		private var healthTxt:TextField = new TextField();
		private var playerLife = new PlayerLife();
		private var playerLife2 = new PlayerLife();
		private var playerLife3 = new PlayerLife();
		
		private var gameOverScr:GameOverScr;

		public function Space_shooter() {
			//Add menu
			menuMusic = new MenuMusic();
			soundChannel = new SoundChannel();
			soundChannel = menuMusic.play(0, 9999);
			openMenu();
		}
		
		public function startGame() {
			//Remove menu
			soundChannel.stop();
			stage.removeChild(menu);
			//Intialize variables
			player = new Player(this);
			bullets = new Array();
			explosion = new Explosion();
			background = new BackgroundMusic();
			shoot = new Shoot();
			particleSystems = new Array();
			levelManager = new LevelManager(this);
			//Set count down
			countDown3.x = 960;
			countDown3.y = 540;
			countDown2.x = 960;
			countDown2.y = 540;
			countDown1.x = 960;
			countDown1.y = 540;
			countDown0.x = 960;
			countDown0.y = 540;
			//Setup game
			spawn();
			addGUI();
			soundChannel2 = new SoundChannel();
			soundChannel2 = background.play(0, 9999);
			//Begin game
			addEventListener(Event.ENTER_FRAME, update);
			stage.focus = this.stage;
		}
		
		public function update(e:Event){
			//Set GUI and begin countdown
			countdown();
			guiUpdate();
			//After countdown begin game
			if(timer > 120){
				if(stage.contains(player)){
					player.movement();
					moveBullets();
					levelManager.checkEnemies();
					levelManager.checkLevel();
					collisionCheckPlayer();
					moveEnemies();
				}
				particleSystemHandler();
				gameOver();
			}
		}
		/**
		*Spawn the player
		**/
		private function spawn(){
			addChild(player);
		}
		/**
		*Begin the countdown
		*check if the countdown is called before
		**/
		private function countdown(){
			if(flag){
				if(timer > 24){
					if(!stage.contains(countDown3)){
						stage.addChild(countDown3);
					}
					countDown3.alpha -= 0.05;
				}
				if(timer > 48){
					if(!stage.contains(countDown2)){
						stage.addChild(countDown2);
					}
					if(stage.contains(countDown3)){
						stage.removeChild(countDown3);
					}
					countDown2.alpha -= 0.05;
				}
				if(timer > 72){
					if(!stage.contains(countDown1)){
						stage.addChild(countDown1);
					}
					if(stage.contains(countDown2)){
						stage.removeChild(countDown2);
					}
					countDown1.alpha -= 0.05;
				}
				if(timer > 96){
					if(!stage.contains(countDown0)){
						stage.addChild(countDown0);
					}
					if(stage.contains(countDown1)){
						stage.removeChild(countDown1);
					}
					countDown0.alpha -= 0.05;
				}
				if(timer > 120){
					if(stage.contains(countDown1)){
						stage.removeChild(countDown1);
					}
					flag = false;
				}
			}
		}
		
		/**
		*Get the timer for enemy spawn
		**/
		public function getPropTimer():int{
			return propTimer;
		}
		/**
		*Get the timer for eventListeners in player
		**/
		public function getTimer():int{
			return timer;
		}
		/**
		*Get the current round
		**/
		public function getRound():int{
			return round;
		}
		/**
		*Add to round
		**/
		public function addRound(i:int){
			round = round + i;
		}
		/**
		*Get the subscore for level progression
		**/
		public function getSubScore():int{
			return subScore;
		}
		/**
		*Reset the subscrore for level progression
		**/
		public function resetSubScore(){
			subScore = 0;
		}
		
		
		/**
		*Check if the particlesystem is burned out
		*If so remove the particlesystem
		**/
		public function particleSystemHandler(){
			for each(var p:ParticleSystem in particleSystems){
				p.updateParticle();
				if(p.getParticles().length == 50){
					if(stage.contains(p)){
						stage.removeChild(p);
					}
				}
			}
		}
		/**
		*Spawn the particleSystem on explosion position
		**/
		private function spawnParticleSystem(posX, posY){
			explosion.play();
			var particleSystem = new ParticleSystem(this, posX, posY);
			particleSystem.x = posX;
			particleSystem.y = posY;
			stage.addChild(particleSystem);
			particleSystems.push(particleSystem);
		}
		
		/**
		*Spawn the bullet at player position
		*Give the position of the mouse
		*Give the spawn for spawn check
		**/
		public function spawnBullet(){
			shoot.play();
			var bullet = new Bullet();
			bullet.getMousePosition(mouseX, mouseY);
			bullet.x = player.x;
			bullet.y = player.y;
			stage.addChild(bullet);
			bullet.setHasSpawned(true);
			bullets.push(bullet);
		}
		/**
		*Update the movement for every bullet on stage
		*Check if bullet is outside the screen
		*If so remove the bullet from stage and array
		**/
		private function moveBullets(){
			for each(var bullet:Bullet in bullets){
				bullet.moveBullet();
				collisionCheckBullets(bullet);
				if(bullet.x > 2020 || bullet.x < -100 || bullet.y > 1180 || bullet.y < -100 && bullets.length != 0){
					if(stage.contains(bullet)){
						var index:int;
						index = bullets.indexOf(bullet);
						bullets.splice(index, 1);
						stage.removeChild(bullet);
					}
				}
			}
		}
		/**
		*Update enemy movement and player position for every enemy
		**/
		private function moveEnemies(){
			var currentLevel:Level = levelManager.getLevel();
			for each(var enemy in currentLevel.getEnemies()){
				if(stage.contains(enemy)){
					enemy.setPlayerPos(player.x, player.y);
					enemy.enemyMovement();
				}
			}
		}
		
		/**
		*Check the collision between bullets and enemies
		**/
		private function collisionCheckBullets(_bullet:Bullet){
			var currentLevel:Level = levelManager.getLevel();
			for each( var enemy:Enemy in currentLevel.getEnemies()){
				if(_bullet.hitTestObject(enemy)){
					if(stage.contains(enemy)){
						score = score + 10;
						subScore = subScore + 10;
						spawnParticleSystem(enemy.x, enemy.y);
						stage.removeChild(enemy);
					}
				}
			}
		}
		/**
		*Check the collison between the player and enemies
		**/
		private function collisionCheckPlayer(){
			var currentLevel:Level = levelManager.getLevel();
			for each(var enemy:Enemy in currentLevel.getEnemies()){
				if(enemy.hitTestObject(player)){
					if(stage.contains(enemy)){
						spawnParticleSystem(enemy.x, enemy.y);
						player.applyDamage();
						score = score + 10;
						subScore = subScore + 10;
						stage.removeChild(enemy);
					}
				}
			}
		}
		/**
		*End of the Game
		**/
		private function gameOver(){
			var currentLevel:Level = levelManager.getLevel();
			if(player.getHealth() <= 0){
				for each(var enemy:Enemy in currentLevel.getEnemies()){
					if(stage.contains(enemy)){
						stage.removeChild(enemy);
					}
				}
				if(stage.contains(player)){
					spawnParticleSystem(player.x, player.y);
					removeChild(player);
				}
				if(!stage.contains(player)){
					gameOverScr = new GameOverScr();
					soundChannel2.stop();
					soundChannel = menuMusic.play(0, 9999);
					stage.addChildAt(gameOverScr, 3);
					addEndScoreText();
				}
			}
		}
		
		/**
		*Open menu
		**/
		public function openMenu() {
			menu = new Menu(this);
			stage.addChild(menu);
		}
		/**
		*Open credits
		**/
		public function openCredits() {
			crScreen = new CrScreen(this);
			stage.addChild(crScreen);
		}
		/**
		*Remove the credits
		**/
		public function backMenu() {
			stage.removeChild(crScreen);
		}
		
		/**
		*Add the GUI
		**/
		public function addGUI(){
			hud = new HUD();
			hud.x = this.width/2;
			hud.y = 0;
			this.addChild(hud);
			addTimerText();
			addScoreText();
			addRoundText();
			addHealthBar();
		}
		/**
		*Add the healthbar on the HUD
		**/
		public function addHealthBar(){
			playerLife.x = 1450;
			playerLife.y = 30;
			
			playerLife2.x = 1500;
			playerLife2.y = 30;
			
			playerLife3.x = 1550;
			playerLife3.y = 30;
			
			stage.addChild(playerLife);
			stage.addChild(playerLife2);
			stage.addChild(playerLife3);
			
			var myFormat:TextFormat = new TextFormat();
			var font1:Font1 = new Font1();
			healthTxt.x = 1300;
			healthTxt.y = 20;
			healthTxt.width = 500;
			myFormat.size = 20;
			myFormat.font = font1.fontName;
			healthTxt.defaultTextFormat = myFormat;
			healthTxt.embedFonts = true;
			healthTxt.antiAliasType = AntiAliasType.ADVANCED;
			healthTxt.text = "Lives: ";
			if(!stage.contains(healthTxt)){
				addChild(healthTxt);
			}
		}
		/**
		*Add the timer on the HUD
		**/
		public function addTimerText(){
			var myFormat:TextFormat = new TextFormat();
			var font1:Font1 = new Font1();
			timerTxt.x = 550;
			timerTxt.y = 20;
			timerTxt.width = 500;
			myFormat.size = 20;
			myFormat.font = font1.fontName;
			timerTxt.defaultTextFormat = myFormat;
			timerTxt.embedFonts = true;
			timerTxt.antiAliasType = AntiAliasType.ADVANCED;
			addChild(timerTxt);
		}
		/**
		*Add the score on the HUD
		**/
		public function addScoreText(){
			var myFormat:TextFormat = new TextFormat();
			var font1:Font1 = new Font1();
			scoreTxt.x = 1050;
			scoreTxt.y = 20;
			scoreTxt.width = 500;
			myFormat.size = 20;
			myFormat.font = font1.fontName;
			scoreTxt.defaultTextFormat = myFormat;
			scoreTxt.embedFonts = true;
			scoreTxt.antiAliasType = AntiAliasType.ADVANCED;
			addChild(scoreTxt);
		}
		/**
		*Add the end score on the game over screen
		**/
		public function addEndScoreText(){
			var myFormat:TextFormat = new TextFormat();
			var font1:Font1 = new Font1();
			endScoreTxt.x = 700;
			endScoreTxt.y = 740;
			endScoreTxt.width = 600;
			myFormat.size = 40;
			myFormat.font = font1.fontName;
			myFormat.color = 0xFFFFFF;
			endScoreTxt.defaultTextFormat = myFormat;
			endScoreTxt.embedFonts = true;
			endScoreTxt.antiAliasType = AntiAliasType.ADVANCED;
			endScoreTxt.text = "end score = "+ score;
			if(!stage.contains(endScoreTxt)){
				stage.addChildAt(endScoreTxt, 5);
			}
		}
		/**
		*Add the round on the HUD
		**/
		public function addRoundText(){
			var myFormat:TextFormat = new TextFormat();
			var font1:Font1 = new Font1();
			roundTxt.x = 800;
			roundTxt.y = 20;
			roundTxt.width = 500;
			myFormat.size = 20;
			myFormat.font = font1.fontName;
			roundTxt.defaultTextFormat = myFormat;
			roundTxt.embedFonts = true;
			roundTxt.antiAliasType = AntiAliasType.ADVANCED;
			addChild(roundTxt);
		}
		/**
		*Update the GUI's value's
		**/
		public function guiUpdate(){
			updateTimer();
			updateScore();
			updateRound();
			updateHealth();
		}
		/**
		*Update the timers
		**/
		public function updateTimer(){
			seconds = ""+timer/24;
			timerTxt.text = "Time:  "+ min + " : " + seconds.substr(0,2);
			timer++;
			if(timer/24 == 60){
				min++;
				timer = 0;
			}
			
			if(player.getPropulsion() && propTimer != player.getSpeed()) propTimer = player.getSpeed();
			else if(propTimer != 0 && propTimer >= 1) propTimer = propTimer - player.getDraft();
		}
		/**
		*Update the score
		**/
		public function updateScore(){
			scoreTxt.text = "Score: "+ score;
		}
		/**
		*Update the round
		**/
		public function updateRound(){
			roundTxt.text = "Round: " + round;
		}
		/**
		*Update the healthbar
		**/
		public function updateHealth(){
			if(player.getHealth() <= 2){
				if(stage.contains(playerLife3)){
					stage.removeChild(playerLife3);
				}
			}
			
			if(player.getHealth() <= 1){
				if(stage.contains(playerLife2)){
					stage.removeChild(playerLife2);
				}
			}
			
			if(player.getHealth() <= 0){
				if(stage.contains(playerLife)){
					stage.removeChild(playerLife);
				}
			}
		}
	}
}
