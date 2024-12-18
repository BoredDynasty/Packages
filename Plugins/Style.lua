local dark = {
	Button = {
		["BackgroundColor3"] = Color3.fromHex(""),
	},
	Canvas = {
		["BackgroundColor3"] = Color3.fromHex(""),
		["CornerRadius"] = Vector2.new(0.2, 0),
	},
}

local function style_accordingly(inst: Instance, class: string, mode: {})
	return task.spawn(function()
		if class == "Button" then
			for _, value: {} in ipairs(mode) do
				for property, prop_value in ipairs(value) do
					if inst[property] then
						inst[property] = prop_value
					end
				end
			end
		end
	end)
end

return function(object: Instance)
	if object:IsA("TextButton") or object:IsA("ImageButton") then
		style_accordingly(object, "Button", dark)
	end
end
