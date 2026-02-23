-- ✯ Neres Hub V2 (By Mycompiler) ✯

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local RootPart, Humanoid

local Settings = {
    PainelAberto = true,
    AntiLag = false,
    Atravessar = false,
    DesarmeAuto = false,
    AntiPulo = false,
    Velocidade = false,
    PingReducer = false,
}

local function UpdateChar()
    if LocalPlayer.Character then
        RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
end
UpdateChar()
LocalPlayer.CharacterAdded:Connect(UpdateChar)

pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

local function OptimizePing(state)
    if state then
        settings().Physics.AllowSleep = false
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
    end
end

local connectionAntiLag
local function ControlarBola()
    local bola = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football")
    if bola and bola:IsA("BasePart") then
        bola:SetNetworkOwner(LocalPlayer)
        bola.AssemblyLinearVelocity *= 0.9
        bola.AssemblyAngularVelocity *= 0.9
    end
end

local function AtravessarJogadores()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

local function AutoDesarme()
    local bola = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football")
    if not bola or not RootPart then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
            if dist < 9 then
                bola.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
            end
        end
    end
end

-- RGB Utilitário
local function rgb(t)
    local s = math.sin
    return Color3.fromRGB(
        math.floor((s(t      )*0.5+0.5)*255),
        math.floor((s(t+2   )*0.5+0.5)*255),
        math.floor((s(t+4   )*0.5+0.5)*255)
    )
end

-- GUI
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "NeresHubV2GUI"

-- Painel (movível)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 340)
mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
mainFrame.Visible = Settings.PainelAberto
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Título RGB + Nome By Mycompiler
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 38)
title.Text = "✯ Neres Hub V2 (By Mycompiler) ✯"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.BackgroundTransparency = 1
title.TextSize = 22

-- Caixa do botão Abrir/Fechar (movível)
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 140, 0, 40)
toggleBtn.Position = UDim2.new(0.05, 0, 0.07, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Text = "Abrir/Fechar Painel"
toggleBtn.BorderSizePixel = 0
toggleBtn.Active = true
toggleBtn.Draggable = true

toggleBtn.MouseButton1Click:Connect(function()
    Settings.PainelAberto = not Settings.PainelAberto
    mainFrame.Visible = Settings.PainelAberto
end)

-- Toggle com tecla "P"
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.P then
        Settings.PainelAberto = not Settings.PainelAberto
        mainFrame.Visible = Settings.PainelAberto
    end
end)

-- Criação dinâmica dos botões
local function CreateButton(nome, ordem, callback)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, 50 + ordem * 42)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = nome.." [OFF]"
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 17
    btn.BorderSizePixel = 0
    btn.Name = nome

    btn.MouseButton1Click:Connect(function()
        local state = not Settings[nome]
        Settings[nome] = state
        btn.Text = nome.." ["..(state and "ON" or "OFF").."]"
        callback(state)
    end)
end

-- Funções dos botões
CreateButton("AntiLag", 0, function(state)
    if state then connectionAntiLag = RunService.Heartbeat:Connect(ControlarBola)
    else if connectionAntiLag then connectionAntiLag:Disconnect() end end
end)
CreateButton("Atravessar", 1, function() end)
CreateButton("DesarmeAuto", 2, function() end)
CreateButton("AntiPulo", 3, function(state)
    if Humanoid then Humanoid.JumpPower = state and 0 or 50 end
end)
CreateButton("Velocidade", 4, function(state)
    if Humanoid then Humanoid.WalkSpeed = state and 45 or 16 end
end)
CreateButton("PingReducer", 5, function(state)
    OptimizePing(state)
end)

-- RGB Animado
spawn(function()
    while task.wait() do
        local t = tick()
        -- Painel RGB
        mainFrame.BackgroundColor3 = rgb(t)
        -- Botão RGB
        toggleBtn.BackgroundColor3 = rgb(t + 1)
        -- Título RGB
        title.TextColor3 = rgb(t + 2)
        -- Botões RGB
        for _, obj in ipairs(mainFrame:GetChildren()) do
            if obj:IsA("TextButton") then
                obj.BackgroundColor3 = rgb(t + 3)
                obj.TextColor3 = rgb(t + 4)
            end
        end
    end
end)

-- Loop das funções automáticas
RunService.RenderStepped:Connect(function()
    if Settings.Atravessar then AtravessarJogadores() end
    if Settings.DesarmeAuto then AutoDesarme() end
end)
