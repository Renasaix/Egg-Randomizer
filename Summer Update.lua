--[[
  Grow A Garden - Visual Egg Pet Randomizer (Manual Egg Selection)
  Author: Renasaix
  Note: This is a client-side visual feature and does not interact with the game's mechanics.
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local eggs = {
    ["Common Egg"] = {"Dog", "Bunny", "Golden Lab"},
    ["Uncommon Egg"] = {"Black Bunny", "Chicken", "Cat", "Deer"},
    ["Rare Egg"] = {"Orange Tabby", "Spotted Deer", "Pig", "Monkey"},
    ["Legendary Egg"] = {"Cow", "Sea Otter", "Turtle", "Polar Bear"},
    ["Bug Egg"] = {"Snail", "Giant Ant", "Caterpillar", "Dragonfly"},
    ["Mythical Egg"] = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
    ["Common Summer Egg"] = {"Starfish", "Seagull", "Crab"},
    ["Rare Summer Egg"] = {"Sea Turtle", "Toucan", "Flamingo", "Seal", "Orangutan"},
    ["Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["Oasis Egg"] = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"},
}

-- Initial selected egg type
local selectedEgg = "Bug Egg"
local autoRandomize = true
local autoStop = false
local countdown = 10

-- Create ScreenGui
local gui = Instance.new("ScreenGui", playerGui)
gu gui.Name = "EggRandomizerGUI"
gu.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 180)
frame.Position = UDim2.new(0.7, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.2
frame.Name = "EggRandomizerFrame"

-- Dropdown Menu (Egg Selector)
local dropdown = Instance.new("TextButton", frame)
dropdown.Size = UDim2.new(1, -20, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 10)
dropdown.Text = "Selected Egg: " .. selectedEgg
dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dropdown.TextColor3 = Color3.new(1, 1, 1)
dropdown.Font = Enum.Font.SourceSansBold
dropdown.TextScaled = true

-- List of Egg Buttons
local eggListFrame = Instance.new("Frame", frame)
eggListFrame.Size = UDim2.new(1, -20, 0, 80)
eggListFrame.Position = UDim2.new(0, 10, 0, 45)
eggListFrame.BackgroundTransparency = 1

table.foreach(eggs, function(eggName, _)
    local eggBtn = Instance.new("TextButton", eggListFrame)
    eggBtn.Size = UDim2.new(1, 0, 0, 20)
    eggBtn.Text = eggName
    eggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    eggBtn.TextColor3 = Color3.new(1, 1, 1)
    eggBtn.Font = Enum.Font.SourceSans
    eggBtn.TextScaled = true
    eggBtn.MouseButton1Click:Connect(function()
        selectedEgg = eggName
        dropdown.Text = "Selected Egg: " .. selectedEgg
    end)
end)

-- Pet Display
local petLabel = Instance.new("TextLabel", frame)
petLabel.Size = UDim2.new(1, -20, 0, 30)
petLabel.Position = UDim2.new(0, 10, 0.7, 0)
petLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
petLabel.TextColor3 = Color3.new(1, 1, 1)
petLabel.Font = Enum.Font.SourceSansBold
petLabel.TextScaled = true
petLabel.Text = "Random Pet: ???"

-- Auto UI Toggle
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(0.48, -5, 0, 25)
autoBtn.Position = UDim2.new(0, 10, 1, -35)
autoBtn.Text = "Auto: ON"
autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.Font = Enum.Font.SourceSans
autoBtn.TextScaled = true
autoBtn.MouseButton1Click:Connect(function()
    autoRandomize = not autoRandomize
    autoBtn.Text = "Auto: " .. (autoRandomize and "ON" or "OFF")
end)

-- Stop Toggle
local stopBtn = Instance.new("TextButton", frame)
stopBtn.Size = UDim2.new(0.48, -5, 0, 25)
stopBtn.Position = UDim2.new(0.52, 0, 1, -35)
stopBtn.Text = "Auto Stop: OFF"
stopBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.SourceSans
stopBtn.TextScaled = true
stopBtn.MouseButton1Click:Connect(function()
    autoStop = not autoStop
    stopBtn.Text = "Auto Stop: " .. (autoStop and "ON" or "OFF")
end)

-- Randomizer Loop
spawn(function()
    while true do
        if autoRandomize then
            local pets = eggs[selectedEgg] or {}
            if #pets > 0 then
                local randomPet = pets[math.random(1, #pets)]
                petLabel.Text = "Random Pet: " .. randomPet
            end
            if autoStop then autoRandomize = false end
        end
        wait(countdown)
    end
end)
