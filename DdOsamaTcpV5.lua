-- DD Osama V5 🇺🇸
-- REACH 50 + CHICLETE 2X + AUTO DESARME BUFF
-- BALL BOOST + CAMPO TRANSPARENTE

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- IMPORTAR RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- JANELA
local Window = Rayfield:CreateWindow({
    Name = "DD Osama V5 🇺🇸",
    Icon = 0,
    LoadingTitle = "Loading DD Osama...",
    LoadingSubtitle = "by zyck team",
    Theme = "Default",

    DisableRayfieldPrompts = true,
    DisableRayfieldNotifs = true,
    DisableMobileWindowMode = false,

    ConfigurationSaving = {
        Enabled = false,
        FileName = "DDOsamaV5",
        FolderName = "DDOsama"
    }
})

-- ABA
local MainTab = Window:CreateTab("Principal", 4483362458)

-- TOGGLES
local toggles = {
    atravessar = false,
    antijump = false,
    autospeed = false,
    fixedspeed = false,
    autoDesarmar = false,
    reach = false,
    chiclete = false
}

local speedValue = 25

-- ATRAVESSAR PLAYERS
local function atravess()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player
        and plr.Character
        and plr.Character:FindFirstChild("HumanoidRootPart") then

            plr.Character.HumanoidRootPart.CanCollide = false
        end
    end
end

-- ANTI PULO
local function antiPulo()
    local char = player.Character

    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = 0
    end
end

-- SPEED
local function speed()
    local char = player.Character

    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speedValue
    end
end

-- REACH 50
local function reachReal()
    local ball = Workspace:FindFirstChild("Soccerball")

    if ball
    and ball:IsA("BasePart")
    and player.Character
    and player.Character:FindFirstChild("HumanoidRootPart") then

        local root = player.Character.HumanoidRootPart

        local dist = (ball.Position - root.Position).Magnitude

        if dist < 50 then
            ball.CFrame = ball.CFrame:Lerp(
                root.CFrame * CFrame.new(0, 0, -7),
                0.35
            )
        end
    end
end

-- CHICLETE 2X
local function chicleteBall()
    local ball = Workspace:FindFirstChild("Soccerball")

    if ball
    and ball:IsA("BasePart")
    and player.Character
    and player.Character:FindFirstChild("HumanoidRootPart") then

        local torso =
            player.Character:FindFirstChild("Torso")
            or player.Character:FindFirstChild("UpperTorso")

        if torso then
            ball.CFrame = ball.CFrame:Lerp(
                torso.CFrame * CFrame.new(0, 0, -2),
                1
            )
        else
            ball.CFrame = ball.CFrame:Lerp(
                player.Character.HumanoidRootPart.CFrame
                * CFrame.new(0, -1, -1.5),
                1
            )
        end
    end
end

-- AUTO DESARME BUFF
local function autoDesarmar()
    local ball = Workspace:FindFirstChild("Soccerball")

    if ball
    and ball:IsA("BasePart")
    and player.Character
    and player.Character:FindFirstChild("HumanoidRootPart") then

        for _, plr in ipairs(Players:GetPlayers()) do

            if plr ~= player
            and plr.Character
            and plr.Character:FindFirstChild("HumanoidRootPart") then

                local dist =
                    (ball.Position
                    - plr.Character.HumanoidRootPart.Position).Magnitude

                if dist < 20 then
                    ball.CFrame = ball.CFrame:Lerp(
                        player.Character.HumanoidRootPart.CFrame
                        * CFrame.new(0, 0, -5),
                        0.8
                    )
                    break
                end
            end
        end
    end
end

-- DETECTAR BOLA
local function isBall(obj)
    local name = obj.Name:lower()

    return name:find("ball")
        or name:find("soccer")
end

-- OTIMIZAR BOLA
-- IMPORTANTE: NÃO MUDA A COR DA BOLA
local function optimizeBall(ball)

    if ball:IsA("BasePart") and isBall(ball) then

        -- FÍSICA MAIS LEVE
        ball.CustomPhysicalProperties = PhysicalProperties.new(
            0.01,
            0.3,
            0,
            0,
            0
        )

        -- REMOVE EFEITOS E TEXTURAS
        for _, v in ipairs(ball:GetDescendants()) do

            if v:IsA("Decal")
            or v:IsA("Texture")
            or v:IsA("Trail")
            or v:IsA("ParticleEmitter") then

                v:Destroy()

            elseif v:IsA("SpecialMesh") then
                v.TextureId = ""
            end
        end
    end
end

-- OTIMIZAR BOLAS EXISTENTES
for _, v in ipairs(Workspace:GetDescendants()) do
    optimizeBall(v)
end

-- OTIMIZAR NOVAS BOLAS
Workspace.DescendantAdded:Connect(function(v)
    task.wait(0.1)
    optimizeBall(v)
end)

-- CAMPO TRANSPARENTE
local keywords = {
    "field",
    "campo",
    "soccer",
    "football",
    "goal",
    "line"
}

local function isField(name)
    name = name:lower()

    for _, word in ipairs(keywords) do
        if string.find(name, word) then
            return true
        end
    end

    return false
end

local function TransparentField()

    for _, obj in ipairs(Workspace:GetDescendants()) do

        if obj:IsA("BasePart")
        and isField(obj.Name) then

            obj.Transparency = 0.9
            obj.Material = Enum.Material.SmoothPlastic
            obj.CastShadow = false
            obj.Reflectance = 0

            for _, d in ipairs(obj:GetChildren()) do

                if d:IsA("Decal")
                or d:IsA("Texture") then

                    d:Destroy()
                end
            end
        end
    end
end

TransparentField()

-- 1. ATRAVESSAR PLAYERS
MainTab:CreateToggle({
    Name = "1. Atravessar Players",
    CurrentValue = false,
    Flag = "Toggle1",

    Callback = function(v)
        toggles.atravessar = v
    end
})

-- 2. ANTI PULO
MainTab:CreateToggle({
    Name = "2. Anti Pulo",
    CurrentValue = false,
    Flag = "Toggle2",

    Callback = function(v)
        toggles.antijump = v
    end
})

-- 3. AUTO SPEED
MainTab:CreateToggle({
    Name = "3. Auto Speed",
    CurrentValue = false,
    Flag = "Toggle3",

    Callback = function(v)
        toggles.autospeed = v
    end
})

-- 4. VELOCIDADE
MainTab:CreateToggle({
    Name = "4. Velocidade",
    CurrentValue = false,
    Flag = "Toggle4",

    Callback = function(v)
        toggles.fixedspeed = v
    end
})

-- 5. AUTO DESARME
MainTab:CreateToggle({
    Name = "5. Auto Desarme Buff",
    CurrentValue = false,
    Flag = "Toggle5",

    Callback = function(v)
        toggles.autoDesarmar = v
    end
})

-- 6. REACH
MainTab:CreateToggle({
    Name = "6. Reach REAL (50)",
    CurrentValue = false,
    Flag = "Toggle6",

    Callback = function(v)
        toggles.reach = v
    end
})

-- 7. CHICLETE
MainTab:CreateToggle({
    Name = "7. Bola Chiclete 2X",
    CurrentValue = false,
    Flag = "Toggle7",

    Callback = function(v)
        toggles.chiclete = v
    end
})

-- SLIDER DE VELOCIDADE
MainTab:CreateSlider({
    Name = "Velocidade",
    Range = {1, 100},
    Increment = 1,
    Suffix = " studs/s",
    CurrentValue = 25,
    Flag = "SpeedSlider",

    Callback = function(Value)
        speedValue = Value
    end
})

-- FECHAR GUI
MainTab:CreateButton({
    Name = "Esconder / Fechar GUI",

    Callback = function()
        Rayfield:Destroy()
    end
})

-- LOOP PRINCIPAL
RunService.Heartbeat:Connect(function()

    if toggles.atravessar then
        atravess()
    end

    if toggles.antijump then
        antiPulo()
    end

    if toggles.autospeed or toggles.fixedspeed then
        speed()
    end

    if toggles.reach then
        reachReal()
    end

    if toggles.chiclete then
        chicleteBall()
    end

    if toggles.autoDesarmar then
        autoDesarmar()
    end

end)
