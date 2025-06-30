--// Grow A Garden Visual Egg Randomizer UI Script
--// Created for immersive preview only (non-functional pets)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove existing GUI if re-run
if PlayerGui:FindFirstChild("EggRandomizerUI") then
    PlayerGui.EggRandomizerUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "EggRandomizerUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- UI Container
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.Position = UDim2.new(1, -330, 1, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.2
mainFrame.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🎲 Egg Visual Randomizer"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = mainFrame

-- Egg preview
local eggDisplay = Instance.new("TextLabel")
eggDisplay.Size = UDim2.new(1, -20, 0, 40)
eggDisplay.Position = UDim2.new(0, 10, 0, 40)
eggDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
eggDisplay.Text = "Bug Egg ➜ Snail"
eggDisplay.TextColor3 = Color3.new(1, 1, 1)
eggDisplay.Font = Enum.Font.GothamSemibold
eggDisplay.TextSize = 16
eggDisplay.Parent = mainFrame

local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 8)
displayCorner.Parent = eggDisplay

-- Controls
local autoRandom = Instance.new("TextButton")
autoRandom.Size = UDim2.new(0.45, -5, 0, 30)
autoRandom.Position = UDim2.new(0, 10, 0, 90)
autoRandom.Text = "Auto Random: ON"
autoRandom.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoRandom.TextColor3 = Color3.new(1, 1, 0.5)
autoRandom.Font = Enum.Font.GothamSemibold
autoRandom.TextSize = 14
autoRandom.Parent = mainFrame

autoRandom.MouseButton1Click:Connect(function()
    if autoRandom.Text:find("ON") then
        autoRandom.Text = "Auto Random: OFF"
    else
        autoRandom.Text = "Auto Random: ON"
    end
end)

local autoStop = Instance.new("TextButton")
autoStop.Size = UDim2.new(0.45, -5, 0, 30)
autoStop.Position = UDim2.new(0.5, 5, 0, 90)
autoStop.Text = "Auto Stop: ON"
autoStop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoStop.TextColor3 = Color3.fromRGB(255, 90, 90)
autoStop.Font = Enum.Font.GothamSemibold
autoStop.TextSize = 14
autoStop.Parent = mainFrame

autoStop.MouseButton1Click:Connect(function()
    if autoStop.Text:find("ON") then
        autoStop.Text = "Auto Stop: OFF"
    else
        autoStop.Text = "Auto Stop: ON"
    end
end)

-- Countdown timer
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, -20, 0, 24)
timerLabel.Position = UDim2.new(0, 10, 0, 130)
timerLabel.Text = "Changing in: 10"
timerLabel.BackgroundTransparency = 1
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.TextSize = 14
timerLabel.Parent = mainFrame

-- Egg data
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

-- Timer functionality
local counter = 10
spawn(function()
    while true do
        wait(1)
        if autoRandom.Text:find("ON") then
            counter = counter - 1
            timerLabel.Text = "Changing in: " .. counter
            if counter <= 0 then
                -- Pick a random egg and pet
                local eggList = {}
                for egg, _ in pairs(eggs) do table.insert(eggList, egg) end
                local eggName = eggList[math.random(1, #eggList)]
                local petList = eggs[eggName]
                local pet = petList[math.random(1, #petList)]
                eggDisplay.Text = eggName .. " ➜ " .. pet
                counter = 10
            end
        else
            timerLabel.Text = "Paused"
        end
    end
end)
