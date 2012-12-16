package fireblend.org.ld25;
import nme.display.Sprite;
import nme.display.Shape;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Sergio Morales
 */

class Mine extends Sprite
{
	public var mineSprite:Sprite;
	public var speed: Int;
	public var delete: Bool;
	public var hitcircle: Shape;
	public var untouched:Bool;
	public var beeps:Int;
	public var gameScreen:GameScreen;
	public var distance:Float;
	public var removed:Bool;
	public var exploded:Bool;
	public var gold:Bool;
	
	public function new(newgameScreen:GameScreen, newGold:Bool) 
	{
		gold = newGold;
		super();
		distance = 0;
		removed = false;
		exploded = false;
		gameScreen = newgameScreen;
		untouched = true;
		var path :String = "assets/gfx/mine.png";
		if(gold)
			 path  = "assets/gfx/mine_gold.png";
		
		mineSprite = Utils.loadGraphic (path, true, true);
		beeps = 3;
		
		hitcircle = new Shape();
		hitcircle.graphics.beginFill(0xFFFF00);
		hitcircle.alpha = 0;
		hitcircle.graphics.drawCircle(mineSprite.width/2, mineSprite.height/2, mineSprite.width/3);
		hitcircle.graphics.endFill (); 
		
		addChild(hitcircle);
		addChild(mineSprite);
	}
	
	public function stick() {
		Actuate.tween (mineSprite, 0.5, { alpha:0 } ).onComplete(setDelete);
	}
	
	public function explodeDamage() {
		exploded = true;
		gameScreen.lowerLife();
		explode();
	}
	
	public function explode()
	{
		var sound  = Utils.loadSound ("assets/sound/dm.wav");
		sound.play();
		var explosionSprite : Sprite = Utils.loadGraphic("assets/gfx/explosion.png", true, true);
		explosionSprite.x = -explosionSprite.width / 2;
		explosionSprite.y = -explosionSprite.height / 2;
		addChild(explosionSprite);
		Actuate.tween (explosionSprite, 0.75, { scaleX : 2, scaleY : 2, width : explosionSprite.width*2, height : explosionSprite.height*2, alpha:0.1 } ).onComplete(setDelete,[]);
		
		Actuate.tween (mineSprite, 0.5, { alpha:0 } );
	}
	
	public function setDelete() {
		delete = true;
	}
	
	public function startBeeping() {
		if (removed || exploded)
			return;
		if (beeps == 0) {
			explode();
			gameScreen.lowerLife();
		}
		else {
			beeps--;
			var sound  = Utils.loadSound ("assets/sound/ms.wav");
			sound.play();
			Actuate.timer (1).onComplete (startBeeping, []);
		}
	}
	
	public function remove() {
		removed = true;
		var sound  = Utils.loadSound ("assets/sound/tm.wav");
		sound.play();
		Actuate.tween (mineSprite, 2, { alpha:0, x: x + 200, y:Std.random(100) } ).onComplete(setDelete,[]);
	}
}