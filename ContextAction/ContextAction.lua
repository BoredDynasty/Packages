local ContextAction = {}
ContextAction.__index = ContextAction

local UserInputService = game:GetService("UserInputService")

type buttonImg = {
	Image: string,
	ImageRectOffset: Vector2,
	ImageRectSize: Vector2,
}

local function newButton(name, img: buttonImg, color: Color3)
	-- Instances:

	local LayerCollector = Instance.new("ScreenGui")
	local FAB = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local blog_large = Instance.new("ImageLabel")

	-- Properties:

	FAB.Name = "FAB"
	FAB.Parent = game.StarterGui.Info
	FAB.AnchorPoint = Vector2.new(0.5, 0.5)
	FAB.BackgroundColor3 = color or Color3.fromRGB(103, 84, 150)
	FAB.BorderSizePixel = 0
	FAB.Position = UDim2.new(0.0503803492, 0, 0.917088628, 0)
	FAB.Size = UDim2.new(0, 50, 0, 50)
	FAB.Font = Enum.Font.GothamMedium
	FAB.Text = name
	FAB.TextColor3 = Color3.fromRGB(226, 224, 249)
	FAB.TextSize = 14.000
	FAB.TextTransparency = 0.700

	LayerCollector.Name = "LayerCollector"
	LayerCollector.IgnoreGuiInset = true

	FAB.Parent = LayerCollector
	UICorner.Parent = FAB

	blog_large.Name = "blog_large"
	blog_large.Parent = FAB
	blog_large.AnchorPoint = Vector2.new(0.5, 0.5)
	blog_large.BackgroundTransparency = 1
	blog_large.Position = UDim2.new(0.5, 0, 0.5, 0)
	blog_large.Size = UDim2.new(0, 25, 0, 25)
	blog_large.Image = img.Image
	blog_large.ImageRectOffset = img.ImageRectOffset
	blog_large.ImageRectSize = img.ImageRectSize

	return FAB
end

function ContextAction.new()
	local self = setmetatable({}, ContextAction)

	self.binding = nil :: Enum.KeyCode
	-- Registered Icons/Buttons
	self.icons = {
		[Enum.KeyCode.ButtonA] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(0, 50),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonB] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonX] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(200, 800),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonY] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(200, 750),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonL1] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(250, 150),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonR1] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(250, 0),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonL2] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(250, 100),
			ImageRectSize = Vector2.new(50, 50),
		},
		[Enum.KeyCode.ButtonR2] = {
			Image = "rbxassetid://6764432408",
			ImageRectOffset = Vector2.new(200, 950),
			ImageRectSize = Vector2.new(50, 50),
		},
	}

	self.button = newButton("Action", self.icons[Enum.KeyCode.ButtonA], Color3.fromRGB(103, 84, 150))
	return self
end

function ContextAction:setImage(key: Enum.KeyCode, img: buttonImg)
	self.icons[key] = img
end

function ContextAction:setContent(content: string)
	self.button.Text = content
end

function ContextAction:setColor(color: Color3)
	self.button.BackgroundColor3 = color
end

function ContextAction:onActivated(key: Enum.KeyCode, callback: (any?) -> ())
	self.binding = key
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == key then
			callback()
		end
	end)
end

function ContextAction:bind(callback: (any?) -> ())
	self.button = self.button :: TextButton
	self.button.Activated:Connect(callback)
end

function ContextAction:destroy()
	self.button.Parent:Destroy()
	self = nil
end

return ContextAction
