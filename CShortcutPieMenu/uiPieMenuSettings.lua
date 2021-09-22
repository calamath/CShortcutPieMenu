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


-- CShortcutPieMenu local definitions
local CSPM = CShortcutPieMenu
local L = GetString

-- ---------------------------------------------------------------------------------------
-- Aliases of constants
local CSPM_UI_NONE								= CSPM.const.CSPM_UI_NONE
local CSPM_UI_OPEN								= CSPM.const.CSPM_UI_OPEN
local CSPM_UI_CLOSE								= CSPM.const.CSPM_UI_CLOSE
local CSPM_UI_COPY								= CSPM.const.CSPM_UI_COPY
local CSPM_UI_PASTE								= CSPM.const.CSPM_UI_PASTE
local CSPM_UI_CLEAR								= CSPM.const.CSPM_UI_CLEAR
local CSPM_UI_RESET								= CSPM.const.CSPM_UI_RESET
local CSPM_UI_PREVIEW							= CSPM.const.CSPM_UI_PREVIEW
local CSPM_UI_SELECT							= CSPM.const.CSPM_UI_SELECT
local CSPM_UI_CANCEL							= CSPM.const.CSPM_UI_CANCEL
local CSPM_UI_EXECUTE							= CSPM.const.CSPM_UI_EXECUTE

local CSPM_MAX_USER_PRESET						= CSPM.const.CSPM_MAX_USER_PRESET
local CSPM_MENU_ITEMS_COUNT_DEFAULT				= CSPM.const.CSPM_MENU_ITEMS_COUNT_DEFAULT
local CSPM_ACTION_TYPE_NOTHING					= CSPM.const.CSPM_ACTION_TYPE_NOTHING
local CSPM_ACTION_TYPE_COLLECTIBLE				= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE
local CSPM_ACTION_TYPE_EMOTE					= CSPM.const.CSPM_ACTION_TYPE_EMOTE
local CSPM_ACTION_TYPE_CHAT_COMMAND				= CSPM.const.CSPM_ACTION_TYPE_CHAT_COMMAND
local CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= CSPM.const.CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE
local CSPM_ACTION_TYPE_PIE_MENU					= CSPM.const.CSPM_ACTION_TYPE_PIE_MENU
local CSPM_ACTION_TYPE_SHORTCUT					= CSPM.const.CSPM_ACTION_TYPE_SHORTCUT
local CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE	= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE

local CSPM_CATEGORY_NOTHING						= CSPM.const.CSPM_CATEGORY_NOTHING
local CSPM_CATEGORY_IMMEDIATE_VALUE				= CSPM.const.CSPM_CATEGORY_IMMEDIATE_VALUE
local CSPM_CATEGORY_C_ASSISTANT					= CSPM.const.CSPM_CATEGORY_C_ASSISTANT
local CSPM_CATEGORY_C_COMPANION					= CSPM.const.CSPM_CATEGORY_C_COMPANION
local CSPM_CATEGORY_C_MEMENTO					= CSPM.const.CSPM_CATEGORY_C_MEMENTO
local CSPM_CATEGORY_C_VANITY_PET				= CSPM.const.CSPM_CATEGORY_C_VANITY_PET
local CSPM_CATEGORY_C_MOUNT						= CSPM.const.CSPM_CATEGORY_C_MOUNT
local CSPM_CATEGORY_C_PERSONALITY				= CSPM.const.CSPM_CATEGORY_C_PERSONALITY
local CSPM_CATEGORY_C_ABILITY_SKIN				= CSPM.const.CSPM_CATEGORY_C_ABILITY_SKIN
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
local CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU	= CSPM.const.CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU
local CSPM_CATEGORY_S_PIE_MENU_ADDON			= CSPM.const.CSPM_CATEGORY_S_PIE_MENU_ADDON
local CSPM_CATEGORY_S_MAIN_MENU					= CSPM.const.CSPM_CATEGORY_S_MAIN_MENU
local CSPM_CATEGORY_S_SYSTEM_MENU				= CSPM.const.CSPM_CATEGORY_S_SYSTEM_MENU
local CSPM_CATEGORY_S_USEFUL_SHORTCUT			= CSPM.const.CSPM_CATEGORY_S_USEFUL_SHORTCUT
local CSPM_CATEGORY_C_HAT						= CSPM.const.CSPM_CATEGORY_C_HAT
local CSPM_CATEGORY_C_HAIR						= CSPM.const.CSPM_CATEGORY_C_HAIR
local CSPM_CATEGORY_C_HEAD_MARKING				= CSPM.const.CSPM_CATEGORY_C_HEAD_MARKING
local CSPM_CATEGORY_C_FACIAL_HAIR_HORNS			= CSPM.const.CSPM_CATEGORY_C_FACIAL_HAIR_HORNS
local CSPM_CATEGORY_C_FACIAL_ACCESSORY			= CSPM.const.CSPM_CATEGORY_C_FACIAL_ACCESSORY
local CSPM_CATEGORY_C_PIERCING_JEWELRY			= CSPM.const.CSPM_CATEGORY_C_PIERCING_JEWELRY
local CSPM_CATEGORY_C_COSTUME					= CSPM.const.CSPM_CATEGORY_C_COSTUME
local CSPM_CATEGORY_C_BODY_MARKING				= CSPM.const.CSPM_CATEGORY_C_BODY_MARKING
local CSPM_CATEGORY_C_SKIN						= CSPM.const.CSPM_CATEGORY_C_SKIN
local CSPM_CATEGORY_C_POLYMORPH					= CSPM.const.CSPM_CATEGORY_C_POLYMORPH
local CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID		= CSPM.const.CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID

local CSPM_SLOT_DATA_DEFAULT 					= CSPM.const.CSPM_SLOT_DATA_DEFAULT

-- ---------------------------------------------------------------------------------------
-- Aliases of look up table
local CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ICON			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ICON
local CSPM_LUT_ACTION_TYPE_API_STRINGS			= CSPM.lut.CSPM_LUT_ACTION_TYPE_API_STRINGS
local CSPM_LUT_ACTION_TYPE_ALIAS				= CSPM.lut.CSPM_LUT_ACTION_TYPE_ALIAS
local CSPM_LUT_UI_COLOR							= CSPM.lut.CSPM_LUT_UI_COLOR


-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu' not found.") return end


-- UI section locals
local ui = ui or {}
local uiPresetId = 1
local uiSlotId = 1

local function DoSetupDefault(slotId)
end

local function GetPresetDisplayNameByPresetId(presetId)
	local name
	local pieMenuName = CSPM:GetPieMenuInfo(presetId)
	if CSPM:IsUserPieMenu(presetId) then
		if CSPM:DoesPieMenuDataExist(presetId) then
			if pieMenuName ~= "" then
				name = zo_strformat(L(SI_CSPM_PRESET_NAME_FORMATTER), presetId, pieMenuName)
			else
				name = ZO_CachedStrFormat(L(SI_CSPM_PRESET_NO_NAME_FORMATTER), presetId)
			end
		else
			name = ZO_CachedStrFormat(L(SI_CSPM_PRESET_NAME_FORMATTER), presetId, L(SI_CSPM_COMMON_UNREGISTERED))
		end
	else
		name = pieMenuName
	end
	return name
end

local function RefreshPanel_OnUserPieMenuInfoUpdated(presetId)
-- This function assumes that the preset attribute information in the user pie menu has just changed.
	if not CSPM:IsUserPieMenu(presetId) then return end
	CSPM.LDL:Debug("RefreshEditorPanel-OnUserPieMenuInfoUpdated : ", presetId)

	-- NOTE : the user preset selection choices and the preset name submenu header for the user pie menu will also be updated here.
	ui.presetChoices[presetId] = GetPresetDisplayNameByPresetId(presetId)
	ui.actionValueChoices[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU][presetId] = ui.presetChoices[presetId]
	if ui.panelInitialized then
		CSPM_UI_PresetSelectMenu:UpdateChoices(ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips)
		CSPM_UI_PresetSelectMenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

		CSPM_UI_PresetSubmenu.data.name = ui.presetChoices[uiPresetId]
		CSPM_UI_PresetSubmenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

		if CSPM.db.preset[uiPresetId].slot[uiSlotId].type == CSPM_ACTION_TYPE_PIE_MENU then
			local categoryId = CSPM.db.preset[uiPresetId].slot[uiSlotId].category
			if categoryId == CSPM_CATEGORY_P_OPEN_USER_PIE_MENU then
				CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU], ui.actionValueChoicesValues[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU], ui.actionValueChoicesTooltips[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU])
				CSPM_UI_ActionValueMenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.
			end
		end
	end
end

local function RebuildUserPieMenuPresetSelectionChoices()
	local choices = {}
	local choicesValues = {}
	for i = 1, CSPM_MAX_USER_PRESET do
		choices[i] = GetPresetDisplayNameByPresetId(i)
		choicesValues[i] = i
	end
	return choices, choicesValues, choicesValues
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the presetId value instead of a string.
end

local function RebuildExternalPieMenuPresetSelectionChoices()
	local choices = {}
	local choicesValues = {}
	local externalPieMenuList = CSPM:GetExternalPieMenuList()
	for _, presetId in pairs(externalPieMenuList) do
		choices[#choices + 1] = GetPresetDisplayNameByPresetId(presetId)
		choicesValues[#choicesValues + 1] = presetId
	end
	return choices, choicesValues, choicesValues
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the presetId value instead of a string.
end

local function GetSlotDisplayNameBySlotId(slotId)
	local slotName = ""
	local savedSlotData = CSPM:GetMenuSlotData(uiPresetId, slotId)
	if savedSlotData then
		if type(savedSlotData.name) == "string" and savedSlotData.name ~= "" then
			slotName = savedSlotData.name
		else
			slotName = CSPM.util.GetDefaultSlotName(savedSlotData.type, savedSlotData.category, savedSlotData.value)
		end
	end
	if slotName == "" then
		slotName = L(SI_CSPM_COMMON_UNREGISTERED)
	end
	return slotName
end

local function RefreshPanel_OnSlotDisplayNameChanged()
-- This function assumes that the slot display name of the currently open preset and slot has just changed.
	CSPM.LDL:Debug("RefreshEditorPanel-OnSlotDisplayNameChanged : ")
	
	-- NOTE : Since the slot display name has been changed, the slot selection choices and the slot name tab header will also be updated here.
	ui.slotChoices[uiSlotId] = zo_strformat(L(SI_CSPM_SLOT_NAME_FORMATTER), uiSlotId, ui.slotDisplayName[uiSlotId] or L(SI_CSPM_COMMON_UNREGISTERED))
	CSPM_UI_SlotSelectMenu:UpdateChoices(ui.slotChoices, ui.slotChoicesValues)
	CSPM_UI_SlotSelectMenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

	CSPM_UI_TabHeader.data.name = ui.slotChoices[uiSlotId]
	CSPM_UI_TabHeader:UpdateValue()
end

local function UpdateSlotDisplayNameTableForSpecificSlot(slotId)
	ui.slotDisplayName[slotId] = GetSlotDisplayNameBySlotId(slotId)
	if slotId == uiSlotId then
		RefreshPanel_OnSlotDisplayNameChanged()
	end
end

local function RebuildSlotDisplayNameTable(presetId)
	presetId = presetId or uiPresetId
	local displayNameTable = {}
	local presetData = CSPM:GetUserPieMenuConfigDataDB(presetId)
	if not presetData then return end
	for i = 1, presetData.menuItemsCount do
		displayNameTable[i] = GetSlotDisplayNameBySlotId(i)
	end
	return displayNameTable
end

local function RebuildSlotSelectionChoices(menuItemsCount)
	local choices = {}
	local choicesValues = {}
	for i = 1, menuItemsCount do
		choices[i] = zo_strformat(L(SI_CSPM_SLOT_NAME_FORMATTER), i, ui.slotDisplayName[i] or L(SI_CSPM_COMMON_UNREGISTERED))
		choicesValues[i] = i
	end
	return choices, choicesValues
end

local function RebuildCollectibleSelectionChoicesByCategoryType(categoryId, unlockedOnly)
--	unlockedOnly : return only the unlocked ones or the whole set
	local choices = {}
	local choicesValues = {}
	unlockedOnly = unlockedOnly or false
	if categoryId then
		for index = 1, GetTotalCollectiblesByCategoryType(categoryId) do
			local collectibleId = GetCollectibleIdFromType(categoryId, index)
			if not unlockedOnly or IsCollectibleUnlocked(collectibleId) then
				choices[#choices + 1] = ZO_CachedStrFormat(L(SI_CSPM_COMMON_FORMATTER), GetCollectibleName(collectibleId))
				choicesValues[#choicesValues + 1] = collectibleId
			end
		end
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the collectibleId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function RebuildEmoteSelectionChoicesByEmoteCategory(emoteCategory)
	local choices = {}
	local choicesValues = PLAYER_EMOTE_MANAGER:GetEmoteListForType(emoteCategory) or {}
	for k, emoteId in pairs(choicesValues) do
		choices[#choices + 1] = ZO_CachedStrFormat(L(SI_CSPM_COMMON_FORMATTER), PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(emoteId).displayName)
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the emoteId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function RebuildHouseSelectionChoices(unlockedOnly, includePrimaryHouse)
--	unlockedOnly : return only the unlocked ones or the whole set
--	includePrimaryHouse : whether to include the primary house
	local choices = {}
	local choicesValues = {}
	unlockedOnly = unlockedOnly or false	-- nil should be false
	includePrimaryHouse = includePrimaryHouse ~= false	-- nil should be true

	if includePrimaryHouse then
		choices[#choices + 1] = ZO_CachedStrFormat(L(SI_CSPM_PARENTHESES_FORMATTER), L(SI_HOUSING_FURNITURE_SETTINGS_GENERAL_PRIMARY_RESIDENCE_TEXT))	-- Primary Residence
		choicesValues[#choicesValues + 1] = CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID
	end
	for index = 1, GetTotalCollectiblesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_HOUSE) do
		local collectibleId = GetCollectibleIdFromType(COLLECTIBLE_CATEGORY_TYPE_HOUSE, index)
		if not unlockedOnly or IsCollectibleUnlocked(collectibleId) then
			choices[#choices + 1] = ZO_CachedStrFormat(L(SI_CSPM_COMMON_FORMATTER), GetCollectibleName(collectibleId))
			choicesValues[#choicesValues + 1] = GetCollectibleReferenceId(collectibleId)
		end
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the houseId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function RebuildShortcutSelectionChoicesByCategory(categoryId)
	local choices = {}
	local choicesValues = CSPM:GetShortcutListByCategory(categoryId) or {}
	for k, v in ipairs(choicesValues) do
		local name = CSPM:GetShortcutInfo(v)
		choices[k] = name or ""
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the shortcutId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function ChangePanelSlotState(slotId)
	CSPM.LDL:Debug("ChangePanelSlotState : %s", slotId)
	-- Here, we need to call the setFunc callback of CSPM_UI_SlotSelectMenu.
	CSPM_UI_SlotSelectMenu:UpdateValue(false, slotId)	-- Note : When called with arguments, setFunc will be called.
end

local function ChangePanelPresetState(presetId)
	CSPM.LDL:Debug("ChangePanelPresetState : %s", presetId)
	-- Here, we need to call the setFunc callback of CSPM_UI_PresetSelectMenu.
	CSPM_UI_PresetSelectMenu:UpdateValue(false, presetId)	-- Note : When called with arguments, setFunc will be called.
end

local function OnPresetIdSelectionChanged(newPresetId)
	CSPM.LDL:Debug("OnPresetIdSelectionChanged : %s", newPresetId)

	if not CSPM:DoesUserPieMenuConfigDataExist(newPresetId) then
--		d("[CSPM] fatal error : preset data not found, so extend !")
		CSPM:CreateUserPieMenuConfigDataDB(newPresetId)
	end

	-- update preset tab
	uiPresetId = newPresetId

	if CSPM_UI_PresetSubmenu.open then
		CSPM_UI_PresetSubmenu.open = false
		CSPM_UI_PresetSubmenu.animation:PlayFromStart()
	end
	CSPM_UI_PresetSubmenu.data.name = ui.presetChoices[uiPresetId]
	CSPM_UI_PresetSubmenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

	ui.slotDisplayName = RebuildSlotDisplayNameTable(uiPresetId)
	CSPM_UI_MenuItemsCountSlider:UpdateValue(false, CSPM.db.preset[uiPresetId].menuItemsCount)
	ChangePanelSlotState(1)
end

local function OnMenuItemCountChanged(newMenuItemsCount)
	CSPM.LDL:Debug("OnMenuItemCountChanged : %s", newMenuItemsCount)
	CSPM.db.preset[uiPresetId].menuItemsCount = newMenuItemsCount
	if not CSPM:DoesMenuSlotDataExist(uiPresetId, newMenuItemsCount) then
--		d("[CSPM] fatal error : slot data not found, so extend !")
		CSPM:ExtendMenuItemsCountForUserPieMenuConfigDataDB(uiPresetId, newMenuItemsCount)
	end

	ui.slotChoices, ui.slotChoicesValues = RebuildSlotSelectionChoices(newMenuItemsCount)
	CSPM_UI_SlotSelectMenu:UpdateChoices(ui.slotChoices, ui.slotChoicesValues)
	CSPM_UI_SlotSelectMenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

	if uiSlotId > newMenuItemsCount then
		ChangePanelSlotState(newMenuItemsCount)
	end
end

local function OnSlotIdSelectionChanged(newSlotId)
	CSPM.LDL:Debug("OnSlotIdSelectionChanged : %s", newSlotId)

	if not CSPM:DoesMenuSlotDataExist(uiPresetId, newSlotId) then
--		d("[CSPM] fatal error : slot data not found, so extend !")
		CSPM:ExtendMenuItemsCountForUserPieMenuConfigDataDB(uiPresetId, newSlotId)
	end
	local savedSlotData = CSPM:GetMenuSlotData(uiPresetId, newSlotId)
	if not savedSlotData then d("[CSPM] fatal error : slot data not found") return end

	-- update slot tab
	uiSlotId = newSlotId
	-- Since the only purpose here is to reflect the saved data to the panel(slot tab), we will make sure NOT to call setFunc for each widget.
	local uiActionTypeId = savedSlotData.type or CSPM_ACTION_TYPE_NOTHING
	local uiCategoryId = savedSlotData.category or CSPM_CATEGORY_NOTHING
--	local uiActionValue = savedSlotData.value or 0

	CSPM_UI_TabHeader.data.name = ui.slotChoices[uiSlotId]
	CSPM_UI_TabHeader:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

	CSPM_UI_ActionTypeMenu:UpdateValue()
	CSPM_UI_CategoryMenu:UpdateChoices(ui.categoryChoices[uiActionTypeId], ui.categoryChoicesValues[uiActionTypeId])
	CSPM_UI_CategoryMenu:UpdateValue()
	CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[uiCategoryId], ui.actionValueChoicesValues[uiCategoryId], ui.actionValueChoicesTooltips[uiCategoryId])
	CSPM_UI_ActionValueMenu:UpdateValue()
	CSPM_UI_ActionValueEditbox:UpdateValue()
	CSPM_UI_ActionValueEditbox:UpdateDisabled()
	CSPM_UI_SlotNameEditbox:UpdateValue()
	CSPM_UI_SlotIconEditbox:UpdateValue()
end

local function OnActionTypeSelectionChanged(newActionTypeId)
	CSPM.LDL:Debug("OnActionTypeSelectionChanged : %s", newActionTypeId)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].type = newActionTypeId

	CSPM_UI_CategoryMenu:UpdateChoices(ui.categoryChoices[newActionTypeId], ui.categoryChoicesValues[newActionTypeId])

	-- The meaning of ActionValue is different for each ActionType, and they are not mutually compatible.
	-- Therefore, when a user changes the ActionType selection, the category id and ActionValue should be initialized．
	CSPM_UI_CategoryMenu:UpdateValue(true)
	CSPM_UI_ActionValueMenu:UpdateValue(true)
	-- According to the design policy, the slot name override setting is also initialized.
	CSPM_UI_SlotNameEditbox:UpdateValue(true)
	-- According to the design policy, the slot icon override setting is only initialized when the action type is set to 'unselected'.
	if newActionTypeId == CSPM_ACTION_TYPE_NOTHING then
		CSPM_UI_SlotIconEditbox:UpdateValue(true)
	end
end

local function OnCategorySelectionChanged(newCategoryId)
	CSPM.LDL:Debug("OnCategorySelectionChanged : %s", newCategoryId)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].category = newCategoryId
	CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[newCategoryId], ui.actionValueChoicesValues[newCategoryId], ui.actionValueChoicesTooltips[newCategoryId])

	-- To prevent a mismatch between the category id and the ActionValue,
	-- the ActionValue should be initialized when the user changes the category selection.
	CSPM_UI_ActionValueMenu:UpdateValue(true)
	-- According to the design policy, the slot name override setting is also initialized.
	CSPM_UI_SlotNameEditbox:UpdateValue(true)
	-- According to the design policy, the slot icon override setting will not be initialized when the category is changed.
	-- CSPM_UI_SlotIconEditbox:UpdateValue(true)
end

local function OnActionValueSelectionChanged(newActionValue)
	CSPM.LDL:Debug("OnActionValueSelectionChanged : %s", newActionValue)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].value = newActionValue
	-- According to the design policy, the slot name override setting is initialized.
	CSPM_UI_SlotNameEditbox:UpdateValue(true)
	-- According to the design policy, the slot icon override setting will not be initialized when the action value is changed.
	-- CSPM_UI_SlotIconEditbox:UpdateValue(true)
end

local function OnActionValueEditboxChanged(newActionValueString)
	CSPM.LDL:Debug("OnActionValueEditboxChanged : %s", newActionValueString)
	local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
	-- NOTE : the meaning of ActionValue is different for each ActionType, and they are not mutually compatible.
	if uiActionTypeId == CSPM_ACTION_TYPE_CHAT_COMMAND then 
		CSPM.db.preset[uiPresetId].slot[uiSlotId].value = newActionValueString
	else
		CSPM.db.preset[uiPresetId].slot[uiSlotId].value = tonumber(newActionValueString)
	end

	-- The slot display name will be changed and the UI panel will be updated here.
	-- When the ActionValue selection is changed, this edit box will be initialized, so the slot display name will be updated here as well.
	UpdateSlotDisplayNameTableForSpecificSlot(uiSlotId)
end

local function OnSlotNameEditboxChanged(newSlotName)
	CSPM.LDL:Debug("OnSlotNameEditboxChanged : %s", newSlotName)
	if newSlotName == "" then
		CSPM.db.preset[uiPresetId].slot[uiSlotId].name = nil
	else
		CSPM.db.preset[uiPresetId].slot[uiSlotId].name = newSlotName
	end

	UpdateSlotDisplayNameTableForSpecificSlot(uiSlotId)
end

local function OnSlotIconEditboxChanged(newSlotIcon)
	CSPM.LDL:Debug("OnSlotIconEditboxChanged : %s", newSlotIcon)
	if newSlotIcon == "" then
		CSPM.db.preset[uiPresetId].slot[uiSlotId].icon = nil
	else
		CSPM.db.preset[uiPresetId].slot[uiSlotId].icon = newSlotIcon
	end
end

local function DoTestButton()
end

local function OnLAMPanelControlsCreated(panel)
	if (panel ~= ui.panel) then return end
	CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)

	-- override ScrollableDropdownHelper for CSPM_UI_ActionValueMenu to customize dropdown choices tooltips
	CSPM_UI_ActionValueMenu.scrollHelper.OnMouseEnter = function(self, control)
		if control.m_data.tooltip then
			local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type or CSPM_ACTION_TYPE_NOTHING
			CSPM.util.LayoutSlotActionTooltip(uiActionTypeId, CSPM.db.preset[uiPresetId].slot[uiSlotId].category or CSPM_CATEGORY_NOTHING, control.m_data.tooltip)
			CSPM.util.ShowSlotActionTooltip(control, TOPLEFT, 0, 0, BOTTOMRIGHT)
		end
	end
	CSPM_UI_ActionValueMenu.scrollHelper.OnMouseExit = function(self, control)
		if control.m_data.tooltip then
			CSPM.util.HideSlotActionTooltip()
		end
	end

	-- Create a widget for the Preset Selection dropdown menu
	local dropdownPresetSelectMenu = {
		type = "dropdown", 
		name = "", 
--		name = L(SI_CSPM_UI_PRESET_SELECT_MENU_NAME), 
		tooltip = L(SI_CSPM_UI_PRESET_SELECT_MENU_TIPS), 
		choices = ui.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.presetChoicesValues, 
		choicesTooltips = ui.presetChoicesTooltips, 
		getFunc = function() return uiPresetId end, 
		setFunc = OnPresetIdSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "full", 
		scrollable = true, 
		default = 1, 
	}
	CSPM_UI_PresetSelectMenu = LAMCreateControl.dropdown(ui.panel, dropdownPresetSelectMenu)
	CSPM_UI_PresetSelectMenu.combobox:SetWidth(300)	-- default : panelWidth(585) / 3
	CSPM_UI_PresetSelectMenu:SetAnchor(BOTTOMLEFT, CSPM_UI_PresetSubmenu, TOPLEFT)
	CSPM_UI_PresetSelectMenu:SetAnchor(BOTTOMRIGHT, CSPM_UI_PresetSubmenu, TOPRIGHT, -112, -4)
	-- override ScrollableDropdownHelper for CSPM_UI_PresetSelectMenu to customize dropdown choices tooltips
	CSPM_UI_PresetSelectMenu.scrollHelper.OnMouseEnter = function(self, control)
		if control.m_data.tooltip then
			CSPM.util.LayoutSlotActionTooltip(CSPM_ACTION_TYPE_PIE_MENU, CSPM_CATEGORY_NOTHING, control.m_data.tooltip, CSPM_UI_NONE)
			CSPM.util.ShowSlotActionTooltip(control, TOPLEFT, 0, 0, BOTTOMRIGHT)
		end
	end
	CSPM_UI_PresetSelectMenu.scrollHelper.OnMouseExit = function(self, control)
		if control.m_data.tooltip then
			CSPM.util.HideSlotActionTooltip()
		end
	end

	ChangePanelPresetState(1)
	ui.panelInitialized = true
end

local function OnLAMPanelOpened(panel)
	if (panel ~= ui.panel) then return end
	CSPM.LDL:Debug("OnLAMPanelOpened:")
end

local function OnLAMPanelClosed(panel)
	if (panel ~= ui.panel) then return end
	CSPM.LDL:Debug("OnLAMPanelClosed:")
end


local function CollectibleDataManager_OnCollectionUpdated(collectionUpdateType, collectiblesByNewUnlockState)
	if collectionUpdateType ~= ZO_COLLECTION_UPDATE_TYPE.UNLOCK_STATE_CHANGES then return end
	if collectiblesByNewUnlockState[COLLECTIBLE_UNLOCK_STATE_UNLOCKED_OWNED] then
		CSPM.LDL:Debug("COLLECTIBLE_DATA_MANAGER-OnCollectionUpdated (UnlockStateChanges)")
		local needToRebuild = {}
		for index, collectibleData in pairs(collectiblesByNewUnlockState[COLLECTIBLE_UNLOCK_STATE_UNLOCKED_OWNED]) do
--			CSPM.LDL:Debug("[%s] : id=%s", tostring(index), tostring(collectibleData:GetId()))
			needToRebuild[collectibleData:GetCategoryType()] = true
		end
		-- update collectible choices if needed
		for cspmCollectibleCategory, zosCollectibleCategory in pairs(CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS) do
			if needToRebuild[zosCollectibleCategory] then
				ui.actionValueChoices[cspmCollectibleCategory], ui.actionValueChoicesValues[cspmCollectibleCategory], ui.actionValueChoicesTooltips[cspmCollectibleCategory] = RebuildCollectibleSelectionChoicesByCategoryType(zosCollectibleCategory, true)
			end
		end
		-- update emote choices if needed
		if needToRebuild[COLLECTIBLE_CATEGORY_TYPE_EMOTE] then
			ui.actionValueChoices[CSPM_CATEGORY_E_COLLECTED], ui.actionValueChoicesValues[CSPM_CATEGORY_E_COLLECTED], ui.actionValueChoicesTooltips[CSPM_CATEGORY_E_COLLECTED] = RebuildEmoteSelectionChoicesByEmoteCategory(EMOTE_CATEGORY_COLLECTED) 
		end
		-- update player house choices if needed
		if needToRebuild[COLLECTIBLE_CATEGORY_TYPE_HOUSE] then
			ui.actionValueChoices[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE], ui.actionValueChoicesValues[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE] = RebuildHouseSelectionChoices(true)
			ui.actionValueChoices[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE], ui.actionValueChoicesValues[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE] = RebuildHouseSelectionChoices(true)
		end
		-- update MenuEditorUI panel
		if ui.panelInitialized then
			ChangePanelSlotState(uiSlotId)
		end
	end
end

function CSPM:InitializeMenuEditorUI()
	ui.panelInitialized = false
	ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips = RebuildUserPieMenuPresetSelectionChoices()

	ui.slotDisplayName = {}
	ui.slotChoices, ui.slotChoicesValues = RebuildSlotSelectionChoices(CSPM_MENU_ITEMS_COUNT_DEFAULT)

	ui.actionTypeChoices = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_COLLECTIBLE), 
		L(SI_CSPM_COMMON_APPEARANCE), 
		L(SI_CSPM_COMMON_EMOTE), 
		L(SI_CSPM_COMMON_CHAT_COMMAND), 
		L(SI_CSPM_COMMON_TRAVEL_TO_HOUSE), 
		L(SI_CSPM_COMMON_PIE_MENU), 
		L(SI_CSPM_COMMON_SHORTCUT), 
	} 
	ui.actionTypeChoicesValues = {
		CSPM_ACTION_TYPE_NOTHING, 
		CSPM_ACTION_TYPE_COLLECTIBLE, 
		CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE, 
		CSPM_ACTION_TYPE_EMOTE, 
		CSPM_ACTION_TYPE_CHAT_COMMAND, 
		CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE, 
		CSPM_ACTION_TYPE_PIE_MENU, 
		CSPM_ACTION_TYPE_SHORTCUT, 
	}
	ui.actionTypeChoicesTooltips = {
		L(SI_CSPM_UI_ACTION_TYPE_NOTHING_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_APPEARANCE_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_EMOTE_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_CHAT_COMMAND_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_TRAVEL_TO_HOUSE_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_PIE_MENU_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_SHORTCUT_TIPS), 
	}

	ui.categoryChoices = {}
	ui.categoryChoicesValues = {}
	ui.categoryChoices[CSPM_ACTION_TYPE_NOTHING], ui.categoryChoicesValues[CSPM_ACTION_TYPE_NOTHING] = {}, {}
	ui.categoryChoices[CSPM_ACTION_TYPE_COLLECTIBLE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_ASSISTANT), 		-- "Assistant", 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_COMPANION), 		-- "Companion", 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_MEMENTO), 		-- "Memento", 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_VANITY_PET), 		-- "Non-combat-pet", 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_MOUNT), 			-- "Mount", 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_PERSONALITY), 	-- "Personality", 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_ABILITY_SKIN), 	-- "Ability Skin", 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_COLLECTIBLE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
		CSPM_CATEGORY_C_ASSISTANT, 
		CSPM_CATEGORY_C_COMPANION, 
		CSPM_CATEGORY_C_MEMENTO, 
		CSPM_CATEGORY_C_VANITY_PET, 
		CSPM_CATEGORY_C_MOUNT, 
		CSPM_CATEGORY_C_PERSONALITY, 
		CSPM_CATEGORY_C_ABILITY_SKIN, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_HAT), 				-- "Hat" 
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_HAIR), 				-- "Hair"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_HEAD_MARKING), 		-- "Head Marking"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_FACIAL_HAIR_HORNS), 	-- "Facial Hair / Horns"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_FACIAL_ACCESSORY), 	-- "Major Adornment"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_PIERCING_JEWELRY), 	-- "Minor Adornment"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_COSTUME), 			-- "Costume"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_BODY_MARKING), 		-- "Body Marking"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_SKIN), 				-- "Skin"
		L("SI_COLLECTIBLECATEGORYTYPE", COLLECTIBLE_CATEGORY_TYPE_POLYMORPH), 			-- "Polymorph"
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
		CSPM_CATEGORY_C_HAT, 
		CSPM_CATEGORY_C_HAIR, 
		CSPM_CATEGORY_C_HEAD_MARKING, 
		CSPM_CATEGORY_C_FACIAL_HAIR_HORNS, 
		CSPM_CATEGORY_C_FACIAL_ACCESSORY, 
		CSPM_CATEGORY_C_PIERCING_JEWELRY, 
		CSPM_CATEGORY_C_COSTUME, 
		CSPM_CATEGORY_C_BODY_MARKING, 
		CSPM_CATEGORY_C_SKIN, 
		CSPM_CATEGORY_C_POLYMORPH, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_EMOTE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_CEREMONIAL), 			-- "Ceremonial"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_CHEERS_AND_JEERS), 	-- "Cheers and Jeers"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_EMOTION), 				-- "Emotion"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_ENTERTAINMENT), 		-- "Entertainment"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_FOOD_AND_DRINK), 		-- "Food and Drink"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_GIVE_DIRECTIONS), 		-- "Give Directions"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_PHYSICAL), 			-- "Physical"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_POSES_AND_FIDGETS), 	-- "Poses and Fidgets"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_PROP), 				-- "Prop"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_SOCIAL), 				-- "Social"
		L("SI_EMOTECATEGORY", EMOTE_CATEGORY_COLLECTED), 			-- "Collected"
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_EMOTE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
		CSPM_CATEGORY_E_CEREMONIAL, 
		CSPM_CATEGORY_E_CHEERS_AND_JEERS, 
		CSPM_CATEGORY_E_EMOTION, 
		CSPM_CATEGORY_E_ENTERTAINMENT, 
		CSPM_CATEGORY_E_FOOD_AND_DRINK, 
		CSPM_CATEGORY_E_GIVE_DIRECTIONS, 
		CSPM_CATEGORY_E_PHYSICAL, 
		CSPM_CATEGORY_E_POSES_AND_FIDGETS, 
		CSPM_CATEGORY_E_PROP, 
		CSPM_CATEGORY_E_SOCIAL, 
		CSPM_CATEGORY_E_COLLECTED, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_CHAT_COMMAND] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_CHAT_COMMAND] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_MY_HOUSE_INSIDE), 
		L(SI_CSPM_COMMON_MY_HOUSE_OUTSIDE), 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE, 
		CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_PIE_MENU] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		ZO_CachedStrFormat(L("SI_CSPM_COMMON_UI_ACTION", CSPM_UI_OPEN), L(SI_CSPM_COMMON_USER_PIE_MENU)), 
		ZO_CachedStrFormat(L("SI_CSPM_COMMON_UI_ACTION", CSPM_UI_OPEN), L(SI_CSPM_COMMON_EXTERNAL_PIE_MENU)), 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_PIE_MENU] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_P_OPEN_USER_PIE_MENU, 
		CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_SHORTCUT] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		CSPM.name, 
		L(SI_CSPM_COMMON_MAIN_MENU), 
		L(SI_CSPM_COMMON_SYSTEM_MENU), 
		L(SI_CSPM_UI_CATEGORY_S_USEFUL_SHORTCUT_NAME), 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_SHORTCUT] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_S_PIE_MENU_ADDON, 
		CSPM_CATEGORY_S_MAIN_MENU, 
		CSPM_CATEGORY_S_SYSTEM_MENU, 
		CSPM_CATEGORY_S_USEFUL_SHORTCUT, 
	}

	ui.actionValueChoices = {}
	ui.actionValueChoicesValues = {}
	ui.actionValueChoicesTooltips = {}
	ui.actionValueChoices[CSPM_CATEGORY_NOTHING], ui.actionValueChoicesValues[CSPM_CATEGORY_NOTHING], ui.actionValueChoicesTooltips[CSPM_CATEGORY_NOTHING] = {}, {}, {}
	ui.actionValueChoices[CSPM_CATEGORY_IMMEDIATE_VALUE], ui.actionValueChoicesValues[CSPM_CATEGORY_IMMEDIATE_VALUE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_IMMEDIATE_VALUE] = {}, {}, {}
	for cspmCollectibleCategory, zosCollectibleCategory in pairs(CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS) do
		ui.actionValueChoices[cspmCollectibleCategory], ui.actionValueChoicesValues[cspmCollectibleCategory], ui.actionValueChoicesTooltips[cspmCollectibleCategory] = RebuildCollectibleSelectionChoicesByCategoryType(zosCollectibleCategory, true)
	end
	for cspmEmoteCategory, zosEmoteCategory in pairs(CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS) do
		ui.actionValueChoices[cspmEmoteCategory], ui.actionValueChoicesValues[cspmEmoteCategory], ui.actionValueChoicesTooltips[cspmEmoteCategory] = RebuildEmoteSelectionChoicesByEmoteCategory(zosEmoteCategory) 
	end
	ui.actionValueChoices[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE], ui.actionValueChoicesValues[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE] = RebuildHouseSelectionChoices(true)
	ui.actionValueChoices[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE], ui.actionValueChoicesValues[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE] = RebuildHouseSelectionChoices(true)
	ui.actionValueChoices[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU], ui.actionValueChoicesValues[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU], ui.actionValueChoicesTooltips[CSPM_CATEGORY_P_OPEN_USER_PIE_MENU] = RebuildUserPieMenuPresetSelectionChoices()
	ui.actionValueChoices[CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU], ui.actionValueChoicesValues[CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU], ui.actionValueChoicesTooltips[CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU] = RebuildExternalPieMenuPresetSelectionChoices()
	ui.actionValueChoices[CSPM_CATEGORY_S_PIE_MENU_ADDON], ui.actionValueChoicesValues[CSPM_CATEGORY_S_PIE_MENU_ADDON], ui.actionValueChoicesTooltips[CSPM_CATEGORY_S_PIE_MENU_ADDON] = RebuildShortcutSelectionChoicesByCategory(CSPM_CATEGORY_S_PIE_MENU_ADDON)
	ui.actionValueChoices[CSPM_CATEGORY_S_MAIN_MENU], ui.actionValueChoicesValues[CSPM_CATEGORY_S_MAIN_MENU], ui.actionValueChoicesTooltips[CSPM_CATEGORY_S_MAIN_MENU] = RebuildShortcutSelectionChoicesByCategory(CSPM_CATEGORY_S_MAIN_MENU)
	ui.actionValueChoices[CSPM_CATEGORY_S_SYSTEM_MENU], ui.actionValueChoicesValues[CSPM_CATEGORY_S_SYSTEM_MENU], ui.actionValueChoicesTooltips[CSPM_CATEGORY_S_SYSTEM_MENU] = RebuildShortcutSelectionChoicesByCategory(CSPM_CATEGORY_S_SYSTEM_MENU)
	ui.actionValueChoices[CSPM_CATEGORY_S_USEFUL_SHORTCUT], ui.actionValueChoicesValues[CSPM_CATEGORY_S_USEFUL_SHORTCUT], ui.actionValueChoicesTooltips[CSPM_CATEGORY_S_USEFUL_SHORTCUT] = RebuildShortcutSelectionChoicesByCategory(CSPM_CATEGORY_S_USEFUL_SHORTCUT)

	CALLBACK_MANAGER:RegisterCallback("CSPM-UserPieMenuInfoUpdated", RefreshPanel_OnUserPieMenuInfoUpdated)
	ZO_COLLECTIBLE_DATA_MANAGER:RegisterCallback("OnCollectionUpdated", CollectibleDataManager_OnCollectionUpdated)
end

function CSPM:CreateMenuEditorPanel()
	local panelData = {
		type = "panel", 
		name = "Shortcut PieMenu", 
		displayName = "Calamath's Shortcut Pie Menu (Editor)", 
		author = CSPM.author, 
		version = CSPM.version, 
		website = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html", 
		feedback = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html#comments", 
		donation = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html#donate", 
		slashCommand = "/cspm.settings", 
		registerForRefresh = true, 
--		registerForDefaults = true, 
--		resetFunc = nil, 
	}
	ui.panel = LAM:RegisterAddonPanel("CSPM_OptionsMenuEditor", panelData)
	self.panelMenuEditor = ui.panel

	local submenuPieVisual = {}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "editbox", 
		name = L(SI_CSPM_UI_VISUAL_PRESET_NAME_OVERRIDE_NAME), 
		tooltip = L(SI_CSPM_UI_VISUAL_PRESET_NAME_OVERRIDE_TIPS), 
		getFunc = function() return CSPM.db.preset[uiPresetId].name end, 
		setFunc = function(newPresetName)
			CSPM.db.preset[uiPresetId].name = newPresetName
			CSPM:UpdateUserPieMenuInfo(uiPresetId, CSPM.db.preset[uiPresetId])
		end, 
		isMultiline = false, 
		isExtraWide = false, 
		maxChars = 1999, 
		width = "full", 
--		disabled = true, 
		default = "", 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "editbox", 
		name = L(SI_CSPM_UI_VISUAL_PRESET_NOTE_NAME), 
		tooltip = L(SI_CSPM_UI_VISUAL_PRESET_NOTE_TIPS), 
		getFunc = function() return CSPM.db.preset[uiPresetId].tooltip or "" end, 
		setFunc = function(newPresetNote)
			CSPM.db.preset[uiPresetId].tooltip = newPresetNote
			CSPM:UpdateUserPieMenuInfo(uiPresetId, CSPM.db.preset[uiPresetId])
		end, 
		isMultiline = false, 
		isExtraWide = false, 
		maxChars = 1999, 
		width = "full", 
--		disabled = true, 
		default = "", 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "header", 
		name = L(SI_CSPM_UI_VISUAL_HEADER1_TEXT), -- "Visual Design Options"
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_VISUAL_QUICKSLOT_STYLE_OP_NAME), 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showTrackQuickslot end, 
		setFunc = function(newValue)
			CSPM.db.preset[uiPresetId].visual.showTrackQuickslot = newValue
			CSPM.db.preset[uiPresetId].visual.showTrackGamepad = not newValue
		end, 
		tooltip = L(SI_CSPM_UI_VISUAL_QUICKSLOT_STYLE_OP_TIPS), 
		width = "full", 
		default = false, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_VISUAL_GAMEPAD_STYLE_OP_NAME), 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showTrackGamepad end, 
		setFunc = function(newValue)
			CSPM.db.preset[uiPresetId].visual.showTrackGamepad = newValue
			CSPM.db.preset[uiPresetId].visual.showTrackQuickslot = not newValue
		end, 
		tooltip = L(SI_CSPM_UI_VISUAL_GAMEPAD_STYLE_OP_TIPS), 
		width = "full", 
		default = true, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "divider", 
		width = "full", 
		height = 10, 
		alpha = 0.5, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_VISUAL_SHOW_PRESET_NAME_OP_NAME), 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showPresetName end, 
		setFunc = function(newValue) CSPM.db.preset[uiPresetId].visual.showPresetName = newValue end, 
		tooltip = L(SI_CSPM_UI_VISUAL_SHOW_PRESET_NAME_OP_TIPS), 
		width = "full", 
		default = false, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_VISUAL_SHOW_SLOT_NAME_OP_NAME), 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showSlotLabel end, 
		setFunc = function(newValue) CSPM.db.preset[uiPresetId].visual.showSlotLabel = newValue end, 
		tooltip = L(SI_CSPM_UI_VISUAL_SHOW_SLOT_NAME_OP_TIPS), 
		width = "full", 
		default = true, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_VISUAL_SHOW_ICON_FRAME_OP_NAME), 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showIconFrame end, 
		setFunc = function(newValue) CSPM.db.preset[uiPresetId].visual.showIconFrame = newValue end, 
		tooltip = L(SI_CSPM_UI_VISUAL_SHOW_ICON_FRAME_OP_TIPS), 
		width = "full", 
		default = true, 
	}

	local optionsData = {}
--[[
	optionsData[#optionsData + 1] = {
		type = "divider", 
		width = "full", 
		height = 10, 
		alpha = 0.5, 
	}
]]
	optionsData[#optionsData + 1] = {
		type = "description", 
		title = "", 
		text = L(SI_CSPM_UI_PANEL_HEADER2_TEXT), 
	}
	optionsData[#optionsData + 1] = {
		type = "submenu",
		name = ui.presetChoices[uiPresetId], 
--		icon = "path/to/my/icon.dds", -- or function returning a string (optional)
--		iconTextureCoords = {left, right, top, bottom}, -- or function returning a table (optional)
		tooltip = L(SI_CSPM_UI_PRESET_VISUAL_SUBMENU_TIPS), 
--		disabled = function() return db.someBooleanSetting end, -- or boolean (optional)
--		disabledLabel = function() return db.someBooleanSetting end, -- or boolean (optional)
		reference = "CSPM_UI_PresetSubmenu" ,
		controls = submenuPieVisual, 
	}
	optionsData[#optionsData + 1] = {
		type = "slider", 
		name = L(SI_CSPM_UI_MENU_ITEMS_COUNT_OP_NAME), 
		tooltip = L(SI_CSPM_UI_MENU_ITEMS_COUNT_OP_TIPS), 
		min = 2,
		max = 11,
		step = 1, 
		getFunc = function() return CSPM.db.preset[uiPresetId].menuItemsCount end, 
		setFunc = OnMenuItemCountChanged,
		clampInput = false, 
		default = CSPM_MENU_ITEMS_COUNT_DEFAULT, 
		reference = "CSPM_UI_MenuItemsCountSlider", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_SLOT_SELECT_MENU_NAME), 
		tooltip = L(SI_CSPM_UI_SLOT_SELECT_MENU_TIPS), 
		choices = ui.slotChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.slotChoicesValues, 
--		choicesTooltips = ui.slotChoicesTooltips, 
		getFunc = function() return uiSlotId end, 
		setFunc = OnSlotIdSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "half", 
--		scrollable = true, 
		default = 1, 
		reference = "CSPM_UI_SlotSelectMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "description", 
		title = " ", 
		text = " ", 
		width = "half", 
	}
	optionsData[#optionsData + 1] = {
		type = "header", 
		name = ui.slotChoices[uiSlotId], 
		reference = "CSPM_UI_TabHeader", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_ACTION_TYPE_MENU_NAME), 
		tooltip = L(SI_CSPM_UI_ACTION_TYPE_MENU_TIPS), 
		choices = ui.actionTypeChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.actionTypeChoicesValues, 
		choicesTooltips = ui.actionTypeChoicesTooltips, 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].type end, 
		setFunc = OnActionTypeSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--		width = "half", 
--		scrollable = true, 
		default = CSPM_ACTION_TYPE_NOTHING, 
		reference = "CSPM_UI_ActionTypeMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_CATEGORY_MENU_NAME), 
--		tooltip = L(SI_CSPM_UI_CATEGORY_MENU_TIPS), 
		choices = ui.categoryChoices[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.categoryChoicesValues[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 
--		choicesTooltips = ui.categoryChoicesTooltips[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].category end, 
		setFunc = OnCategorySelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--		width = "half", 
--		scrollable = true, 
		default = CSPM_CATEGORY_NOTHING, 
		reference = "CSPM_UI_CategoryMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_ACTION_VALUE_MENU_NAME), 
--		tooltip = L(SI_CSPM_UI_ACTION_VALUE_MENU_TIPS), 
		choices = ui.actionValueChoices[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.actionValueChoicesValues[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 
		choicesTooltips = ui.actionValueChoicesTooltips[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].value end, 
		setFunc = OnActionValueSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		sort = "name-up", 
--		width = "half", 
		scrollable = 15, 
		default = 0, 
		reference = "CSPM_UI_ActionValueMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "editbox", 
		name = "", 
		tooltip = L(SI_CSPM_UI_ACTION_VALUE_EDITBOX_TIPS), 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].value end, 
		setFunc = OnActionValueEditboxChanged, 
		isMultiline = false, 
		isExtraWide = false, 
		maxChars = 1999, 
--		width = "half", 
		disabled = function()
			local uiCategoryId = CSPM.db.preset[uiPresetId].slot[uiSlotId].category
			return uiCategoryId ~= CSPM_CATEGORY_IMMEDIATE_VALUE
		end, 
		default = 0, 
		reference = "CSPM_UI_ActionValueEditbox", 
	}
	optionsData[#optionsData + 1] = {
		type = "divider", 
		width = "full", 
		height = 10, 
		alpha = 0.25, 
	}
	optionsData[#optionsData + 1] = {
		type = "editbox", 
		name = L(SI_CSPM_UI_VISUAL_SLOT_NAME_OVERRIDE_NAME), 
		tooltip = L(SI_CSPM_UI_VISUAL_SLOT_NAME_OVERRIDE_TIPS), 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].name end, 
		setFunc = OnSlotNameEditboxChanged, 
		isMultiline = false, 
		isExtraWide = false, 
		maxChars = 1999, 
--		textType = TEXT_TYPE_NUMERIC, -- number (optional) or function returning a number. Valid TextType numbers: TEXT_TYPE_ALL, TEXT_TYPE_ALPHABETIC, TEXT_TYPE_ALPHABETIC_NO_FULLWIDTH_LATIN, TEXT_TYPE_NUMERIC, TEXT_TYPE_NUMERIC_UNSIGNED_INT, TEXT_TYPE_PASSWORD
		width = "full", 
--		disabled = true, 
		default = "", 
		reference = "CSPM_UI_SlotNameEditbox", 
	}
	optionsData[#optionsData + 1] = {
		type = "button", 
		name = L(SI_CSPM_UI_DEFAULT_SLOT_NAME_BUTTON_NAME), 
		tooltip = L(SI_CSPM_UI_DEFAULT_SLOT_NAME_BUTTON_TIPS), 
		func = function()
			local actionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
			local categoryId = CSPM.db.preset[uiPresetId].slot[uiSlotId].category
			local actionValue = CSPM.db.preset[uiPresetId].slot[uiSlotId].value
			local newSlotName = CSPM.util.GetDefaultSlotName(actionTypeId, categoryId, actionValue) 
			CSPM_UI_SlotNameEditbox:UpdateValue(false, newSlotName)
		end, 
		width = "full", 
--		disabled = true, 
		disabled = function()
			local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
			if uiActionTypeId == CSPM_ACTION_TYPE_COLLECTIBLE or uiActionTypeId == CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE or uiActionTypeId == CSPM_ACTION_TYPE_EMOTE or uiActionTypeId == CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE or uiActionTypeId == CSPM_ACTION_TYPE_PIE_MENU then
				return false
			else
				return true
			end
		end, 
--		isDangerous = false, 
--		warning = "Will need to reload the UI.", -- (optional)
--		reference = "CSPM_UI_GetSlotNameButton", 
	}
	optionsData[#optionsData + 1] = {
		type = "editbox", 
		name = L(SI_CSPM_UI_VISUAL_SLOT_ICON_OVERRIDE_NAME), 
		tooltip = L(SI_CSPM_UI_VISUAL_SLOT_ICON_OVERRIDE_TIPS), 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].icon end, 
		setFunc = OnSlotIconEditboxChanged, 
		isMultiline = false, 
		isExtraWide = false, 
		maxChars = 1999, 
--		textType = TEXT_TYPE_NUMERIC, -- number (optional) or function returning a number. Valid TextType numbers: TEXT_TYPE_ALL, TEXT_TYPE_ALPHABETIC, TEXT_TYPE_ALPHABETIC_NO_FULLWIDTH_LATIN, TEXT_TYPE_NUMERIC, TEXT_TYPE_NUMERIC_UNSIGNED_INT, TEXT_TYPE_PASSWORD
		width = "full", 
--		disabled = true, 
		default = "", 
		reference = "CSPM_UI_SlotIconEditbox", 
	}
--[[
	optionsData[#optionsData + 1] = {
		type = "button", 
		name = "Test", 
		func = DoTestButton, 
--		width = "half", 
	}
]]
	LAM:RegisterOptionControls("CSPM_OptionsMenuEditor", optionsData)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelOpened", OnLAMPanelOpened)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelClosed", OnLAMPanelClosed)
end

function CSPM:OpenMenuEditorPanel(presetId, slotId)
	if self.panelMenuEditor then
		LAM:OpenToPanel(self.panelMenuEditor)
		if presetId and CSPM:IsUserPieMenu(presetId) then
			if ui.panelInitialized then
				ChangePanelPresetState(presetId)
				if slotId then
					ChangePanelSlotState(slotId)
				end
			else
				zo_callLater(function()
					ChangePanelPresetState(presetId)
					if slotId then
						ChangePanelSlotState(slotId)
					end
				end, 1000)
			end
		end
	end
end
