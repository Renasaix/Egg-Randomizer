-- Egg Pet Randomizer (Landscape + Interactive + Timer Boosted Rarity)
-- By: Aroa + ChatGPT Custom GUI

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Egg Data
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
    ["Bee Egg"] = {"Bee", "Drone Bee", "Queen Bee"},
    ["Mythical Summer Egg"] = {"Red Fox", "Golden Deer", "Mimic Octopus"}
}

-- Rare pets that only appear after timer reaches threshold
local rarePets = {
    ["Mythical Egg"] = "Red Fox",
    ["Mythical Summer Egg"] = "Mimic Octopus",
    ["Bug Egg"] = "Dragonfly",
    ["Oasis Egg"] = "Fennec Fox",
    ["Bee Egg"] = "Queen Bee"
}

-- Egg image asset IDs (replace with real IDs!)
local eggImages = {
    ["Mythical Egg"] = "rbxassetid://1234567890",
    ["Rare Summer Egg"] = "rbxassetid://1234567891",
    ["Common Egg"] = "rbxassetid://1234567892",
    ["Common Summer Egg"] = "rbxassetid://1234567893",
    ["Mythical Summer Egg"] = "rbxassetid://1234567894",
    ["Bee Egg"] = "rbxassetid://1234567895",
    ["Bug Egg"] = "rbxassetid://1234567896",
    ["Oasis Egg"] = "rbxassetid://1234567897"
}

local selectedEgg = "Common Egg"
local countdown = 5
local autoRandomize = true
local autoStop = false

-- GUI Setup
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "EggPetRandomizer"
gui.ResetOnSpawn = false

-- Draggable Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 250)
frame.Position = UDim2.new(0.5, -300, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🥚 Egg Pet Randomizer 🐾"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Pet Display
local petDisplay = Instance.new("TextLabel", frame)
petDisplay.Position = UDim2.new(0, 10, 0, 40)
petDisplay.Size = UDim2.new(1, -20, 0, 50)
petDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
petDisplay.Text = "Random Pet: ???"
petDisplay.TextColor3 = Color3.new(1, 1, 1)
petDisplay.Font = Enum.Font.GothamBold
petDisplay.TextScaled = true

-- Timer Label
local timerLabel = Instance.new("TextLabel", frame)
timerLabel.Position = UDim2.new(0, 10, 0, 100)
timerLabel.Size = UDim2.new(0.5, -20, 0, 30)
timerLabel.Text = "Timer: " .. countdown .. "s"
timerLabel.BackgroundTransparency = 1
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextScaled = true

-- Timer Increase Button
local timerBtn = Instance.new("TextButton", frame)
timerBtn.Position = UDim2.new(0.5, 0, 0, 100)
timerBtn.Size = UDim2.new(0.5, -10, 0, 30)
timerBtn.Text = "Increase Time"
timerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
timerBtn.TextColor3 = Color3.new(1, 1, 1)
timerBtn.Font = Enum.Font.Gotham
timerBtn.TextScaled = true
timerBtn.MouseButton1Click:Connect(function()
    countdown += 1
    timerLabel.Text = "Timer: " .. countdown .. "s"
end)

-- Egg Selector
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 140)
scroll.Size = UDim2.new(1, -20, 0, 100)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scroll.CanvasSize = UDim2.new(0, #eggs * 110, 0, 0)
scroll.ScrollBarThickness = 6
scroll.ScrollingDirection = Enum.ScrollingDirection.X

-- Egg Buttons with Images
local x = 0
for name, _ in pairs(eggs) do
    local eggBtn = Instance.new("ImageButton", scroll)
    eggBtn.Position = UDim2.new(0, x, 0, 0)
    eggBtn.Size = UDim2.new(0, 100, 0, 100)
    eggBtn.Name = name
    eggBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    eggBtn.Image = eggImages[name] or ""
    
    local lbl = Instance.new("TextLabel", eggBtn)
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.Position = UDim2.new(0, 0, 1, -20)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    
    eggBtn.MouseButton1Click:Connect(function()
        selectedEgg = name
    end)
    x += 110
end

-- Pet Randomizer Loop
task.spawn(function()
    while true do
        if autoRandomize then
            local pets = eggs[selectedEgg] or {}
            local picked = "???"
            
            -- Rare pet logic
            if rarePets[selectedEgg] and countdown >= 10 then
                picked = rarePets[selectedEgg]
                petDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
            elseif #pets > 0 then
                picked = pets[math.random(1, #pets)]
                petDisplay.TextColor3 = Color3.new(1, 1, 1)
            end
            
            petDisplay.Text = "Random Pet: " .. picked
            if autoStop then autoRandomize = false end
        end
        wait(countdown)
    end
end)
