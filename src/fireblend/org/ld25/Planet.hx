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
	public var planetId: Int;
	public var delete: Bool;
	public var hitcircle: Shape;
	public var untouched:Bool;
	
	public function new() 
	{
		super();
		untouched = true;
		planetId = Std.random(3) + 1;
		var path :String = "assets/gfx/planet"+planetId+".png";
		planetSprite = Utils.loadGraphic (path, true, true);
		
		hitcircle = new Shape();
		hitcircle.graphics.beginFill(0xFFFF00);
		hitcircle.alpha = 0;
		#if android
		hitcircle.graphics.drawCircle(planetSprite.width / 2, planetSprite.height / 2, planetSprite.width / 2 + 10);
		#else
		hitcircle.graphics.drawCircle(planetSprite.width / 2, planetSprite.height / 2, planetSprite.width / 2 - 10);
		#end
		hitcircle.graphics.endFill (); 
		
		
		addChild(hitcircle);
		addChild(planetSprite);
	}
	
	public function explode()
	{
		Actuate.tween (planetSprite, 0.2, { alpha : 0 } );
		var debris:Sprite = Utils.loadGraphic("assets/gfx/debris" + planetId + ".png", true, true);
		
		addChild(debris);
		Actuate.tween (debris, 1, { scaleX : 1.5, scaleY: 1.5, x:debris.x-(debris.width/3), y:debris.y-(debris.height/3), alpha: 1} ).onComplete(setDelete,[]);
		
	}
	
	public function setDelete() {
		delete = true;
	}
}
