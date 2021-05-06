package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.FlxAssets.FlxShader;
import openfl.display.Sprite;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import states.MainMenuState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(320, 240, MainMenuState, 1, 60, 60, true));
		FlxG.game.setFilters([new ShaderFilter(new FlxShader())]);
		FlxG.game.stage.quality = StageQuality.LOW;
		FlxG.resizeWindow(400, 240);

		/* we use the system cursor instead of the default one
			as it reduces cursor lag on some systems.
			maybe make it toggleable in the future? */
		FlxG.mouse.useSystemCursor = true;

		#if desktop
		FlxG.fullscreen = true; // setting fullscreen to true in html5 throws exception
		#end
	}
}
