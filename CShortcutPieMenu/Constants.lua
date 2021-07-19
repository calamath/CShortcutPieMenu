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


-- CShortcutPieMenu namespace
CShortcutPieMenu = CShortcutPieMenu or {}

local CSPM = CShortcutPieMenu
CSPM.name = "CShortcutPieMenu"
CSPM.version = "0.8.0"
CSPM.author = "Calamath"
CSPM.savedVarsPieMenuEditor = "CShortcutPieMenuDB"
CSPM.savedVarsPieMenuManager = "CShortcutPieMenuSV"
CSPM.savedVarsVersion = 1
CSPM.authority = {2973583419,210970542} 

-- ---------------------------------------------------------------------------------------
-- constants
CSPM.const = {
	CSPM_MAX_USER_PRESET						= 10, 
	CSPM_MENU_ITEMS_COUNT_DEFAULT				= 2, 
	CSPM_ACTION_TYPE_NOTHING					= 0, 
	CSPM_ACTION_TYPE_COLLECTIBLE				= 1, 
	CSPM_ACTION_TYPE_EMOTE						= 2, 
	CSPM_ACTION_TYPE_CHAT_COMMAND				= 3, 
	CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= 4, 
	CSPM_ACTION_TYPE_PIE_MENU					= 5, 
	CSPM_CATEGORY_NOTHING						= 0, 
	CSPM_CATEGORY_IMMEDIATE_VALUE				= 1, 
	CSPM_CATEGORY_C_ASSISTANT					= 11, 
	CSPM_CATEGORY_C_COMPANION					= 12, 
	CSPM_CATEGORY_C_MEMENTO						= 13, 
	CSPM_CATEGORY_C_VANITY_PET					= 14, 
	CSPM_CATEGORY_C_MOUNT						= 15, 
	CSPM_CATEGORY_C_PERSONALITY					= 16, 
	CSPM_CATEGORY_E_CEREMONIAL					= 31, 
	CSPM_CATEGORY_E_CHEERS_AND_JEERS			= 32, 
	CSPM_CATEGORY_E_EMOTION						= 33, 
	CSPM_CATEGORY_E_ENTERTAINMENT				= 34, 
	CSPM_CATEGORY_E_FOOD_AND_DRINK				= 35, 
	CSPM_CATEGORY_E_GIVE_DIRECTIONS				= 36, 
	CSPM_CATEGORY_E_PHYSICAL					= 37, 
	CSPM_CATEGORY_E_POSES_AND_FIDGETS			= 38, 
	CSPM_CATEGORY_E_PROP						= 39, 
	CSPM_CATEGORY_E_SOCIAL						= 40, 
	CSPM_CATEGORY_E_COLLECTED					= 41, 
	CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE		= 51, 
	CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE		= 52, 
	CSPM_CATEGORY_P_OPEN_USER_PIE_MENU			= 61, 
	CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID			= -1, 
}

-- ---------------------------------------------------------------------------------------
-- Aliases of constants
local CSPM_MAX_USER_PRESET						= CSPM.const.CSPM_MAX_USER_PRESET
local CSPM_MENU_ITEMS_COUNT_DEFAULT				= CSPM.const.CSPM_MENU_ITEMS_COUNT_DEFAULT
local CSPM_ACTION_TYPE_NOTHING					= CSPM.const.CSPM_ACTION_TYPE_NOTHING
local CSPM_ACTION_TYPE_COLLECTIBLE				= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE
local CSPM_ACTION_TYPE_EMOTE					= CSPM.const.CSPM_ACTION_TYPE_EMOTE
local CSPM_ACTION_TYPE_CHAT_COMMAND				= CSPM.const.CSPM_ACTION_TYPE_CHAT_COMMAND
local CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= CSPM.const.CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE
local CSPM_ACTION_TYPE_PIE_MENU					= CSPM.const.CSPM_ACTION_TYPE_PIE_MENU
local CSPM_CATEGORY_NOTHING						= CSPM.const.CSPM_CATEGORY_NOTHING
local CSPM_CATEGORY_IMMEDIATE_VALUE				= CSPM.const.CSPM_CATEGORY_IMMEDIATE_VALUE
local CSPM_CATEGORY_C_ASSISTANT					= CSPM.const.CSPM_CATEGORY_C_ASSISTANT
local CSPM_CATEGORY_C_COMPANION					= CSPM.const.CSPM_CATEGORY_C_COMPANION
local CSPM_CATEGORY_C_MEMENTO					= CSPM.const.CSPM_CATEGORY_C_MEMENTO
local CSPM_CATEGORY_C_VANITY_PET				= CSPM.const.CSPM_CATEGORY_C_VANITY_PET
local CSPM_CATEGORY_C_MOUNT						= CSPM.const.CSPM_CATEGORY_C_MOUNT
local CSPM_CATEGORY_C_PERSONALITY				= CSPM.const.CSPM_CATEGORY_C_PERSONALITY
local CSPM_CATEGORY_E_CEREMONIAL				= CSPM.const.CSPM_CATEGORY_E_CEREMONIAL
local CSPM_CATEGORY_E_CHEERS_AND_JEERS			= CSPM.const.CSPM_CATEGORY_E_CHEERS_AND_JEERS
local CSPM_CATEGORY_E_EMOTION					= CSPM.const.CSPM_CATEGORY_E_EMOTION
local CSPM_CATEGORY_E_ENTERTAINMENT				= CSPM.const.CSPM_CATEGORY_E_ENTERTAINMENT
local CSPM_CATEGORY_E_FOOD_AND_DRINK			= CSPM.const.CSPM_CATEGORY_E_FOOD_AND_DRINK
local CSPM_CATEGORY_E_GIVE_DIRECTIONS			= CSPM.const.CSPM_CATEGORY_E_GIVE_DIRECTIONS
local CSPM_CATEGORY_E_PHYSICAL					= CSPM.const.CSPM_CATEGORY_E_PHYSICAL
local CSPM_CATEGORY_E_POSES_AND_FIDGETS			= CSPM.const.CSPM_CATEGORY_E_POSES_AND_FIDGETS
local CSPM_CATEGORY_E_PROP						= CSPM.const.CSPM_CATEGORY_E_PROP
local CSPM_CATEGORY_E_SOCIAL					= CSPM.const.CSPM_CATEGORY_E_SOCIAL
local CSPM_CATEGORY_E_COLLECTED					= CSPM.const.CSPM_CATEGORY_E_COLLECTED
local CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE		= CSPM.const.CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE
local CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE	= CSPM.const.CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE
local CSPM_CATEGORY_P_OPEN_USER_PIE_MENU		= CSPM.const.CSPM_CATEGORY_P_OPEN_USER_PIE_MENU
local CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID		= CSPM.const.CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID

local CSPM_SLOT_DATA_DEFAULT 					= CSPM.const.CSPM_SLOT_DATA_DEFAULT

-- ---------------------------------------------------------------------------------------
-- look up table
CSPM.lut = {
	CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS = {
		[CSPM_CATEGORY_C_ASSISTANT]				= COLLECTIBLE_CATEGORY_TYPE_ASSISTANT, 
		[CSPM_CATEGORY_C_COMPANION]				= COLLECTIBLE_CATEGORY_TYPE_COMPANION, 
		[CSPM_CATEGORY_C_MEMENTO]				= COLLECTIBLE_CATEGORY_TYPE_MEMENTO, 
		[CSPM_CATEGORY_C_VANITY_PET]			= COLLECTIBLE_CATEGORY_TYPE_VANITY_PET, 
		[CSPM_CATEGORY_C_MOUNT]					= COLLECTIBLE_CATEGORY_TYPE_MOUNT, 
		[CSPM_CATEGORY_C_PERSONALITY]			= COLLECTIBLE_CATEGORY_TYPE_PERSONALITY, 
	}, 
	CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS = {
		[CSPM_CATEGORY_E_CEREMONIAL]			= EMOTE_CATEGORY_CEREMONIAL, 
		[CSPM_CATEGORY_E_CHEERS_AND_JEERS]		= EMOTE_CATEGORY_CHEERS_AND_JEERS, 
		[CSPM_CATEGORY_E_EMOTION]				= EMOTE_CATEGORY_EMOTION, 
		[CSPM_CATEGORY_E_ENTERTAINMENT]			= EMOTE_CATEGORY_ENTERTAINMENT, 
		[CSPM_CATEGORY_E_FOOD_AND_DRINK]		= EMOTE_CATEGORY_FOOD_AND_DRINK, 
		[CSPM_CATEGORY_E_GIVE_DIRECTIONS]		= EMOTE_CATEGORY_GIVE_DIRECTIONS, 
		[CSPM_CATEGORY_E_PHYSICAL]				= EMOTE_CATEGORY_PHYSICAL, 
		[CSPM_CATEGORY_E_POSES_AND_FIDGETS]		= EMOTE_CATEGORY_POSES_AND_FIDGETS, 
		[CSPM_CATEGORY_E_PROP]					= EMOTE_CATEGORY_PROP, 
		[CSPM_CATEGORY_E_SOCIAL]				= EMOTE_CATEGORY_SOCIAL, 
		[CSPM_CATEGORY_E_COLLECTED] 			= EMOTE_CATEGORY_COLLECTED, 
	}, 
	CSPM_LUT_CATEGORY_E_CSPM_TO_ICON = {
		[CSPM_CATEGORY_NOTHING]					= "EsoUI/Art/Inventory/inventory_tabIcon_quickslot_up.dds", 
		[CSPM_CATEGORY_IMMEDIATE_VALUE]			= "EsoUI/Art/Help/help_tabIcon_emotes_up.dds", 
		[CSPM_CATEGORY_E_CEREMONIAL]			= "EsoUI/Art/Emotes/emotes_indexIcon_ceremonial_up.dds", 
		[CSPM_CATEGORY_E_CHEERS_AND_JEERS]		= "EsoUI/Art/Emotes/emotes_indexIcon_cheersJeers_up.dds", 
		[CSPM_CATEGORY_E_EMOTION]				= "EsoUI/Art/Emotes/emotes_indexIcon_emotion_up.dds", 
		[CSPM_CATEGORY_E_ENTERTAINMENT]			= "EsoUI/Art/Emotes/emotes_indexIcon_entertain_up.dds", 
		[CSPM_CATEGORY_E_FOOD_AND_DRINK]		= "EsoUI/Art/Emotes/emotes_indexIcon_eatDrink_up.dds", 
		[CSPM_CATEGORY_E_GIVE_DIRECTIONS]		= "EsoUI/Art/Emotes/emotes_indexIcon_directions_up.dds", 
		[CSPM_CATEGORY_E_PHYSICAL]				= "EsoUI/Art/Emotes/emotes_indexIcon_physical_up.dds", 
		[CSPM_CATEGORY_E_POSES_AND_FIDGETS]		= "EsoUI/Art/Emotes/emotes_indexIcon_fidget_up.dds", 
		[CSPM_CATEGORY_E_PROP]					= "EsoUI/Art/Emotes/emotes_indexIcon_prop_up.dds", 
		[CSPM_CATEGORY_E_SOCIAL]				= "EsoUI/Art/Emotes/emotes_indexIcon_social_up.dds", 
		[CSPM_CATEGORY_E_COLLECTED] 			= "EsoUI/Art/Collections/collections_tabIcon_collectibles_up.dds", 
	}, 
}
-- ---------------------------------------------------------------------------------------
-- Aliases of look up table
local CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ICON			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ICON

-- ---------------------------------------------------------------------------------------