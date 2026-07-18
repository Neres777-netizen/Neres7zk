--[[ 
    ╔═════════════════════════════════════════════════════════════╗
    ║                 PEPPA TCP 33 - OPTIMIZATION                 ║
    ╠═════════════════════════════════════════════════════════════╣
    ║ Fundo: Preto | Estilo: Sofisticado RGB LED                  ║
    ║ Som: Click de Teclado ASMR                                  ║
    ╚═════════════════════════════════════════════════════════════╝
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

-- Criação da GUI Principal
local gui = Instance.new("ScreenGui")
gui.Name = "PeppaTcp33Hub"
pcall(function() gui.Parent = CoreGui end)

-- Instanciação do Sub-Painel Fixo
local subGui = Instance.new("ScreenGui")
subGui.Name = "PeppaSubHub"
subGui.Enabled = true
pcall(function() subGui.Parent = CoreGui end)

-- ==================== SISTEMA DE NOTIFICAÇÃO ====================
local function showNotification(title, text)
    task.spawn(function()
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = text,
                Duration = 4,
                Button1 = "OK"
            })
        end)
    end)
end

-- ==================== EFEITO RGB LED ====================
local function applyRGB(strokeObj)
    task.spawn(function()
        while gui and gui.Parent do
            for hue = 0, 1, 0.005 do
                if not strokeObj or not strokeObj.Parent then return end
                strokeObj.Color = Color3.fromHSV(hue, 1, 1)
                task.wait(0.02)
            end
        end
    end)
end

-- ==================== SISTEMA DE ARRASTE ====================
local function drag(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==================== SISTEMA DE SOM (ASMR) ====================
local function playASMRClick()
    task.spawn(function()
        local clickSound = Instance.new("Sound")
        clickSound.SoundId = "rbxassetid://5854737227" 
        clickSound.Volume = 2
        clickSound.Parent = game:GetService("SoundService")
        clickSound:Play()
        task.wait(1.5)
        clickSound:Destroy()
    end)
end

-- ==================== BOTÃO DE ABRIR E FECHAR (NOME ATUALIZADO) ====================
local ToggleBtn = Instance.new("TextButton", gui)
ToggleBtn.Size = UDim2.new(0, 220, 0, 45)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Text = "Peppa Tcp 33"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamMedium 
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
local strokeToggle = Instance.new("UIStroke", ToggleBtn)
strokeToggle.Thickness = 2
applyRGB(strokeToggle)
drag(ToggleBtn)

-- ==================== PAINEL PRINCIPAL (NOME ATUALIZADO) ====================
local MainPanel = Instance.new("Frame", gui)
MainPanel.Size = UDim2.new(0, 380, 0, 340)
MainPanel.Position = UDim2.new(0.5, -190, 0.5, -170)
MainPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainPanel.Visible = false
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 10)
local strokeMain = Instance.new("UIStroke", MainPanel)
strokeMain.Thickness = 2.5
applyRGB(strokeMain)
drag(MainPanel)

local Title = Instance.new("TextLabel", MainPanel)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "PEPPA TCP 33"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local ScrollContainer = Instance.new("ScrollingFrame", MainPanel)
ScrollContainer.Size = UDim2.new(1, -10, 1, -85)
ScrollContainer.Position = UDim2.new(0, 5, 0, 45)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 300)
ScrollContainer.ScrollBarThickness = 3
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(150,150,150)

local ListLayout = Instance.new("UIListLayout", ScrollContainer)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

ToggleBtn.MouseButton1Click:Connect(function()
    playASMRClick()
    MainPanel.Visible = not MainPanel.Visible
end)

-- ==================== CRIADOR DE BOTÕES ====================
local function createFunctionButton(text, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.92, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Color = Color3.fromRGB(45, 45, 45)
    bStroke.Thickness = 1
    
    btn.MouseButton1Click:Connect(function()
        playASMRClick()
        callback(btn)
    end)
    return btn
end

-- ==================== SUB-PAINEL SEGURO ====================
local SubMain = Instance.new("Frame", subGui)
SubMain.Size = UDim2.new(0, 420, 0, 320)
SubMain.Position = UDim2.new(0.5, -210, 0.5, -160)
SubMain.BackgroundColor3 = Color3.new(0,0,0)
SubMain.Visible = false
Instance.new("UICorner", SubMain).CornerRadius = UDim.new(0, 12)
local subStroke = Instance.new("UIStroke", SubMain)
subStroke.Thickness = 2
applyRGB(subStroke)
drag(SubMain)

local subTitle = Instance.new("TextLabel", SubMain)
subTitle.Size = UDim2.new(1,0,0,40)
subTitle.Text = "SUB-MENU REQUISITOS TCP"
subTitle.TextColor3 = Color3.new(1,1,1)
subTitle.Font = Enum.Font.GothamBold
subTitle.BackgroundTransparency = 1

local SubScroll = Instance.new("ScrollingFrame", SubMain)
SubScroll.Size = UDim2.new(1, -10, 1, -95)
SubScroll.Position = UDim2.new(0, 5, 0, 45)
SubScroll.BackgroundTransparency = 1
SubScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
SubScroll.ScrollBarThickness = 2

local SubList = Instance.new("UIListLayout", SubScroll)
SubList.SortOrder = Enum.SortOrder.LayoutOrder
SubList.Padding = UDim.new(0, 8)
SubList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Funções do Sub-Painel
createFunctionButton("Limpar Coisas Inúteis", SubScroll, function(self)
    task.spawn(function()
        Lighting.GlobalShadows = false
        settings().Rendering.QualityLevel = 1
        for _, item in ipairs(game:GetDescendants()) do
            if item:IsA("Texture") or item:IsA("Decal") or item:IsA("Cloud") or item:IsA("Atmosphere") or item:IsA("PostEffect") then
                item:Destroy()
            end
        end
        self.TextColor3 = Color3.fromRGB(0, 255, 100)
    end)
end)

createFunctionButton("⚽ Otimização Bola Lisa", SubScroll, function(self)
    task.spawn(function()
        local function limparBola(ball)
            if ball:IsA("BasePart") and (ball.Shape == Enum.PartType.Ball or ball.Name:lower():find("ball")) then
                ball.Material = Enum.Material.SmoothPlastic
                ball.Color = Color3.fromRGB(255, 255, 255)
                ball.CastShadow = false
                for _, child in ipairs(ball:GetChildren()) do
                    if child:IsA("SpecialMesh") or child:IsA("MeshPart") or child:IsA("Decal") or child:IsA("Texture") then
                        child:Destroy()
                    end
                end
            end
        end
        for _, obj in ipairs(workspace:GetDescendants()) do limparBola(obj) end
        workspace.DescendantAdded:Connect(function(v) task.wait(0.1); limparBola(v) end)
        self.TextColor3 = Color3.fromRGB(0, 255, 100)
    end)
end)

createFunctionButton("🚫 Ativar Antipulo", SubScroll, function(self)
    local p = game:GetService("Players").LocalPlayer
    local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.JumpPower = 0
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        self.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

local CloseSub = Instance.new("TextButton", SubMain)
CloseSub.Size = UDim2.new(0.9, 0, 0, 35)
CloseSub.Position = UDim2.new(0.05, 0, 1, -45)
CloseSub.Text = "Fechar Sub-Painel"
CloseSub.BackgroundColor3 = Color3.fromRGB(20,20,20)
CloseSub.TextColor3 = Color3.new(1,1,1)
CloseSub.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", CloseSub).CornerRadius = UDim.new(0,6)
CloseSub.MouseButton1Click:Connect(function() 
    playASMRClick() 
    SubMain.Visible = false 
end)

-- ==================== BOTOES PAINEL PRINCIPAL ====================

-- FUNÇÃO: Desacelerar Bola (Com Notificação)
createFunctionButton("Desacelerar Bola (Cravado 52-57 FPS)", ScrollContainer, function(self)
    task.spawn(function()
        local Stats = game:GetService("Stats")
        if setfpscap then setfpscap(53) end
        pcall(function()
            settings().Physics.AllowSleep = false
            settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
            Stats.Network.ServerToClientConnection.RouterLagLowerBound = 0
        end)
        self.TextColor3 = Color3.fromRGB(0, 255, 100)
        showNotification("Peppa Tcp 33", "⚽ Desacelerar Bola ATIVADO! (Física travada em 53 FPS com Sucesso)")
    end)
end)

createFunctionButton("Abrir Sub-Painel Imperial", ScrollContainer, function()
    SubMain.Visible = true
end)

local clickCount = 0
createFunctionButton("Anti Bola Atravessar (Toques: 0/7)", ScrollContainer, function(self)
    clickCount = clickCount + 1
    self.Text = "Anti Bola Atravessar (Toques: " .. clickCount .. "/7)"
    
    if clickCount >= 7 then
        self.TextColor3 = Color3.fromRGB(0, 255, 100)
        task.spawn(function()
            local protectedBalls = {}
            while task.wait(2) do
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj.Name:lower():find("ball") or obj.Name == "SoccerBall" then
                        local part = obj:FindFirstChildWhichIsA("BasePart") or obj
                        if part and not protectedBalls[part] then
                            protectedBalls[part] = true
                            RunService.Heartbeat:Connect(function()
                                if part and part.Parent then 
                                    part.CanCollide = true 
                                    if part.Velocity.Magnitude > 35 then part.Velocity = part.Velocity * 0.75 end
                                end
                            end)
                        end
                    end
                end
            end
        end)
    end
end)

createFunctionButton("⚡ Corpo de Rocha (Física Estabilizada)", ScrollContainer, function(self)
    local p = game:GetService("Players").LocalPlayer
    if p.Character then
        for _, v in pairs(p.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5, 1, 1)
            end
        end
        self.TextColor3 = Color3.fromRGB(0, 180, 255)
    end
end)

-- FUNÇÃO: VPN Turbo (Com Notificação)
createFunctionButton("🌐 VPN Turbo (+Reach Otimizado Estável)", ScrollContainer, function(self)
    task.spawn(function()
        local p = game:GetService("Players").LocalPlayer
        settings().Network.AsynchronousReceiveEnabled = true
        settings().Network.DataSendRate = 45
        
        RunService.RenderStepped:Connect(function()
            pcall(function()
                local tool = p.Character and p.Character:FindFirstChildOfClass("Tool")
                if tool then
                    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
                    if handle then
                        handle.Size = Vector3.new(6, 6, 6)
                        handle.CanCollide = false
                    end
                end
            end)
        end)
        self.TextColor3 = Color3.fromRGB(0, 255, 150)
        showNotification("Peppa Tcp 33", "🌐 VPN Turbo & Reach Estável ONLINE! (Conexão e Analógico Otimizados)")
    end)
end)

createFunctionButton("📉 Lag Drop (0.2 ms + Teleport de Visão)", ScrollContainer, function(self)
    task.spawn(function()
        self.TextColor3 = Color3.fromRGB(255, 50, 50)
        while task.wait(0.1) do
            pcall(function()
                local char = game:GetService("Players").LocalPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")
                
                if hum and hum.MoveDirection.Magnitude > 0 then
                    settings().Network.IncomingReplicationLag = 0.35
                    RunService.Heartbeat:Wait()
                    settings().Network.IncomingReplicationLag = 0.0002
                else
                    settings().Network.IncomingReplicationLag = 0.0002
                end
            end)
        end
    end)
end)

local WarningLabel = Instance.new("TextLabel", MainPanel)
WarningLabel.Size = UDim2.new(0.9, 0, 0, 30)
WarningLabel.Position = UDim2.new(0.05, 0, 1, -35)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "⚠️ Observação: Clique 7 vezes no script da bola para ativar totalmente."
WarningLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
WarningLabel.Font = Enum.Font.GothamSemibold
WarningLabel.TextSize = 11
WarningLabel.TextWrapped = true
