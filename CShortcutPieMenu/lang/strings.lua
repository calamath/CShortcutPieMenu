local strings = {
	SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION =	"|c7CFC00PieMenu Interaction|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_SECONDARY = 	"|cC5C292PieMenu Secondary Action|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_TERTIARY =	"|cC5C293PieMenu Tertiary Action|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_QUATERNARY =	"|cC5C294PieMenu Quaternary Action|r", 
	SI_BINDING_NAME_CSPM_PIE_MENU_QUINARY =		"|cC5C295PieMenu Quinary Action|r", 

	SI_CSPM_COMMON_PRESET =							"Preset", 
	SI_CSPM_COMMON_SLOT =							"Slot", 
	SI_CSPM_COMMON_UNSELECTED =						"<Unselected>", 
	SI_CSPM_COMMON_UNREGISTERED =					"<Unregistered>", 
	SI_CSPM_COMMON_IMMEDIATE_VALUE =				"(Immediate Value)", 
	SI_CSPM_COMMON_COLLECTIBLE =					"Collectible", 
	SI_CSPM_COMMON_EMOTE =							"Emote", 
	SI_CSPM_COMMON_CHAT_COMMAND =					"Chat Command", 
	SI_CSPM_COMMON_TRAVEL_TO_HOUSE =				"Travel to house", 
	SI_CSPM_COMMON_MY_HOUSE_INSIDE =				"My House (inside)", 
	SI_CSPM_COMMON_MY_HOUSE_OUTSIDE =				"My House (outside)", 
	SI_CSPM_COMMON_PIE_MENU =						"Pie Menu", 
	SI_CSPM_COMMON_OPEN_USER_PIE_MENU_PRESET =		"Open Pie Menu Preset", 
	SI_CSPM_UI_PANEL_HEADER1_TEXT =					"This add-on provides a pie menu for shortcuts to various UI operations.", 
	SI_CSPM_UI_PANEL_HEADER2_TEXT =					"In this panel, you can configure your favorite shortcuts for each slot in the pie menu and register them as presets that can be used throughout your account.\n", 
	SI_CSPM_UI_PRESET_SELECT_MENU_NAME =			"Select preset", 
	SI_CSPM_UI_PRESET_SELECT_MENU_TIPS =			"Please select the preset you want to configure.", 
	SI_CSPM_UI_SLOT_SELECT_MENU_NAME =				"Select slot", 
	SI_CSPM_UI_SLOT_SELECT_MENU_TIPS =				"Please select the slot number you want to configure.", 
	SI_CSPM_UI_ACTION_TYPE_MENU_NAME =				"Action Type", 
	SI_CSPM_UI_ACTION_TYPE_MENU_TIPS =				"Select the type of operation for this slot.", 
	SI_CSPM_UI_ACTION_TYPE_NOTHING_TIPS =			"", 
	SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_TIPS =		"Use unlocked collectible.", 
	SI_CSPM_UI_ACTION_TYPE_EMOTE_TIPS =				"Play unlocked emote.", 
	SI_CSPM_UI_ACTION_TYPE_CHAT_COMMAND_TIPS =		"Execute the chat command.", 
	SI_CSPM_UI_ACTION_TYPE_TRAVEL_TO_HOUSE_TIPS =	"Jump to your home already unlocked", 
	SI_CSPM_UI_ACTION_TYPE_PIE_MENU_TIPS =			"Open pie menu preset.", 
	SI_CSPM_UI_CATEGORY_MENU_NAME =					"Category", 
	SI_CSPM_UI_CATEGORY_MENU_TIPS =					"<Category menu tips>", 
	SI_CSPM_UI_ACTION_VALUE_MENU_NAME =				"Value", 
	SI_CSPM_UI_ACTION_VALUE_MENU_TIPS =				"<Action Value tips>", 

	SI_CSPM_UI_PANEL_HEADER3_TEXT =					"In this panel, you can configure which pie menu will be invoked for various UI event triggers.", 
}

for stringId, stringToAdd in pairs(strings) do
   ZO_CreateStringId(stringId, stringToAdd)
   SafeAddVersion(stringId, 1)
end
