local Rayfield = loadstring(game:HttpGet('loadstring(game:HttpGet("https://raw.githubusercontent.com/PantherScriptzzz/P9-HUB/refs/heads/main/P9HUB.lua"))()'))()

local Window = Rayfield:CreateWindow({
   Name = "P9 SCRIPT",
   LoadingTitle = "WELCOME TO P9 HUB",
   LoadingSubtitle = "by Panther's Team",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
     FileName = "P9 HUB"
   },
   Discord = {
      Enabled = true,
      Invite = "kS7akSZB9q", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = false -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key Pastebin",
      Subtitle = "By Lootlabs",
      Note = "Key In Discord Server",
      FileName = "P9HUB", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/Tf0nX6DK"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("General", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Script is Loaded",
   Content = "P9 MADE",
   Duration = 5,
   Image = nil,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})

local Button = MainTab:CreateButton({
   Name = "Camlock Toggle (C)",
   Callback = function()
-- Player Locking Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local targetPlayer = nil -- Currently locked-on player
local isLocked = false -- Track if we are locked onto a player

-- Function to get the closest player to the mouse cursor
local function GetClosestPlayer()
    local closestDistance = math.huge
    local closestPlayer = nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local screenPosition = Camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPosition.X, screenPosition.Y)).magnitude

            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

-- Function to lock onto the selected player
local function LockOntoPlayer()
    if isLocked and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1, 0) -- Slight upward offset
        -- Instantly change the camera's CFrame to look at the target
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition) -- Directly point to the target
    end
end

-- User Input for Locking
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.C then
            -- Lock onto the closest player
            if isLocked then
                targetPlayer = nil -- Unlock
                isLocked = false
            else
                targetPlayer = GetClosestPlayer() -- Lock onto closest player
                isLocked = true
            end
        end
    end
end)

-- Run the lock function on RenderStepped
RunService.RenderStepped:Connect(function()
    LockOntoPlayer() -- Keep the camera locked onto the target
end)

end
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "CFrame Slider(Q)",
   Range = {1, 2000},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})


local Toggle = Tab:CreateToggle({
   Name = "ESP(T)",
   CurrentValue = false,
   Flag = "ESP WITH NAME", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
  -- Highlight and Billboard GUI Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local highlightEnabled = false -- Track if highlights are enabled
local highlights = {} -- Store highlights for players
local billboardGuis = {} -- Store BillboardGuis for players

-- Function to create a BillboardGui for a player
local function CreateBillboardGui(player)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(1, 0, 1, 0)
    billboardGui.Adornee = player.Character.HumanoidRootPart
    billboardGui.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel", billboardGui)
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 16

    billboardGuis[player.UserId] = billboardGui
    return billboardGui
end

-- Function to toggle highlights for players
local function ToggleHighlights()
    highlightEnabled = not highlightEnabled

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if highlightEnabled then
                -- Create highlight and BillboardGui
                local highlight = Instance.new("Highlight", player.Character)
                highlight.FillColor = Color3.new(1, 0, 0) -- Red fill
                highlight.FillTransparency = 0.5 -- Low transparency
                highlight.OutlineColor = Color3.new(0, 0, 0) -- Black outline
                highlights[player.UserId] = highlight

                local billboardGui = CreateBillboardGui(player)
                billboardGui.Parent = workspace
            else
                -- Remove highlight and BillboardGui
                if highlights[player.UserId] then
                    highlights[player.UserId]:Destroy()
                    highlights[player.UserId] = nil
                end
                if billboardGuis[player.UserId] then
                    billboardGuis[player.UserId]:Destroy()
                    billboardGuis[player.UserId] = nil
                end
            end
        end
    end
end

-- Function to update BillboardGui sizes based on distance
local function UpdateBillboardGuiSizes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local billboardGui = billboardGuis[player.UserId]
            if billboardGui then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                billboardGui.Size = UDim2.new(1 / (distance / 10), 0, 1 / (distance / 10), 0) -- Adjust size based on distance
            end
        end
    end
end

-- User Input for toggling highlights
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.T then
            ToggleHighlights() -- Toggle highlights on/off
        end
    end
end)

-- Update BillboardGui sizes on RenderStepped
RunService.RenderStepped:Connect(function()
    if highlightEnabled then
        UpdateBillboardGuiSizes()
    end
end)

-- Initialize highlights and BillboardGuis for existing players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillColor = Color3.new(1, 0, 0) -- Red fill
        highlight.FillTransparency = 0.5 -- Low transparency
        highlight.OutlineColor = Color3.new(0, 0, 0) -- Black outline
        highlights[player.UserId] = highlight

        local billboardGui = CreateBillboardGui(player)
        billboardGui.Parent = workspace
    end
end

-- Update highlights when players join/leave
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()
    if highlightEnabled then
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(0, 0, 0)
        highlights[player.UserId] = highlight

        local billboardGui = CreateBillboardGui(player)
        billboardGui.Parent = workspace
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if highlights[player.UserId] then
        highlights[player.UserId]:Destroy()
        highlights[player.UserId] = nil
    end
    if billboardGuis[player.UserId] then
        billboardGuis[player.UserId]:Destroy()
        billboardGuis[player.UserId] = nil
    end
end)

   end,
})
