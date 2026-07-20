--[[ 
    SoccerTech UI Controller
    Funcionalidade: Painel Arrastável com Handle e Estados Dinâmicos
]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Re-utilizando a tabela de estados do script anterior
-- (Assumindo que o SoccerTech.Enabled já existe no seu escopo)
local SoccerTech = {
    Enabled = {
        NoClip = false,
        SolidDefense = false,
        Magnet = false,
        Reach = false,
        AntiFling = false
    }
}

local function CreateEnhancedUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SoccerTech_V2"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 180, 0, 260)
    MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 8)

    -- Handle (Barra para Arrastar)
    local DragHandle = Instance.new("Frame")
    DragHandle.Name = "DragHandle"
    DragHandle.Size = UDim2.new(1, 0, 0, 30)
    DragHandle.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    DragHandle.BorderSizePixel = 0
    DragHandle.Parent = MainFrame

    local HandleCorner = Instance.new("UICorner", DragHandle)
    HandleCorner.CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Text = "SOCCER TECH"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.BackgroundTransparency = 1
    Title.Parent = DragHandle

    -- Conteúdo (Botões)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -40)
    ContentFrame.Position = UDim2.new(0, 10, 0, 35)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    local UIList = Instance.new("UIListLayout", ContentFrame)
    UIList.Padding = UDim.new(0, 6)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Lógica de Arrastar (InputService)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    DragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    DragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Construtor de Botões com Feedback Visual
    local function AddButton(text, stateKey)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 38)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        Btn.Text = text
        Btn.Font = Enum.Font.GothamSemibold
        Btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        Btn.TextSize = 12
        Btn.AutoButtonColor = false
        Btn.Parent = ContentFrame

        local BtnCorner = Instance.new("UICorner", Btn)
        BtnCorner.CornerRadius = UDim.new(0, 6)

        -- Efeito de Toggle
        Btn.MouseButton1Click:Connect(function()
            SoccerTech.Enabled[stateKey] = not SoccerTech.Enabled[stateKey]
            
            local targetColor = SoccerTech.Enabled[stateKey] and Color3.fromRGB(0, 170, 120) or Color3.fromRGB(50, 50, 60)
            local targetText = SoccerTech.Enabled[stateKey] and text .. " [ON]" or text
            
            TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
            Btn.Text = targetText
            
            -- Feedback tátil simples (opcional para mobile)
            if UserInputService.VibrationSupported then
                -- Haptics podem ser adicionados aqui
            end
        end)
    end

    -- Instanciar Botões
    AddButton("Atravessar", "NoClip")
    AddButton("Solid Defense", "SolidDefense")
    AddButton("Auto Desarme", "Magnet")
    AddButton("Reach (30s)", "Reach")
    AddButton("Anti-Fling", "AntiFling")
end

-- Inicializa a UI
CreateEnhancedUI()
