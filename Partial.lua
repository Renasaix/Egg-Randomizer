-- Egg Pet Randomizer GUI (Styled Like Munki UI)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Eggs and pets
local eggs = {
    ["🥚 Common Egg"] = {"Dog", "Bunny", "Golden Lab"},
    ["🥕 Uncommon Egg"] = {"Black Bunny", "Chicken", "Cat", "Deer"},
    ["💎 Rare Egg"] = {"Orange Tabby", "Spotted Deer", "Pig", "Monkey"},
    ["🌟 Legendary Egg"] = {"Cow", "Sea Otter", "Turtle", "Polar Bear"},
    ["🐛 Bug Egg"] = {"Snail", "Giant Ant", "Caterpillar", "Dragonfly"},
    ["🦊 Mythical Egg"] = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
    ["☀️ Common Summer Egg"] = {"Starfish", "Seagull", "Crab"},
    ["🏜️ Rare Summer Egg"] = {"Sea Turtle", "Toucan", "Flamingo", "Seal", "Orangutan"},
    ["🌴 Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["🌼 Oasis Egg"] = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"},
    ["🐝 Bee Egg"] = {"Bee", "Drone Bee", "Queen Bee"},
    ["🔥 Mythical Summer Egg"] = {"Red Fox", "Golden Deer", "Mimic Octopus"},
    ["🌙 Night Egg"] = {"Bat", "Night Owl", "Moth", "Raccoon"},
    ["🚫🐝 Anti-Bee Egg"] = {"Dust Bee", "Angry Bee", "Robot Bee", "Disco Bee"},
    ["🦖 Dino Egg"] = {"Triceratops", "Raptor", "Pterodactyl", "Brontosaurus", "Stegosaurus", "T-Rex"},
    ["🧬 Primal Egg"] = {"Parasaurolophus", "Iguanodon", "Pachycephalosaurus", "Dilophosaurus", "Ankylosaurus", "Spinosaurus"}
}

local rarePets = {
    ["🦊 Mythical Egg"] = "Red Fox",
    ["🔥 Mythical Summer Egg"] = "Mimic Octopus",
    ["🐛 Bug Egg"] = "Dragonfly",
    ["🌼 Oasis Egg"] = "Fennec Fox",
    ["🐝 Bee Egg"] = "Queen Bee",
    ["🌙 Night Egg"] = "Raccoon",
    ["🚫🐝 Anti-Bee Egg"] = "Disco Bee",
    ["🦖 Dino Egg"] = "T-Rex",
    ["🧬 Primal Egg"] = "Spinosaurus"
}

local selectedEgg = "🐛 Bug Egg"
local countdown = 0
local autoRandomize = true
local autoStop = false

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "EggPetRandomizer"
gui.ResetOnSpawn = false

-- Modern UI Frame
local mainPanel = Instance.new("Frame", gui)
mainPanel.Size = UDim2.new(0, 250, 0, 250)
mainPanel.Position = UDim2.new(0, 20, 0.5, -125)
mainPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainPanel.BorderSizePixel = 0
mainPanel.Active = true
mainPanel.Draggable = true

local title = Instance.new("TextLabel", mainPanel)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Pet Randomizer ✨"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local subtitle = Instance.new("TextLabel", mainPanel)
subtitle.Position = UDim2.new(0, 0, 0, 30)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Text = "Made by - zyferion"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextScaled = true

local randomBtn = Instance.new("TextButton", mainPanel)
randomBtn.Position = UDim2.new(0.1, 0, 0, 60)
randomBtn.Size = UDim2.new(0.8, 0, 0, 35)
randomBtn.Text = "🎲 Randomize Pets"
randomBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
randomBtn.TextColor3 = Color3.new(1, 1, 1)
randomBtn.Font = Enum.Font.GothamBold
randomBtn.TextScaled = true
randomBtn.MouseButton1Click:Connect(function()
    autoRandomize = true
    autoStop = true
end)

local espBtn = Instance.new("TextButton", mainPanel)
espBtn.Position = UDim2.new(0.1, 0, 0, 105)
espBtn.Size = UDim2.new(0.8, 0, 0, 30)
espBtn.Text = "👁 ESP: ON"
espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.Gotham
espBtn.TextScaled = true

local autoRndBtn = Instance.new("TextButton", mainPanel)
autoRndBtn.Position = UDim2.new(0.1, 0, 0, 145)
autoRndBtn.Size = UDim2.new(0.8, 0, 0, 30)
autoRndBtn.Text = "🔵 Auto Randomize: OFF"
autoRndBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 90)
autoRndBtn.TextColor3 = Color3.new(1, 1, 1)
autoRndBtn.Font = Enum.Font.Gotham
autoRndBtn.TextScaled = true
autoRndBtn.MouseButton1Click:Connect(function()
    autoRandomize = not autoRandomize
    autoRndBtn.Text = (autoRandomize and "🔵 Auto Randomize: ON" or "🔵 Auto Randomize: OFF")
end)

local countdownLabel = Instance.new("TextLabel", mainPanel)
countdownLabel.Position = UDim2.new(0.1, 0, 0, 185)
countdownLabel.Size = UDim2.new(0.8, 0, 0, 25)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Text = "Changing in: 0"
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.Font = Enum.Font.Gotham
countdownLabel.TextScaled = true

local petDisplay = Instance.new("TextLabel", mainPanel)
petDisplay.Position = UDim2.new(0.1, 0, 0, 215)
petDisplay.Size = UDim2.new(0.8, 0, 0, 25)
petDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
petDisplay.Text = "Random Pet: ???"
petDisplay.TextColor3 = Color3.new(1, 1, 1)
petDisplay.Font = Enum.Font.GothamBold
petDisplay.TextScaled = true

spawn(function()
    while true do
        wait(1)
        countdown += 1
        countdownLabel.Text = "Changing in: " .. countdown
        if countdown >= 15 then
            countdown = 0
        end
    end
end)

spawn(function()
    while true do
        if autoRandomize then
            local pets = eggs[selectedEgg] or {}
            local chosen = "???"
            local isRare = false
            if rarePets[selectedEgg] and countdown >= 10 then
                chosen = rarePets[selectedEgg]
                isRare = true
            elseif #pets > 0 then
                chosen = pets[math.random(1, #pets)]
            end
            petDisplay.Text = selectedEgg .. " Pet: " .. chosen
            petDisplay.TextColor3 = isRare and Color3.fromRGB(255, 215, 0) or Color3.new(1, 1, 1)
            if autoStop then autoRandomize = false end
        end
        wait(1)
    end
end)
