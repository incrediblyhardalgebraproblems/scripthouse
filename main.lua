-- LocalScript inside StarterPlayerScripts or StarterGui
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "CoolDummyGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(520, 340)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 120)
stroke.Thickness = 1
stroke.Transparency = 0.35
stroke.Parent = main

local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 42)
topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
topbar.BorderSizePixel = 0
topbar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = topbar

local topFix = Instance.new("Frame")
topFix.Size = UDim2.new(1, 0, 0, 14)
topFix.Position = UDim2.new(0, 0, 1, -14)
topFix.BackgroundColor3 = topbar.BackgroundColor3
topFix.BorderSizePixel = 0
topFix.Parent = topbar

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(14, 0)
title.Size = UDim2.new(1, -140, 1, 0)
title.Font = Enum.Font.GothamSemibold
title.Text = "Dummy GUI"
title.TextColor3 = Color3.fromRGB(235, 235, 255)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topbar

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(34, 26)
minimize.Position = UDim2.new(1, -78, 0.5, -13)
minimize.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minimize.Text = "—"
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.BorderSizePixel = 0
minimize.Parent = topbar
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 26)
close.Position = UDim2.new(1, -40, 0.5, -13)
close.BackgroundColor3 = Color3.fromRGB(120, 45, 55)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.BorderSizePixel = 0
close.Parent = topbar
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

local tabBar = Instance.new("Frame")
tabBar.BackgroundTransparency = 1
tabBar.Position = UDim2.fromOffset(12, 54)
tabBar.Size = UDim2.new(1, -24, 0, 32)
tabBar.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 8)
tabLayout.Parent = tabBar

local content = Instance.new("Frame")
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(12, 92)
content.Size = UDim2.new(1, -24, 1, -104)
content.Parent = main

local pages = {}

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
	tab.Size = UDim2.fromOffset(92, 32)
	tab.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
	tab.Text = text
	tab.TextColor3 = Color3.fromRGB(235, 235, 255)
	tab.Font = Enum.Font.GothamSemibold
	tab.TextSize = 13
	tab.BorderSizePixel = 0
	tab.Parent = tabBar
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 10)
	return tab
end

local function makeCard(parent, y)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 92)
	card.Position = UDim2.fromOffset(0, y)
	card.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
	card.BorderSizePixel = 0
	card.Parent = parent
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(90, 90, 130)
	s.Transparency = 0.6
	s.Parent = card
	return card
end

local function makeButton(parent, text, x, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(120, 32)
	b.Position = UDim2.fromOffset(x, y)
	b.BackgroundColor3 = Color3.fromRGB(52, 52, 72)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.GothamSemibold
	b.TextSize = 13
	b.BorderSizePixel = 0
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
	return b
end

local function makeToggle(parent, text, x, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromOffset(150, 30)
	btn.Position = UDim2.fromOffset(x, y)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 13
	btn.BorderSizePixel = 0
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
	frame.Size = UDim2.fromOffset(240, 36)
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
	bar.Position = UDim2.fromOffset(0, 18)
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

local function activate(name)
	for n, p in pairs(pages) do
		p.Visible = (n == name)
	end
	for _, child in ipairs(tabBar:GetChildren()) do
		if child:IsA("TextButton") then
			child.BackgroundColor3 = (child.Text == name) and Color3.fromRGB(70, 70, 100) or Color3.fromRGB(32, 32, 44)
		end
	end
end

local home = makePage("Home")
local settings = makePage("Settings")
local info = makePage("Info")

local tab1 = makeTab("Home")
local tab2 = makeTab("Settings")
local tab3 = makeTab("Info")

tab1.MouseButton1Click:Connect(function() activate("Home") end)
tab2.MouseButton1Click:Connect(function() activate("Settings") end)
tab3.MouseButton1Click:Connect(function() activate("Info") end)

local c1 = makeCard(home, 0)
local c2 = makeCard(home, 104)

makeButton(c1, "Button A", 14, 28)
makeButton(c1, "Button B", 144, 28)
makeToggle(c1, "Switch", 274, 28)

makeSlider(c2, "Speed", 14, 16)
makeSlider(c2, "Opacity", 14, 52)

local s1 = makeCard(settings, 0)
local s2 = makeCard(settings, 104)

makeToggle(s1, "Theme", 14, 28)
makeToggle(s1, "Glow", 174, 28)
makeButton(s2, "Apply", 14, 28)
makeButton(s2, "Reset", 144, 28)

local i1 = makeCard(info, 0)
local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.Size = UDim2.new(1, -28, 1, -20)
label.Position = UDim2.fromOffset(14, 10)
label.Font = Enum.Font.Gotham
label.Text = "This is a dummy UI for your own Roblox game.\nIt does not do anything except look nice."
label.TextColor3 = Color3.fromRGB(230, 230, 240)
label.TextSize = 14
label.TextWrapped = true
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.Parent = i1

activate("Home")

local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	for _, obj in ipairs(main:GetChildren()) do
		if obj ~= topbar then
			obj.Visible = not minimized
		end
	end
	main.Size = minimized and UDim2.fromOffset(520, 42) or UDim2.fromOffset(520, 340)
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

do
	local dragging, dragStart, startPos
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
			TweenService:Create(main, TweenInfo.new(0.08), {Position = goal}):Play()
		end
	end)
end
