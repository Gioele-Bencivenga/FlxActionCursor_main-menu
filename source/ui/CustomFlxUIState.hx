package ui;

import flixel.FlxSubState;
import flixel.addons.ui.FlxUIState;

/**
 * This class is a `FlxUIState` that uses a `CustomCursor` instead of `cursor:FlxUICursor`
 */
class CustomFlxUIState extends FlxUIState
{
	/**
	 * Whether we want to create a custom cursor and load widgets into it from the ui.
	 */
	private var makeCustomCursor:Bool;

	/**
	 * Our `CustomFlxUICursor`.
	 */
	public var customCursor:CustomFlxUICursor;

	override function create()
	{
		_makeCursor = false; // we don't want the default cursor
		makeCustomCursor = true; // we want our custom one
		#if FLX_MOUSE
		if (makeCustomCursor == true)
		{
			customCursor = createCursor();
		}
		#end

		super.create();

		#if FLX_MOUSE
		// need to do this after super.create() as _ui is initialized there
		if (customCursor != null && _ui != null)
		{ // Cursor goes on top, of course
			add(customCursor);
			customCursor.addWidgetsFromUI(_ui);
			customCursor.findVisibleLocation(0);
		}
		#end
	}

	/**
	 * We return a `CustomFlxUICursor` instead of a `FlxUICursor`.
	 * @return the new `CustomFlxUICursor`
	 */
	override function createCursor():CustomFlxUICursor
	{
		return new CustomFlxUICursor(onCursorEvent);
	}

	/**
	 * Untested, may not work.
	 * @param SubState 
	 */
	public override function openSubState(SubState:FlxSubState):Void
	{
		#if FLX_MOUSE
		if (customCursor != null && hideCursorOnSubstate && customCursor.visible == true)
		{
			_cursorHidden = true;
			customCursor.visible = false;
		}
		#end
		super.openSubState(SubState);
	}

	/**
	 * Untested, may not work.
	 * @param SubState 
	 */
	public override function closeSubState():Void
	{
		#if FLX_MOUSE
		if (customCursor != null && hideCursorOnSubstate && _cursorHidden)
		{
			_cursorHidden = false;
			customCursor.visible = true;
		}
		#end
		super.closeSubState();
	}
}
