local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

StarterGui:SetCore("SendNotification", {
    Title = "PACKEDLOL",
    Text = "PACKEDLOL FR!",
    Duration = 4
})

local ESPEnabled = true
local CamlockEnabled = false
local ESPObjects = {}

local function createESP(player)
    if player == LocalPlayer or ESPObjects[player] then return end
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")

    local Billboard = Instance.new("BillboardGui", head)
    Billboard.Name = "PackedName"
    Billboard.Size = UDim2.new(0, 200, 0, 50)
    Billboard.Adornee = head
    Billboard.AlwaysOnTop = true

    local NameLabel = Instance.new("TextLabel", Billboard)
    NameLabel.Size = UDim2.new(1, 0, 1, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = player.Name
    NameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    NameLabel.TextScaled = true
    NameLabel.Font = Enum.Font.SourceSansBold

    local highlight = Instance.new("Highlight")
    highlight.Name = "PackedESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.3
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineTransparency = 0
    highlight.Adornee = character
    highlight.Parent = character

    ESPObjects[player] = {highlight, Billboard}
end

local function removeESP(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        ESPObjects[player] = nil
    end
end

local function toggleESP()
    ESPEnabled = not ESPEnabled
    for _, player in ipairs(Players:GetPlayers()) do
        if ESPEnabled then
            createESP(player)
        else
            removeESP(player)
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end

Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

local camlockTarget = nil

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.Q then
        if CamlockEnabled then
            camlockTarget = nil
            CamlockEnabled = false
        else
            local closest, dist = nil, math.huge
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local headPos = camera:WorldToViewportPoint(player.Character.Head.Position)
                    local mousePos = UserInputService:GetMouseLocation()
                    local mag = (Vector2.new(headPos.X, headPos.Y) - mousePos).Magnitude
                    if mag < dist and mag < 250 then
                        closest = player
                        dist = mag
                    end
                end
            end
            camlockTarget = closest
            CamlockEnabled = camlockTarget ~= nil
        end
    elseif input.KeyCode == Enum.KeyCode.P then
        toggleESP()
    end
end)

RunService.RenderStepped:Connect(function()
    if CamlockEnabled and camlockTarget and camlockTarget.Character and camlockTarget.Character:FindFirstChild("Head") then
        camera.CFrame = CFrame.new(camera.CFrame.Position, camlockTarget.Character.Head.Position)
    end
end)


local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "PackedTextBox"

local label = Instance.new("TextLabel", screenGui)
label.Size = UDim2.new(0, 300, 0, 100)
label.Position = UDim2.new(0.5, -150, 0, 10)
label.BackgroundTransparency = 1
label.Text = "Muha\nFulcrum"
label.TextColor3 = Color3.fromRGB(255, 0, 0)
label.TextStrokeTransparency = 0.8
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.TextYAlignment = Enum.TextYAlignment.Top
