--
-- LibCPieMenu [LCPM]
--
-- Copyright (c) 2022 Calamath
--
-- This software is released under the Artistic License 2.0
-- https://opensource.org/licenses/Artistic-2.0
--
-- Note :
-- This addon works that uses the add-on CShortcutPieMenu by Calamath, released under the Artistic License 2.0
-- You will need to obtain the above add-on separately.
--

if LibCPieMenu then return end
-- ---------------------------------------------------------------------------------------
-- Dependencies
-- ---------------------------------------------------------------------------------------
local CShortcutPieMenu = CShortcutPieMenu
if not CShortcutPieMenu then d("[LibCPieMenu] Error : 'CShortcutPieMenu' not found.") return end

-- ---------------------------------------------------------------------------------------
-- Name Space
-- ---------------------------------------------------------------------------------------
local LCPM = {
	name = "LibCPieMenu", 
	version = "1.0.2", 
	author = "Calamath", 
}	
LibCPieMenu = LCPM


-- ---------------------------------------------------------------------------------------
-- API
-- ---------------------------------------------------------------------------------------
-- * LibCPieMenu:RegisterPieMenu(*string* _presetId_, *table* _pieMenuData)
-- NOTE: The first character of the presetId must begin with something other than an exclamation mark. (! : exclamation mark)
function LibCPieMenu:RegisterPieMenu(presetId, pieMenuData)
	return CShortcutPieMenu:RegisterPieMenu(presetId, pieMenuData)
end

