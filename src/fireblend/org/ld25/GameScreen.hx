package fireblend.org.ld25;

import nme.events.Event;
import nme.display.Sprite;
import nme.display.Shape;
import nme.display.DisplayObject;
import nme.events.MouseEvent;
import nme.Lib;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.system.System;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.geom.Rectangle;
import nme.Assets;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Sergio Morales
 */

class GameScreen implements Screen, extends Sprite
{

	private var gameMain:Main;
	private var planets:Array<Planet>;
	private var mines:Array<Mine>;
	private var meteorite:Meteorite;
	private var started:Bool;
	private var paused:Bool;
	private var scoreField:TextField;
	private var userDragging:Bool;
	private var startedDragOnY: Float;
	private var startingYForMeteorite: Float;
	private var hitPlanet:Sprite;
	private var life :Int;
	private var life1 :Sprite;
	private var life2 :Sprite;
	private var life3 :Sprite;
	private var endGame : Bool;
	
	public function new(newGameMain:Main) 
	{
		super();
		gameMain = newGameMain;
		
		
		
	}
	
	public function initialize() {
		
		gameMain.score = 0;
		started = false;
		var scaleFactor : Float;
		endGame = false;
		if(meteorite == null){
			meteorite = new Meteorite(this);
			scaleFactor = (gameMain.screenHeight / 3) / meteorite.height ;
			meteorite.scaleX = scaleFactor;
			meteorite.scaleY = scaleFactor;
		}
		else {
			scaleFactor = meteorite.scaleFactor;
		}
		addChild(meteorite);
		paused = false;
		userDragging = false;
		life = 3;
		
		planets = new Array<Planet>();
		mines = new Array<Mine>();
		
		if(scoreField==null){
			scoreField = new TextField ();
		}
		scoreField.text = "Score: 0";
		scoreField.width = 200;
		var textFormat:TextFormat = new TextFormat ("_sans", 30, 0xFFFFFF);
		scoreField.setTextFormat (textFormat);
		scoreField.x = 6;
		scoreField.y = 6;
		scoreField.alpha = 0;
		scoreField.selectable = false;
		addChild(scoreField);
		
		if (life1 == null){
		life1 = Utils.loadGraphic ("assets/gfx/heart.png", true, true);
		life2 = Utils.loadGraphic ("assets/gfx/heart.png", true, true);
		life3 = Utils.loadGraphic ("assets/gfx/heart.png", true, true);
		var scaleForHearts : Float = (gameMain.screenHeight / 14) / life1.height;
		life1.y = 7;
		life2.y = 7;
		life3.y = 7;
		life1.scaleX = scaleForHearts;
		life2.scaleX = scaleForHearts;
		life3.scaleX = scaleForHearts;
		life1.scaleY = scaleForHearts;
		life2.scaleY = scaleForHearts;
		life3.scaleY = scaleForHearts;
		life3.scaleY = scaleForHearts;
		life1.x = gameMain.screenWidth - (gameMain.screenWidth/14)*3;
		life2.x = gameMain.screenWidth - (gameMain.screenWidth/14)*2;
		life3.x = gameMain.screenWidth - (gameMain.screenWidth/14)*1;
		}
		life1.alpha = 0;
		life2.alpha = 0;
		life3.alpha = 0;
		
		addChild(life1);
		addChild(life2);
		addChild(life3);
		
		meteorite.scaleFactor = scaleFactor;
		meteorite.x = gameMain.screenWidth+meteorite.width-10;
		meteorite.y = gameMain.screenHeight / 2 - meteorite.height / 2;
		
		var path :String = "assets/gfx/hitplan.png";
		hitPlanet = Utils.loadGraphic (path, true, true);
		hitPlanet.x = gameMain.screenWidth - meteorite.width - (gameMain.screenWidth / 12) + meteorite.width/7;
		hitPlanet.y = meteorite.y*1.28;
		hitPlanet.alpha = 0;
		addChild(hitPlanet);
		
		
		Actuate.tween (meteorite, 3, { x: gameMain.screenWidth-meteorite.width-(gameMain.screenWidth/12) } );
		
		Actuate.tween (scoreField, 3, { alpha: 1 } );
		Actuate.tween (life1, 3, { alpha: 1 } );
		Actuate.tween (life2, 3, { alpha: 1 } );
		Actuate.tween (life3, 3, { alpha: 1 } );
			
		started = true;
		
		
		gameMain.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
		gameMain.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		gameMain.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		
		thisFiresEverySecond();
	}
	
    public function onDrag(e:MouseEvent):Void { 
		if (!paused) {
			userDragging = true;
			startedDragOnY = e.stageY;
			startingYForMeteorite = meteorite.y;
		}
    }
	
    public function onStopDrag(e:MouseEvent):Void { 
		if (!paused) {
			userDragging = false;
		}
    }
	
    public function onMove(e:MouseEvent):Void { 
		if (userDragging) {
			var newY: Float = startingYForMeteorite + (e.stageY - startedDragOnY);
			if (newY > -meteorite.height/2 && newY < gameMain.screenHeight-meteorite.height/2){
				meteorite.addDistance(Math.abs(meteorite.y-newY));
				meteorite.y = newY;
				hitPlanet.y = newY + (meteorite.height / 3);	
			}
		}
    }
	
	public function thisFiresEverySecond() {
		
		if (!started) {
			return;
		}
		
		if (Std.random(9 - (2*(4-planets.length))) < 1 ) {
			var newPlanet :Planet = new Planet();
			var scaleFactor : Float = ((gameMain.screenHeight / 8) / newPlanet.height);
			var scaleModifier : Int = Std.random(6)+1;
			scaleFactor = scaleFactor * ((scaleModifier/10)+1) ;
		
			newPlanet.scaleX = scaleFactor;
			newPlanet.scaleY = scaleFactor;
			
			newPlanet.x = -newPlanet.width;
			var planetHeight : Int = Std.int(newPlanet.height);
			var newY: Int = Std.random(Lib.current.stage.stageHeight - planetHeight) ;
			newPlanet.y = newY;
			newPlanet.speed = Std.random(2) +7;
			
			addChild(newPlanet);
			planets.push(newPlanet);
		}
		
		if (Std.random(2) < 1 && mines.length < 10) {
			var scoreModifier : Int = 15;
			
			if (gameMain.score > 10000) {
				scoreModifier = 4;
			}
			else {
				scoreModifier = 15-Std.int(gameMain.score / 1000);
			}
			
			var newMine : Mine = new Mine(this, (Std.random(scoreModifier)<1));
			var scaleFactor : Float = ((gameMain.screenHeight / 35) / newMine.height);
		
			newMine.scaleX = scaleFactor;
			newMine.scaleY = scaleFactor;
			
			newMine.rotation = Std.random(40);
			
			newMine.x = -newMine.width;
			var newY: Int = Std.random(Lib.current.stage.stageHeight-Std.int(newMine.height)) ;
			newMine.y = newY;
			newMine.speed = Std.random(2)+ 7;
			
			addChild(newMine);
			mines.push(newMine);
		}
		
		Actuate.timer (0.10).onComplete (thisFiresEverySecond, []);
		
	}
	
	public function handleFrame(event:Event) {
		
		var st:Int = 0;
				
		while (st < planets.length) {
			var planet :Planet = planets[st];
				
			if (planet != null && planet.delete) {
				if(planets.remove(planet)){
					removeChild(planet);
				}
				else {
					break;
				}
			}
			else {
				st += 1;
			}
		}		
		st = 0;
		while (st < mines.length) {
			var mine :Mine = mines[st];
				
			if (mine != null && mine.delete) {
				if(mines.remove(mine)){
					removeChild(mine);
				}
				else {
					break;
				}
			}
			else {
				st += 1;
			}
		}
		meteorite.reviewMines();
		if (!started) {
			return;
		}
		
		var comparison : Sprite = hitPlanet;
		
		for (i in 0...planets.length) {
			if (planets[i].x > Lib.current.stage.stageWidth) {
				planets[i].delete = true;
			}
			planets[i].x += planets[i].speed;
			
			if (comparison.hitTestObject(planets[i].hitcircle) && planets[i].untouched) {
				planets[i].untouched = false;
				var sound  = Utils.loadSound ("assets/sound/dp.wav");
				planets[i].explode();
				sound.play ();
				gameMain.score += Std.int(planets[i].width);
			}
		}
		
		for (i in 0...mines.length) {
			if (mines[i].x > Lib.current.stage.stageWidth) {
				mines[i].delete = true;
			}
			mines[i].x += mines[i].speed;
			
			if (comparison.hitTestObject(mines[i].hitcircle) && mines[i].untouched ) {
				mines[i].untouched = false;
				var sound = Utils.loadSound ("assets/sound/hm.wav");
				meteorite.addMine(mines[i].gold);
				mines[i].stick();
				sound.play ();
			}
		}
	
		//addChild(meteorite);
		
		scoreField.text = "Score: "+ gameMain.score;
		scoreField.width = 2000;
		var textFormat:TextFormat = new TextFormat ("_sans", 30, 0xFFFFFF);
		scoreField.setTextFormat (textFormat);
		
		
		if (endGame) {
			cleanUp();
		}
	}
	
	public function lowerLife(){
		life--;
		if (life > -1) {
			if (life == 2) {
				removeChild(life3);
			}
			if (life == 1) {
				removeChild(life2);
			}
			if (life == 0) {
				removeChild(life1);
				endGame = true;
			}
		}
	}
	
	public function cleanUp() {
		started = false;
		
		for (i in 0...planets.length) {
			planets[i].untouched = false;
			var sound  = Utils.loadSound ("assets/sound/dp.wav");
			planets[i].explode();
			sound.play ();
		}
		
		for (i in 0...mines.length) {
			mines[i].untouched = false;
			var sound  = Utils.loadSound ("assets/sound/dm.wav");
			mines[i].explode();
			sound.play ();
		}
		
		var sound  = Utils.loadSound ("assets/sound/dm.wav");
		sound.play (0,3);
		
		Actuate.tween (scoreField, 3, { alpha: 0 } );
		Actuate.tween (meteorite, 3, { x: gameMain.screenWidth/3, y: gameMain.screenHeight } ).ease(Quad.easeIn).onComplete(gameMain.goToScreen, [gameMain.SCREEN_END]);
		
	}
	public function drawScreen(event:Event){
		
	}
	public function handleInput(event:Event){
		
	}
	public function handleLogic(event:Event){
		
	}
}