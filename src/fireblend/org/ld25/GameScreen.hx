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
	//private var planets:Array<Planet>;
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
		
		Actuate.tween (meteorite, 3, { x: gameMain.screenWidth-meteorite.width-(gameMain.screenWidth/5) } ).onComplete(meteorite.explode, []);
		Actuate.tween (scoreField, 3, { alpha: 1 } );
			
		started = true;
		
		
		gameMain.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
		gameMain.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		gameMain.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
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
	
	
	
	public function handleFrame(event:Event){
		if (!started) {
			return;
		}
		
		
	}
	public function drawScreen(event:Event){
		
	}
	public function handleInput(event:Event){
		
	}
	public function handleLogic(event:Event){
		
	}
}