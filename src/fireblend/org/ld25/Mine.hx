package fireblend.org.ld25;
import nme.display.Sprite;
import nme.display.Shape;

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
		
	}
}