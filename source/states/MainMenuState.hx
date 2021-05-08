package states;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.interfaces.IFlxUIWidget;

/**
 * A FlxState which can be used for the game's menu.
 */
class MainMenuState extends BaseMenuState
{
	override public function create():Void
	{
		_xml_id = "main-menu"; // needs to be set before calling create()
		super.create();
	}

	override public function getEvent(eventName:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		if (destroyed)
		{
			return;
		}

		switch (eventName) // check which event was called
		{
			case FlxUITypedButton.OVER_EVENT:
			// do nothing for now
			case FlxUITypedButton.CLICK_EVENT:
				var widget:IFlxUIWidget = cast(sender, IFlxUIWidget); // get the widget that called the event
				if (widget != null && (widget is FlxUIButton)) // we are over a button indeed
				{
					var btn:FlxUIButton = cast(widget, FlxUIButton); //  get the btn
					switch (btn.name)
					{
						case option1 = "butt_0":
						case option2 = "butt_1":
						case option3 = "butt_2":
						case option4 = "butt_3":
							var newState = new OptionMenuState();
							newState.actionManager = this.actionManager;
							FlxG.switchState(newState);
						case quit = "butt_4":
							quitGame();
					}
				}
		}
	}

	/**
	 * Quits the game by closing the window if running the `c++` or `openfl` versions.
	 * 
	 * Redirects to a `url` if we are on `html5`. (maybe this should be changed to something other than redirecting?)
	 * 
	 * Thanks to @dean from the Haxe discord for this function!
	 */
	private function quitGame()
	{
		#if html5
		FlxG.openURL("https://duckduckgo.com", "_self");
		#else
		#if cpp
		Sys.exit(0);
		#else
		openfl.system.System.exit(0);
		#end
		#end
	}
}
