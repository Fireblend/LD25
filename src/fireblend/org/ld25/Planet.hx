package fireblend.org.ld25;
import nme.display.Shape;
import nme.display.Sprite;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Sergio Morales
 */

class Planet extends Sprite
{
	public var planetSprite :Sprite;
	public var speed: Int;
	public var delete: Bool;
	public var hitcircle: Shape;
	public var untouched:Bool;
	
	public function new() 
	{
		super();
		untouched = true;
		var path :String = "assets/gfx/planet"+(Std.random(3)+1)+".png";
		planetSprite = Utils.loadGraphic (path, true, true);
		
		hitcircle = new Shape();
		hitcircle.graphics.beginFill(0x1A2B59);
		hitcircle.alpha = 0;
		hitcircle.graphics.drawCircle(planetSprite.width/2, planetSprite.height/2, planetSprite.width/2-10);
		hitcircle.graphics.endFill (); 
		
		
		addChild(hitcircle);
		addChild(planetSprite);
	}
	
	public function explode()
	{
		Actuate.tween (planetSprite, 0.2, { alpha : 0.3 } ).reverse().repeat(3).onComplete(setDelete,[]);
		
	}
	
	public function setDelete() {
		delete = true;
	}
}
