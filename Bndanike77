-- https://scriptblox.com/script/Universal-Script-Atravessar-ultra-56433

-- bndanike77

-------------------------------------------------
-- SERVICES
-------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-------------------------------------------------
-- CHARACTER CACHE
-------------------------------------------------
local Character, Humanoid, RootPart

local function UpdateChar()
	Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	RootPart = Character:WaitForChild("HumanoidRootPart")
end
UpdateChar()
LocalPlayer.CharacterAdded:Connect(UpdateChar)

-------------------------------------------------
-- SETTINGS
-------------------------------------------------
local Settings = {
	PainelAberto = true,
	Atravessar = false,
	NoCollideNivel = 50,
	DesarmeAuto = false,
	AntiPulo = false,
	Velocidade = false,
	PingReducer = false
}

local NoCollideLevels = {50, 100, 120, 150, 200}
local LevelIndex = 1

-------------------------------------------------
-- FPS / PING
-------------------------------------------------
pcall(function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

local function OptimizePing(state)
	if state then
		settings().Physics.AllowSleep = false
		settings().Physics.PhysicsEnvironmentalThrottle =
			Enum.EnviromentalPhysicsThrottle.Disabled
	end
end

-------------------------------------------------
-- NO COLLIDE SISTEMA
-------------------------------------------------
local function SetCollision(char, enabled)
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = enabled
			part.CanTouch = enabled
			part.CanQuery = enabled
		end
	end
end

local function UltraAtravessar()
	if not Settings.Atravessar then return end
	if not RootPart then return end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local char = plr.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				SetCollision(char, false)

				local dist = (char.HumanoidRootPart.Position - RootPart.Position).Magnitude
				if dist < Settings.NoCollideNivel then
					char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
				end
			end
		end
	end
end

local function RestaurarTudo()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			SetCollision(plr.Character, true)
		end
	end
end

-------------------------------------------------
-- DESARME AUTO
-------------------------------------------------
local function AutoDesarme()
	if not RootPart then return end

	local bola =
		workspace:FindFirstChild("Ball")
		or workspace:FindFirstChild("Football")
		or workspace:FindFirstChild("SoccerBall")

	if not bola then return end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (plr.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
			if dist < 8 then
				bola.CFrame = RootPart.CFrame * CFrame.new(0, 0, -2)
			end
		end
	end
end

-------------------------------------------------
-- GUI
-------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "bndanike77GUI"
gui.Parent = LocalPlayer.PlayerGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 240, 0, 310)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true
main.Visible = Settings.PainelAberto

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "bndanike77"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(45,45,45)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

-------------------------------------------------
-- BUTTON CREATOR
-------------------------------------------------
local function CreateButton(text, order, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1,-20,0,30)
	btn.Position = UDim2.new(0,10,0,40 + order*35)
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 14
	btn.Text = text.." [OFF]"

	btn.MouseButton1Click:Connect(function()
		Settings[text] = not Settings[text]
		btn.Text = text.." ["..(Settings[text] and "ON" or "OFF").."]"
		if callback then callback(Settings[text]) end
	end)
end

-------------------------------------------------
-- BOTÕES
-------------------------------------------------
CreateButton("Atravessar", 0, function(state)
	if not state then RestaurarTudo() end
end)

local levelBtn = Instance.new("TextButton", main)
levelBtn.Size = UDim2.new(1,-20,0,30)
levelBtn.Position = UDim2.new(0,10,0,40 + 1*35)
levelBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
levelBtn.TextColor3 = Color3.new(1,1,1)
levelBtn.Font = Enum.Font.SourceSansBold
levelBtn.TextSize = 14
levelBtn.Text = "No Collide: "..Settings.NoCollideNivel

levelBtn.MouseButton1Click:Connect(function()
	LevelIndex += 1
	if LevelIndex > #NoCollideLevels then
		LevelIndex = 1
	end
	Settings.NoCollideNivel = NoCollideLevels[LevelIndex]
	levelBtn.Text = "No Collide: "..Settings.NoCollideNivel
end)

CreateButton("DesarmeAuto", 2)

CreateButton("AntiPulo", 3, function(state)
	if Humanoid then
		Humanoid.JumpPower = state and 0 or 50
	end
end)

CreateButton("Velocidade", 4, function(state)
	if Humanoid then
		Humanoid.WalkSpeed = state and 45 or 16
	end
end)

CreateButton("PingReducer", 5, function(state)
	OptimizePing(state)
end)

-------------------------------------------------
-- BOTÃO FLUTUANTE
-------------------------------------------------
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,140,0,32)
toggle.Position = UDim2.new(0.05,0,0.15,0)
toggle.Text = "bndanike77"
toggle.BackgroundColor3 = Color3.fromRGB(90,90,90)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 14
toggle.Active = true
toggle.Draggable = true

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-------------------------------------------------
-- LOOP PRINCIPAL
-------------------------------------------------
RunService.RenderStepped:Connect(function()
	if Settings.Atravessar then
		UltraAtravessar()
	end
	if Settings.DesarmeAuto then
		AutoDesarme()
	end
end)
