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

if CShortcutPieMenu then return end
-- ---------------------------------------------------------------------------------------
-- Library
-- ---------------------------------------------------------------------------------------
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu-2.0' not found.") return end
local LibCInteraction = LibCInteraction
if not LibCInteraction then d("[CSPM] Error : 'LibCInteraction' not found.") return end

-- ---------------------------------------------------------------------------------------
-- Name Space
-- ---------------------------------------------------------------------------------------
local CSPM = {
	name = "CShortcutPieMenu", 
	version = "0.10.4", 
	author = "Calamath", 
	savedVarsPieMenuEditor = "CShortcutPieMenuDB", 
	savedVarsPieMenuManager = "CShortcutPieMenuSV", 
	savedVarsVersion = 1, 
	authority = {2973583419,210970542}, 
	class = {}, 
	external = {},
}
CShortcutPieMenu = CSPM.external
CShortcutPieMenu.name = CSPM.name
CShortcutPieMenu.version = CSPM.version
CShortcutPieMenu.author = CSPM.author

-- ---------------------------------------------------------------------------------------
-- Constants
-- ---------------------------------------------------------------------------------------
CSPM.const = {
	UI_NONE									= 0, 
	UI_OPEN									= 1, 
	UI_CLOSE								= 2, 
	UI_COPY									= 3, 
	UI_PASTE								= 4, 
	UI_CLEAR								= 5, 
	UI_RESET								= 6, 
	UI_PREVIEW								= 7, 
	UI_SELECT								= 8, 
	UI_CANCEL								= 9, 
	UI_EXECUTE								= 10, 

	MAX_USER_PRESET							= 10, 
	MENU_ITEMS_COUNT_DEFAULT				= 2, 
	ACTION_TYPE_NOTHING						= 0, 
	ACTION_TYPE_COLLECTIBLE					= 1, 
	ACTION_TYPE_EMOTE						= 2, 
	ACTION_TYPE_CHAT_COMMAND				= 3, 
	ACTION_TYPE_TRAVEL_TO_HOUSE				= 4, 
	ACTION_TYPE_PIE_MENU					= 5, 
	ACTION_TYPE_SHORTCUT					= 6, 
	ACTION_TYPE_COLLECTIBLE_APPEARANCE		= 11, 	-- alias of ACTION_TYPE_COLLECTIBLE
	ACTION_TYPE_SHORTCUT_ADDON				= 16, 	-- alias of ACTION_TYPE_SHORTCUT
	CATEGORY_NOTHING						= 0, 
	CATEGORY_IMMEDIATE_VALUE				= 1, 
	CATEGORY_C_ASSISTANT					= 11, 
	CATEGORY_C_COMPANION					= 12, 
	CATEGORY_C_MEMENTO						= 13, 
	CATEGORY_C_VANITY_PET					= 14, 
	CATEGORY_C_MOUNT						= 15, 
	CATEGORY_C_PERSONALITY					= 16, 
	CATEGORY_C_ABILITY_SKIN					= 17, 
	CATEGORY_E_CEREMONIAL					= 31, 
	CATEGORY_E_CHEERS_AND_JEERS				= 32, 
	CATEGORY_E_EMOTION						= 33, 
	CATEGORY_E_ENTERTAINMENT				= 34, 
	CATEGORY_E_FOOD_AND_DRINK				= 35, 
	CATEGORY_E_GIVE_DIRECTIONS				= 36, 
	CATEGORY_E_PHYSICAL						= 37, 
	CATEGORY_E_POSES_AND_FIDGETS			= 38, 
	CATEGORY_E_PROP							= 39, 
	CATEGORY_E_SOCIAL						= 40, 
	CATEGORY_E_COLLECTED					= 41, 
	CATEGORY_H_UNLOCKED_HOUSE_INSIDE		= 51, 
	CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE		= 52, 
	CATEGORY_P_OPEN_USER_PIE_MENU			= 61, 
	CATEGORY_P_OPEN_EXTERNAL_PIE_MENU		= 62, 
	CATEGORY_S_PIE_MENU_ADDON				= 71, 
	CATEGORY_S_MAIN_MENU					= 72, 
	CATEGORY_S_SYSTEM_MENU					= 73, 
	CATEGORY_S_USEFUL_SHORTCUT				= 74, 
	CATEGORY_C_HAT							= 81, 
	CATEGORY_C_HAIR							= 82, 
	CATEGORY_C_HEAD_MARKING					= 83, 
	CATEGORY_C_FACIAL_HAIR_HORNS			= 84, 
	CATEGORY_C_FACIAL_ACCESSORY				= 85, 
	CATEGORY_C_PIERCING_JEWELRY				= 86, 
	CATEGORY_C_COSTUME						= 87, 
	CATEGORY_C_BODY_MARKING					= 88, 
	CATEGORY_C_SKIN							= 89, 
	CATEGORY_C_POLYMORPH					= 90, 
	ACTION_VALUE_PRIMARY_HOUSE_ID			= -1, 
}
local C = CSPM.const

-- ---------------------------------------------------------------------------------------
-- Lookup tables
-- ---------------------------------------------------------------------------------------
CSPM.lut = {
	CategoryId_To_CollectibleCategoryType = {
		[C.CATEGORY_C_ASSISTANT]			= COLLECTIBLE_CATEGORY_TYPE_ASSISTANT, 
		[C.CATEGORY_C_COMPANION]			= COLLECTIBLE_CATEGORY_TYPE_COMPANION, 
		[C.CATEGORY_C_MEMENTO]				= COLLECTIBLE_CATEGORY_TYPE_MEMENTO, 
		[C.CATEGORY_C_VANITY_PET]			= COLLECTIBLE_CATEGORY_TYPE_VANITY_PET, 
		[C.CATEGORY_C_MOUNT]				= COLLECTIBLE_CATEGORY_TYPE_MOUNT, 
		[C.CATEGORY_C_PERSONALITY]			= COLLECTIBLE_CATEGORY_TYPE_PERSONALITY, 
		[C.CATEGORY_C_ABILITY_SKIN]			= COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN, 
		[C.CATEGORY_C_HAT]					= COLLECTIBLE_CATEGORY_TYPE_HAT, 
		[C.CATEGORY_C_HAIR]					= COLLECTIBLE_CATEGORY_TYPE_HAIR, 
		[C.CATEGORY_C_HEAD_MARKING]			= COLLECTIBLE_CATEGORY_TYPE_HEAD_MARKING, 
		[C.CATEGORY_C_FACIAL_HAIR_HORNS]	= COLLECTIBLE_CATEGORY_TYPE_FACIAL_HAIR_HORNS, 
		[C.CATEGORY_C_FACIAL_ACCESSORY]		= COLLECTIBLE_CATEGORY_TYPE_FACIAL_ACCESSORY, 
		[C.CATEGORY_C_PIERCING_JEWELRY]		= COLLECTIBLE_CATEGORY_TYPE_PIERCING_JEWELRY, 
		[C.CATEGORY_C_COSTUME]				= COLLECTIBLE_CATEGORY_TYPE_COSTUME, 
		[C.CATEGORY_C_BODY_MARKING]			= COLLECTIBLE_CATEGORY_TYPE_BODY_MARKING, 
		[C.CATEGORY_C_SKIN]					= COLLECTIBLE_CATEGORY_TYPE_SKIN, 
		[C.CATEGORY_C_POLYMORPH]			= COLLECTIBLE_CATEGORY_TYPE_POLYMORPH, 
	}, 
	CategoryId_To_EmoteCategory = {
		[C.CATEGORY_E_CEREMONIAL]			= EMOTE_CATEGORY_CEREMONIAL, 
		[C.CATEGORY_E_CHEERS_AND_JEERS]		= EMOTE_CATEGORY_CHEERS_AND_JEERS, 
		[C.CATEGORY_E_EMOTION]				= EMOTE_CATEGORY_EMOTION, 
		[C.CATEGORY_E_ENTERTAINMENT]		= EMOTE_CATEGORY_ENTERTAINMENT, 
		[C.CATEGORY_E_FOOD_AND_DRINK]		= EMOTE_CATEGORY_FOOD_AND_DRINK, 
		[C.CATEGORY_E_GIVE_DIRECTIONS]		= EMOTE_CATEGORY_GIVE_DIRECTIONS, 
		[C.CATEGORY_E_PHYSICAL]				= EMOTE_CATEGORY_PHYSICAL, 
		[C.CATEGORY_E_POSES_AND_FIDGETS]	= EMOTE_CATEGORY_POSES_AND_FIDGETS, 
		[C.CATEGORY_E_PROP]					= EMOTE_CATEGORY_PROP, 
		[C.CATEGORY_E_SOCIAL]				= EMOTE_CATEGORY_SOCIAL, 
		[C.CATEGORY_E_COLLECTED] 			= EMOTE_CATEGORY_COLLECTED, 
	}, 
	CategoryId_To_Icon = {
		[C.CATEGORY_NOTHING]				= "EsoUI/Art/Inventory/inventory_tabIcon_quickslot_up.dds", 
		[C.CATEGORY_IMMEDIATE_VALUE]		= "EsoUI/Art/Icons/Emotes/emotecategoryicon_common.dds", 
		[C.CATEGORY_E_CEREMONIAL]			= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_CEREMONIAL), 
		[C.CATEGORY_E_CHEERS_AND_JEERS]		= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_CHEERS_AND_JEERS), 
		[C.CATEGORY_E_EMOTION]				= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_EMOTION), 
		[C.CATEGORY_E_ENTERTAINMENT]		= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_ENTERTAINMENT), 
		[C.CATEGORY_E_FOOD_AND_DRINK]		= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_FOOD_AND_DRINK), 
		[C.CATEGORY_E_GIVE_DIRECTIONS]		= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_GIVE_DIRECTIONS), 
		[C.CATEGORY_E_PHYSICAL]				= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_PHYSICAL), 
		[C.CATEGORY_E_POSES_AND_FIDGETS]	= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_POSES_AND_FIDGETS), 
		[C.CATEGORY_E_PROP]					= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_PROP), 
		[C.CATEGORY_E_SOCIAL]				= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_SOCIAL), 
		[C.CATEGORY_E_COLLECTED] 			= GetSharedEmoteIconForCategory(EMOTE_CATEGORY_COLLECTED), 
	}, 
	ActionTypeApiStrings = {
		["collectible"] 		= C.ACTION_TYPE_COLLECTIBLE, 
		["emote"] 				= C.ACTION_TYPE_EMOTE, 
		["chat_command"] 		= C.ACTION_TYPE_CHAT_COMMAND, 
		["travel_to_house"] 	= C.ACTION_TYPE_TRAVEL_TO_HOUSE, 
		["pie_menu"] 			= C.ACTION_TYPE_PIE_MENU, 
		["shortcut"] 			= C.ACTION_TYPE_SHORTCUT, 
	}, 
	ActionTypeAlias = {
		[C.ACTION_TYPE_COLLECTIBLE_APPEARANCE]		= C.ACTION_TYPE_COLLECTIBLE, 
		[C.ACTION_TYPE_SHORTCUT_ADDON]				= C.ACTION_TYPE_SHORTCUT, 
	}, 
	UI_Color = {
		["NORMAL"]				= { 1, 1, 1, }, 
		["ACTIVE"]				= { 0.6, 1, 0, }, 
		["BLOCKED"]				= { 1, 0.3, 0, }, 
	}, 
	UI_Icon = {
		["CHECK"]				= "EsoUI/Art/Miscellaneous/check_icon_32.dds", 
		["LOCKED"]				= "EsoUI/Art/Miscellaneous/status_locked.dds", 
		["UNLOCKED"]			= "EsoUI/Art/Miscellaneous/Gamepad/gp_icon_unlocked32.dds", 
		["BLOCKED"]				= "EsoUI/Art/Mappins/hostile_pin.dds", 
		["HELP"]				= "EsoUI/Art/Miscellaneous/help_icon.dds", 
		["NEW"]					= "EsoUI/Art/Miscellaneous/new_icon.dds", 
		["WARNING"]				= "EsoUI/Art/Miscellaneous/eso_icon_warning.dds", 
		["MOUSE_LMB"]			= GetMouseIconPathForKeyCode(KEY_MOUSE_LEFT), 
		["MOUSE_RMB"]			= GetMouseIconPathForKeyCode(KEY_MOUSE_RIGHT), 
		["GAMEPAD_1"]			= GetGamepadIconPathForKeyCode(KEY_GAMEPAD_BUTTON_1), 
		["GAMEPAD_2"]			= GetGamepadIconPathForKeyCode(KEY_GAMEPAD_BUTTON_2), 
	}, 
	ActionNames = {
		"CSPM_PIE_MENU_INTERACTION", 
		"CSPM_PIE_MENU_SECONDARY", 
		"CSPM_PIE_MENU_TERTIARY", 
		"CSPM_PIE_MENU_QUATERNARY", 
		"CSPM_PIE_MENU_QUINARY", 
	}, 
	ActionNameAlias = {
		["CSPM_UIMODE_PIE_MENU_INTERACTION"]	= "CSPM_PIE_MENU_INTERACTION", 
		["CSPM_UIMODE_PIE_MENU_SECONDARY"]		= "CSPM_PIE_MENU_SECONDARY", 
		["CSPM_UIMODE_PIE_MENU_TERTIARY"]		= "CSPM_PIE_MENU_TERTIARY", 
		["CSPM_UIMODE_PIE_MENU_QUATERNARY"]		= "CSPM_PIE_MENU_QUATERNARY", 
		["CSPM_UIMODE_PIE_MENU_QUINARY"]		= "CSPM_PIE_MENU_QUINARY", 
	}, 
	ActionName_To_KeybindsId = {
		["CSPM_PIE_MENU_INTERACTION"]			= 1, 
		["CSPM_PIE_MENU_SECONDARY"]				= 2, 
		["CSPM_PIE_MENU_TERTIARY"]				= 3, 
		["CSPM_PIE_MENU_QUATERNARY"]			= 4, 
		["CSPM_PIE_MENU_QUINARY"]				= 5, 
		["CSPM_UIMODE_PIE_MENU_INTERACTION"]	= 1, 
		["CSPM_UIMODE_PIE_MENU_SECONDARY"]		= 2, 
		["CSPM_UIMODE_PIE_MENU_TERTIARY"]		= 3, 
		["CSPM_UIMODE_PIE_MENU_QUATERNARY"]		= 4, 
		["CSPM_UIMODE_PIE_MENU_QUINARY"]		= 5, 
	}, 
}
local LUT = CSPM.lut

-- ---------------------------------------------------------------------------------------
-- CShortcutPieMenu savedata (default)
-- ---------------------------------------------------------------------------------------
-- PieMenu Slot
local CSPM_SLOT_DATA_DEFAULT = {
	type = C.ACTION_TYPE_NOTHING, 
	category = C.CATEGORY_NOTHING, 
	value = 0, 
} 

-- CShortcutPieMenu PieMenuEditor Config (AccountWide / User-customizable PieMenu Preset)
local CSPM_DB_DEFAULT = {
	preset = {
		[1] = {
			id = 1, 
			name = "", 
			menuItemsCount = C.MENU_ITEMS_COUNT_DEFAULT, 
			visual = {
				showIconFrame = true, 
				showSlotLabel = true, 
				showPresetName = false, 
				style = "gamepad", 
				size = 350, 
			}, 
			slot = {
				[1] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT), 
				[2] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT), 
			}, 
		}, 
	}, 
}

-- CShortcutPieMenu PieMenuManager Config
local CSPM_SV_DEFAULT = {
	accountWide = true, 
	menuAttributes = {
		allowActivateInUIMode = true, 
		allowClickable = true, 
		centeringAtMouseCursor = false, 
		timeToHoldKey = 250, 
		mouseDeltaScaleFactorInUIMode = 1, 
	}, 
	keybinds = {
		[1] = 1, 	-- Primary Action
		[2] = 0, 	-- Secondary Action
		[3] = 0, 	-- Tertiary Action
		[4] = 0, 	-- Quaternary Action
		[5] = 0, 	-- Quinary Action
	}, 
}

-- ---------------------------------------------------------------------------------------
-- Helper Functions
-- ---------------------------------------------------------------------------------------
local L = GetString

CSPM.util = {}
function CSPM.util.GetValue(value, ...)
	if type(value) == "function" then
		return value(...)
	else
		return value
	end
end
local GetValue = CSPM.util.GetValue

function CSPM.util.GetActionType(value)
	local value = GetValue(value)
	local actionType = type(value) == "string" and LUT.ActionTypeApiStrings[zo_strlower(value)] or value or C.ACTION_TYPE_NOTHING
	return LUT.ActionTypeAlias[actionType] or actionType
end
local GetActionType = CSPM.util.GetActionType

do
	local GetDefaultSlotName = {		-- you cannot use 'self' within this block.
		[C.ACTION_TYPE_NOTHING] = function(actionType, categoryId, actionValue)
			return ""
		end, 
		[C.ACTION_TYPE_COLLECTIBLE] = function(_, _, actionValue)
			local name = zo_strformat(L(SI_CSPM_COMMON_FORMATTER), GetCollectibleName(actionValue))
			local nameColor
			if IsCollectibleActive(actionValue, GAMEPLAY_ACTOR_CATEGORY_PLAYER) then 
				nameColor = LUT.UI_Color.ACTIVE
			elseif GetCollectibleBlockReason(actionValue) ~= COLLECTIBLE_USAGE_BLOCK_REASON_NOT_BLOCKED then
				nameColor = LUT.UI_Color.BLOCKED
			end
			return name, nameColor
		end, 
		[C.ACTION_TYPE_EMOTE] = function(_, _, actionValue)
			local emoteItemInfo = PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(actionValue)
			local name = zo_strformat(L(SI_CSPM_COMMON_FORMATTER), emoteItemInfo and emoteItemInfo.displayName or "")
			local nameColor = emoteItemInfo and emoteItemInfo.isOverriddenByPersonality and { ZO_PERSONALITY_EMOTES_COLOR:UnpackRGB() }
			return name, nameColor
		end, 
		[C.ACTION_TYPE_CHAT_COMMAND] = function(_, _, actionValue)
			return tostring(actionValue)
		end, 
		[C.ACTION_TYPE_TRAVEL_TO_HOUSE] = function(_, categoryId, actionValue)
			local name = ""
			if actionValue == C.ACTION_VALUE_PRIMARY_HOUSE_ID then
				name = L(SI_HOUSING_FURNITURE_SETTINGS_GENERAL_PRIMARY_RESIDENCE_TEXT)		-- "Primary Residence"
			else
				name = zo_strformat(L(SI_CSPM_COMMON_FORMATTER), GetCollectibleName(GetCollectibleIdForHouse(actionValue)))
			end
			if actionValue ~= 0 then
				if categoryId == C.CATEGORY_H_UNLOCKED_HOUSE_INSIDE then
					name = zo_strformat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_INSIDE), name)		-- "<<1>> (inside)"
				elseif categoryId == C.CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE then
					name = zo_strformat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_OUTSIDE), name)	-- "<<1>> (outside)"
				end
			end
			return name
		end, 
		[C.ACTION_TYPE_PIE_MENU] = function(_, _, actionValue)
			local name = ""
			if CSPM.util.IsUserPieMenu(actionValue) and actionValue ~= 0 then
				name = zo_strformat(L(SI_CSPM_PRESET_NO_NAME_FORMATTER), actionValue)
			elseif CSPM.util.IsExternalPieMenu(actionValue) and actionValue ~= "" then
				name = zo_strformat(L(SI_CSPM_COMMON_FORMATTER), CSPM.util.GetPieMenuInfo(actionValue) or "")
			end
			return name
		end, 
		[C.ACTION_TYPE_SHORTCUT] = function(_, _, actionValue)
			local name, _, _, _, nameColor = CSPM.util.GetShortcutInfo(actionValue)	-- actionValue: shortcutData or shortcutId
			return name or "", nameColor
		end, 
	}
	setmetatable(GetDefaultSlotName, { __index = function(self, key) return rawget(self, C.ACTION_TYPE_NOTHING) end, })

	function CSPM.util.GetDefaultSlotName(actionType, categoryId, actionValue)
		local actionType = GetActionType(actionType)
		local categoryId = GetValue(categoryId)
		local actionValue = GetValue(actionValue)
		return GetDefaultSlotName[actionType](actionType, categoryId, actionValue)
	end
end

do
	local GetDefaultSlotIcon = {		-- you cannot use 'self' within this block.
		[C.ACTION_TYPE_NOTHING] = function(actionType, categoryId, actionValue)
			return ""
		end, 
		[C.ACTION_TYPE_COLLECTIBLE] = function(_, _, actionValue)
			return GetCollectibleIcon(actionValue)
		end, 
		[C.ACTION_TYPE_EMOTE] = function(_, categoryId, actionValue)
			local icon = ""
			local emoteItemInfo = PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(actionValue)
			if emoteItemInfo then
				local emoteCollectibleId = GetEmoteCollectibleId(emoteItemInfo.emoteIndex)
				if emoteCollectibleId then
					icon = GetCollectibleIcon(emoteCollectibleId)
				else
					icon = LUT.CategoryId_To_Icon[categoryId] or LUT.CategoryId_To_Icon[C.CATEGORY_NOTHING]
				end
			end
			return icon
		end, 
		[C.ACTION_TYPE_CHAT_COMMAND] = function(_, _, _)
			return "EsoUI/Art/Icons/crafting_dwemer_shiny_cog.dds"
		end, 
		[C.ACTION_TYPE_TRAVEL_TO_HOUSE] = function(_, _, actionValue)
			local icon
			if actionValue == C.ACTION_VALUE_PRIMARY_HOUSE_ID then
				icon = "EsoUI/Art/Worldmap/map_indexicon_housing_up.dds"
			else
				icon = GetCollectibleIcon(GetCollectibleIdForHouse(actionValue))
			end
			return icon
		end, 
		[C.ACTION_TYPE_PIE_MENU] = function(_, _, actionValue)
			local icon
			if CSPM.util.IsUserPieMenu(actionValue) then
				icon = "EsoUI/Art/Icons/crafting_tart_006.dds"
			else
				icon = (select(3, CSPM.util.GetPieMenuInfo(actionValue))) or "EsoUI/Art/Icons/crafting_tart_006.dds"
			end
			return icon
		end, 
		[C.ACTION_TYPE_SHORTCUT] = function(_, _, actionValue)
			return (select(3, CSPM.util.GetShortcutInfo(actionValue))) or "EsoUI/Art/Icons/crafting_dwemer_shiny_gear.dds"	-- actionValue: shortcutData or shortcutId
		end, 
	}
	setmetatable(GetDefaultSlotIcon, { __index = function(self, key) return rawget(self, C.ACTION_TYPE_NOTHING) end, })

	function CSPM.util.GetDefaultSlotIcon(actionType, categoryId, actionValue)
		local actionType = GetActionType(actionType)
		local categoryId = GetValue(categoryId)
		local actionValue = GetValue(actionValue)
		return GetDefaultSlotIcon[actionType](actionType, categoryId, actionValue)
	end
end

do
	local FULL_WIDTH = true
	function CSPM.util.GetSlotActionTooltip()
		return ItemTooltip
	end

	local function LayoutBasicSlotActionTooltip(tooltip, title, body, icon, leftSideHeader, rightSideHeader)
		InitializeTooltip(tooltip)
		local r, g, b = ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB()
		if icon then
			ZO_ItemIconTooltip_OnAddGameData(tooltip, TOOLTIP_GAME_DATA_ITEM_ICON, GetValue(icon))
		end
		if leftSideHeader and leftSideHeader ~= "" then
			tooltip:AddHeaderLine(GetValue(leftSideHeader), "ZoFontWinH5", 1, TOOLTIP_HEADER_SIDE_LEFT, r, g, b)
		end
		if rightSideHeader and rightSideHeader ~= "" then
			tooltip:AddHeaderLine(GetValue(rightSideHeader), "ZoFontWinH5", 1, TOOLTIP_HEADER_SIDE_RIGHT, r, g, b)
		end
		if not leftSideHeader and not rightSideHeader then
			tooltip:AddVerticalPadding(18)
		end
		r, g, b = ZO_SELECTED_TEXT:UnpackRGB()
		if title and title ~= "" then
			tooltip:AddLine(GetValue(title), "ZoFontWinH2", r, g, b, TOPLEFT, MODIFY_TEXT_TYPE_UPPERCASE, TEXT_ALIGN_CENTER, FULL_WIDTH)
			ZO_Tooltip_AddDivider(tooltip)
		end
		if body and body ~= "" then
			tooltip:AddLine(GetValue(body), "ZoFontGameMedium", ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())
		end
	end

	local LayoutSlotActionTooltip = {		-- you cannot use 'self' within this block.
		[C.ACTION_TYPE_NOTHING] = function(actionType, categoryId, actionValue, uiActionId)
			ClearTooltip(ItemTooltip)
			return false
		end, 
		[C.ACTION_TYPE_COLLECTIBLE] = function(actionType, _, actionValue)
			local name, description, icon, _, _, _, isActive, collectibleCategoryType = GetCollectibleInfo(actionValue)
			if name ~= "" then
				name = zo_strformat(L(SI_CSPM_COMMON_FORMATTER), name)
				LayoutBasicSlotActionTooltip(ItemTooltip, name, description, icon, L("SI_COLLECTIBLECATEGORYTYPE", collectibleCategoryType), isActive and "Active" or "Inactive")
				ItemTooltip:AddLine(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", actionType), name), "ZoFontWinH4", ZO_SELECTED_TEXT:UnpackRGB())
				if collectibleCategoryType == COLLECTIBLE_CATEGORY_TYPE_PERSONALITY then
					local overridenEmoteNames = { GetCollectiblePersonalityOverridenEmoteDisplayNames(actionValue) }
					local overridenEmoteSlashCommands = { GetCollectiblePersonalityOverridenEmoteSlashCommandNames(actionValue) }
					if #overridenEmoteSlashCommands > 0 then
						ItemTooltip:AddLine(zo_strformat(SI_COLLECTIBLE_TOOLTIP_PERSONALITY_OVERRIDES_DISPLAY_NAMES_FORMATTER, ZO_GenerateCommaSeparatedList(overridenEmoteSlashCommands), #overridenEmoteSlashCommands), "ZoFontWinH5", ZO_PERSONALITY_EMOTES_COLOR:UnpackRGB())
					end
				end
				return true
			else
				return false
			end
		end, 
		[C.ACTION_TYPE_EMOTE] = function(actionType, categoryId, actionValue)
			local emoteItemInfo = PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(actionValue)
			if emoteItemInfo then
				local name = zo_strformat(L(SI_CSPM_COMMON_FORMATTER), emoteItemInfo.displayName)
				local emoteCollectibleId = GetEmoteCollectibleId(emoteItemInfo.emoteIndex)
				if emoteCollectibleId then
					local _, description, icon, _, _, _, _, collectibleCategoryType = GetCollectibleInfo(emoteCollectibleId)
					LayoutBasicSlotActionTooltip(ItemTooltip, name, description, icon, L("SI_COLLECTIBLECATEGORYTYPE", collectibleCategoryType))
				else
					LayoutBasicSlotActionTooltip(ItemTooltip, name, nil, LUT.CategoryId_To_Icon[categoryId] or LUT.CategoryId_To_Icon[C.CATEGORY_NOTHING], L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_EMOTE))
				end
				ItemTooltip:AddLine(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", actionType), emoteItemInfo.emoteSlashName), "ZoFontWinH4", ZO_SELECTED_TEXT:UnpackRGB())
				return true
			else
				return false
			end
		end, 
		[C.ACTION_TYPE_CHAT_COMMAND] = function(actionType, categoryId, actionValue)
			local name = CSPM.util.GetDefaultSlotName(actionType, categoryId, actionValue)
			local icon = CSPM.util.GetDefaultSlotIcon(actionType, categoryId, actionValue)
			LayoutBasicSlotActionTooltip(ItemTooltip, name, nil, icon, L(SI_CSPM_COMMON_CHAT_COMMAND))
			ItemTooltip:AddLine(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", actionType), name), "ZoFontWinH4", ZO_SELECTED_TEXT:UnpackRGB())
			return true
		end, 
		[C.ACTION_TYPE_TRAVEL_TO_HOUSE] = function(actionType, categoryId, actionValue)
			local name = CSPM.util.GetDefaultSlotName(actionType, categoryId, actionValue)
			local icon = CSPM.util.GetDefaultSlotIcon(actionType, categoryId, actionValue)
			local houseCollectibleId, description
			if actionValue == C.ACTION_VALUE_PRIMARY_HOUSE_ID then
				houseCollectibleId = GetHousingPrimaryHouse()
				_, description = GetHelpInfo(GetHelpIndicesFromHelpLink("|H1:help:278|h|h"))	-- Tutorial: Housing - Permissions
			else
				if actionValue == 0 then return false end
				houseCollectibleId = GetCollectibleIdForHouse(actionValue)
				description = GetCollectibleDescription(houseCollectibleId)
			end
			LayoutBasicSlotActionTooltip(ItemTooltip, name, description, icon, L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_HOUSE))
			ItemTooltip:AddLine(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", actionType), name), "ZoFontWinH4", ZO_SELECTED_TEXT:UnpackRGB())
--			ItemTooltip:AddLine(zo_strformat(L(SI_HOUSING_BOOK_HOUSE_TYPE_FORMATTER), L("SI_HOUSECATEGORYTYPE", GetHouseCategoryType(actionValue))), "ZoFontWinH5", ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())
			ItemTooltip:AddLine(zo_strformat(L(SI_HOUSING_BOOK_LOCATION_FORMATTER), GetZoneNameById(GetHouseFoundInZoneId(actionValue))), "ZoFontWinH5", ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())
			return true
		end, 
		[C.ACTION_TYPE_PIE_MENU] = function(actionType, categoryId, actionValue, uiActionId)
			if not CSPM.util.DoesPieMenuDataExist(actionValue) then return false end
			local name = CSPM.util.GetDefaultSlotName(actionType, categoryId, actionValue)
			local tooltipTitle = name
			local pieMenuName, description, icon = CSPM.util.GetPieMenuInfo(actionValue)
			if CSPM.util.IsUserPieMenu(actionValue) and pieMenuName and pieMenuName ~= "" then
				tooltipTitle = zo_strformat(L(SI_CSPM_PRESET_NAME_FORMATTER), actionValue, pieMenuName)
			end
			LayoutBasicSlotActionTooltip(ItemTooltip, tooltipTitle, description, icon or CSPM.util.GetDefaultSlotIcon(actionType, categoryId, actionValue), L(SI_CSPM_COMMON_PIE_MENU))
			if uiActionId ~= C.UI_NONE then
				ItemTooltip:AddLine(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", actionType), name), "ZoFontWinH4", ZO_SELECTED_TEXT:UnpackRGB())
			end
			return true
		end, 
		[C.ACTION_TYPE_SHORTCUT] = function(actionType, categoryId, actionValue)
			local name, description, icon = CSPM.util.GetShortcutInfo(actionValue)	-- actionValue: shortcutData or shortcutId
			if not name or name == "" then return false end
			LayoutBasicSlotActionTooltip(ItemTooltip, name, description, icon or CSPM.util.GetDefaultSlotIcon(actionType, categoryId, actionValue), L(SI_CSPM_COMMON_SHORTCUT))
			ItemTooltip:AddLine(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", actionType), name), "ZoFontWinH4", ZO_SELECTED_TEXT:UnpackRGB())
			return true
		end, 
	}
	setmetatable(LayoutSlotActionTooltip, { __index = function(self, key) return rawget(self, C.ACTION_TYPE_NOTHING) end, })

	function CSPM.util.LayoutSlotActionTooltip(actionType, categoryId, actionValue, uiActionId)
		local actionType = GetActionType(actionType)
		local categoryId = GetValue(categoryId)
		local actionValue = GetValue(actionValue)
		return LayoutSlotActionTooltip[actionType](actionType, categoryId, actionValue, uiActionId)
	end

	function CSPM.util.ShowSlotActionTooltip(owner, point, offsetX, offsetY, relativePoint)
		CSPM.util.GetSlotActionTooltip():SetOwner(owner, point, offsetX, offsetY, relativePoint)
		CSPM.util.GetSlotActionTooltip():GetOwningWindow():BringWindowToTop()
	end

	function CSPM.util.HideSlotActionTooltip()
	    ClearTooltip(CSPM.util.GetSlotActionTooltip())
	end
end


-- ---------------------------------------------------------------------------------------
-- Shortcut Manager Class
-- ---------------------------------------------------------------------------------------
local CSPM_ShortcutManager_Singleton = ZO_InitializingObject:Subclass()
function CSPM_ShortcutManager_Singleton:Initialize()
	self.name = "CSPM_ShortcutManager"
	self.shortcutList = {}
	self.externalShortcutCategory = {}
	self.externalShortcutCategoryList = {}
	self:RegisterInternalShortcuts()
end

function CSPM_ShortcutManager_Singleton:RegisterInternalShortcuts()
	self.shortcutList["!CSPM_invalid_slot"] = {
		name = L(SI_QUICKSLOTS_EMPTY), 
		icon = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", 
		callback = function() return end, 
		category = C.CATEGORY_NOTHING, 
		showSlotLabel = false, 
	}
	self.shortcutList["!CSPM_invalid_slot_thus_open_piemenu_editor"] = {
		name = L(SI_QUICKSLOTS_EMPTY), 
		icon = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", 
		callback = function(data)
			local activePresetId = CShortcutPieMenu:GetActivePresetId()
			if CSPM.util.IsUserPieMenu(activePresetId) then
				CShortcutPieMenu:OpenPieMenuEditorPanel(activePresetId, data.index)
			end
			return
		end, 
		category = C.CATEGORY_NOTHING, 
		showSlotLabel = false, 
		activeStatusIcon = function()
			local selectionButton = IsInGamepadPreferredMode() and LUT.UI_Icon.GAMEPAD_1 or LUT.UI_Icon.MOUSE_LMB
			return { selectionButton, selectionButton, }
		end, 
	}
	self.shortcutList["!CSPM_cancel_slot"] = {
		name = L(SI_RADIAL_MENU_CANCEL_BUTTON), 
		icon = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", 
		callback = function() return end, 
		category = C.CATEGORY_NOTHING, 
		showSlotLabel = false, 
	}
	self.shortcutList["!CSPM_open_piemenu_editor"] = {
		name = zo_strformat(L("SI_CSPM_COMMON_UI_ACTION", C.UI_OPEN), "PieMenu Editor"), 
		tooltip = L(SI_CSPM_UI_PANEL_HEADER2_TEXT), 
		icon = "EsoUI/Art/Icons/crafting_dwemer_shiny_gear.dds", 
		callback = function() CShortcutPieMenu:OpenPieMenuEditorPanel() end, 
		category = C.CATEGORY_S_PIE_MENU_ADDON, 
	}
	self.shortcutList["!CSPM_open_piemenu_manager"] = {
		name = zo_strformat(L("SI_CSPM_COMMON_UI_ACTION", C.UI_OPEN), "PieMenu Manager"), 
		tooltip = L(SI_CSPM_UI_PANEL_HEADER3_TEXT), 
		icon = "EsoUI/Art/Icons/crafting_dwemer_shiny_gear.dds", 
		callback = function() CShortcutPieMenu:OpenPieMenuManagerPanel() end, 
		category = C.CATEGORY_S_PIE_MENU_ADDON, 
	}
	self.shortcutList["!CSPM_reloadui"] = {
		name = L(SI_ADDON_MANAGER_RELOAD), 
		tooltip = L(SI_CSPM_SHORTCUT_RELOADUI_TIPS), 
		icon = "Esoui/Art/Loadscreen/Keyboard/load_ourosboros.dds", 
		resizeIconToFitFile = true, 
		callback = function()
			local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.NONE)
			messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
			messageParams:SetText(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", C.ACTION_TYPE_SHORTCUT), L(SI_ADDON_MANAGER_RELOAD)))
			CENTER_SCREEN_ANNOUNCE:DisplayMessage(messageParams)
			zo_callLater(function() ReloadUI("ingame") end, 1)
		end, 
		category = C.CATEGORY_S_SYSTEM_MENU, 
	}
	self.shortcutList["!CSPM_logout"] = {
		name = L(SI_DIALOG_TITLE_LOGOUT), 
		tooltip = L(SI_CSPM_SHORTCUT_LOGOUT_TIPS), 
		icon = "Esoui/Art/Menubar/Gamepad/gp_playermenu_icon_logout.dds", 
		callback = function()
			local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.NONE)
			messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
			messageParams:SetText(zo_strformat(L("SI_CSPM_SLOT_ACTION_TOOLTIP", C.ACTION_TYPE_SHORTCUT), L(SI_DIALOG_TITLE_LOGOUT)))
			CENTER_SCREEN_ANNOUNCE:DisplayMessage(messageParams)
			Logout()
		end, 
		category = C.CATEGORY_S_SYSTEM_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_inventory"] = {
		name = L(SI_MAIN_MENU_INVENTORY), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_INVENTORY)), 
		icon = "EsoUI/Art/MainMenu/menuBar_inventory_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_inventory_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_INVENTORY) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_character"] = {
		name = L(SI_MAIN_MENU_CHARACTER), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_CHARACTER)), 
		icon = "EsoUI/Art/MainMenu/menuBar_character_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_character_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_CHARACTER) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_skill"] = {
		name = L(SI_MAIN_MENU_SKILLS), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_SKILLS)), 
		icon = "EsoUI/Art/MainMenu/menuBar_skills_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_skills_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_SKILLS) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_champion"] = {
		name = L(SI_MAIN_MENU_CHAMPION), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_CHAMPION)), 
		icon = "EsoUI/Art/MainMenu/menuBar_champion_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_champion_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_CHAMPION) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_journal"] = {
		name = L(SI_MAIN_MENU_JOURNAL), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_JOURNAL)), 
		icon = "EsoUI/Art/MainMenu/menuBar_journal_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_journal_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_JOURNAL) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_collections"] = {
		name = L(SI_MAIN_MENU_COLLECTIONS), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_COLLECTIONS)), 
		icon = "EsoUI/Art/MainMenu/menuBar_collections_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_collections_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_COLLECTIONS) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_map"] = {
		name = L(SI_MAIN_MENU_MAP), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_MAP)), 
		icon = "EsoUI/Art/MainMenu/menuBar_map_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_map_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_MAP) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_group"] = {
		name = L(SI_MAIN_MENU_GROUP), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_GROUP)), 
		icon = "EsoUI/Art/MainMenu/menuBar_group_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_group_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_GROUP) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_friends"] = {
		name = L(SI_MAIN_MENU_CONTACTS), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_CONTACTS)), 
		icon = "EsoUI/Art/MainMenu/menuBar_social_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_social_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_CONTACTS) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_guilds"] = {
		name = L(SI_MAIN_MENU_GUILDS), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_GUILDS)), 
		icon = "EsoUI/Art/MainMenu/menuBar_guilds_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_guilds_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_GUILDS) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_alliance_war"] = {
		name = L(SI_MAIN_MENU_ALLIANCE_WAR), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_ALLIANCE_WAR)), 
		icon = "EsoUI/Art/MainMenu/menuBar_ava_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_ava_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_ALLIANCE_WAR) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_mail"] = {
		name = L(SI_MAIN_MENU_MAIL), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_MAIL)), 
		icon = "EsoUI/Art/MainMenu/menuBar_mail_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_mail_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_MAIL) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_notifications"] = {
		name = L(SI_MAIN_MENU_NOTIFICATIONS), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_NOTIFICATIONS)), 
		icon = "EsoUI/Art/MainMenu/menuBar_notifications_up.dds", 
		activeIcon = "EsoUI/Art/MainMenu/menuBar_notifications_down.dds", 
		callback = function() SYSTEMS:GetObject("mainMenu"):ToggleCategory(MENU_CATEGORY_NOTIFICATIONS) end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
	self.shortcutList["!CSPM_mainmenu_help"] = {
		name = L(SI_MAIN_MENU_HELP), 
		tooltip = zo_strformat(L(SI_CSPM_SHORTCUT_MAIN_MENU_ITEMS_TIPS), L(SI_MAIN_MENU_HELP)), 
		icon = "EsoUI/Art/MenuBar/menuBar_help_up.dds", 
		activeIcon = "EsoUI/Art/MenuBar/menuBar_help_down.dds", 
		callback = function() HELP_MANAGER:ToggleHelp() end, 
		category = C.CATEGORY_S_MAIN_MENU, 
	}
end

function CSPM_ShortcutManager_Singleton:IsExternalShortcutCategory(categoryId)
	return type(categoryId) == "string" and self.externalShortcutCategory[categoryId]
end

function CSPM_ShortcutManager_Singleton:GetShortcutData(shortcutId)
	return self.shortcutList[shortcutId]
end

function CSPM_ShortcutManager_Singleton:GetShortcutInfo(shortcutDataOrId)
	local shortcutData = type(shortcutDataOrId) == "table" and shortcutDataOrId or self:GetShortcutData(shortcutDataOrId) or {}
	return CSPM.util.GetValue(shortcutData.name), CSPM.util.GetValue(shortcutData.tooltip), CSPM.util.GetValue(shortcutData.icon), shortcutData.callback, CSPM.util.GetValue(shortcutData.nameColor)
end

function CSPM_ShortcutManager_Singleton:EncodeMenuEntry(shortcutDataOrId, desiredIndex)
	local shortcutData = type(shortcutDataOrId) == "table" and shortcutDataOrId or self:GetShortcutData(shortcutDataOrId) or {}
	local data = {
		index = desiredIndex or shortcutData.index or 1, 
		showIconFrame = GetValue(shortcutData.showIconFrame), 
		showSlotLabel = GetValue(shortcutData.showSlotLabel), 
		showGlow = GetValue(shortcutData.showGlow), 
		itemCount = GetValue(shortcutData.itemCount), 
		name = GetValue(shortcutData.name) or "", 
		nameColor = GetValue(shortcutData.nameColor), 
		tooltip = GetValue(shortcutData.tooltip), 
		icon = GetValue(shortcutData.icon) or "EsoUI/Art/Icons/crafting_dwemer_shiny_gear.dds", 
		iconAttributes = GetValue(shortcutData.iconAttributes), 
		resizeIconToFitFile = GetValue(shortcutData.resizeIconToFitFile), 
		callback = shortcutData.callback or function() end, 
		statusIcon = GetValue(shortcutData.statusIcon), 
		activeStatusIcon = GetValue(shortcutData.activeStatusIcon), 
		cooldownRemaining = GetValue(shortcutData.cooldownRemaining), 
		cooldownDuration = GetValue(shortcutData.cooldownDuration), 
		disabled = GetValue(shortcutData.disabled), 
		slotData = {}, 
		category = shortcutData.category, 
	}
	data.activeIcon = GetValue(shortcutData.activeIcon) or data.icon
	if data.disabled == true then
		data.nameColor = LUT.UI_Color.BLOCKED	-- red color-coded
		data.activeIcon = data.icon					-- not using activeIcon
	end
	return data
end

function CSPM_ShortcutManager_Singleton:GetShortcutCategoryList()
	return self.externalShortcutCategoryList
end

function CSPM_ShortcutManager_Singleton:GetShortcutListByCategory(categoryId)
	local list = {}
	for k, v in pairs(self.shortcutList) do
		if v.category == categoryId then
			list[#list + 1] = k
		end
	end
	return list
end

function CSPM_ShortcutManager_Singleton:RegisterExternalShortcutData(shortcutId, shortcutData)
	if type(shortcutId) ~= "string" or zo_strsub(shortcutId, 1, 1) == "!" or type(shortcutData) ~= "table" then return false end
	if self.shortcutList[shortcutId] then return false end
	local categoryId = GetValue(shortcutData.category)
	if type(categoryId) == "number" then return false end

	self.shortcutList[shortcutId] = shortcutData
	if categoryId then
		if not self.externalShortcutCategory[categoryId] then
			self.externalShortcutCategory[categoryId] = true
			table.insert(self.externalShortcutCategoryList, categoryId)
		end
	else
		self.shortcutList[shortcutId].category = C.CATEGORY_NOTHING
	end
	CSPM.LDL:Debug("ExternalShortcutRegistered : %s (%s)", shortcutId, self.shortcutList[shortcutId].category)
	CALLBACK_MANAGER:FireCallbacks("CSPM-ShortcutRegistered", shortcutId, self.shortcutList[shortcutId].category)
	return true
end

local CSPM_ShortcutManager = CSPM_ShortcutManager_Singleton:New()	-- Never do this more than once!

-- global API --
local GetShortcutManager = function() return CSPM_ShortcutManager end
CSPM.util.GetShortcutData = function(shortcutId) return CSPM_ShortcutManager:GetShortcutData(shortcutId) end
CSPM.util.GetShortcutInfo = function(shortcutDataOrId) return CSPM_ShortcutManager:GetShortcutInfo(shortcutDataOrId) end


-- ---------------------------------------------------------------------------------------
-- Pie Menu Data Manager Class
-- ---------------------------------------------------------------------------------------
local CSPM_PieMenuDataManager_Singleton = ZO_InitializingObject:Subclass()
function CSPM_PieMenuDataManager_Singleton:Initialize()
	self.name = "CSPM_PieMenuDataManager"
	self.pieMenuList = {}
	self.userPieMenuList = {}
	self.isUserPieMenuAvailable = false

	self:RegisterInternalPieMenus()
end

function CSPM_PieMenuDataManager_Singleton:RegisterUserPieMenuPresets(userPieMenuPresetTable)
	if type(userPieMenuPresetTable) == "table" then
		self.userPieMenuList = userPieMenuPresetTable
		self.isUserPieMenuAvailable  = true
	end
end

function CSPM_PieMenuDataManager_Singleton:RegisterInternalPieMenus()
	self.pieMenuList["!CSPM_mainmenu"] = {
		id = "!CSPM_mainmenu", 
		name = L(SI_CSPM_COMMON_MAIN_MENU), 
		menuItemsCount = 13, 
		tooltip = table.concat({ L(SI_CSPM_PIE_MAIN_MENU_TIPS1), "\n\n", L(SI_CSPM_PIE_MAIN_MENU_TIPS2), }), 
		icon = "EsoUI/Art/Menubar/menubar_mainmenu_down.dds", 
		visual = {
			showIconFrame = true, 
			showSlotLabel = true, 
			showPresetName = true, 
			style = "gamepad", 
			size = 500, 
		}, 
		slot = {
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_notifications", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_mail", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_alliance_war", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_guilds", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_friends", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_group", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_map", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_collections", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_journal", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_champion", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_skill", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_character", 
			}, 
			{
				type = "shortcut", 
				value = "!CSPM_mainmenu_inventory", 
			}, 
		}, 
		hidden = false, 
	}
end

function CSPM_PieMenuDataManager_Singleton:IsUserPieMenu(presetId)
	return type(presetId) == "number"
end

function CSPM_PieMenuDataManager_Singleton:IsExternalPieMenu(presetId)
	return type(presetId) == "string"
end

function CSPM_PieMenuDataManager_Singleton:DoesPieMenuDataExist(presetId)
	return self.pieMenuList[presetId] ~= nil or self.userPieMenuList[presetId] ~= nil
end

function CSPM_PieMenuDataManager_Singleton:GetPieMenuData(presetId)
	return self:IsUserPieMenu(presetId) and self.userPieMenuList[presetId] or self.pieMenuList[presetId]
end

function CSPM_PieMenuDataManager_Singleton:GetPieMenuInfo(pieMenuDataOrPresetId)
	local pieMenuData = type(pieMenuDataOrPresetId) == "table" and pieMenuDataOrPresetId or self:GetPieMenuData(pieMenuDataOrPresetId) or {}
	return CSPM.util.GetValue(pieMenuData.name), CSPM.util.GetValue(pieMenuData.tooltip), CSPM.util.GetValue(pieMenuData.icon)
end

--[[
function CSPM_PieMenuDataManager_Singleton:GetUserPieMenuList()
	local idList = {}
	for presetId, _ in pairs(self.userPieMenuList) do
		if self:IsUserPieMenu(presetId) then
			table.insert(idList, presetId)
		end
	end
	return list
end
]]

function CSPM_PieMenuDataManager_Singleton:GetExternalPieMenuPresetIdList()
	local idList = {}
	for presetId, pieMenuData in pairs(self.pieMenuList) do
		if self:IsExternalPieMenu(presetId) and not pieMenuData.hidden then
			table.insert(idList, presetId)
		end
	end
	return idList
end

function CSPM_PieMenuDataManager_Singleton:RegisterInternalPieMenu(presetId, pieMenuData)
	if type(presetId) ~= "string" or type(pieMenuData) ~= "table" then return false end
	if self.pieMenuList[presetId] then return false end
	self.pieMenuList[presetId] = pieMenuData
	CALLBACK_MANAGER:FireCallbacks("CSPM-PieMenuRegistered", presetId)
	return true
end

function CSPM_PieMenuDataManager_Singleton:RegisterExternalPieMenu(presetId, pieMenuData)
	if not self:IsExternalPieMenu(presetId) or zo_strsub(presetId, 1, 1) == "!" or type(pieMenuData) ~= "table" then return false end
	if self.pieMenuList[presetId] then return false end
	self.pieMenuList[presetId] = pieMenuData
	CALLBACK_MANAGER:FireCallbacks("CSPM-PieMenuRegistered", presetId)
	return true
end

local CSPM_PieMenuDataManager = CSPM_PieMenuDataManager_Singleton:New()	-- Never do this more than once!

-- global API --
local GetPieMenuDataManager = function() return CSPM_PieMenuDataManager end
CSPM.util.IsUserPieMenu = function(presetId) return CSPM_PieMenuDataManager:IsUserPieMenu(presetId) end
CSPM.util.IsExternalPieMenu = function(presetId) return CSPM_PieMenuDataManager:IsExternalPieMenu(presetId) end
CSPM.util.DoesPieMenuDataExist = function(presetId) return CSPM_PieMenuDataManager:DoesPieMenuDataExist(presetId) end
CSPM.util.GetPieMenuData = function(presetId) return CSPM_PieMenuDataManager:GetPieMenuData(presetId) end
CSPM.util.GetPieMenuInfo = function(pieMenuDataOrPresetId) return CSPM_PieMenuDataManager:GetPieMenuInfo(pieMenuDataOrPresetId) end


-- ---------------------------------------------------------------------------------------
-- CShortcutPieMenu
-- ---------------------------------------------------------------------------------------
function CSPM:Initialize()
	self:ConfigDebug()
	self.lang = GetCVar("Language.2")
	self.isGamepad = IsInGamepadPreferredMode()

	-- PieMenuEditor Config (AccountWide / User-customizable PieMenu Preset)
	self.db = ZO_SavedVars:NewAccountWide(self.savedVarsPieMenuEditor, 1, nil, CSPM_DB_DEFAULT)
	self:ValidateConfigDataDB()

	-- PieMenuManager Config (Preset Allocation)
	self.svCurrent = {}
	self.svAccount = ZO_SavedVars:NewAccountWide(self.savedVarsPieMenuManager, 1, nil, CSPM_SV_DEFAULT, GetWorldName())
	self:ValidateConfigDataSV(self.svAccount)
	if self.svAccount.accountWide then
		self.svCurrent = self.svAccount
	else
		self.svCharacter = ZO_SavedVars:NewCharacterIdSettings(self.savedVarsPieMenuManager, 1, nil, CSPM_SV_DEFAULT, GetWorldName())
		self:ValidateConfigDataSV(self.svCharacter)
		self.svCurrent = self.svCharacter
	end

	-- Data Management
	self.shortcutManager = GetShortcutManager()
	self.pieMenuDataManager = GetPieMenuDataManager()
	self.pieMenuDataManager:RegisterUserPieMenuPresets(self.db.preset)

	-- UI Section
	self.activePresetId = 0
	self.topmostPieMenu = nil
	self.rootMenu = CSPM.class.PieMenuController:New(CSPM_UI_Root_Pie, "CSPM_SelectableItemRadialMenuEntryTemplate", "CSPM_RadialMenuAnimation", "SelectableItemRadialMenuEntryAnimation", self.svCurrent.menuAttributes)
	self.rootMenu:SetOnSelectionChangedCallback(function(...) self:OnSelectionChangedCallback(...) end)
	self.rootMenu:SetPopulateMenuCallback(function(...) self:PopulateMenuCallback(...) end)
	self:RegisterInteraction(self.rootMenu)

	self.menuEditorPanel = CSPM.class.PieMenuEditorPanel:New(self.shared, self.db, self.db, CSPM_DB_DEFAULT)
	self.menuManagerPanel = CSPM.class.PieMenuManagerPanel:New(self.shared, self.svCurrent, self.svAccount, CSPM_SV_DEFAULT)

	-- Events
	self:RegisterEvents()

	-- Bindings
	self:InitializeKeybinds()

	-- Interaction
	self.holdDownInteractionKey = false
	self.requestedPresetId = 0

	self.LDL:Debug("Initialized")
end

function CSPM:ConfigDebug(arg)
	local debugMode = false
	local key = HashString(GetDisplayName())
	local dummy = function() end
	if LibDebugLogger then
		for _, v in pairs(arg or self.authority or {}) do
			if key == v then debugMode = true end
		end
	end
	if debugMode then
		self.LDL = LibDebugLogger(self.name)
	else
		self.LDL = { Verbose = dummy, Debug = dummy, Info = dummy, Warn = dummy, Error = dummy, }
	end
	if self.shared then
		self.shared.LDL = self.LDL
	end
end

function CSPM:ValidateConfigDataDB()
	for k, v in pairs(self.db.preset) do
		if v.id == nil								then v.id = k 														end
		if v.name == nil							then v.name = ""													end
		if v.menuItemsCount == nil					then v.menuItemsCount = C.MENU_ITEMS_COUNT_DEFAULT					end
		if v.visual == nil							then v.visual = {}													end
		if v.visual.showIconFrame == nil			then v.visual.showIconFrame			= CSPM_DB_DEFAULT.preset[1].visual.showIconFrame			end
		if v.visual.showSlotLabel == nil			then v.visual.showSlotLabel			= CSPM_DB_DEFAULT.preset[1].visual.showSlotLabel			end
		if v.visual.showPresetName == nil			then v.visual.showPresetName		= CSPM_DB_DEFAULT.preset[1].visual.showPresetName			end
		if v.visual.style == nil					then v.visual.style					= CSPM_DB_DEFAULT.preset[1].visual.style					end
		if v.visual.size == nil						then v.visual.size					= CSPM_DB_DEFAULT.preset[1].visual.size						end
		if v.slot == nil							then v.slot = ZO_ShallowTableCopy(CSPM_DB_DEFAULT.prest[1].slot)	end

		-- migrate to the new format	(Ver.0.10.2)
		if v.visual.showTrackGamepad ~= nil			then v.visual.style 				= (v.visual.showTrackGamepad == true) and "gamepad" or "quickslot"		v.visual.showTrackGamepad = nil		v.visual.showTrackQuickslot = nil		end
	end
end

function CSPM:ValidateConfigDataSV(sv)
	if sv.accountWide == nil						then sv.accountWide						= CSPM_SV_DEFAULT.accountWide 								end
	if sv.menuAttributes == nil						then sv.menuAttributes					= ZO_ShallowTableCopy(CSPM_SV_DEFAULT.menuAttributes)		end
	for i = 1, #CSPM_SV_DEFAULT.keybinds do
		if sv.keybinds[i] == nil					then sv.keybinds[i]						= CSPM_SV_DEFAULT.keybinds[i]								end
	end

	-- migrate to the new format	(Ver.0.10.2)
	if sv.allowActivateInUIMode ~= nil				then sv.menuAttributes.allowActivateInUIMode			= sv.allowActivateInUIMode				sv.allowActivateInUIMode = nil			 end
	if sv.allowClickable ~= nil						then sv.menuAttributes.allowClickable 					= sv.allowClickable						sv.allowClickable = nil					 end
	if sv.centeringAtMouseCursor ~= nil				then sv.menuAttributes.centeringAtMouseCursor		 	= sv.centeringAtMouseCursor				sv.centeringAtMouseCursor = nil			 end
	if sv.timeToHoldKey ~= nil						then sv.menuAttributes.timeToHoldKey 					= sv.timeToHoldKey						sv.timeToHoldKey = nil					 end
	if sv.mouseDeltaScaleFactorInUIMode ~= nil		then sv.menuAttributes.mouseDeltaScaleFactorInUIMode	= sv.mouseDeltaScaleFactorInUIMode		sv.mouseDeltaScaleFactorInUIMode = nil	 end
end

function CSPM:RegisterEvents()
	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_ACTIVATED, function(event, initial)
		EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_PLAYER_ACTIVATED)		-- Only after the first login/reloadUI.
	
		-- UI setting panel initialization
		self.menuEditorPanel:CreateOptionsPanel()
		self.menuManagerPanel:CreateOptionsPanel()
	end)
end

function CSPM:CopyKeybinds(sourceActionName, destActionName)
	local layer, category, action = GetActionIndicesFromName(destActionName)
	if layer and category and action then
		if IsProtectedFunction("UnbindAllKeysFromAction") then
			CallSecureProtected("UnbindAllKeysFromAction", layer, category, action)
		else
			UnbindAllKeysFromAction(layer, category, action)
		end
	else
		return
	end
	layer, category, action = GetActionIndicesFromName(sourceActionName)
	if layer and category and action then
		for i = 1, GetMaxBindingsPerAction() do
			local key, mod1, mod2, mod3, mod4 = GetActionBindingInfo(layer, category, action, i)
			CreateDefaultActionBind(destActionName, key, mod1, mod2, mod3, mod4)
		end
	else
		return
	end
	if self.keybinds then
		self.keybinds[sourceActionName] = destActionName
	end
	return true
end

function CSPM:InitializeKeybinds()
	self.keybinds = self.keybinds or {}
	for destActionName, sourceActionName in pairs(LUT.ActionNameAlias) do
		self:CopyKeybinds(sourceActionName, destActionName)
	end
	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_KEYBINDING_CLEARED, function(event, layerIndex, categoryIndex, actionIndex, bindingIndex)
		local actionName = GetActionInfo(layerIndex, categoryIndex, actionIndex)
		if self.keybinds[actionName] then
			self:CopyKeybinds(actionName, self.keybinds[actionName])	-- Rebuild due to setting changes
		end
	end)
	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_KEYBINDING_SET, function(event, layerIndex, categoryIndex, actionIndex, bindingIndex)
		local actionName = GetActionInfo(layerIndex, categoryIndex, actionIndex)
		if self.keybinds[actionName] then
			self:CopyKeybinds(actionName, self.keybinds[actionName])	-- Rebuild due to setting changes
		end
	end)
end

function CSPM:RegisterInteraction(pieMenu)
	if not pieMenu then return end
	local pieMenuHoldInteraction = {
		type = "hold", 
		enabled = function()
			return not pieMenu:IsInteracting() and pieMenu:PrepareForInteraction()
		end, 
		multipleInput = true, 
		holdTime = function() return self.svCurrent.menuAttributes.timeToHoldKey end, 
		startedCallback = function(interaction, presetId)
			self.holdDownInteractionKey = true
			self.requestedPresetId = presetId
		end, 
		endedCallback = function(interaction, clearSelection)
			if interaction.isPerformed then
				pieMenu:StopInteraction(clearSelection)
				self:ClearActivePresetId()
				self:SetTopmostPieMenu(nil)
			end
			self.holdDownInteractionKey = false
			self.requestedPresetId = 0
		end, 
		performedCallback = function(interaction)
			if not pieMenu:IsInteracting() then
				self:SetActivePresetId(self.requestedPresetId)
				pieMenu:ShowMenu()
				self:SetTopmostPieMenu(pieMenu)
			end
		end, 
		canceledCallback = function()
			self.holdDownInteractionKey = false
			self.requestedPresetId = 0
		end, 
	}
	pieMenu.interactions = pieMenu.interactions or {}
	table.insert(pieMenu.interactions, LibCInteraction:RegisterInteraction(LUT.ActionNames, pieMenuHoldInteraction))

	pieMenu:RegisterBindings(KEY_GAMEPAD_BUTTON_1, function(menu) menu:SelectCurrentEntry() end)
	pieMenu:RegisterBindings(KEY_GAMEPAD_BUTTON_2, function(menu) menu:CancelInteraction() end)
	pieMenu:RegisterBindings(KEY_ESCAPE, function(menu) menu:ForceExitInteraction() end)
	pieMenu:RegisterBindings(KEY_MOUSE_LEFT, function(menu) menu:SelectCurrentEntry() end)
	pieMenu:RegisterBindings(KEY_MOUSE_RIGHT, function(menu) menu:CancelInteraction() end)
end

function CSPM:GetActivePresetId()
	return self.activePresetId
end

function CSPM:SetActivePresetId(presetId)
	self.activePresetId = presetId
end

function CSPM:ClearActivePresetId()
	self.activePresetId = 0
end

function CSPM:GetTopmostPieMenu()
	return self.topmostPieMenu
end

function CSPM:SetTopmostPieMenu(pieMenu)
	self.topmostPieMenu = pieMenu
end


function CSPM:OnSelectionChangedCallback(menu, slotIndex, data)
--	self.LDL:Debug("OnSelectionChangedCallback() : %s", slotIndex)
end

function CSPM:AddMenuEntry(pieMenu, name, inactiveIcon, activeIcon, callback, data)
	if pieMenu and pieMenu.AddMenuEntry then
		pieMenu:AddMenuEntry(name, inactiveIcon, activeIcon, callback, data)
	end
end

function CSPM:AddMenuEntryWithShortcut(pieMenu, shortcutId, visualData)
	-- pieMenu    : (required) CSPM_PieMenuController class object
	-- shortcutId : (required) registered shortcutId for Shortcut Manager
	-- visualData : (optional) nilable PieMenu visual data table to reference if not specified in shortcut data.
	--		visualData.showIconFrame : boolean - whether to show the icon frame texture.
	--		visualData.showSlotLabel : boolean - whether to show the slot display name label.
	local shortcutId = shortcutId or "!CSPM_invalid_slot"
	local shortcutData = CSPM.util.GetShortcutData(shortcutId) or CSPM.util.GetShortcutData("!CSPM_invalid_slot")
	if pieMenu and pieMenu.AddMenuEntry then
		local data = self.shortcutManager:EncodeMenuEntry(shortcutData, pieMenu:GetNumMenuEntries() + 1)
		-- fail safe
		if data.showIconFrame == nil then
			if visualData then
				data.showIconFrame = visualData.showIconFrame
			else
				data.showIconFrame = CSPM_DB_DEFAULT.preset[1].visual.showIconFrame
			end
		end
		if data.showSlotLabel == nil then
			if visualData then
				data.showSlotLabel = visualData.showSlotLabel
			else
				data.showSlotLabel = CSPM_DB_DEFAULT.preset[1].visual.showIconFrame
			end
		end
		data.slotData.type = data.slotData.type or C.ACTION_TYPE_SHORTCUT
		data.slotData.category = data.slotData.category or C.CATEGORY_NOTHING
		data.slotData.value = data.slotData.value or shortcutId

		local entryName = (data.nameColor and type(data.nameColor) == "table") and { data.name, { r = data.nameColor[1], g = data.nameColor[2], b = data.nameColor[3], }, } or data.name
		pieMenu:AddMenuEntry(entryName, data.icon, data.activeIcon, function() return self:OnSelectionExecutionCallback(data) end, data)
	end
end

function CSPM:PopulateMenuCallback(pieMenu)
--	self.LDL:Debug("PopulateMenuCallback()")
	local presetId = self:GetActivePresetId()
	local presetData = self.pieMenuDataManager:GetPieMenuData(presetId)
	if type(presetData) ~= "table" then return end

	local visualData = presetData.visual or {}
	pieMenu:SetupPieMenuPresetName(presetData.name, visualData.showPresetName)
	pieMenu:SetupPieMenuVisual(visualData.style, visualData.size)

	for i = 1, GetValue(presetData.menuItemsCount) do
		local actionType = C.ACTION_TYPE_NOTHING
		local cspmCategoryId = C.CATEGORY_NOTHING
		local actionValue = 0
		local data = {}
		local isValid = false
		if type(presetData.slot[i]) == "table" then
			actionType = GetActionType(presetData.slot[i].type)
			cspmCategoryId = GetValue(presetData.slot[i].category)
			actionValue = GetValue(presetData.slot[i].value) or 0
			if actionType == C.ACTION_TYPE_SHORTCUT then
				if type(actionValue) == "string" then
					data = self.shortcutManager:EncodeMenuEntry(actionValue, i)
				else
					data = self.shortcutManager:EncodeMenuEntry(presetData.slot[i], i)	-- for embedded shortcut data
				end
			else
				data = {
					index = i, 
					itemCount = nil, 
					statusIcon = nil, 
					activeStatusIcon = nil, 
				}
				data.name, data.nameColor = self.util.GetDefaultSlotName(actionType, cspmCategoryId, actionValue)
				data.icon = self.util.GetDefaultSlotIcon(actionType, cspmCategoryId, actionValue)
				data.activeIcon = data.icon
			end
			if data.showIconFrame == nil then
				data.showIconFrame = visualData.showIconFrame
			end
			if data.showSlotLabel == nil then
				data.showSlotLabel = visualData.showSlotLabel
			end
			isValid = data.name ~= ""
		end

		if actionType == C.ACTION_TYPE_COLLECTIBLE then
			if IsCollectibleActive(actionValue, GAMEPLAY_ACTOR_CATEGORY_PLAYER) then
				data.statusIcon = LUT.UI_Icon.CHECK
			elseif GetCollectibleUnlockStateById(actionValue) == COLLECTIBLE_UNLOCK_STATE_LOCKED or IsCollectibleBlocked(actionValue) then
				data.statusIcon = LUT.UI_Icon.BLOCKED
				data.iconAttributes = { iconDesaturation = 1, }
			end
			data.cooldownRemaining, data.cooldownDuration  = GetCollectibleCooldownAndDuration(actionValue)
		end
		if actionType == C.ACTION_TYPE_TRAVEL_TO_HOUSE and actionValue == C.ACTION_VALUE_PRIMARY_HOUSE_ID then
			-- override the display name and icon according to the current primary house setting.
			local primaryHouseId = GetHousingPrimaryHouse()
			if primaryHouseId ~= 0 then
				local primaryHouseName = zo_strformat(L(SI_HOUSING_BOOK_PRIMARY_RESIDENCE_FORMATTER), GetCollectibleName(GetCollectibleIdForHouse(primaryHouseId)))		-- "Primary Residence: |cffffff<<1>>|r"
				if cspmCategoryId == C.CATEGORY_H_UNLOCKED_HOUSE_INSIDE then
					data.name = zo_strformat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_INSIDE), primaryHouseName)		-- "<<1>> (inside)"
				elseif cspmCategoryId == C.CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE then
					data.name = zo_strformat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_OUTSIDE), primaryHouseName)	-- "<<1>> (outside)"
				end
				data.icon = GetCollectibleIcon(GetCollectibleIdForHouse(primaryHouseId))
				data.activeIcon = data.icon
			end
		end
		if actionType == C.ACTION_TYPE_PIE_MENU then
			local selectionButton = IsInGamepadPreferredMode() and LUT.UI_Icon.GAMEPAD_1 or LUT.UI_Icon.MOUSE_LMB
			data.activeStatusIcon = { selectionButton, selectionButton, }	-- for blinking icon
			-- override the display name of user pie menu according to its user defined preset name.
			local pieMenuName = self.util.GetPieMenuInfo(actionValue)
			if self.util.IsUserPieMenu(actionValue) and pieMenuName and pieMenuName ~= "" then
				data.name = zo_strformat(L(SI_CSPM_PRESET_NAME_FORMATTER), actionValue, pieMenuName)
			end
		end

		if isValid then
			if self.util.IsUserPieMenu(presetId) then
				data.slotData = presetData.slot[i] or {}
				-- override the display name, if slot name data exists
				local replacementName = GetValue(data.slotData.name)
				if type(replacementName) == "string" and replacementName ~= "" then
					data.name = replacementName
				end
				-- override the icon, if slot icon data exists
				local replacementIcon = GetValue(data.slotData.icon)
				if type(replacementIcon) == "string" and replacementIcon ~= "" then
					data.icon = replacementIcon
					data.activeIcon = replacementIcon
					data.resizeIconToFitFile = nil
				end
			end
			local entryName = (data.nameColor and type(data.nameColor) == "table") and { data.name, { r = data.nameColor[1], g = data.nameColor[2], b = data.nameColor[3], }, } or data.name
			self:AddMenuEntry(pieMenu, entryName, data.icon, data.activeIcon, function() return self:OnSelectionExecutionCallback(data) end, data)
		else
			self:AddMenuEntryWithShortcut(pieMenu, "!CSPM_invalid_slot_thus_open_piemenu_editor", visualData)
		end
	end

	-- Entry Cancel Slot
	if not presetData.suppressCancelSlot then
		self:AddMenuEntryWithShortcut(pieMenu, "!CSPM_cancel_slot", visualData)
	end
end
-- ------------------------------------------------

do
	local ExecuteSlotAction = {		-- you cannot use 'self' within this block.
		[C.ACTION_TYPE_NOTHING] = function(actionTypeId, categoryId, actionValue, data)
			return
		end, 
		[C.ACTION_TYPE_COLLECTIBLE] = function(_, _, actionValue, _)
			-- actionValue : collectibleId
			if actionValue > 0 then
				UseCollectible(actionValue, GAMEPLAY_ACTOR_CATEGORY_PLAYER)
			end
		end, 
		[C.ACTION_TYPE_EMOTE] = function(_, _, actionValue, _)
			-- actionValue : emoteId
			if actionValue > 0 then
				local emoteIndex = GetEmoteIndex(actionValue)
				if emoteIndex then
					PlayEmoteByIndex(emoteIndex)
				end
			end
		end, 
		[C.ACTION_TYPE_CHAT_COMMAND] = function(_, _, actionValue, _)
			-- actionValue : chatCommandString
			local command, args = string.match(actionValue, "^(%S+)% *(.*)")
			CSPM.LDL:Debug("chat command : %s, argments : %s", tostring(command), tostring(args))
			if SLASH_COMMANDS[command] then
				SLASH_COMMANDS[command](args)
			else
				df("[CSPM] error : slash command '%s' not found", tostring(command))
			end
		end, 
		[C.ACTION_TYPE_TRAVEL_TO_HOUSE] = function(_, categoryId, actionValue, _)
			-- actionValue : houseId
			local houseId = actionValue
			local jumpOutside = false
			if actionValue == C.ACTION_VALUE_PRIMARY_HOUSE_ID then
				houseId = GetHousingPrimaryHouse()
			end
			if categoryId == C.CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE then
				jumpOutside = true
			end
			RequestJumpToHouse(houseId, jumpOutside)
		end, 
		[C.ACTION_TYPE_PIE_MENU] = function(_, _, actionValue, _)
			-- actionValue : presetId
			if CSPM.holdDownInteractionKey then
				CSPM:ChangeTopmostPieMenu(actionValue)
				return true	-- If the callback returns true it means that the callback requested continuous processing.
			else
				d("At the moment, opening the nested pie menu only works when you perform a selection with the mouse or gamepad.")
			end
		end, 
		[C.ACTION_TYPE_SHORTCUT] = function(_, _, actionValue, data)
			-- actionValue : shortcutId
			local shortcutData = CSPM.util.GetShortcutData(actionValue)
			if shortcutData and type(shortcutData.callback) == "function" then
				shortcutData.callback(data)
			end
		end, 
	}
	setmetatable(ExecuteSlotAction, { __index = function(self, key) return rawget(self, C.ACTION_TYPE_NOTHING) end, })

	function CSPM:OnSelectionExecutionCallback(data)
		local slotData = data.slotData or {}
		local actionType = GetActionType(slotData.type)
		local cspmCategoryId = GetValue(slotData.category)
		local actionValue = GetValue(slotData.value) or 0

		if data.callback and type(data.callback) == "function" then
			return data.callback(data)	-- for embedded shortcut data
		else
			return ExecuteSlotAction[actionType](actionType, cspmCategoryId, actionValue, data)
		end
	end
end


function CSPM:HandleKeybindDown(actionName)
	self.LDL:Debug("HandleKeybindDown: %s", tostring(actionName))
	local actionName = LUT.ActionNameAlias[actionName] or actionName	-- There are multiple action layers for activating the root pie menu, but we will consolidate them here.
	local keybindsId = LUT.ActionName_To_KeybindsId[actionName or ""]
	local presetId = self.svCurrent.keybinds[keybindsId or 0]
	if presetId and presetId ~= 0 and self.util.DoesPieMenuDataExist(presetId) then
		LibCInteraction:HandleKeybindDown(actionName, presetId)
	end
end

--[[
function CSPM:StartRootPieMenuInteraction(presetId, actionName)
	local actionName = 
	self.LDL:Debug("TryStartingRootPieMenuInteraction(%s)", tostring(presetId))
	if presetId ~= 0 and self.util.DoesPieMenuDataExist(presetId) then
		self.rootMenu:SetAllowActivateInUIMode(self.svCurrent.allowActivateInUIMode)
		self.rootMenu:SetCenteringAtMouseCursor(self.svCurrent.centeringAtMouseCursor)
		self.rootMenu:SetAllowClickable(self.svCurrent.allowClickable)
		self.rootMenu:SetTimeToHoldKey(self.svCurrent.timeToHoldKey)
		self.rootMenu:SetMouseDeltaScaleFactorInUIMode(self.svCurrent.mouseDeltaScaleFactorInUIMode)
		LibCInteraction:HandleKeybindDown(actionName, presetId)
	end
end
]]


function CSPM:HandleKeybindUp(actionName)
	self.LDL:Debug("HandleKeybindUp: %s", tostring(actionName))
	local actionName = LUT.ActionNameAlias[actionName] or actionName	-- There are multiple action layers for activating the root pie menu, but we will consolidate them here.
	local keybindsId = LUT.ActionName_To_KeybindsId[actionName or ""]
	local presetId = self.svCurrent.keybinds[keybindsId or 0]
	if presetId and presetId ~= 0 and self.util.DoesPieMenuDataExist(presetId) then
		LibCInteraction:HandleKeybindUp(actionName)
	end
end

function CSPM:ChangeTopmostPieMenu(newPresetId)
	local pieMenu = self:GetTopmostPieMenu()
	if pieMenu then
		if newPresetId and newPresetId ~= 0 and self.util.DoesPieMenuDataExist(newPresetId) then
			self:SetActivePresetId(newPresetId)
			pieMenu:RefreshMenu()
			return true
		end
	end
end

function CSPM:EndPieMenuInteraction(pieMenu, clearSelection)
-- pieMenu : pieMenuController object
	self.LDL:Debug("EndPieMenuInteraction(%s)", tostring(clearSelection))
	if pieMenu then
		pieMenu:StopInteraction(clearSelection)
		self:ClearActivePresetId()
		for k, interaction in pairs(pieMenu.interactions) do
			interaction:Reset()
		end
	end
end

function CSPM:CancelPieMenuInteraction(pieMenu)
	self:EndPieMenuInteraction(pieMenu, true)
end


EVENT_MANAGER:RegisterForEvent(CSPM.name, EVENT_ADD_ON_LOADED, function(event, addonName)
	if addonName ~= CSPM.name then return end
	EVENT_MANAGER:UnregisterForEvent(CSPM.name, EVENT_ADD_ON_LOADED)
	CSPM:Initialize()
end)


-- ---------------------------------------------------------------------------------------
-- Shared Workspace for external modules
-- ---------------------------------------------------------------------------------------
CSPM.shared = {
	name = CSPM.name, 
	version = CSPM.version, 
	author = CSPM.author, 
	const = CSPM.const, 
	lut = CSPM.lut, 
	util = CSPM.util, 
	shortcutManager = GetShortcutManager(), 
	pieMenuManager = GetPieMenuDataManager(), 
}

-- ---------------------------------------------------------------------------------------
-- Bindings
-- ---------------------------------------------------------------------------------------
CShortcutPieMenu.HandleKeybindDown = function(self, actionName, ...)
	return CSPM:HandleKeybindDown(actionName, ...)
end
CShortcutPieMenu.HandleKeybindUp = function(self, actionName, ...)
	return CSPM:HandleKeybindUp(actionName, ...)
end


-- ---------------------------------------------------------------------------------------
-- APIs
-- ---------------------------------------------------------------------------------------
CShortcutPieMenu.RegisterClassObject = function(self, className, classObject)
	if className and classObject and not CSPM.class[className] then
		CSPM.class[className] = classObject
	end
end

CShortcutPieMenu.GetActivePresetId = function(self)
	return CSPM.activePresetId
end

CShortcutPieMenu.OpenPieMenuEditorPanel = function(self, presetId, slotId)
	if CSPM.menuEditorPanel then
		CSPM.menuEditorPanel:OpenOptionsPanel(presetId, slotId)
	end
end

CShortcutPieMenu.OpenPieMenuManagerPanel = function(self)
	if CSPM.menuManagerPanel then
		CSPM.menuManagerPanel:OpenOptionsPanel()
	end
end
-- ---------------------------------------------------------------------------------------
CShortcutPieMenu.RegisterPieMenu = function(self, presetId, pieMenuData)
	return CSPM.pieMenuDataManager:RegisterExternalPieMenu(presetId, pieMenuData)
end

-- ---------------------------------------------------------------------------------------
-- Chat commands
-- ---------------------------------------------------------------------------------------
SLASH_COMMANDS["/cspm.debug"] = function(arg) if arg ~= "" then CSPM:ConfigDebug({tonumber(arg)}) end end
SLASH_COMMANDS["/cspm.test"] = function(arg)
	CSPM.LDL:Verbose("hoge")
	CSPM.LDL:Debug("hoge")
	CSPM.LDL:Info("hoge")
	CSPM.LDL:Warn("hoge")
	CSPM.LDL:Error("hoge")
end
