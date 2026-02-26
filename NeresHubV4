local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- === CONFIGURAÇÃO DO PAINEL (V4 - COMPLETO) ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlamengoHubV4"
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 160, 0, 300) -- Aumentado para caber novas funções
mainFrame.Position = UDim2.new(0.5, -80, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true 
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Títulos e Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0.5, -20, 0.05, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://12502621115" 
logo.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0.20, 0)
title.Text = "Painel | D.Pedro LL"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 10
title.Parent = mainFrame

local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1, -30, 1, 0)
hubTitle.Position = UDim2.new(0, 10, 0, 0)
hubTitle.Text = "Flamengo 3.0 HUB V3"
hubTitle.TextColor3 = Color3.new(1, 1, 1)
hubTitle.BackgroundTransparency = 1
hubTitle.Font = Enum.Font.GothamBold
hubTitle.TextSize = 9
hubTitle.Visible = false
hubTitle.Parent = mainFrame

-- Botão Minimizar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0, 5)
closeBtn.Text = "-"
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

-- Scrolling Frame para os botões (para não poluir a tela)
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0.65, 0)
scroll.Position = UDim2.new(0.05, 0, 0.3, 0)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
scroll.ScrollBarThickness = 0
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, 5)

-- Função de criar botões
local function createBtn(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 28)
    btn.BackgroundColor3 = color or Color3.fromRGB(170, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 8
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

-- Instanciando Botões
local btnAtravessar = createBtn("ATRAVESSAR: OFF")
local btnNoJump = createBtn("NOJUMP: OFF")
local btnAntiLag = createBtn("ANTILAG (TEXTURA): OFF")
local btnCopySkin = createBtn("COPIAR SKIN (CLIQUE)", Color3.fromRGB(50, 50, 50))
local btnBigKick = createBtn("BIG KICK (290): OFF")
local btnSuperChute = createBtn("SUPER CHUTE (999): OFF")

-- === LÓGICA DAS FUNÇÕES ===

local atravessar, nojump, antilag, bigkick, superchute = false, false, false, false, false

-- AntiLag (Remove texturas do personagem)
btnAntiLag.MouseButton1Click:Connect(function()
    antilag = not antilag
    btnAntiLag.Text = antilag and "ANTILAG: ON" or "ANTILAG: OFF"
    btnAntiLag.BackgroundColor3 = antilag and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(170, 0, 0)
    
    local char = localPlayer.Character
    if char then
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA("MeshPart") or obj:IsA("Part") then
                obj.Material = antilag and Enum.Material.SmoothPlastic or Enum.Material.Plastic
            elseif obj:IsA("CharacterMesh") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("Accessory") then
                obj.Visible = not antilag
            end
        end
    end
end)

-- Copiar Skin (Aproxima-se de um player e clica)
btnCopySkin.MouseButton1Click:Connect(function()
    local mouse = localPlayer:GetMouse()
    local target = mouse.Target
    if target and target.Parent:FindFirstChild("Humanoid") then
        local targetChar = target.Parent
        localPlayer.CharacterAppearanceId = Players:GetUserIdFromNameAsync(targetChar.Name)
        print("Skin copiada de: "..targetChar.Name)
    end
end)

-- Chutes (Modifica força se o jogo permitir via BodyVelocity/Custom Phys)
local function applyKick(power)
    RunService.Stepped:Connect(function()
        local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football")
        if ball and (localPlayer.Character.HumanoidRootPart.Position - ball.Position).Magnitude < 6 then
            ball.Velocity = localPlayer.Character.HumanoidRootPart.CFrame.LookVector * power
        end
    end)
end

btnBigKick.MouseButton1Click:Connect(function()
    bigkick = not bigkick
    btnBigKick.Text = bigkick and "BIG KICK: ON" or "BIG KICK: OFF"
    if bigkick then applyKick(290) end
end)

btnSuperChute.MouseButton1Click:Connect(function()
    superchute = not superchute
    btnSuperChute.Text = superchute and "SUPER CHUTE: ON" or "SUPER CHUTE: OFF"
    if superchute then applyKick(999) end
end)

-- Funções Anteriores (Minimizar, Atravessar, NoJump)
closeBtn.MouseButton1Click:Connect(function()
    local minimizado = (mainFrame.Size.Y.Offset > 50)
    mainFrame:TweenSize(minimizado and UDim2.new(0, 160, 0, 30) or UDim2.new(0, 160, 0, 300), "Out", "Quad", 0.2, true)
    scroll.Visible = not minimizado
    logo.Visible = not minimizado
    title.Visible = not minimizado
    hubTitle.Visible = minimizado
    closeBtn.Text = minimizado and "+" or "-"
end)

btnAtravessar.MouseButton1Click:Connect(function()
    atravessar = not atravessar
    btnAtravessar.Text = atravessar and "ATRAVESSAR: ON" or "ATRAVESSAR: OFF"
    btnAtravessar.BackgroundColor3 = atravessar and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(170, 0, 0)
end)

btnNoJump.MouseButton1Click:Connect(function()
    nojump = not nojump
    btnNoJump.Text = nojump and "NOJUMP: ON" or "NOJUMP: OFF"
    btnNoJump.BackgroundColor3 = nojump and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(170, 0, 0)
end)

RunService.RenderStepped:Connect(function()
    uiStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    if nojump and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpPower = 0
    end
end)

RunService.Stepped:Connect(function()
    if atravessar then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= localPlayer and p.Character then
                for _, part in pairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "Ball" and part.Name ~= "Football" then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)
