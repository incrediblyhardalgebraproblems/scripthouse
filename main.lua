-- LocalScript
-- Put this in StarterPlayerScripts or inside StarterGui as a LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "CoolDummyGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(560, 360)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(110, 110, 170)
mainStroke.Transparency = 0.5
mainStroke.Thickness = 1
mainStroke.Parent = main

local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.Size = UDim2.new(1, 0, 0, 44)
topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
topbar.BorderSizePixel = 0
topbar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = topbar

local topMask = Instance.new("Frame")
topMask.Size = UDim2.new(1, 0, 0, 14)
topMask.Position = UDim2.new(0, 0, 1, -14)
topMask.BackgroundColor3 = topbar.BackgroundColor3
topMask.BorderSizePixel = 0
topMask.Parent = topbar

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(14, 0)
title.Size = UDim2.new(1, -160, 1, 0)
title.Font = Enum.Font.GothamSemibold
title.Text = "Dummy GUI"
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topbar

local minimize = Instance.new("TextButton")
minimize.Name = "Minimize"
minimize.Size = UDim2.fromOffset(34, 26)
minimize.Position = UDim2.new(1, -78, 0.5, -13)
minimize.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minimize.BorderSizePixel = 0
minimize.Text = "—"
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.Parent = topbar
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(34, 26)
close.Position = UDim2.new(1, -40, 0.5, -13)
close.BackgroundColor3 = Color3.fromRGB(130, 50, 60)
close.BorderSizePixel = 0
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.Parent = topbar
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

local tabBar = Instance.new("Frame")
tabBar.BackgroundTransparency = 1
tabBar.Position = UDim2.fromOffset(12, 56)
tabBar.Size = UDim2.new(1, -24, 0, 34)
tabBar.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 8)
tabLayout.Parent = tabBar

local content = Instance.new("Frame")
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(12, 98)
content.Size = UDim2.new(1, -24, 1, -110)
content.Parent = main

local pages = {}
local tabButtons = {}

local function makePage(name)
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = content
	pages[name] = page
	return page
end

local function makeTab(text)
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.fromOffset(94, 34)
	tab.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
	tab.BorderSizePixel = 0
	tab.Text = text
	tab.TextColor3 = Color3.fromRGB(240, 240, 255)
	tab.Font = Enum.Font.GothamSemibold
	tab.TextSize = 13
	tab.Parent = tabBar
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 10)
	table.insert(tabButtons, tab)
	return tab
end

local function makeCard(parent, y)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 96)
	card.Position = UDim2.fromOffset(0, y)
	card.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
	card.BorderSizePixel = 0
	card.Parent = parent
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(100, 100, 140)
	stroke.Transparency = 0.65
	stroke.Parent = card

	return card
end

local function makeButton(parent, text, x, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(120, 32)
	b.Position = UDim2.fromOffset(x, y)
	b.BackgroundColor3 = Color3.fromRGB(54, 54, 76)
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.GothamSemibold
	b.TextSize = 13
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(66, 66, 92)}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(54, 54, 76)}):Play()
	end)

	return b
end

local function makeToggle(parent, text, x, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromOffset(150, 32)
	btn.Position = UDim2.fromOffset(x, y)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	btn.BorderSizePixel = 0
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 13
	btn.Parent = parent
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	local on = false
	btn.MouseButton1Click:Connect(function()
		on = not on
		btn.Text = text .. (on and ": ON" or ": OFF")
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = on and Color3.fromRGB(70, 95, 70) or Color3.fromRGB(40, 40, 55)
		}):Play()
	end)

	return btn
end

local function makeSlider(parent, label, x, y)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromOffset(260, 38)
	frame.Position = UDim2.fromOffset(x, y)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local txt = Instance.new("TextLabel")
	txt.BackgroundTransparency = 1
	txt.Size = UDim2.new(1, 0, 0, 14)
	txt.Font = Enum.Font.Gotham
	txt.Text = label .. ": 50"
	txt.TextColor3 = Color3.fromRGB(230, 230, 240)
	txt.TextSize = 12
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.Parent = frame

	local bar = Instance.new("Frame")
	bar.Position = UDim2.fromOffset(0, 20)
	bar.Size = UDim2.new(1, 0, 0, 10)
	bar.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
	bar.BorderSizePixel = 0
	bar.Parent = frame
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(0.5, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(120, 120, 255)
	fill.BorderSizePixel = 0
	fill.Parent = bar
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local dragging = false
	local value = 50

	local function setFromX(xPos)
		local rel = math.clamp((xPos - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		value = math.floor(rel * 100 + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		txt.Text = label .. ": " .. value
	end

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			setFromX(input.Position.X)
		end
	end)

	bar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			setFromX(input.Position.X)
		end
	end)
end

local function setActiveTab(name)
	for n, page in pairs(pages) do
		page.Visible = (n == name)
	end

	for _, tab in ipairs(tabButtons) do
		tab.BackgroundColor3 = (tab.Text == name) and Color3.fromRGB(72, 72, 102) or Color3.fromRGB(32, 32, 44)
	end
end

local home = makePage("Home")
local settings = makePage("Settings")
local info = makePage("Info")

local tab1 = makeTab("Home")
local tab2 = makeTab("Settings")
local tab3 = makeTab("Info")

tab1.MouseButton1Click:Connect(function() setActiveTab("Home") end)
tab2.MouseButton1Click:Connect(function() setActiveTab("Settings") end)
tab3.MouseButton1Click:Connect(function() setActiveTab("Info") end)

local homeCard1 = makeCard(home, 0)
local homeCard2 = makeCard(home, 106)

makeButton(homeCard1, "Button A", 14, 30)
makeButton(homeCard1, "Button B", 144, 30)
makeToggle(homeCard1, "Switch", 274, 30)

makeSlider(homeCard2, "Speed", 14, 16)
makeSlider(homeCard2, "Opacity", 14, 54)

local settingsCard1 = makeCard(settings, 0)
local settingsCard2 = makeCard(settings, 106)

makeToggle(settingsCard1, "Glow", 14, 30)
makeToggle(settingsCard1, "Accent", 174, 30)
makeButton(settingsCard2, "Apply", 14, 30)
makeButton(settingsCard2, "Reset", 144, 30)

local infoCard = makeCard(info, 0)
local infoText = Instance.new("TextLabel")
infoText.BackgroundTransparency = 1
infoText.Size = UDim2.new(1, -28, 1, -20)
infoText.Position = UDim2.fromOffset(14, 10)
infoText.Font = Enum.Font.Gotham
infoText.Text = "This is a dummy UI for your own Roblox game.\nIt only changes visuals and does not do anything gameplay-related."
infoText.TextColor3 = Color3.fromRGB(235, 235, 245)
infoText.TextSize = 14
infoText.TextWrapped = true
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoCard

setActiveTab("Home")

local minimized = false
local expandedSize = UDim2.fromOffset(560, 360)
local minimizedSize = UDim2.fromOffset(560, 44)

minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	for _, child in ipairs(main:GetChildren()) do
		if child ~= topbar then
			child.Visible = not minimized
		end
	end
	TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = minimized and minimizedSize or expandedSize
	}):Play()
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

do
	local dragging = false
	local dragStart
	local startPos

	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
		end
	end)

	topbar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			local goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			TweenService:Create(main, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = goal}):Play()
		end
	end)
end
