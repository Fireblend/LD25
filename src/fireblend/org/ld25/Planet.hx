package fireblend.org.ld25;
import nme.display.Sprite;

/**
 * ...
 * @author Sergio Morales
 */

class Planet extends Sprite
{
	public var planetSprite :Sprite;
	public var speed: Int;
	public var delete: Bool;
	
	public function new() 
	{
		super();
		var path :String = "assets/gfx/planet"+(Std.random(3)+1)+".png";
		planetSprite = Utils.loadGraphic (path, true, true);
		
		addChild(planetSprite);
	}
	
	public function explode()
	{
		
	}
}
