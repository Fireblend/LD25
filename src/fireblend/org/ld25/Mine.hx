package fireblend.org.ld25;
import nme.display.Sprite;

/**
 * ...
 * @author Sergio Morales
 */

class Mine extends Sprite
{
	public var mineSprite:Sprite;
	public var speed: Int;
	public var delete: Bool;
	
	public function new() 
	{
		super();
		var path :String = "assets/gfx/mine.png";
		mineSprite = Utils.loadGraphic (path, true, true);
		addChild(mineSprite);
	}
	
	public function explode()
	{
		
	}
}