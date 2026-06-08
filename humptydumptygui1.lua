-- Humpty Dumpty Revenge GUI
-- LocalScript → Put in StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "HumptyDumptyRevenge"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(580, 420)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 16)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(120, 120, 180)
mainStroke.Transparency = 0.4
mainStroke.Thickness = 1.5

-- Topbar
local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.Size = UDim2.new(1, 0, 0, 46)
topbar.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
topbar.BorderSizePixel = 0
topbar.Parent = main

Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 16)
local topMask = Instance.new("Frame", topbar)
topMask.Size = UDim2.new(1, 0, 0, 16)
topMask.Position = UDim2.new(0, 0, 1, -16)
topMask.BackgroundColor3 = topbar.BackgroundColor3
topMask.BorderSizePixel = 0

local title = Instance.new("TextLabel", topbar)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -180, 1, 0)
title.Position = UDim2.fromOffset(16, 0)
title.Font = Enum.Font.GothamBold
title.Text = "🥚 Humpty Dumpty Revenge GUI"
title.TextSize = 17
title.TextColor3 = Color3.fromRGB(255, 240, 200)
title.TextXAlignment = Enum.TextXAlignment.Left

local minimize = Instance.new("TextButton", topbar)
minimize.Size = UDim2.fromOffset(36, 28)
minimize.Position = UDim2.new(1, -78, 0.5, -14)
minimize.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minimize.Text = "—"
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)

local close = Instance.new("TextButton", topbar)
close.Size = UDim2.fromOffset(36, 28)
close.Position = UDim2.new(1, -38, 0.5, -14)
close.BackgroundColor3 = Color3.fromRGB(135, 55, 65)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

-- Tab System
local tabBar = Instance.new("Frame", main)
tabBar.BackgroundTransparency = 1
tabBar.Position = UDim2.fromOffset(12, 56)
tabBar.Size = UDim2.new(1, -24, 0, 36)

local content = Instance.new("Frame", main)
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(12, 102)
content.Size = UDim2.new(1, -24, 1, -118)

local pages = {}
local tabButtons = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 6
    page.Visible = false
    page.Parent = content
    pages[name] = page
    return page
end

local function makeTab(text)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.fromOffset(110, 36)
    tab.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(240, 240, 255)
    tab.Font = Enum.Font.GothamSemibold
    tab.TextSize = 14
    tab.Parent = tabBar
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 10)
    table.insert(tabButtons, tab)
    return tab
end

local function setActiveTab(name)
    for n, page in pairs(pages) do
        page.Visible = (n == name)
    end
    for _, tab in ipairs(tabButtons) do
        tab.BackgroundColor3 = (tab.Text == name) and Color3.fromRGB(80, 80, 130) or Color3.fromRGB(32, 32, 44)
    end
end

-- Create Pages
local home = makePage("Home")
local movement = makePage("Movement")
local trolls = makePage("Trolls")
local revenge = makePage("Revenge")

makeTab("Home").MouseButton1Click:Connect(function() setActiveTab("Home") end)
makeTab("Movement").MouseButton1Click:Connect(function() setActiveTab("Movement") end)
makeTab("Trolls").MouseButton1Click:Connect(function() setActiveTab("Trolls") end)
makeTab("Revenge").MouseButton1Click:Connect(function() setActiveTab("Revenge") end)

setActiveTab("Home")

-- ==================== ACTUAL FEATURES ====================

local targetPlayer = nil -- For targeted trolls

-- Simple Player List (Home)
local function refreshPlayerList()
    -- You can expand this later
end

-- Domain Expansion / Infinite Goon
local domainConnection = nil
local domainAnimTrack = nil
local orbiting = false

local function StartDomainExpansion(target)
    if orbiting then return end
    if not target or not target.Character then return end
    
    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
    local myChar = player.Character
    if not targetRoot or not myChar then return end
    
    local humanoid = myChar:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    orbiting = true
    
    -- Jerk Animation
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://698251653" -- Classic jerk/goon anim
    domainAnimTrack = humanoid:LoadAnimation(anim)
    domainAnimTrack.Looped = true
    domainAnimTrack:Play()
    
    local angle = 0
    domainConnection = RunService.Heartbeat:Connect(function()
        if not orbiting or not targetRoot.Parent then
            StopDomainExpansion()
            return
        end
        
        angle += 4.5 -- Spin speed
        local radius = 12
        local height = math.sin(tick() * 4) * 4
        
        local offset = Vector3.new(math.cos(math.rad(angle)) * radius, height, math.sin(math.rad(angle)) * radius)
        local newPos = targetRoot.Position + offset
        
        local root = myChar:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(newPos, targetRoot.Position)
        end
    end)
end

function StopDomainExpansion()
    orbiting = false
    if domainConnection then domainConnection:Disconnect() end
    if domainAnimTrack then domainAnimTrack:Stop() end
end

-- Basic Fly (for Movement tab)
local flying = false
local flySpeed = 50
local bv

local function ToggleFly()
    flying = not flying
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if flying then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = root
    else
        if bv then bv:Destroy() end
    end
end

-- ==================== GUI CONTENT ====================

-- Home Page
local homeCard = Instance.new("Frame")
homeCard.Size = UDim2.new(1, 0, 0, 140)
homeCard.Position = UDim2.fromOffset(0, 10)
homeCard.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
homeCard.Parent = home
Instance.new("UICorner", homeCard).CornerRadius = UDim.new(0, 12)

local welcome = Instance.new("TextLabel", homeCard)
welcome.Size = UDim2.new(1, -20, 0, 50)
welcome.Position = UDim2.fromOffset(10, 10)
welcome.BackgroundTransparency = 1
welcome.Text = "🥚 All the King's Trolls are here.\nBreak them like Humpty."
welcome.TextColor3 = Color3.fromRGB(255, 220, 100)
welcome.TextSize = 16
welcome.Font = Enum.Font.GothamBold

-- Movement Page
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.fromOffset(140, 40)
flyBtn.Position = UDim2.fromOffset(20, 20)
flyBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
flyBtn.Text = "Toggle Fly"
flyBtn.Parent = movement
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 10)
flyBtn.MouseButton1Click:Connect(ToggleFly)

-- Revenge Page (Main Feature)
local revengeCard = Instance.new("Frame")
revengeCard.Size = UDim2.new(1, -20, 0, 220)
revengeCard.Position = UDim2.fromOffset(10, 20)
revengeCard.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
revengeCard.Parent = revenge
Instance.new("UICorner", revengeCard).CornerRadius = UDim.new(0, 12)

local domainBtn = Instance.new("TextButton")
domainBtn.Size = UDim2.fromOffset(220, 50)
domainBtn.Position = UDim2.fromOffset(20, 30)
domainBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 160)
domainBtn.Text = "🌌 DOMAIN EXPANSION\nInfinite Goon"
domainBtn.TextSize = 15
domainBtn.Font = Enum.Font.GothamBold
domainBtn.Parent = revengeCard
Instance.new("UICorner", domainBtn).CornerRadius = UDim.new(0, 12)

domainBtn.MouseButton1Click:Connect(function()
    if targetPlayer then
        StartDomainExpansion(targetPlayer)
    else
        -- Target closest player if none selected
        local closest = nil
        local dist = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local d = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = p
                end
            end
        end
        if closest then StartDomainExpansion(closest) end
    end
end)

local stopDomain = Instance.new("TextButton")
stopDomain.Size = UDim2.fromOffset(140, 40)
stopDomain.Position = UDim2.fromOffset(260, 35)
stopDomain.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
stopDomain.Text = "Stop Domain"
stopDomain.Parent = revengeCard
Instance.new("UICorner", stopDomain).CornerRadius = UDim.new(0, 10)
stopDomain.MouseButton1Click:Connect(StopDomainExpansion)

-- More buttons can be added easily...

-- Dragging + Minimize Fix
local minimized = false
local expandedSize = main.Size

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        Size = minimized and UDim2.fromOffset(220, 46) or expandedSize
    }):Play()
    
    for _, child in ipairs(main:GetChildren()) do
        if child ~= topbar then
            child.Visible = not minimized
        end
    end
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Topbar Dragging
local dragging = false
local dragStart, startPos

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
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("🥚 Humpty Dumpty Revenge GUI Loaded!")
