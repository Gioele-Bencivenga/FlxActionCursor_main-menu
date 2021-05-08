package states;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.interfaces.IFlxUIWidget;

/**
 * A FlxState which can be used for the game's menu.
 */
class OptionMenuState extends BaseMenuState
{

	override public function create():Void
	{
		_xml_id = "options"; // needs to be set before calling create()
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
						case option5 = "butt_4":
						case back = "butt_5":
							var newState = new MainMenuState();
							newState.actionManager = this.actionManager;
							FlxG.switchState(newState);
					}
				}
		}
	}
}
