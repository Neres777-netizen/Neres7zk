local player = game.Players.LocalPlayer
local JUMP_POWER_DEFAULT = 50
local jumpEnabled = true -- true = pulo liberado

-- Função pra ligar/desligar o pulo
local function setJumpEnabled(enabled)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		if enabled then
			humanoid.JumpPower = JUMP_POWER_DEFAULT
		else
			humanoid.JumpPower = 0
			humanoid.Jump = false
		end
	end
end

-- Criar o botão flutuante redondo
local function createFloatingButton()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "JumpToggleGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local button = Instance.new("TextButton")
	button.Name = "FloatingJumpButton"
	button.Size = UDim2.new(0, 40, 0, 40)
	button.Position = UDim2.new(0, 10, 0.5, -20)
	button.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo inicial (pulo ON)
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.TextSize = 12
	button.Text = "OFF"
	button.BackgroundTransparency = 0
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Parent = screenGui
	button.ClipsDescendants = true

	-- Torna o botão redondo
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = button

	-- Função de arrastar
	local dragging
	local dragInput
	local dragStart
	local startPos

	local uis = game:GetService("UserInputService")

	local function updatePosition(input)
		local delta = input.Position - dragStart
		button.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end

	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = button.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	button.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			updatePosition(input)
		end
	end)

	-- Alternar pulo
	button.MouseButton1Click:Connect(function()
		jumpEnabled = not jumpEnabled
		setJumpEnabled(jumpEnabled)

		if jumpEnabled then
			button.Text = "OFF"
			button.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo
		else
			button.Text = "ON"
			button.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Azul
		end
	end)

	-- Atualiza estado no respawn
	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		setJumpEnabled(jumpEnabled)

		if jumpEnabled then
			button.Text = "OFF"
			button.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
		else
			button.Text = "ON"
			button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		end
	end)

	-- Inicializa estado
	setJumpEnabled(jumpEnabled)
end

-- Garantir que PlayerGui existe
if player:FindFirstChild("PlayerGui") then
	createFloatingButton()
else
	player:WaitForChild("PlayerGui")
	createFloatingButton()
end
