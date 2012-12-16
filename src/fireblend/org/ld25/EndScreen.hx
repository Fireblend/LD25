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


import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Sergio Morales
 */

class EndScreen implements Screen, extends Sprite
{

	private var gameMain:Main;
	private var scoreText:TextField;
	private var buttonAgain:Sprite;
	private var buttonMain:Sprite;
	
	public function new(newGameMain:Main) 
	{
		super();
		gameMain = newGameMain;
	}
	
	public function initialize() {
		
		scoreText = new TextField ();
		scoreText.text = "Score: "+gameMain.score;
		scoreText.width = 800;
		var textFormat:TextFormat = new TextFormat ("_sans", 55, 0xFFFFFF);
		scoreText.setTextFormat (textFormat);
		scoreText.x = gameMain.screenWidth/3;
		scoreText.y = -55;
		scoreText.alpha = 1;
		scoreText.selectable = false;
		addChild(scoreText);
		
		buttonAgain = Utils.loadGraphic("assets/gfx/againBtn.png", true, true);
		buttonMain = Utils.loadGraphic("assets/gfx/titleBtn.png", true, true);
		addChild(buttonAgain);
		addChild(buttonMain);
		
		var scaler:Float = (gameMain.screenWidth/5) / buttonAgain.width;
		buttonAgain.scaleX = scaler;
		buttonAgain.scaleY = scaler;
		buttonMain.scaleX = scaler;
		buttonMain.scaleY = scaler;
		
		buttonMain.y = gameMain.screenHeight/3 + 110;
		buttonAgain.y = gameMain.screenHeight/3 + 110;
		buttonMain.alpha = 0;
		buttonAgain.alpha = 0;
		buttonAgain.x = gameMain.screenWidth/2 - 5 - buttonAgain.width;
		buttonMain.x = gameMain.screenWidth/2 + 15 ;
		
		Actuate.tween (scoreText, 2, { y: gameMain.screenHeight/3 } );
		Actuate.tween (buttonAgain, 1.5, { alpha: 1 } );
		Actuate.tween (buttonMain, 1.5, { alpha: 1 } );
		
		buttonAgain.addEventListener(MouseEvent.MOUSE_DOWN, buttonAgain_onClick);
		buttonMain.addEventListener(MouseEvent.MOUSE_DOWN, buttonMain_onClick);
		
	}
	
	private function buttonMain_onClick (event:MouseEvent):Void {
		Actuate.tween (scoreText, 2, { y: -100 } ).onComplete(
		gameMain.goToScreen, [gameMain.SCREEN_MENU]);
		Actuate.tween (buttonAgain, 1.5, { alpha: 0 } );
		Actuate.tween (buttonMain, 1.5, { alpha: 0 } );
		
	}
	private function buttonAgain_onClick (event:MouseEvent):Void {
		
		Actuate.tween (scoreText, 2, { y: -100 } ).onComplete(
		gameMain.goToScreen, [gameMain.SCREEN_GAME]);
		Actuate.tween (buttonAgain, 1.5, { alpha: 0 } );
		Actuate.tween (buttonMain, 1.5, { alpha: 0 } );
	}
	
	public function handleFrame(event:Event){
		
	}
	public function drawScreen(event:Event){
		
	}
	public function handleInput(event:Event){
		
	}
	public function handleLogic(event:Event){
		
	}
}