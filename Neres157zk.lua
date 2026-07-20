-- ====== SCRIPT STAR HUB COMPLETO E CORRIGIDO ======
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Verificação do WindUI
if not WindUI then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ ERRO",
        Text = "Falha ao carregar WindUI!",
        Duration = 5,
    })
    return
end

-- ========== WEBHOOK ==========
local HttpService = game:GetService("HttpService")
local request_func = http_request or request

local Webhook_URL = "https://discord.com/api/webhooks/1521158004186288209/a1uMv_SXlItQWtPftGEhgHnZdZ-JbfgplvTyMrEP2x_Kk26MlN4uqAnVIkJzbOWvNGyT"

-- ========== SISTEMA DE WHITELIST ==========
local whitelistedUsers = {
    "mbape9joat1",
    "Yasmin_xx778",
    "brayannathan09",
    "poderoso4424",
    "Fastzadas",
    "Viniixz36",
    "Souzateatravessouokd",
    "pequenolittlebk3",
    "arte_thetravessa",
    "garotosemcop",
    "Aliban_32",
    "brayannathan09", -- ✅ ADICIONADO
}

local player = game.Players.LocalPlayer
local userName = player.Name
local displayName = player.DisplayName
local userId = player.UserId
local StarterGui = game:GetService("StarterGui")

-- Verifica whitelist
local isWhitelisted = false
for _, whitelisted in ipairs(whitelistedUsers) do
    if string.lower(userName) == string.lower(whitelisted) then
        isWhitelisted = true
        break
    end
end

-- ====== SISTEMA DE MENSAGENS ======
if isWhitelisted then
    StarterGui:SetCore("SendNotification", {
        Title = "✅ ACESSO LIBERADO!",
        Text = "Bem-vindo " .. displayName .. "!\nVocê está na whitelist do Star Hub!\nAproveite os scripts! 🚀",
        Duration = 5,
    })
    print("✅ " .. userName .. " - AUTORIZADO!")
    
    pcall(function()
        local embedSucesso = {
            embeds = {{
                title = "✅ USUÁRIO AUTORIZADO!",
                description = "**" .. displayName .. "** executou o script com sucesso!\n\n" ..
                              "**Usuário:** " .. userName .. "\n" ..
                              "**User ID:** " .. userId .. "\n" ..
                              "**PlaceId:** " .. game.PlaceId,
                color = 0x00FF00
            }}
        }
        request_func({
            Url = Webhook_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(embedSucesso)
        })
    end)
    
else
    StarterGui:SetCore("SendNotification", {
        Title = "⛔ ACESSO NEGADO!",
        Text = "❌ Você NÃO está na whitelist!\n\nUsuário: " .. userName .. "\n\nEntre em contato com o administrador.",
        Duration = 10,
    })
    print("❌ " .. userName .. " - BLOQUEADO!")
    
    pcall(function()
        local embedFalha = {
            embeds = {{
                title = "⛔ ACESSO NEGADO - WHITELIST",
                description = "**" .. displayName .. "** tentou executar mas foi BLOQUEADO!\n\n" ..
                              "**Usuário:** " .. userName .. "\n" ..
                              "**User ID:** " .. userId .. "\n" ..
                              "**PlaceId:** " .. game.PlaceId .. "\n\n" ..
                              "❌ **Este usuário NÃO está na whitelist!**",
                color = 0xFF0000
            }}
        }
        request_func({
            Url = Webhook_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(embedFalha)
        })
    end)
    
    error("🚫 Usuário não autorizado! Script cancelado.")
    return
end

-- ====== MENSAGEM DE SUCESSO ======
StarterGui:SetCore("SendNotification", {
    Title = "🚀 STAR HUB CARREGADO!",
    Text = "Bem-vindo " .. displayName .. "!\nAproveite os scripts! ⚡",
    Duration = 4,
})

-- ====== CRIAÇÃO DA INTERFACE ======
WindUI:AddTheme({
    Name = "Star",
    Accent = Color3.fromHex("#FFD700"),
    Background = Color3.fromHex("#000000"),
    Outline = Color3.fromHex("#FFD700"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#FFD700"),
    Button = Color3.fromHex("#FFD700"),
    Icon = Color3.fromHex("#FFD700"),
})

local MainWindow = WindUI:CreateWindow({
    Title = "Star Hub",
    Icon = "star",
    Author = "Por Math & Brito",
    Folder = "SH",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = false,
    Theme = "Star",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
})

if not MainWindow then
    StarterGui:SetCore("SendNotification", {
        Title = "❌ ERRO",
        Text = "Falha ao criar a interface!",
        Duration = 5,
    })
    return
end

pcall(function()
    MainWindow:Tag({
        Title = "V1",
        Icon = "",
        Color = Color3.fromHex("#FFD700"),
        Radius = 13,
    })
end)

pcall(function()
    MainWindow:EditOpenButton({
        Title = "Anti Pulo",
        Icon = "shield-ban",
        CornerRadius = UDim.new(0,8),
        StrokeThickness = 3,
        Color = ColorSequence.new(
            Color3.fromHex("#FFD700"),
            Color3.fromHex("#DAA520")
        ),
        OnlyMobile = true,
        Enabled = true,
        Draggable = true,
    })
end)

-- ================= TAB PRINCIPAL =================
local MainTab = MainWindow:Tab({
    Title = "Principal",
    Icon = "house",
    Locked = false,
})

-- Função helper para carregar scripts
local function LoadScript(url)
    pcall(function()
        loadstring(game:HttpGet(url))()
    end)
end

-- =====================================================
-- SEÇÃO 1: ZYCK SCRIPTS
-- =====================================================
MainTab:Section({
    Title = "Zyck Scripts",
    Icon = "star",
})

MainTab:Button({
    Title = "Zyck Control 🌀",
    Desc = "Key: 123ZYCK",
    Locked = false,
    Callback = function() LoadScript("https://pastefy.app/pA4bytOQ/raw") end
})

MainTab:Button({
    Title = "Zyck 4.5 🇺🇸",
    Locked = false,
    Callback = function() LoadScript("https://pastefy.app/P2eNOBe2/raw") end
})

MainTab:Button({
    Title = "Zyck ☠️",
    Locked = false,
    Callback = function() LoadScript("https://pastebin.com/raw/WYeG9ypc") end
})

MainTab:Button({
    Title = "Zyck + Mtzin + Soccer + Nova Era Hub 🌈",
    Locked = false,
    Callback = function() LoadScript("https://pastebin.com/fm7nN4KF") end
})

-- =====================================================
-- SEÇÃO 2: ATRAVESSAR
-- =====================================================
MainTab:Section({
    Title = "Atravessar",
    Icon = "footprints",
})

local atravessarScripts = {
    {"Atravessar Theus 👻", "https://pastefy.app/7e1VxPgW/raw"},
    {"PJ Atravessa 🧧", "https://pastefy.app/CrhmqFtx/raw"},
    {"Atravessar V12🟣", "https://pastebin.com/raw/GZn1L0PM"},
    {"Atravessar Simples🔥", "https://pastebin.com/raw/D15v30nW"},
    {"Atravessar Zyck + Bola Branca🔮", "https://pastefy.app/UyL8ic0V/raw"},
    {"Oliver Atravessador 🗡", "https://pastefy.app/GTHc3EnC/raw"},
    {"Atravessar Pikolandia 💗", "https://pastefy.app/FMwl1GLk/raw"},
    {"Anti Atravessar Soccer Tool⚽", "https://pastebin.com/raw/LYWJ6sfF"},
    {"Atravessar Lendário ✡️", "https://pastebin.com/raw/zh9P9AqV"},
    {"Atravessar 🟪", "https://pastefy.app/KdhVVlaC/raw"},
}

for _, script in ipairs(atravessarScripts) do
    MainTab:Button({
        Title = script[1],
        Locked = false,
        Callback = function() LoadScript(script[2]) end
    })
end

-- =====================================================
-- SEÇÃO 3: ANTI PULO
-- =====================================================
MainTab:Section({
    Title = "Anti Pulo",
    Icon = "shield-ban",
})

local antiPuloScripts = {
    {"Anti Pulo + Atravessar + Empurrar ⚽️", "https://pastefy.app/sIhEJFAz/raw"},
    {"Anti Pulo Foldenxz 🚫", "https://pastebin.com/raw/d2T3QxGt"},
    {"Anti Pulo Elias 🚫", "https://pastebin.com/raw/mgzrnsbr"},
    {"Lc Pjl Anti Pulo 🚫", "https://pastebin.com/raw/MCTcaHZq"},
    {"Anti Pulo Luke Jr 🔆", "https://pastefy.app/d0yvvV78/raw"},
}

for _, script in ipairs(antiPuloScripts) do
    MainTab:Button({
        Title = script[1],
        Locked = false,
        Callback = function() LoadScript(script[2]) end
    })
end

-- =====================================================
-- SEÇÃO 4: REACH
-- =====================================================
MainTab:Section({
    Title = "Reach",
    Icon = "hand",
})

local reachScripts = {
    {"Reach Forte Do Morales🤣", "https://pastefy.app/ckJb1cXM/raw"},
    {"Theus Reach V2 🦿", "https://pastebin.com/raw/pm4pyxm4"},
    {"Reach The Void🌑", "https://pastefy.app/1fVPQXXM/raw"},
    {"Reach Do Theus🦿", "https://pastefy.app/tSYVNcwc/raw"},
    {"Ghost + Reach👻", "https://pastebin.com/raw/1if0pn7x"},
    {"Noclip Injusto + reach bola 900 studs🔥", "https://pastebin.com/raw/hfrDcUm8"},
}

for _, script in ipairs(reachScripts) do
    MainTab:Button({
        Title = script[1],
        Locked = false,
        Callback = function() LoadScript(script[2]) end
    })
end

-- =====================================================
-- SEÇÃO 5: BOLA
-- =====================================================
MainTab:Section({
    Title = "Bola",
    Icon = "circle",
})

local bolaScripts = {
    {"Ball Chiclete ⚽️", "https://pastefy.app/AzBz08Dq/raw"},
    {"Bola Roxa 🟣", "https://pastefy.app/lGbsdxob/raw"},
    {"Bola Chiclete⚽️", "https://pastefy.app/ZMHWh8kW/raw"},
    {"Anti Ball Pedra + Atravessar⚽", "https://pastebin.com/raw/Z7eZDEj8"},
    {"Anti Ball Pedra⚽", "https://pastefy.app/59dDHHfr/raw"},
}

for _, script in ipairs(bolaScripts) do
    MainTab:Button({
        Title = script[1],
        Locked = false,
        Callback = function() LoadScript(script[2]) end
    })
end

-- =====================================================
-- SEÇÃO 6: HUBS E PAINEIS
-- =====================================================
MainTab:Section({
    Title = "Hubs e Painéis",
    Icon = "box",
})

local hubs = {
    {"DD Osama V5 🇺🇸", "https://pastebin.com/raw/NxpP7iWb"},
    {"Fuzzy Bugs ♟️", "https://pastefy.app/rsiBF3CL/raw"},
    {"Anti Roubo Bola ⚽️", "https://pastebin.com/raw/4GXQEjAs"},
    {"Brito Hub ⚡️", "https://pastebin.com/raw/e8i6ytza"},
    {"Sixxinho Hub 🔒", "https://raw.githubusercontent.com/josegaviao888-alt/Six-Hub-Privdo/refs/heads/main/Six%20hUB"},
    {"Six Hub 6️⃣", "https://pastebin.com/raw/MDhqkib4"},
    {"Brazilian Panel V2 🇧🇷", "https://pastebin.com/raw/geau1Zy7"},
    {"Brazilian Panel🇧🇷", "https://pastebin.com/raw/x5XX9kiK"},
    {"Nova Era Hub💎", "https://pastefy.app/FIyTYLlC/raw"},
    {"Fire Hub🔥", "https://pastebin.com/raw/iVp2tnCR"},
    {"Sforza Hub🔧", "https://pastebin.com/raw/pdyfSjzK"},
    {"Cantona Hub 🏡", "https://pastefy.app/Ul55j8hu/raw"},
    {"Armando Jr Hub🔥", "https://raw.githubusercontent.com/carlosedut11/ArmadinhoJrPorCantonaJr/refs/heads/main/ArmadinhoJrPorCantonaJr.lua"},
    {"Water Hub🌊", "https://pastefy.app/vcwYKiUn/raw"},
    {"Lukinhas Hub 💙", "https://pastebin.com/raw/dhxQnF4b"},
    {"Pirulito Hub 🍭", "https://pastebin.com/raw/A0xCHTGM"},
    {"Toni Kroos 🍀", "https://pastebin.com/raw/bCL22UZw"},
    {"X10 Premium Hub 💎", "https://pastebin.com/raw/MW2Zyv6z"},
    {"Soccer Dribble Hub ⚡️", "https://pastebin.com/raw/gwZKjbVM"},
    {"Puyol V3 ⚡️", "https://pastebin.com/raw/bMLRRKwG"},
    {"Gui Prime Pro⚽️", "https://pastebin.com/raw/xgkQc7Q9"},
    {"Lucas Hub😈", "https://pastebin.com/raw/xmbL5T3i"},
    {"Matteo Hub ❄️", "https://pastefy.app/Pvf3lqmJ/raw"},
    {"Gotto Hub⚽", "https://pastefy.app/EOizRmIz/raw"},
    {"Loved Hub🍷", "https://pastefy.app/AccDN8CV/raw"},
    {"Angel Hub😇", "https://pastefy.app/679CyrEi/raw"},
    {"Samuzx Hub🥶", "https://pastefy.app/yOVyrBNy/raw"},
    {"Brookhaven Panel🏠", "https://pastefy.app/RGPRtmRg/raw"},
    {"GK Hub (Goleiro Deitado)🧤", "https://pastebin.com/raw/FaBkfBHr"},
    {"Muralha Hub🧱", "https://pastebin.com/raw/UxtmMHm1"},
    {"Yashin Ultra🧤", "https://pastebin.com/raw/KmNHLYsb"},
    {"Goleiro Hub (Rayfield)🧤", "https://pastefy.app/cogJvYif/raw"},
    {"Theus Hub🍎", "https://pastefy.app/bib1MRS8/raw"},
    {"Painel Spider V2🕷", "https://pastefy.app/LvYw31OO/raw"},
    {"Script do Spider V1🕷", "https://pastefy.app/hutJntDN/raw"},
    {"Hub Da Leandrinha⚽️", "https://pastebin.com/raw/q5CxCNyi"},
    {"Caga Na Roupa Hub 💩", "https://pastefy.app/eKFExNPG/raw"},
    {"Script Da Debinha🥀", "https://pastefy.app/9k4tL5Q7/raw"},
    {"Hotdog V4 🌭", "https://pastefy.app/GzxmSIIn/raw"},
    {"Tubaina Hub 🥶", "https://pastefy.app/xLM92mP5/raw"},
    {"Brookhaven Painel V2🏠", "https://pastebin.com/raw/m70Y67h9"},
    {"Papai Cris Menu❤️", "https://pastefy.app/jI58Il0a/raw"},
    {"Hunk Hub🫂", "https://pastefy.app/ZGDUJNWr/raw"},
    {"Legendary Defender ⚔️", "https://pastebin.com/raw/s91y0AFs"},
    {"X Hub ❌️", "https://pastefy.app/yXuzlTpQ/raw"},
    {"K4y The Promission☠️", "https://pastefy.app/UtzKwcGt/raw"},
    {"LP Scripts✔️", "https://gist.githubusercontent.com/yesn20456-crypto/af368f3184c1d34a8f4a9e33d4325d0d/raw/60e8309b99f9e002a55005b2d7905a82b90b70f1/gistfile1.txt"},
    {"Pedrizz Bug⚡️", "https://pastebin.com/raw/28LDYic2"},
    {"Glitch Infinity♾️", "https://pastebin.com/raw/FpPh3UhN"},
    {"Script do Kay V2🔥", "https://pastebin.com/raw/eXGuwWWE"},
    {"Mtzin Pro Max ⚡️", "https://pastebin.com/raw/kCKEhh99"},
    {"Painel do Kayne🔥", "https://pastebin.com/raw/Frxjj6my"},
    {"Kayne Supremo🔥", "https://pastebin.com/raw/xyS7KQdY"},
    {"Football Master V7⚽", "https://pastefy.app/I9nocuO2/raw"},
    {"Football Master V5 Pro⚽", "https://pastefy.app/77ScQkbz/raw"},
    {"Script do Freezer🧊", "https://pastefy.app/bWS31I8q/raw"},
    {"Piu V5 ㊗️", "https://pastefy.app/ZTjSqELh/raw"},
    {"Royal Shadow ☂️", "https://pastefy.app/Y6yKS7DD/raw"},
    {"Armando Shop 👑", "https://pastebin.com/raw/9uJjEgB1"},
}

for _, hub in ipairs(hubs) do
    MainTab:Button({
        Title = hub[1],
        Locked = false,
        Callback = function() LoadScript(hub[2]) end
    })
end

-- =====================================================
-- SEÇÃO 7: OTIMIZAÇÕES E UTILIDADES
-- =====================================================
MainTab:Section({
    Title = "Otimizações e Utilidades",
    Icon = "wrench",
})

local otimizacoes = {
    {"Mega Otimização Brookhaven 🏠", "https://pastebin.com/raw/GzrqQWkx"},
    {"Otimização Muda Cor do Campo 🎨", "https://pastebin.com/raw/Zfjqvyzn"},
    {"Otimização Slow 🐢", "https://pastebin.com/raw/gX2QzCQ4"},
    {"Otimização Linha Transparente 🔗", "https://pastebin.com/raw/RbC506TY"},
    {"Otimização🚀", "https://raw.githubusercontent.com/Davzxxfixroblox/DavzxHubFixLag/refs/heads/main/FixLagHub"},
    {"Ping Optimizer🧟‍♂️", "https://pastebin.com/raw/kbHL8MZ5"},
    {"Brookhaven Optimization🧩", "https://pastebin.com/raw/5DK3dz5Y"},
    {"Slow Otimizer 💍", "https://pastefy.app/tSoOifGr/raw"},
    {"Esticar Tela 🖥", "https://pastefy.app/4Sa0uIve/raw"},
    {"Tira Analógico 🕹", "https://pastefy.app/AJhzcN5G/raw"},
}

for _, otim in ipairs(otimizacoes) do
    MainTab:Button({
        Title = otim[1],
        Locked = false,
        Callback = function() LoadScript(otim[2]) end
    })
end

-- =====================================================
-- SEÇÃO 8: DIVERSOS
-- =====================================================
MainTab:Section({
    Title = "Diversos",
    Icon = "plus",
})

local diversos = {
    {"Limpar Tela 💻", "https://pastefy.app/FwY4L6qM/raw"},
    {"Teste De Campo 🏑", "https://pastefy.app/dNWJ5ot7/raw"},
    {"Passe Forte🦵", "https://pastebin.com/raw/2Yw8Bv85"},
    {"Lag Switch👣", "https://pastefy.app/zZo7yoUB/raw"},
    {"Bug Do reidorm👑", "https://pastebin.com/raw/qtsDZHGu"},
    {"Henrique Drible ⚡", "https://pastebin.com/raw/wJKBdV8A"},
    {"Jvz Bug🥷", "https://pastefy.app/hYyBJna9/raw"},
    {"Condução Theus⚽", "https://pastefy.app/7FAwfRUX/raw"},
    {"Chute Bomba💣", "https://pastefy.app/HeRcZpTg/raw"},
    {"Script De Magnetismo 🧲", "https://pastefy.app/SNttOINq/raw"},
}

for _, div in ipairs(diversos) do
    MainTab:Button({
        Title = div[1],
        Locked = false,
        Callback = function() LoadScript(div[2]) end
    })
end

-- ================= TAB SCRIPTS ALTERNATIVOS =================
local SATab = MainWindow:Tab({
    Title = "Scripts Alternativos",
    Icon = "shield",
    Locked = false,
})

local alternativos = {
    {"Fly🍃", "https://pastefy.app/IHIgGN9b/raw"},
    {"Coquette Hub🎀", "https://rawscripts.net/raw/Brookhaven-RP-Coquette-Hub-41921"},
    {"Hexagon Client🔘", "https://raw.githubusercontent.com/nxvap/hexagon/refs/heads/main/brookhaven"},
    {"Script De Emotes🕺", "https://pastefy.app/lAdApmz4/raw"},
    {"Crosshair 🎯", "https://rawscripts.net/raw/Universal-Script-Custom-Crosshair-Gui-237611"},
}

for _, alt in ipairs(alternativos) do
    SATab:Button({
        Title = alt[1],
        Locked = false,
        Callback = function() LoadScript(alt[2]) end
    })
end

-- ================= TAB CONFIGURAÇÕES =================
local ConfigTab = MainWindow:Tab({
    Title = "Configurações",
    Icon = "cog",
    Locked = false,
})

local Camera = workspace.CurrentCamera

ConfigTab:Slider({
    Title = "FOV",
    Step = 1,
    Value = {
        Min = 20,
        Max = 120,
        Default = 70,
    },
    Callback = function(value)
        pcall(function()
            if Camera then
                Camera.FieldOfView = value
            end
        end)
    end
})

ConfigTab:Slider({
    Title = "Velocidade (Speed)",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = 16,
    },
    Callback = function(value)
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then 
                hum.WalkSpeed = value 
            end
        end)
    end
})

ConfigTab:Slider({
    Title = "Força de Pulo (Jump)",
    Step = 1,
    Value = {
        Min = 50,
        Max = 300,
        Default = 50,
    },
    Callback = function(value)
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then 
                hum.JumpPower = value 
            end
        end)
    end
})

-- Botão Destruir Interface (CORRIGIDO)
ConfigTab:Button({
    Title = "Destruir Interface🔨",
    Locked = false,
    Callback = function()
        pcall(function()
            if MainWindow then
                MainWindow:Destroy()
            end
        end)
    end
})

print("✅ Star Hub Carregado com sucesso!")
