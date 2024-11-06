-- GUI to Lua 
-- Version: 0.0.3

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Main_1 = Instance.new("Frame")
local TEXT_1 = Instance.new("TextLabel")
local Lock_1 = Instance.new("TextButton")
local ESP_1 = Instance.new("TextButton")
local TP_1 = Instance.new("TextButton")
local Cframe_1 = Instance.new("TextButton")
local TextLabel_1 = Instance.new("TextLabel")
local UICorner_1 = Instance.new("UICorner")

-- Properties:
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Main_1.Name = "Main"
Main_1.Parent = ScreenGui
Main_1.BackgroundColor3 = Color3.fromRGB(30,30,30)
Main_1.BorderColor3 = Color3.fromRGB(0,0,0)
Main_1.BorderSizePixel = 0
Main_1.Position = UDim2.new(0.231544763, 0,0.191237822, 0)
Main_1.Size = UDim2.new(0, 688,0, 354)
Main_1.Active = true
Main_1.Draggable = true
Main_1.Style = Enum.FrameStyle.RobloxRound
Main_1.ResetonSpawn = true

TEXT_1.Name = "P9 HUB TEXT"
TEXT_1.Parent = Main_1
TEXT_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
TEXT_1.BackgroundTransparency = 0.6000000238418579
TEXT_1.BorderColor3 = Color3.fromRGB(0,0,0)
TEXT_1.BorderSizePixel = 0
TEXT_1.Position = UDim2.new(-0.0121640936, 0,-0.00028043412, 0)
TEXT_1.Size = UDim2.new(0, 688,0, 67)
TEXT_1.Font = Enum.Font.Unknown
TEXT_1.Text = "P9 HUB"
TEXT_1.TextColor3 = Color3.fromRGB(255,0,4)
TEXT_1.TextSize = 80
TEXT_1.TextWrapped = true

Lock_1.Name = "Lock"
Lock_1.Parent = Main_1
Lock_1.Active = true
Lock_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
Lock_1.BackgroundTransparency = 1
Lock_1.BorderColor3 = Color3.fromRGB(0,0,0)
Lock_1.Position = UDim2.new(0.0366414078, 0,0.294152379, 0)
Lock_1.Size = UDim2.new(0, 200,0, 50)
Lock_1.Font = Enum.Font.Highway
Lock_1.Text = "CamLock (C)"
Lock_1.TextColor3 = Color3.fromRGB(255,0,4)
Lock_1.TextScaled = true
Lock_1.TextSize = 14
Lock_1.MouseButton1down:connect(function()
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

end)

Lock_1.TextWrapped = true

ESP_1.Name = "ESP"
ESP_1.Parent = Main_1
ESP_1.Active = true
ESP_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
ESP_1.BackgroundTransparency = 1
ESP_1.BorderColor3 = Color3.fromRGB(0,0,0)
ESP_1.Position = UDim2.new(0.628812551, 0,0.303456247, 0)
ESP_1.Size = UDim2.new(0, 200,0, 50)
ESP_1.Font = Enum.Font.Highway
ESP_1.Text = " ESP (T)"
ESP_1.TextColor3 = Color3.fromRGB(255,0,4)
ESP_1.TextScaled = true
ESP_1.TextSize = 14
ESP_1.MouseButton1down:connect(function()
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

end)


TP_1.Name = "TP"
TP_1.Parent = Main_1
TP_1.Active = true
TP_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
TP_1.BackgroundTransparency = 1
TP_1.BorderColor3 = Color3.fromRGB(0,0,0)
TP_1.Position = UDim2.new(0.0321157128, 0,0.704136729, 0)
TP_1.Size = UDim2.new(0, 220,0, 50)
TP_1.Font = Enum.Font.Highway
TP_1.Text = "TELEPORT (Z)"
TP_1.TextColor3 = Color3.fromRGB(255,0,4)
TP_1.TextScaled = true
TP_1.TextSize = 14
TP_1.MouseButton1down:connect(function()
	-- Teleport Script
	-- Teleport Script
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera

	local targetPlayer = nil -- Target player to teleport to

	-- Function to find the closest player to the mouse cursor
	local function GetClosestPlayerToCursor()
		local closestDistance = math.huge
		local closestPlayer = nil

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local screenPosition = Camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
				local distance = (Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y) - Vector2.new(screenPosition.X, screenPosition.Y)).magnitude

				if distance < closestDistance then
					closestDistance = distance
					closestPlayer = player
				end
			end
		end
		return closestPlayer
	end

	-- Function to teleport to the target player
	local function TeleportToPlayer()
		if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character:SetPrimaryPartCFrame(targetPlayer.Character.HumanoidRootPart.CFrame)
		end
	end

	-- User Input for teleporting
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.Z then
				targetPlayer = GetClosestPlayerToCursor()
				if targetPlayer then
					TeleportToPlayer()
				end
			end
		end
	end)


Cframe_1.Name = "Cframe"
Cframe_1.Parent = Main_1
Cframe_1.Active = true
Cframe_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
Cframe_1.BackgroundTransparency = 1
Cframe_1.BorderColor3 = Color3.fromRGB(0,0,0)
Cframe_1.Position = UDim2.new(0.638927042, 0,0.694910228, 0)
Cframe_1.Size = UDim2.new(0, 220,0, 50)
Cframe_1.Font = Enum.Font.Highway
Cframe_1.Text = "CFRAME (Q)"
Cframe_1.TextColor3 = Color3.fromRGB(255,0,4)
Cframe_1.TextScaled = true
Cframe_1.TextSize = 14
	Cframe_1.MouseButton1down:connect(function()
		-- CFrame Movement Control Script
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local UserInputService = game:GetService("UserInputService")

		local LocalPlayer = Players.LocalPlayer
		local Camera = workspace.CurrentCamera

		local cframeMovementEnabled = false -- Toggle CFrame movement
		local speedMultiplier = 0 -- Initial speed multiplier
		local maxSpeedMultiplier = 2000 -- Maximum speed multiplier

		-- Function to control player movement using CFrame
		local function AdjustCFrameMovement()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local moveDirection = Vector3.new(0, 0, 0)

				if cframeMovementEnabled then
					-- Calculate directions for movement
					local forwardDirection = Camera.CFrame.LookVector * speedMultiplier
					local backwardDirection = -Camera.CFrame.LookVector * speedMultiplier
					local rightDirection = Camera.CFrame.RightVector * speedMultiplier
					local leftDirection = -Camera.CFrame.RightVector * speedMultiplier

					-- Detect input for movement
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then
						moveDirection = moveDirection + forwardDirection
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then
						moveDirection = moveDirection + backwardDirection
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then
						moveDirection = moveDirection + leftDirection
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then
						moveDirection = moveDirection + rightDirection
					end

					-- Update character's position using CFrame
					LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + moveDirection
				end
			end
		end

		-- User Input for toggling CFrame movement and adjusting speed
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Q then
					cframeMovementEnabled = not cframeMovementEnabled -- Toggle CFrame movement
				elseif input.KeyCode == Enum.KeyCode.P then
					-- Increase speed multiplier
					speedMultiplier = math.clamp(speedMultiplier + 100, 0, maxSpeedMultiplier)
				elseif input.KeyCode == Enum.KeyCode.M then
					-- Decrease speed multiplier
					speedMultiplier = math.clamp(speedMultiplier - 100, 0, maxSpeedMultiplier)
				end
			end
		end)

		-- Update player movement on RenderStepped
		RunService.RenderStepped:Connect(function()
			AdjustCFrameMovement() -- Adjust player movement based on input
		end)


TextLabel_1.Parent = Main_1
TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
TextLabel_1.BackgroundTransparency = 1
TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
TextLabel_1.BorderSizePixel = 0
TextLabel_1.Position = UDim2.new(-0.00160252769, 0,0.856586277, 0)
TextLabel_1.Size = UDim2.new(0, 679,0, 50)
TextLabel_1.Font = Enum.Font.Antique
TextLabel_1.Text = "Credits to Panther, Drowned, Kolina and 9127348501"
TextLabel_1.TextColor3 = Color3.fromRGB(255,0,4)
TextLabel_1.TextSize = 20
TextLabel_1.TextStrokeTransparency = 0.9800000190734863
TextLabel_1.TextTransparency = 0.4000000059604645

UICorner_1.Parent = ScreenGui
