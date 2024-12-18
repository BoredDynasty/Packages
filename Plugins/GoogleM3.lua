--!strict

--[[
    BoredDynasty
--]]

-- GoogleM3.lua

-- // Services -- //

local ServerStorage = game:GetService("ServerStorage")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

-- // Requires -- //
local Style = require(script:WaitForChild("Style"))

-- // Variables -- //

local dock = plugin:CreateToolbar("GoogleM3")

-- // Setup -- //

local style_dark = dock:CreateButton("Style Dark", "Styles the selected GuiObject to M3.")

-- // Functions -- //

local function styleDark()
	local objects = Selection:Get()
	task.spawn(function()
		if objects > 0 then
			for _, object in objects do
				if object:IsA("GuiObject") then
					Style(object)
					ChangeHistoryService:SetWaypoint(`Styled: {object} to M3`)
				end
			end
		end
	end)
end

style_dark.Click:Connect(styleDark)
