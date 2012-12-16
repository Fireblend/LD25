package fireblend.org.ld25;

import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;
import nme.media.Sound;
import nme.media.SoundChannel;
import nme.system.System;
import nme.display.Shape;
/**
 * ...
 * @author Sergio Morales
 */

class Main extends Sprite
{
	//Screens of the game
	public var SCREEN_MENU:Screen;
	public var SCREEN_GAME:Screen;
	public var SCREEN_END:Screen;
	
	//Size variables
	private var setHeight:Float;
	private var setWidth:Float;
	public var screenWidth:Float;
	public var screenHeight:Float;
	
	private var starSize:Int;
	
	private var stars:Array<Star>;
	
	//Current active screen
	private var currentScreen:Screen;
	
	//Current score
	public var score:Int;
	
	public function new() {
		super ();
		
		initializeGame ();
		
		resize (Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		Lib.current.stage.addEventListener (Event.RESIZE, stage_onResize);

		startGame ();
	}
	
	private function resize (newWidth:Float, newHeight:Float):Void 
	{
		// position objects based on size
		this.setHeight = newHeight;
		this.setWidth = newWidth;
	}
	
	private function stage_onResize (event:Event):Void 
	{
		resize (stage.stageWidth, stage.stageHeight);
	}
	
	static public function main() 
	{
		Lib.current.addChild (new Main ());
	}
	
	private function initializeGame ():Void {
		//Align stage
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		//Get stage dimensions
		screenWidth = Lib.current.stage.stageWidth;
		screenHeight = Lib.current.stage.stageHeight;
		
		starSize = Std.int(screenWidth / 300);
		
		//Load graphics
		var background : Shape = new Shape();
		
		background.graphics.beginFill ( 0x1A2B59 );  // the color of the rectangle
		background.graphics.drawRect ( 0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		background.graphics.endFill (); 
		
		addChild(background);
		
		stars = new Array<Star>();
		
		//Create screens
		SCREEN_MENU = new MenuScreen(this);
		SCREEN_GAME = new GameScreen(this);
		SCREEN_END = new EndScreen(this);
		
		//Music start
		var sound : Sound = Utils.loadSound ("assets/music/music.wav");

		var channel :SoundChannel = sound.play (0,-1);
	
		#if flash
		doUglyMusicFlashFix(sound, channel);
		#end
		
		//Activate first screen
		goToScreen(SCREEN_GAME);
	}
	
	public function doUglyMusicFlashFix(sound :Sound, channel:SoundChannel) {
		
		channel.addEventListener(Event.SOUND_COMPLETE,function(e:Event):Void {
			channel.stop();
			channel = sound.play(0);
			doUglyMusicFlashFix(sound, channel);
		});
	}
	
	//Handle screen switching
	public function goToScreen(newScreen:Screen):Void {
		
		if(currentScreen != null){
			var currentSpritedScreen:Sprite = cast(currentScreen, Sprite);
			removeChild(currentSpritedScreen);
		}
		
		var newSpritedScreen:Sprite = cast(newScreen, Sprite);
		addChild(newSpritedScreen);
		currentScreen = newScreen;
		newScreen.initialize();
	}
	
	//Start listening to events
	private function startGame() {
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	//Redirect enterFrame event to current screen.
	private function this_onEnterFrame (event:Event):Void {
		
		if (Std.random(7)<1 && stars.length < 40) {
			var y : Int = Std.random(Lib.current.stage.stageHeight);
			var x : Int = -starSize;
			
			var circle : Star = new Star();
			circle.x = x;
			circle.y = y;
			circle.graphics.beginFill(0xFFFFFF);
			circle.graphics.drawCircle(0, 0, starSize*(1+(Std.random(5)/10)));
			circle.graphics.endFill ();
			circle.alpha = 0.7+(Std.random(3)/10);
			circle.speed = 2 + Std.random(5);
			
			addChild(circle);
			stars.push(circle);
		}
		
		for (i in 0...stars.length) {
			if (stars[i].x > Lib.current.stage.stageWidth) {
				stars[i].delete = true;
			}
			stars[i].x += stars[i].speed;
		}
		
		var st:Int = 0;
				
		while (st < stars.length) {
			var star :Star = stars[st];
				
			if (star.delete) {
				removeChild(star);
				stars.remove(star);
			}
			else {
				st += 1;
			}
		}
		
		currentScreen.handleFrame(event);
	}
}