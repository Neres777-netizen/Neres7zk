--// Painel Speed 25 - Corrigido //--

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false
gui.Name = "SpeedGui"

-- Janela principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 150, 0, 70)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "Speed 25"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Botão
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 35)
toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.Text = "Ativar"

-- Variáveis
local ativo = false
local velocidade = 25

-- Função
local function aplicarSpeed()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = ativo and velocidade or 16
	end
end

-- Evento do botão
toggle.MouseButton1Click:Connect(function()
	ativo = not ativo
	if ativo then
		toggle.Text = "Desativar"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
	else
		toggle.Text = "Ativar"
		toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
	end
	aplicarSpeed()
end)

-- Garante que reaplica após respawn
player.CharacterAdded:Connect(function()
	repeat task.wait() until player.Character:FindFirstChildOfClass("Humanoid")
	aplicarSpeed()
end)
