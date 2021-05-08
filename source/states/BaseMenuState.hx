package states;

import flixel.FlxG;
import flixel.input.actions.FlxActionManager;
import flixel.input.actions.FlxAction.FlxActionDigital;
import ui.CustomFlxUIState;

class BaseMenuState extends CustomFlxUIState{
	/**
	 * Our action manager.
	 */
	public var actionManager:FlxActionManager;

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

	override public function create():Void {
		super.create();

		// declare actions and define callback functions
		cursorLeft = new FlxActionDigital("cursor_left", function(_) customCursor.moveLeft(1));
		cursorUp = new FlxActionDigital("cursor_up", function(_) customCursor.moveUp(1));
		cursorRight = new FlxActionDigital("cursor_right", function(_) customCursor.moveRight(1));
		cursorDown = new FlxActionDigital("cursor_down", function(_) customCursor.moveDown(1));
		cursorClick = new FlxActionDigital("cursor_click", function(_) customCursor.click());
		cursorClickRelease = new FlxActionDigital("cursor_click_release", function(_) customCursor.clickRelease());
		// add sets of keys that will trigger our actions
		setupWASDLayout();
		setupArrowsLayout();
		setupGamepadLayout();

		// create action manager if null
		if (actionManager == null)
			actionManager = FlxG.inputs.add(new FlxActionManager());

		// add all of our actions to the manager
		actionManager.addActions([cursorLeft, cursorUp, cursorRight, cursorDown, cursorClick, cursorClickRelease]);

		customCursor.setDefaultKeys(0);

		#if debug
		trace('${Type.getClassName(Type.getClass(this))} created.');
		#end
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