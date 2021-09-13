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

local LDL
--local debugMode = true
if debugMode and LibDebugLogger then
	LDL = LibDebugLogger("CSPM-class")
else
	LDL = { Verbose = function() end, Debug = function() end, Info = function() end, Warn = function() end, Error = function() end, }
end

-- Template
-- NOTE : This template is based on ZO_SelectableItemRadialMenuEntryTemplate by ZOS, with its own extensions and size adjustment to fit the UI design of the CShortcutPieMenu add-on.
function CSPM_SelectableItemRadialMenuEntryTemplate_OnInitialized(self)
	self.glow = self:GetNamedChild("Glow")
	self.icon = self:GetNamedChild("Icon")
	self.count = self:GetNamedChild("CountText")
	self.cooldown = self:GetNamedChild("Cooldown")

	self.frame = self:GetNamedChild("Frame")
	self.label = self:GetNamedChild("Label")
	self.label:SetDimensionConstraints(0, 0, 360, 64)
	self.status = self:GetNamedChild("StatusText")
end

function CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(template, statusLabelText)
	statusLabelText = statusLabelText or ""
	template.status:SetText(statusLabelText)
end

function CSPM_SetupSelectableItemRadialMenuEntryTemplate(template, selected, itemCount, showIconFrame, slotLabelText, statusLabelText)
	if showIconFrame then
		template.frame:SetHidden(false)
	else
		template.frame:SetHidden(true)
	end

	slotLabelText = slotLabelText or ""
	template.label:SetText(slotLabelText)

	CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(template, statusLabelText)

	if itemCount then
		template.count:SetHidden(false)
		template.count:SetText(itemCount)

		if itemCount == 0 then
			template.icon:SetDesaturation(1)
		else
			template.icon:SetDesaturation(0)
		end
	else
		template.count:SetHidden(true)
		template.icon:SetDesaturation(0)
	end

	if selected then
		if template.glow then
			template.glow:SetAlpha(1)
		end
		template.animation:GetLastAnimation():SetAnimatedControl(nil)
	else
		if template.glow then
			template.glow:SetAlpha(0)
		end
		template.animation:GetLastAnimation():SetAnimatedControl(template.glow)
	end
end

-- ------------------------------------------------
-- Class

-- NOTE : Since this add-on emphasizes interface consistency with the QuickSlot system and Fishing Manager, 
--        the pie menu control class inherits from ZOS's ZO_InteractiveRadialMenuController class.
--        However, there are some methods that are overridden for functional extensions and differences, 
--        and some of them may contain some of the original code of ZO_RadialMenu and ZO_InteractiveRadialMenuController by ZOS.
--
if CSPM_PieMenuController then return end

local TIME_TO_HOLD_KEY_MS = 250
local ROTATION_OFFSET = 3 * math.pi / 2
local CSPM_INTERCEPTOR = {
	["CSPM_KEY_MOUSE_LEFT"] = { KEY_MOUSE_LEFT, }, 
	["CSPM_KEY_MOUSE_LEFTRIGHT"] = { KEY_MOUSE_LEFTRIGHT, }, 
	["CSPM_KEY_MOUSE_MIDDLE"] = { KEY_MOUSE_MIDDLE, }, 
	["CSPM_KEY_MOUSE_RIGHT"] = { KEY_MOUSE_RIGHT, }, 
	["CSPM_KEY_MOUSEWHEEL_DOWN"] = { KEY_MOUSEWHEEL_DOWN, }, 
	["CSPM_KEY_MOUSEWHEEL_UP"] = { KEY_MOUSEWHEEL_UP, }, 
	["CSPM_KEY_MOUSE_4"] = { KEY_MOUSE_4, }, 
	["CSPM_KEY_MOUSE_5"] = { KEY_MOUSE_5, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_1"] = { KEY_GAMEPAD_BUTTON_1, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_2"] = { KEY_GAMEPAD_BUTTON_2, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_3"] = { KEY_GAMEPAD_BUTTON_3, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_4"] = { KEY_GAMEPAD_BUTTON_4, }, 
	["CSPM_HUD_KEY_MOUSE_LEFT"] = { KEY_MOUSE_LEFT, }, 
	["CSPM_HUD_KEY_MOUSE_LEFTRIGHT"] = { KEY_MOUSE_LEFTRIGHT, }, 
	["CSPM_HUD_KEY_MOUSE_MIDDLE"] = { KEY_MOUSE_MIDDLE, }, 
	["CSPM_HUD_KEY_MOUSE_RIGHT"] = { KEY_MOUSE_RIGHT, }, 
	["CSPM_HUD_KEY_MOUSEWHEEL_DOWN"] = { KEY_MOUSEWHEEL_DOWN, }, 
	["CSPM_HUD_KEY_MOUSEWHEEL_UP"] = { KEY_MOUSEWHEEL_UP, }, 
	["CSPM_HUD_KEY_MOUSE_4"] = { KEY_MOUSE_4, }, 
	["CSPM_HUD_KEY_MOUSE_5"] = { KEY_MOUSE_5, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_1"] = { KEY_GAMEPAD_BUTTON_1, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_2"] = { KEY_GAMEPAD_BUTTON_2, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_3"] = { KEY_GAMEPAD_BUTTON_3, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_4"] = { KEY_GAMEPAD_BUTTON_4, }, 
}
local pieMenuCount = pieMenuCount or 0

CSPM_PieMenuController = ZO_InteractiveRadialMenuController:Subclass()

function CSPM_PieMenuController:New(...)
    return ZO_InteractiveRadialMenuController.New(self, ...)
end

function CSPM_PieMenuController:Initialize(control, entryTemplate, animationTemplate, entryAnimationTemplate)
	ZO_InteractiveRadialMenuController.Initialize(self, control, entryTemplate, animationTemplate, entryAnimationTemplate)
	pieMenuCount = pieMenuCount + 1
	self.menu.presetLabel = self.menuControl:GetNamedChild("PresetName")
	self.menu.trackQuickslot = self.menuControl:GetNamedChild("TrackQuickslot")
	self.menu.trackGamepad = self.menuControl:GetNamedChild("TrackGamepad")
	self.menu.underlay = self.menuControl:GetNamedChild("Underlay")
	self.menu.overlay = self.menuControl:GetNamedChild("Overlay")
	self.menu.overlay:SetHandler("OnMouseDown", function(control, button, ...) self:OnGlobalKeyDown(ConvertMouseButtonToKeyCode(button), ...) end)
	self.menu.overlay:SetHandler("OnMouseWheel", function(control, delta, ...) self:OnGlobalKeyDown((delta > 0) and KEY_MOUSEWHEEL_UP or KEY_MOUSEWHEEL_DOWN, ...) end)
	self.menu.overlay:SetHandler("OnKeyDown", function(control, ...) self:OnGlobalKeyDown(...) end)
	CALLBACK_MANAGER:RegisterCallback("CSPM-KeyDownHUD", function(...) self:OnGlobalKeyDown(...) end)
	self.isTopmost = false
	self.allowActivateInUIMode = true
	self.allowClickable = true
	self.centeringAtMouseCursor = false
	self.timeToHoldKey = TIME_TO_HOLD_KEY_MS
	self.bindings = {}
	for k, v in pairs(CSPM_INTERCEPTOR) do
		local layer, category, action = GetActionIndicesFromName(k)
		if layer and category and action then
			if IsProtectedFunction("UnbindAllKeysFromAction") then
				CallSecureProtected("UnbindAllKeysFromAction", layer, category, action)
			else
				UnbindAllKeysFromAction(layer, category, action)
			end
			if IsProtectedFunction("BindKeyToAction") then
				CallSecureProtected("BindKeyToAction", layer, category, action, 1, v[1], v[2], v[3], v[4], v[5])
			else
				BindKeyToAction(layer, category, action, 1,  v[1], v[2], v[3], v[4], v[5])
			end
		end
	end
	if self.menu.SetOnUpdateRotationFunction then
		self.rotationRaw = ROTATION_OFFSET
		self.menu:SetOnUpdateRotationFunction(function(...) self:OnUpdateRotationCallback(...) end)
	end
	EVENT_MANAGER:RegisterForEvent("CSPM-class_PieMenu" .. pieMenuCount, EVENT_LUA_ERROR, function()
		if self.menu:IsShown() then
			self.menu.ForceActiveMenuClosed()
		end
	end)
	-- Overridden some methods of the original ZO_RadialMenu class by ZOS.
	self.menu.OnUpdate = function(self)
		if self:UpdateVirtualMousePosition() then
			self:UpdateSelectedEntryFromVirtualMousePosition()
		end
	end
end

function CSPM_PieMenuController:SetOnSelectionChangedCallback(callback)
    self.onSelectionChangedCallback = callback
end

function CSPM_PieMenuController:SetOnUpdateRotationFunction(callback)
    self.onUpdateRotationFunc = callback
end

function CSPM_PieMenuController:SetPopulateMenuCallback(callback)
    self.populateMenuCallback = callback
end

function CSPM_PieMenuController:OnGlobalKeyDown(key, ctrl, alt, shift, command)
	if self.bindings[key] then
		self.bindings[key](key, ctrl, alt, shift, command)
	end
end

function CSPM_PieMenuController:SetActionLayer(actionLayerName)
	self.menu.actionLayerName = actionLayerName
end

function CSPM_PieMenuController:SetSelectIfCentered(selectIfCentered)
	self.menu.selectIfCentered = selectIfCentered
end

function CSPM_PieMenuController:IsTopmost()
	return self.isTopmost
end

function CSPM_PieMenuController:SetTopmost(isTopmost)
	self.isTopmost = isTopmost
	self.menuControl:GetParent():SetTopmost(isTopmost)
end

function CSPM_PieMenuController:ShowUnderlay()
	if self.menu.underlay then
		self.menu.underlay:SetHidden(false)
	end
end

function CSPM_PieMenuController:HideUnderlay()
	if self.menu.underlay then
		self.menu.underlay:SetHidden(true)
	end
end

function CSPM_PieMenuController:ShowOverlay()
	if self.menu.overlay then
		self.menu.overlay:SetHidden(false)
	end
end

function CSPM_PieMenuController:HideOverlay()
	if self.menu.overlay then
		self.menu.overlay:SetHidden(true)
	end
end

function CSPM_PieMenuController:SetAllowActivateInUIMode(allowActivateInUIMode)
	self.allowActivateInUIMode = allowActivateInUIMode
end

function CSPM_PieMenuController:SetAllowClickable(allowClickable)
	self.allowClickable = allowClickable
end

function CSPM_PieMenuController:SetCenteringAtMouseCursor(centeringAtMouseCursor)
	self.centeringAtMouseCursor = centeringAtMouseCursor
end

function CSPM_PieMenuController:SetTimeToHoldKey(timeToHoldKey)
	self.timeToHoldKey = timeToHoldKey or TIME_TO_HOLD_KEY_MS
end

function CSPM_PieMenuController:SetAnchorOffset(offsetX, offsetY)
	self.menuControl:ClearAnchors()
	self.menuControl:SetAnchor(CENTER, guiRoot, CENTER, offsetX, offsetY)
end

function CSPM_PieMenuController:SetAnchorToMousePosition()
	local centerX, centerY = GuiRoot:GetCenter()
	local x, y = GetUIMousePosition()
	self:SetAnchorOffset(x - centerX, y - centerY)
end

function CSPM_PieMenuController:SetAnchorToCenterPosition()
	self:SetAnchorOffset(0, 0)
end

function CSPM_PieMenuController:RegisterBindings(key, callback)
	if type(callback) == "function" then
		self.bindings[key] = callback
	end
end

function CSPM_PieMenuController:UnregisterBindings(key)
	self.bindings[key] = nil
end

function CSPM_PieMenuController:GetCurrentRotation()
	return self.rotationRaw and (self.rotationRaw - ROTATION_OFFSET) or 0.0
end

function CSPM_PieMenuController:SetupPieMenuVisual(presetName, showPresetName, showQuickslotRadialTrack, showGamepadRadialTrack)
	presetName = presetName or ""
	self.menu.presetLabel:SetText(presetName)

	if showPresetName then
		self.menu.presetLabel:SetHidden(false)
	else
		self.menu.presetLabel:SetHidden(true)
	end

	if type(showQuickslotRadialTrack) == "boolean" then
		showQuickslotRadialTrack = showQuickslotRadialTrack and 1.0 or 0.0
	end
	self.menu.trackQuickslot:SetAlpha(showQuickslotRadialTrack or 0.0)

	if type(showGamepadRadialTrack) == "boolean" then
		showGamepadRadialTrack = showGamepadRadialTrack and 0.8 or 0.0
	end
	self.menu.trackGamepad:SetAlpha(showGamepadRadialTrack or 0.0)
end

function CSPM_PieMenuController:ClearSelection(...)
	self.menu:ClearSelection(...)
end

function CSPM_PieMenuController:GetNumMenuEntries()
	return #self.menu.entries
end

function CSPM_PieMenuController:AddMenuEntry(name, inactiveIcon, activeIcon, callback, data)
	self.menu:AddEntry(name, inactiveIcon, activeIcon, callback, data)
end

function CSPM_PieMenuController:CancelInteraction()
	self:ClearSelection()
	return(self:StopInteraction())
end

-- Overridden from base class
function CSPM_PieMenuController:StopInteraction()
	if self.isInteracting then
		self:HideUnderlay()
		self:ShowOverlay()
		self:SetTopmost(false)
	end
	return(ZO_InteractiveRadialMenuController.StopInteraction(self))
end

function CSPM_PieMenuController:OnUpdate()
    if self.beginHold and GetFrameTimeMilliseconds() >= self.beginHold + self.timeToHoldKey then
        self.beginHold = nil
        if not self.isInteracting then
            self:ShowMenu()
        end
    end
end

function CSPM_PieMenuController:PrepareForInteraction()
	LDL:Debug("PrepareForInteraction()")
	local currentScene = SCENE_MANAGER:GetCurrentScene()
    if not currentScene or currentScene:IsRemoteScene() then
		return false
	end
    if IsGameCameraActive() and IsGameCameraUIModeActive() and not self.allowActivateInUIMode then
		return false
	end
    return true
end

function CSPM_PieMenuController:SetupEntryControl(entryControl, data)
	if not data then return end
	LDL:Debug("SetupEntryControl(_, %s)", tostring(data.name))
	local selected = false
	local itemCount
	local slotLabelText
	local statusLabelText = data.statusLabelText or ""
	
	if data.itemCount then
		itemCount = data.itemCount
	else
		itemCount = nil
	end

	if data.showSlotLabel then
		slotLabelText = data.name
	else
		slotLabelText = ""
	end

	CSPM_SetupSelectableItemRadialMenuEntryTemplate(entryControl, selected, itemCount, data.showIconFrame, slotLabelText, statusLabelText)
end

function CSPM_PieMenuController:OnSelectionChangedCallback(selectedEntry)
	LDL:Debug("OnSelectionChangedCallback() : %s", selectedEntry and selectedEntry.data.index or "nil")
	if not selectedEntry then return end
	if self.onSelectionChangedCallback then
		self.onSelectionChangedCallback(self, selectedEntry.data.index, selectedEntry.data)
	end
end

function CSPM_PieMenuController:OnUpdateRotationCallback(rotationRaw)
--	LDL:Debug("OnUpdateRotationCallback() : rotationRaw = %s", tostring(rotationRaw))
	self.rotationRaw = rotationRaw
	if self.onUpdateRotationFunc then
		self.onUpdateRotationFunc(self, rotationRaw)
	end
end

function CSPM_PieMenuController:PopulateMenu()
	LDL:Debug("PopulateMenu()")
	self.selectedSlotNum = 0
	if IsGameCameraActive() and IsGameCameraUIModeActive() or IsInteracting() then
		if self.allowClickable then
			self:SetActionLayer("CSPM_UI_Interceptor")
			self:ShowOverlay()
		else
			self:SetActionLayer("CSPM_Interceptor")
			self:HideOverlay()
		end
		if self.centeringAtMouseCursor then
			self:SetAnchorToMousePosition()
		else
			self:SetAnchorToCenterPosition()
		end
		self:ShowUnderlay()
	else
		if self.allowClickable then
			self:SetActionLayer("CSPM_HUD_Interceptor")
			self:ShowOverlay()
		else
			self:SetActionLayer("CSPM_Interceptor")
			self:HideOverlay()
		end
		self:SetAnchorToCenterPosition()
	end
	self:SetTopmost(true)
	if self.populateMenuCallback then
		self.populateMenuCallback(self)
	end
end
