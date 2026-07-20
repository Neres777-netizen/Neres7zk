-- 🌈 Menu Anti Pulo Foldenxzz (com RGB e Otimização embutida)

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 270, 0, 210)
main.Position = UDim2.new(0.5, -135, 0.5, -105)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

-- Bordas RGB
local rgbLinha = Instance.new("Frame")
rgbLinha.Size = UDim2.new(1, 0, 0, 3)
rgbLinha.Position = UDim2.new(0,0,0,0)
rgbLinha.BorderSizePixel = 0
rgbLinha.Parent = main

local rgbLinha2 = Instance.new("Frame")
rgbLinha2.Size = UDim2.new(1, 0, 0, 3)
rgbLinha2.Position = UDim2.new(0,0,1,-3)
rgbLinha2.BorderSizePixel = 0
rgbLinha2.Parent = main

-- Animação RGB
local function animarRGB(obj)
    while true do
        TweenService:Create(obj, TweenInfo.new(2), {BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
        wait(2)
        TweenService:Create(obj, TweenInfo.new(2), {BackgroundColor3 = Color3.fromRGB(0,255,0)}):Play()
        wait(2)
        TweenService:Create(obj, TweenInfo.new(2), {BackgroundColor3 = Color3.fromRGB(0,0,255)}):Play()
        wait(2)
    end
end

task.spawn(function() animarRGB(rgbLinha) end)
task.spawn(function() animarRGB(rgbLinha2) end)

-- Cantos arredondados
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 45)
titulo.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titulo.Text = "Ant Pulo Foldenxzz"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Font = Enum.Font.GothamBold
titulo.TextScaled = true
titulo.Parent = main

Instance.new("UICorner", titulo).CornerRadius = UDim.new(0, 10)

-- Função criar botão
local function botao(nome, posY)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, 0, posY)
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.Text = nome
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    b.Parent = main
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    return b
end

-- Variável Anti Pulo
local anti = false

-- Lógica Anti Pulo
runService.RenderStepped:Connect(function()
    if anti and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 0
    end
end)

-- Botão Anti-Pulo
local antiBtn = botao("🚫 Anti-Pulo [OFF]", 60)

antiBtn.MouseButton1Click:Connect(function()
    anti = not anti
    if anti then
        antiBtn.Text = "🚫 Anti-Pulo [ON]"
        antiBtn.BackgroundColor3 = Color3.fromRGB(50,180,70)
    else
        antiBtn.Text = "🚫 Anti-Pulo [OFF]"
        antiBtn.BackgroundColor3 = Color3.fromRGB(180,60,60)

        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = 50
        end
    end
end)

-- Botão Otimização
local optBtn = botao("⚙️ Otimização", 115)

optBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") then
            obj.Enabled = false
        elseif obj:IsA("Decal") then
            obj.Transparency = 1
        end
    end

    optBtn.Text = "⚙️ Otimização ✔"
    optBtn.BackgroundColor3 = Color3.fromRGB(70, 140, 255)
end)
