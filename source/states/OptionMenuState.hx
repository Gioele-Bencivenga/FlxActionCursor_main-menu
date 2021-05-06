package states;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionManager;
import ui.CustomFlxUIState;

/**
 * A FlxState which can be used for the game's menu.
 */
class OptionMenuState extends CustomFlxUIState
{
	/**
	 * This is set when the game first finishes loading.
	 */
	public static inline final GAME_LOADED = "finish_load";

	/**
	 * Our action manager.
	 */
	var actionManager:FlxActionManager;

	/**
	 * Our action triggered when the cursor should move left.
	 * 
	 * We can optionally pass in a callback in the constructor for when the action is triggered.
	 */
	var cursorLeft:FlxActionDigital;

	/**
	 * Our action triggered when the cursor should move up.
	 */
	var cursorUp:FlxActionDigital;

	/**
	 * Our action triggered when the cursor should move right.
	 */
	var cursorRight:FlxActionDigital;

	/**
	 * Our action triggered when the cursor should move down.
	 */
	var cursorDown:FlxActionDigital;

	/**
	 * Our action triggered when the cursor should click.
	 */
	var cursorClick:FlxActionDigital;

	/**
	 * Our action triggered when the cursor click should be released.
	 */
	var cursorClickRelease:FlxActionDigital;

	override public function create():Void
	{
		_xml_id = "options"; // needs to be set before calling create()
		super.create();

		#if debug
		trace('${Type.getClassName(Type.getClass(this))} created.');
		trace('loaded widgets:\n${customCursor.getWidgets()}');
		#end

		// init();
	}

	public function init()
	{
		/* seems like it's not needed for now but not sure
			// declare actions and define callback functions
			cursorLeft = new FlxActionDigital("cursor_left", function(_)
			{
				customCursor.moveLeft(1);
			});
			cursorUp = new FlxActionDigital("cursor_up", function(_) customCursor.moveUp(1));
			cursorRight = new FlxActionDigital("cursor_right", function(_) customCursor.moveRight(1));
			cursorDown = new FlxActionDigital("cursor_down", function(_) customCursor.moveDown(1));
			cursorClick = new FlxActionDigital("cursor_click", function(_) customCursor.click());
			cursorClickRelease = new FlxActionDigital("cursor_click_release", function(_) customCursor.clickRelease());
			// add sets of keys that will trigger our actions
			setupWASDLayout();
			setupArrowsLayout();
			setupGamepadLayout();
			// create action manager
			actionManager = new FlxActionManager();
			// add all of our actions to the manager
			actionManager.addActions([cursorLeft, cursorUp, cursorRight, cursorDown, cursorClick, cursorClickRelease]);
			// add the manager to the inputs, starting to listen for any keys triggering an action
			// var a = FlxG.inputs.replace(_prevActionManager, actionManager);
			// trace('replaced? ${a}');
		 */
		customCursor.setDefaultKeys(0);

		#if debug
		trace('${Type.getClassName(Type.getClass(this))} initialized.');
		trace('loaded widgets:\n${customCursor.getWidgets()}');
		#end
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
							FlxG.switchState(new MainMenuState());
					}
				}
		}
	}

	/**
	 * Add the default WASD layout keys to our actions.
	 */
	function setupWASDLayout()
	{
		cursorLeft.addKey(A, JUST_PRESSED);
		cursorUp.addKey(W, JUST_PRESSED);
		cursorRight.addKey(D, JUST_PRESSED);
		cursorDown.addKey(S, JUST_PRESSED);
		cursorClick.addKey(ENTER, JUST_PRESSED);
		cursorClickRelease.addKey(ENTER, JUST_RELEASED);
	}

	/**
	 * Add the default arrows input keys to our actions.
	 */
	function setupArrowsLayout()
	{
		cursorLeft.addKey(LEFT, JUST_PRESSED);
		cursorUp.addKey(UP, JUST_PRESSED);
		cursorRight.addKey(RIGHT, JUST_PRESSED);
		cursorDown.addKey(DOWN, JUST_PRESSED);
		cursorClick.addKey(Z, JUST_PRESSED);
		cursorClickRelease.addKey(Z, JUST_RELEASED);
	}

	/**
	 * Add the default gamepad input keys to our actions.
	 */
	function setupGamepadLayout()
	{
		cursorLeft.addGamepad(DPAD_LEFT, JUST_PRESSED);
		cursorUp.addGamepad(DPAD_UP, JUST_PRESSED);
		cursorRight.addGamepad(DPAD_RIGHT, JUST_PRESSED);
		cursorDown.addGamepad(DPAD_DOWN, JUST_PRESSED);
		cursorClick.addGamepad(A, JUST_PRESSED);
		cursorClickRelease.addGamepad(A, JUST_RELEASED);
	}
}
