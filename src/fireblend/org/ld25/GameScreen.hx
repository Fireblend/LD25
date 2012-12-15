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

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Sergio Morales
 */

class GameScreen implements Screen, extends Sprite
{

	private var gameMain:Main;
	private var score:Int;
	private var planets:Array<Planet>;
	private var mines:Array<Mine>;
	private var meteorite:Meteorite;
	private var started:Bool;
	private var paused:Bool;
	private var scoreField:TextField;
	private var userDragging:Bool;
	private var startedDragOnY: Float;
	private var startingYForMeteorite: Float;
	
	public function new(newGameMain:Main) 
	{
		super();
		gameMain = newGameMain;
		
		
		
	}
	
	public function initialize() {
		
		score = 0;
		started = false;
		meteorite = new Meteorite();
		addChild(meteorite);
		paused = false;
		userDragging = false;
		planets = new Array<Planet>();
		mines = new Array<Mine>();
		
		scoreField = new TextField ();
		scoreField.text = "Score: 0";
		scoreField.width = 200;
		var textFormat:TextFormat = new TextFormat ("_sans", 30, 0xFFFFFF);
		scoreField.setTextFormat (textFormat);
		scoreField.x = 6;
		scoreField.y = 6;
		scoreField.alpha = 0;
		addChild(scoreField);
		
		var scaleFactor : Float = (gameMain.screenHeight / 3) / meteorite.height ;
		meteorite.scaleX = scaleFactor;
		meteorite.scaleY = scaleFactor;
		meteorite.scaleFactor = scaleFactor;
		meteorite.x = gameMain.screenWidth+meteorite.width-10;
		meteorite.y = gameMain.screenHeight / 2 - meteorite.height / 2;
		
		Actuate.tween (meteorite, 3, { x: gameMain.screenWidth-meteorite.width-(gameMain.screenWidth/12) } );
		Actuate.tween (scoreField, 3, { alpha: 1 } );
			
		started = true;
		
		
		gameMain.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
		gameMain.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		gameMain.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		
		trace("H1");
		thisFiresEverySecond();
		trace("H2");
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
			if (newY > 0 && newY < gameMain.screenHeight)
				meteorite.y = newY;
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
			newPlanet.speed = Std.random(2) + 7;
			
			addChild(newPlanet);
			planets.push(newPlanet);
		}
		
		if (Std.random(2) < 1 && mines.length < 9) {
			var newMine : Mine = new Mine();
			var scaleFactor : Float = ((gameMain.screenHeight / 28) / newMine.height);
		
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
		
		Actuate.timer (0.3).onComplete (thisFiresEverySecond, []);
	}
	
	public function handleFrame(event:Event) {
		
		if (!started) {
			return;
		}
		
		for (i in 0...planets.length) {
			if (planets[i].x > Lib.current.stage.stageWidth) {
				planets[i].delete = true;
			}
			planets[i].x += planets[i].speed;
		}
		for (i in 0...mines.length) {
			if (mines[i].x > Lib.current.stage.stageWidth) {
				mines[i].delete = true;
			}
			mines[i].x += mines[i].speed;
		}
		
		
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
		
		addChild(meteorite);
		
	}
	public function drawScreen(event:Event){
		
	}
	public function handleInput(event:Event){
		
	}
	public function handleLogic(event:Event){
		
	}
}