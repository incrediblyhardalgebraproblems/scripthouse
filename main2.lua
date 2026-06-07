-- ====================================================================
-- THE REDEMPTION SUITE V1.0 (WORKING TEMPLATE INTEGRATED CORE)
-- ====================================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- --------------------------------------------------------------------
-- 1. BASE GRAPHICAL CONTAINER LAYER (YOUR WORKING ARCHITECTURE)
-- --------------------------------------------------------------------
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("RedemptionMasterGui") then
    PlayerGui.RedemptionMasterGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RedemptionMasterGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Panel Casing (Deep Charcoal Obsidian Finish)
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
Frame.BorderSizePixel = 1
Frame.BorderColor3 = Color3.fromRGB(0, 255, 128) -- Glowing Neon Green Outline
Frame.Size = UDim2.new(0, 320, 0, 260)
Frame.Position = UDim2.new(0.5, -160, 0.3, -130)

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = Frame

-- Title Banner String
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
titleLabel.Text = "THE REDEMPTION SUITE V1.0"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 13
titleLabel.Parent = Frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- --------------------------------------------------------------------
-- 2. INTEGRATED DRAG ENGINE UTILITIES (YOUR EXACT WORKING LOGIC)
-- --------------------------------------------------------------------
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- --------------------------------------------------------------------
-- 3. INTERACTION COMPONENT GENERATORS (SCROLLABLE GENERAL TAB)
-- --------------------------------------------------------------------
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -45)
ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 480) -- Vertical scrolling space for all commands
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollFrame

-- Button Generator Configuration Utility
local function addMenuButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    -- Use direct InputBegan tracking to completely bypass Delta's touch screen bugs
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            pcall(callback, btn)
        end
    end)
    
    btn.Parent = ScrollFrame
    return btn
end

-- --------------------------------------------------------------------
-- 4. GENERAL TAB TOOL DEPLOYMENT (INFINITE YIELD LEVEL EXECUTION)
-- --------------------------------------------------------------------

-- Tool 1: Universal Noclip Toggle
local noclipActive = false
addMenuButton("Toggle Noclip: OFF", function(btn)
    noclipActive = not noclipActive
    btn.Text = noclipActive and "Toggle Noclip: ACTIVE" or "Toggle Noclip: OFF"
    btn.TextColor3 = noclipActive and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(240, 240, 240)
    
    local connection
    connection = RunService.Stepped:Connect(function()
        if not noclipActive then connection:Disconnect() return end
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

-- Tool 2: Flight Mode Vector
local flyingActive = false
addMenuButton("Toggle Fly: OFF", function(btn)
    flyingActive = not flyingActive
    btn.Text = flyingActive and "Toggle Fly: ACTIVE" or "Toggle Fly: OFF"
    btn.TextColor3 = flyingActive and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(240, 240, 240)
    
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local flyLoop
    flyLoop = RunService.RenderStepped:Connect(function()
        if not flyingActive or not hrp.Parent then flyLoop:Disconnect() return end
        hrp.Velocity = Vector3.new(0, 0.1, 0) -- Gravity neutralizing packet
        
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.RightVector end
        if move.Magnitude > 0 then hrp.CFrame = hrp.CFrame + (move.Unit * 1.5) end
    end)
end)

-- Tool 3: Safe Velocity Prop Fling (Bypasses Player-Velocity Filters)
addMenuButton("Execute Prop Fling (Nearest Object)", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsRootPart() and not obj.Anchored and (obj.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 40 then
            -- Claims master replication authority over the loose item mesh
            settings().Physics.AllowSleep = false
            obj.Velocity = Vector3.new(0, 99999, 0)
            obj.RotVelocity = Vector3.new(99999, 99999, 99999)
            break
        end
    end
end)

-- Tool 4: Dynamic ESP Frame Overlay
local espActive = false
addMenuButton("Toggle Server ESP: OFF", function(btn)
    espActive = not espActive
    btn.Text = espActive and "Toggle Server ESP: ACTIVE" or "Toggle Server ESP: OFF"
    btn.TextColor3 = espActive and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(240, 240, 240)
    
    local function applyESP(p)
        if p == LocalPlayer then return end
        local c = p.Character or p.CharacterAdded:Wait()
        local bb = Instance.new("BillboardGui", c:WaitForChild("HumanoidRootPart", 5))
        bb.Name = "EspBox"
        bb.Size = UDim2.new(4, 0, 5, 0)
        bb.AlwaysOnTop = true
        
        local f = Instance.new("Frame", bb)
        f.Size = UDim2.new(1, 0, 1, 0)
        f.BackgroundTransparency = 0.8
        f.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
        f.BorderSizePixel = 1
    end
    
    if espActive then
        for _, p in pairs(Players:GetPlayers()) do pcall(applyESP, p) end
    else
        for _, p in pairs(Players:GetPlayers()) do
            pcall(function() p.Character.HumanoidRootPart.EspBox:Destroy() end)
        end
    end
end)

-- Tool 5: Speed Modifier Boost
addMenuButton("Set Speed: Hyper (80)", function()
    pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 80 end)
end)

-- Tool 6: Jump Modifier Boost
addMenuButton("Set Jump: Gravity Defying", function()
    pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 130 end)
end)

-- Tool 7: Instant Void Reset / Respawn Bypass
addMenuButton("Force Instant Reset", function()
    pcall(function() LocalPlayer.Character:BreakJoints() end)
end)

-- Tool 8: Screen Invisible Toggle (Desync Proxy)
local invisActive = false
addMenuButton("Toggle Invisible: OFF", function(btn)
    invisActive = not invisActive
    btn.Text = invisActive and "Toggle Invisible: ACTIVE" or "Toggle Invisible: OFF"
    btn.TextColor3 = invisActive and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(240, 240, 240)
    
    if LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- Blends character meshes locally to create a visual phantom ghost effect
            hrp.Transparency = invisActive and 1 or 0
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = invisActive and 0.9 or 0
                end
            end
        end
    end
end)
