local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

pcall(function()
    if CoreGui:FindFirstChild("PackedTextBox") then
        CoreGui.PackedTextBox:Destroy()
    end
end)

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
    NameLabel.TextWrapped = true
    NameLabel.Font = Enum.Font.SourceSansBold

    local highlight = Instance.new("Highlight
