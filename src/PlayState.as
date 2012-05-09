package {
	import org.flixel.*;
	
	public class PlayState extends FlxState {
		private const TILE_HEIGHT:uint = 16;
		private const TILE_WIDTH:uint = 16;
		
		[Embed(source = '../assets/map_boundaries/array_map_boundaries.txt', mimeType = 'application/octet-stream')]
		private var array_mapBoundaries:Class;
		
		[Embed(source = '../assets/map_boundaries/tiles_boundaries.png')]
		private var imgBoundariesTiles:Class;
		
		private var emitter:FlxEmitter;
		
		private var arrBullet:FlxGroup;
		private var arrEnemies:FlxGroup;
		
		private var mapBoundaries:FlxTilemap;
		
		private var spawnInterval:Number = 2.5;
		private var spawnTimer:Number;
		
		private var sprBullet:Bullet;
		private var sprHero:Hero;
		
		private var score:FlxText;
		
		public function PlayState():void {
			super();
			
			//debug
			trace("PlayState.as Initialized");
		}
		
		public override function create():void {
			super.create();
			
			FlxG.bgColor = 0x44ABCC7D;
			
			resetSpawnTimer();
			
			arrBullet = new FlxGroup();
			add(arrBullet);
			
			arrEnemies = new FlxGroup();
			add(arrEnemies);
			
			sprHero = new Hero(20, 250);
			add(sprHero);
			
			FlxG.score = 0;
			score = new FlxText(TILE_WIDTH, TILE_HEIGHT, FlxG.width, "0");
			add(score);
			
			mapBoundaries = new FlxTilemap();
			mapBoundaries.loadMap(new array_mapBoundaries, imgBoundariesTiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			add(mapBoundaries);
}
		
		public override function update():void {
			super.update();
			
			spawnTimer -= FlxG.elapsed;
			
			if (spawnTimer < 0) {
				resetSpawnTimer();
				spawnEnemy();
			}
			
			if (FlxG.keys.justPressed("X") && sprHero.alive == true) {
				if (sprHero.getDirection() == 16) {
					spawnBullet(sprHero.getBulletSpawnPositionRight());
				}
				else if (sprHero.getDirection() == 1) {
					spawnBullet(sprHero.getBulletSpawnPositionLeft());
				}
			}
			
			FlxG.collide(mapBoundaries, arrBullet, collideMapBoundariesBullet);
			FlxG.collide(mapBoundaries, arrEnemies);
			FlxG.collide(mapBoundaries, sprHero);
			
			FlxG.overlap(arrBullet, arrEnemies, overlapBulletEnemies);
			FlxG.overlap(arrEnemies, sprHero, overlapEnemiesHero);
		}
		
		private function collideMapBoundariesBullet(mapBoundaries:FlxTilemap, bullet:Bullet):void {
			bullet.kill();
		}
		
		private function createEmitter():FlxEmitter {
			var particles:uint = 20;
			
			emitter = new FlxEmitter();
			emitter.frequency = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed( -500, 500);
			emitter.setYSpeed( -500, 500);
			
			for (var i:uint = 1; i < particles; i++) {
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xFF597137, true);
				particle.exists = false;
				emitter.add(particle);
			}
			
			emitter.start();
			
			add(emitter);
			
			return emitter;
		}
		
		private function overlapBulletEnemies(bullet:Bullet, enemy:Enemy):void {
			bullet.kill();
			enemy.kill();
			
			emitter = createEmitter();
			emitter.at(enemy);
			
			FlxG.score++;
			score.text = FlxG.score.toString();
		}
		
		private function overlapEnemiesHero(enemy:Enemy, hero:Hero):void {
			enemy.kill();
			hero.kill();
			
			emitter = createEmitter();
			emitter.at(enemy);
			emitter.at(hero);
		}
		
		private function resetSpawnTimer():void {
			spawnTimer = spawnInterval;
			spawnInterval *= 0.95;
			
			if (spawnInterval < 0.1) {
				spawnInterval = 0.1;
			}
		}
		
		private function spawnBullet(p:FlxPoint):void {
			sprBullet = new Bullet(p.x, p.y, sprHero.getDirection());
			arrBullet.add(sprBullet);
		}
		
		private function spawnEnemy():void {
			var x:Number = spawnEnemyX();
			var y:Number = spawnEnemyY();
			arrEnemies.add(new Enemy(x, y, sprHero));
		}
		
		private function spawnEnemyX():Number {
			var a:Number = Math.random() * 380;
			var b:Number = 20 + Math.random() * 355;
			
			return a, b;
		}
		
		private function spawnEnemyY():Number {
			var a:Number = Math.random() * 380;
			var b:Number = 20 + Math.random() * 355;
			
			return a, b;
		}
	}
}