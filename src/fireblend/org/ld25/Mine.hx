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
	
	public function new() 
	{
		super();
		untouched = true;
		var path :String = "assets/gfx/mine.png";
		mineSprite = Utils.loadGraphic (path, true, true);
		
		hitcircle = new Shape();
		hitcircle.graphics.beginFill(0xFFFF00);
		hitcircle.alpha = 0;
		hitcircle.graphics.drawCircle(mineSprite.width/2, mineSprite.height/2, mineSprite.width/3);
		hitcircle.graphics.endFill (); 
		
		
		addChild(hitcircle);
		addChild(mineSprite);
	}
	
	public function explode()
	{
		var sound  = Utils.loadSound ("assets/sound/dm.wav");
		sound.play();
		var explosionSprite : Sprite = Utils.loadGraphic("assets/gfx/explosion.png", true, true);
		explosionSprite.x = -explosionSprite.width / 2;
		explosionSprite.y = -explosionSprite.height / 2;
		addChild(explosionSprite);
		Actuate.tween (explosionSprite, 0.75, { scaleX : 2, scaleY : 2, width : explosionSprite.width*2, height : explosionSprite.height*2 } ).onComplete(setDelete,[]);
	}
	
	public function setDelete() {
		delete = true;
	}
}