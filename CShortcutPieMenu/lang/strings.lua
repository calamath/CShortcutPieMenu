--
-- Calamath's Shortcut Pie Menu [CSPM]
--
-- Copyright (c) 2021 Calamath
--
-- This software is released under the Artistic License 2.0
-- https://opensource.org/licenses/Artistic-2.0
--
-- Note :
-- This addon works that uses the library LibAddonMenu-2.0 by sirinsidiator, Seerah, released under the Artistic License 2.0
-- You will need to obtain the above libraries separately.
--

-- English Translations

local strings = {
	-- Key Bindings --
	SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION =	"|c7CFC00PieMenu Interaction|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_SECONDARY =	"|cC5C292PieMenu Secondary Action|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_TERTIARY =	"|cC5C293PieMenu Tertiary Action|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_QUATERNARY =	"|cC5C294PieMenu Quaternary Action|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_QUINARY =		"|cC5C295PieMenu Quinary Action|r", 

	-- Common Strings --
	SI_CSPM_COMMON_PRESET =							"Preset", 
	SI_CSPM_COMMON_SLOT =							"Slot", 
	SI_CSPM_COMMON_UNSELECTED =						"<Unselected>", 
	SI_CSPM_COMMON_UNREGISTERED =					"<Unregistered>", 
	SI_CSPM_COMMON_IMMEDIATE_VALUE =				"(Immediate Value)", 
	SI_CSPM_COMMON_SLASH_COMMAND =					"(Slash Command)", 
	SI_CSPM_COMMON_COLLECTIBLE =					"Collectible", 
	SI_CSPM_COMMON_APPEARANCE =						"Appearance", 
	SI_CSPM_COMMON_EMOTE =							"Emote", 
	SI_CSPM_COMMON_CHAT_COMMAND =					"Chat Command", 
	SI_CSPM_COMMON_TRAVEL_TO_HOUSE =				"Travel to house", 
	SI_CSPM_COMMON_MY_HOUSE_INSIDE =				"My House (inside)", 
	SI_CSPM_COMMON_MY_HOUSE_OUTSIDE =				"My House (outside)", 
	SI_CSPM_COMMON_PIE_MENU =						"Pie Menu", 
	SI_CSPM_COMMON_USER_PIE_MENU =					"User Pie Menu", 
	SI_CSPM_COMMON_EXTERNAL_PIE_MENU =				"External Pie Menu", 
	SI_CSPM_COMMON_SHORTCUT =						"Shortcut", 
	SI_CSPM_COMMON_ADDON =							"Add-on", 
	SI_CSPM_COMMON_MAIN_MENU =						"Player Menu", 
	SI_CSPM_COMMON_SYSTEM_MENU =					"System Menu", 
	SI_CSPM_COMMON_UI_ACTION0 =						"<<1>>", 
	SI_CSPM_COMMON_UI_ACTION1 =						"Open <<1>>", 
	SI_CSPM_COMMON_UI_ACTION2 =						"Close <<1>>", 
	SI_CSPM_COMMON_UI_ACTION3 =						"Copy <<1>>", 
	SI_CSPM_COMMON_UI_ACTION4 =						"Paste <<1>>", 
	SI_CSPM_COMMON_UI_ACTION5 =						"Clear <<1>>", 
	SI_CSPM_COMMON_UI_ACTION6 =						"Reset <<1>>", 
	SI_CSPM_COMMON_UI_ACTION7 =						"Preview <<1>>", 
	SI_CSPM_COMMON_UI_ACTION8 =						"Select <<1>>", 
	SI_CSPM_COMMON_UI_ACTION9 =						"Cancel <<1>>", 
	SI_CSPM_COMMON_UI_ACTION10 =					"Execute <<1>>", 

	-- Formatter
	SI_CSPM_COMMON_FORMATTER =						"<<1>>", 
	SI_CSPM_PARENTHESES_FORMATTER =					"(<<1>>)", 
	SI_CSPM_SLOT_NAME_FORMATTER =					"Slot <<1>>: <<2>>", 
	SI_CSPM_PRESET_NO_NAME_FORMATTER =				"Preset <<1>>", 
	SI_CSPM_PRESET_NAME_FORMATTER =					"Preset <<1>>: <<2>>", 

	-- Slot action tooltip
	SI_CSPM_SLOT_ACTION_TOOLTIP1 =					"Use collectible: <<1>>", 
	SI_CSPM_SLOT_ACTION_TOOLTIP2 =					"Play emote: <<1>>", 
	SI_CSPM_SLOT_ACTION_TOOLTIP3 =					"Execute chat command: <<1>>", 
	SI_CSPM_SLOT_ACTION_TOOLTIP4 =					"Travel to: <<1>>", 
	SI_CSPM_SLOT_ACTION_TOOLTIP5 =					"Open pie menu: <<1>>", 
	SI_CSPM_SLOT_ACTION_TOOLTIP6 =					"Execute shortcut: <<1>>", 

	-- Built-in Pie Menu
	SI_CSPM_PIE_MAIN_MENU_TIPS1 =					"The Player Menu, also called the Main Menu, is located above the Character Window. Most of the complex operations related to game system mechanics are performed here.", 
	SI_CSPM_PIE_MAIN_MENU_TIPS2 =					"This pie menu is a collection of shortcuts to quickly launch submenu items in the Player Menu. It can be used as an alternative to the Player Menu. It will be especially useful when you are in gamepad mode.", 
	SI_CSPM_PIE_SYSTEM_MENU_TIPS1 =					"The System Menu, also called the Game Menu, is used for various game settings, key bindings, and to quit the game.", 

	-- Built-in Shortcut
	SI_CSPM_SHORTCUT_RELOADUI_TIPS =				"A shortcut for reloading the game's user interface system. It can be used to take effect some kind of game system or add-on setting changes, or if the game becomes unstable.", 
	SI_CSPM_SHORTCUT_LOGOUT_TIPS =					"After waiting for a while, log out of your character and go to the character selection screen.", 
	SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS =			"A shortcut for opening '<<C:1>>' submenu in the Player Menu.", 

	-- CShortcut PieMenu Editor UI --
	SI_CSPM_UI_PANEL_HEADER1_TEXT =					"This add-on provides a pie menu for shortcuts to various UI operations.", 
	SI_CSPM_UI_PANEL_HEADER2_TEXT =					"In this panel, you can configure your favorite shortcuts for each slot in the pie menu and register them as presets that can be used throughout your account.\n", 
	SI_CSPM_UI_PRESET_SELECT_MENU_NAME =			"Select preset", 
	SI_CSPM_UI_PRESET_SELECT_MENU_TIPS =			"Please select the preset you want to configure.", 
	SI_CSPM_UI_PRESET_VISUAL_SUBMENU_TIPS =			"Adjust the visual design of the pie menu. (optional)", 
	SI_CSPM_UI_MENU_ITEMS_COUNT_OP_NAME =			"Menu items count", 
	SI_CSPM_UI_MENU_ITEMS_COUNT_OP_TIPS =			"Select the number of slots to be displayed in the pie menu.", 
	SI_CSPM_UI_SLOT_SELECT_MENU_NAME =				"Select slot", 
	SI_CSPM_UI_SLOT_SELECT_MENU_TIPS =				"Please select the slot number you want to configure.", 
	SI_CSPM_UI_ACTION_TYPE_MENU_NAME =				"Action Type", 
	SI_CSPM_UI_ACTION_TYPE_MENU_TIPS =				"Select the type of operation for this slot.", 
	SI_CSPM_UI_ACTION_TYPE_NOTHING_TIPS =			"", 
	SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_TIPS =		"Use unlocked collectible.", 
	SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_APPEARANCE_TIPS	= "Use unlocked appearance collectible.", 
	SI_CSPM_UI_ACTION_TYPE_EMOTE_TIPS =				"Play unlocked emote.", 
	SI_CSPM_UI_ACTION_TYPE_CHAT_COMMAND_TIPS =		"Execute chat command.", 
	SI_CSPM_UI_ACTION_TYPE_TRAVEL_TO_HOUSE_TIPS =	"Fast travel to player's house.", 
	SI_CSPM_UI_ACTION_TYPE_PIE_MENU_TIPS =			"Open another pie menu preset.", 
	SI_CSPM_UI_ACTION_TYPE_SHORTCUT_TIPS =			"Shortcuts for menu and UI operations.", 
	SI_CSPM_UI_ACTION_TYPE_SHORTCUT_ADDON_TIPS =	"Shortcuts provided by other add-ons.", 
	SI_CSPM_UI_CATEGORY_MENU_NAME =					"Category", 
	SI_CSPM_UI_CATEGORY_MENU_TIPS =					"<Category menu tips>", 
	SI_CSPM_UI_CATEGORY_S_USEFUL_SHORTCUT_NAME =	"Useful Shortcut", 
	SI_CSPM_UI_ACTION_VALUE_MENU_NAME =				"Value", 
	SI_CSPM_UI_ACTION_VALUE_MENU_TIPS =				"<Action Value tips>", 
	SI_CSPM_UI_ACTION_VALUE_EDITBOX_TIPS =			"If you want to enter the action value directly, enter it here (for advanced users)", 
	SI_CSPM_UI_VISUAL_SLOT_NAME_OVERRIDE_NAME =		"Slot Name Override", 
	SI_CSPM_UI_VISUAL_SLOT_NAME_OVERRIDE_TIPS =		"Adjust the name of this slot. (optional)", 
	SI_CSPM_UI_DEFAULT_SLOT_NAME_BUTTON_NAME =		"Default Name", 
	SI_CSPM_UI_DEFAULT_SLOT_NAME_BUTTON_TIPS =		"Insert the default slot name corresponding to the selected action in the edit box above.", 
	SI_CSPM_UI_VISUAL_SLOT_ICON_OVERRIDE_NAME =		"Slot Icon Override", 
	SI_CSPM_UI_VISUAL_SLOT_ICON_OVERRIDE_TIPS =		"Adjust the icon of this slot. Enter the full pathname of an icon image file starting with Esoui to replace the icon. (optional)", 

	SI_CSPM_UI_VISUAL_PRESET_NAME_OVERRIDE_NAME =	"Preset Name Override", 
	SI_CSPM_UI_VISUAL_PRESET_NAME_OVERRIDE_TIPS =	"Adjust the name of this preset. (optional)", 
	SI_CSPM_UI_VISUAL_PRESET_NOTE_NAME =			"Preset Description", 
	SI_CSPM_UI_VISUAL_PRESET_NOTE_TIPS =			"Adjust the notes for this preset. This text is used in the pie menu tooltip. (optional)", 
	SI_CSPM_UI_VISUAL_HEADER1_TEXT =				"Visual Design Options", 
	SI_CSPM_UI_VISUAL_QUICKSLOT_STYLE_OP_NAME =		"Quickslot radial menu style", 
	SI_CSPM_UI_VISUAL_QUICKSLOT_STYLE_OP_TIPS =		"Apply a background design like a quick slot radial menu.", 
	SI_CSPM_UI_VISUAL_GAMEPAD_STYLE_OP_NAME =		"Gamepad mode radial menu style", 
	SI_CSPM_UI_VISUAL_GAMEPAD_STYLE_OP_TIPS =		"Apply a background design like a radial menu in gamepad mode.", 
	SI_CSPM_UI_VISUAL_SHOW_PRESET_NAME_OP_NAME =	"Show preset name", 
	SI_CSPM_UI_VISUAL_SHOW_PRESET_NAME_OP_TIPS =	"Whether to show the preset name under the pie menu.", 
	SI_CSPM_UI_VISUAL_SHOW_SLOT_NAME_OP_NAME =		"Show slot name", 
	SI_CSPM_UI_VISUAL_SHOW_SLOT_NAME_OP_TIPS =		"Whether to show the name of each slot around the pie menu.", 
	SI_CSPM_UI_VISUAL_SHOW_ICON_FRAME_OP_NAME =		"Show icon frame", 
	SI_CSPM_UI_VISUAL_SHOW_ICON_FRAME_OP_TIPS =		"Whether to show the icon frame for each slot in the pie menu.", 
	
	-- CShortcut PieMenu Manager UI --
	SI_CSPM_UI_PANEL_HEADER3_TEXT =					"In this panel, you can configure which pie menu will be invoked for various UI event triggers.", 
	SI_CSPM_UI_ACCOUNT_WIDE_OP_NAME =				"Use Account Wide Settings", 
	SI_CSPM_UI_ACCOUNT_WIDE_OP_TIPS =				"When the account wide setting is OFF, then each character can have different configuration options set below.", 
	SI_CSPM_UI_BINDINGS_HEADER1_TEXT =				"Key Bindings and Presets", 
	SI_CSPM_UI_BINDINGS_HEADER1_TIPS =				"For each shortcut key, you can assign your favorite pie menu. Of course, you need to configure addon keybinds in the CONTROLS settings.", 
	SI_CSPM_UI_BINDINGS_INTERACTION1_TIPS =			"This is the 'primary interaction' key bindings that must be assigned to this add-on. Basically, you should assign the most frequently used pie menu presets, but the add-on may occasionally switch pie menu presets automatically due to the event triggers described below.", 
	SI_CSPM_UI_BEHAVIOR_HEADER1_TEXT =				"Behavior Options (Advanced)", 
	SI_CSPM_UI_BEHAVIOR_HEADER1_TIPS =				"These are optional settings that normally do not need to be changed, such as prototype features that are still under development. Option settings that are being tweaked will be marked as beta, and positive feedback on future tweaks will be welcomed. (For advanced users)", 
	SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_NAME =	"Time to hold key until activation (milliseconds)", 
	SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_TIPS =	"You can adjust the key hold time for pie menu activation. The smaller the number, the faster it is.", 
	SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_NAME =	"Activate Pie Menu in UI mode", 
	SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_TIPS =	"Allow you to activate pie menu in most UI mode (cursor mode) scenes.", 
	SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_NAME =			"Selecting and canceling with click", 
	SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_TIPS =			"By turning on this setting, you can use mouse buttons or gamepad buttons to quickly select or cancel pie menus.\n\nSelecting : <<1>>, <<2>>, <<3>>\nCanceling : <<4>>, <<5>>, <<6>>", 
	SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_NAME =	"Centering Pie Menu at mouse cursor in UI mode", 
	SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_TIPS =	"By turning on this setting, the pie menu will be displayed at the current mouse cursor position instead of the center of the screen in UI mode.", 
}
for stringId, stringToAdd in pairs(strings) do
   ZO_CreateStringId(stringId, stringToAdd)
   SafeAddVersion(stringId, 1)
end
