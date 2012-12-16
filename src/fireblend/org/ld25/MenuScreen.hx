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

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Sergio Morales
 */

class MenuScreen implements Screen, extends Sprite
{

	private var gameMain:Main;
	private var scoreText:TextField;
	private var buttonPlay:Sprite;
	private var buttonHow:Sprite;
	private var title:Sprite;
	private var meteorite:Sprite;
	private var credits:Sprite;
	private var howTo:Sprite;
	
	public function new(newGameMain:Main) 
	{
		super();
		gameMain = newGameMain;
	}
	
	public function initialize() {
		
		if(buttonPlay == null){
			buttonPlay = Utils.loadGraphic("assets/gfx/playBtn.png", true, true);
			buttonHow = Utils.loadGraphic("assets/gfx/howBtn.png", true, true);
			meteorite = Utils.loadGraphic("assets/gfx/astrid.png", true, true);
			title = Utils.loadGraphic("assets/gfx/title.png", true, true);
			credits = Utils.loadGraphic("assets/gfx/credits.png", true, true);
			howTo = Utils.loadGraphic("assets/gfx/howto.png", true, true);
			var scaleForMeteorite = gameMain.screenWidth/1.5/meteorite.height;
			meteorite.scaleX = scaleForMeteorite;
			meteorite.scaleY = scaleForMeteorite;
		}
		howTo.alpha = 0;
		howTo.visible = false;
		title.alpha = 0;
		meteorite.y = 20;
		meteorite.x = (gameMain.screenWidth / 3 )* 1.5;
		
		title.x = 20;
		title.y = 20;
		
		buttonPlay.x = gameMain.screenWidth/10*1;
		buttonPlay.y = gameMain.screenHeight / 6*3;
		buttonHow.x = gameMain.screenWidth/10*2;
		buttonHow.y = gameMain.screenHeight / 6*4;
		
		credits.x = gameMain.screenWidth - credits.width - 5;
		credits.y = gameMain.screenHeight - credits.height - 5;
		
		addChild(title);
		addChild(meteorite);
		addChild(buttonHow);
		addChild(buttonPlay);
		addChild(credits);
		addChild(howTo);
		howTo.x = gameMain.screenWidth / 2 - howTo.width / 2;
		howTo.y = gameMain.screenHeight / 2 - howTo.height / 2;
		
		Actuate.tween (title, 1, { alpha: 1 } ).ease(Quad.easeInOut);
		Actuate.tween (buttonHow, 1, { alpha: 1 } ).ease(Quad.easeInOut);
		Actuate.tween (buttonPlay, 1, { alpha: 1 } ).ease(Quad.easeInOut);
		Actuate.tween (meteorite, 1, { alpha: 1 } ).ease(Quad.easeInOut);
		Actuate.tween (credits, 1, { alpha: 1 } ).ease(Quad.easeInOut);
		
		title1();
		buttonHow.addEventListener(MouseEvent.MOUSE_DOWN, buttonHow_onDown);
		buttonPlay.addEventListener(MouseEvent.MOUSE_DOWN, buttonPlay_onDown);
		howTo.addEventListener(MouseEvent.MOUSE_DOWN, buttonHowTo_onDown);
	}
	
	public function title1() {
		Actuate.tween (title, 1, { alpha: 0.4 } ).ease(Quad.easeInOut).onComplete(title2);
		Actuate.tween (meteorite, 1, { y: meteorite.y+25 } ).ease(Quad.easeInOut);
	}
	public function title2() {
		Actuate.tween (title, 1, { alpha: 1 } ).ease(Quad.easeInOut).onComplete(title1);
		Actuate.tween (meteorite, 1, { y: meteorite.y-25 } ).ease(Quad.easeInOut);
	}
	
	public function buttonPlay_onDown (event:MouseEvent):Void {
		Actuate.stop(title, alpha);
		if(howTo.alpha == 0){
			Actuate.tween (title, 1, { alpha: 0 } ).ease(Quad.easeInOut);
			Actuate.tween (buttonHow, 1, { alpha: 0 } ).ease(Quad.easeInOut);
			Actuate.tween (buttonPlay, 1, { alpha: 0 } ).ease(Quad.easeInOut);
			Actuate.tween (credits, 1, { alpha: 0 } ).ease(Quad.easeInOut);
			Actuate.tween (meteorite, 1.2, { alpha: 0 } ).ease(Quad.easeInOut).onComplete(gameMain.goToScreen, [gameMain.SCREEN_GAME]);
		}
		else {
			hideHowTo();
		}
	}
	
	public function buttonHow_onDown (event:MouseEvent):Void {
		if(howTo.alpha == 0){
			Actuate.tween (howTo, 0.5, { alpha: 1 } ).ease(Quad.easeInOut);
		}
		else {
			hideHowTo();
		}
	}
	
	public function buttonHowTo_onDown (event:MouseEvent):Void {
		hideHowTo();
	}
	
	public function hideHowTo() {
		Actuate.tween (howTo, 0.5, { alpha: 0 } ).ease(Quad.easeInOut);
	}
	
	public function handleOut() {
		removeChild(title);
		removeChild(buttonHow);
		removeChild(buttonPlay);
		removeChild(meteorite);
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