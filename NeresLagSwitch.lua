-- Lag Switch com botão no topo direito (ajustado mais à esquerda) e botão X

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "LagSwitchGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Container do botão (quadro)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 80, 0, 80)
frame.Position = UDim2.new(1, -160, 0, 10) -- ajustado mais pra esquerda
frame.BackgroundTransparency = 1
frame.Parent = gui

-- Botão ON/OFF
local button = Instance.new("TextButton")
button.Name = "LagSwitchButton"
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- vermelho
button.Text = "OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextScaled = true
button.AutoButtonColor = true
button.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = button

-- Botão "X" para fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -15, 0, -5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0.5, 0)
closeCorner.Parent = closeBtn

-- Lógica do botão ON/OFF
local lagAtivo = false

local function toggleLag()
	lagAtivo = not lagAtivo
	
	if lagAtivo then  
		button.Text = "ON"  
		button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)  
		pcall(function() settings().Network.IncomingReplicationLag = 10 end)
	else  
		button.Text = "OFF"  
		button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)  
		pcall(function() settings().Network.IncomingReplicationLag = 0 end)
	end
end

button.MouseButton1Click:Connect(toggleLag)

-- Escuta os botões do controle (R1 ou Bola)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.ButtonR1 or input.KeyCode == Enum.KeyCode.ButtonB then
		toggleLag()
	end
end)

-- Remover a interface ao clicar no X
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	pcall(function() settings().Network.IncomingReplicationLag = 0 end)
end)
