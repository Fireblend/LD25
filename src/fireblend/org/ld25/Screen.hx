package fireblend.org.ld25;

import nme.display.Sprite;
import nme.events.Event;
/**
 * ...
 * @author Sergio Morales
 */

interface Screen
{
	function initialize():Void;
	
	function handleFrame(event:Event):Void;
	function drawScreen(event:Event):Void;
	function handleInput(event:Event):Void;
	function handleLogic(event:Event):Void;
}