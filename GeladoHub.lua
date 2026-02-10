local player = game.Players.LocalPlayer

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "GeraldoHubV2"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Fundo congelado
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(170, 220, 255)
frame.BackgroundTransparency = 1
frame.Parent = gui

-- Imagem do jumpscare
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(0.6, 0, 0.6, 0)
image.Position = UDim2.new(0.2, 0, 0.2, 0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://ID_DA_IMAGEM"
image.ImageTransparency = 1
image.Parent = frame

-- Texto Geraldo Hub V2
local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 0.15, 0)
text.Position = UDim2.new(0, 0, 0.05, 0)
text.BackgroundTransparency = 1
text.Text = "GERALDO HUB V2"
text.TextColor3 = Color3.fromRGB(240, 250, 255)
text.TextScaled = true
text.Font = Enum.Font.GothamBlack
text.TextTransparency = 1
text.Parent = frame

-- Som do jumpscare
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://ID_DO_SOM"
sound.Volume = 10
sound.Parent = gui

-- Delay antes do jumpscare
task.wait(1)

-- Ativar jumpscare
frame.BackgroundTransparency = 0
image.ImageTransparency = 0
text.TextTransparency = 0
sound:Play()

-- Tremida
for i = 1, 18 do
	image.Position = image.Position + UDim2.new(
		0, math.random(-12, 12),
		0, math.random(-12, 12)
	)
	task.wait(0.03)
end

-- Final
task.wait(2)
gui:Destroy()
