local RunService = game:GetService("RunService")
local eggsFolder = workspace:WaitForChild("eggs")

-- Egg definitions
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
    ["🌙 Night Egg"] = {"Hedgehog", "Frog", "Echo Frog", "Night Owl", "Raccoon"},
    ["🚫🐝 Anti-Bee Egg"] = {"Wasp", "Tarantula Hawk", "Moth", "Butterfly", "Disco Bee"},
    ["🦖 Dinosaur Egg"] = {"Raptor", "Triceratops", "Stegosaurus", "Pterodactyl", "Brontosaurus", "T-Rex"},
    ["🧬 Primal Egg"] = {"Parasaurolophus", "Iguanodon", "Pachycephalosaurus", "Dilophosaurus", "Ankylosaurus", "Spinosaurus"}
}

-- Rare pets
local rarePets = {
    ["🦊 Mythical Egg"] = "Red Fox",
    ["🔥 Mythical Summer Egg"] = "Mimic Octopus",
    ["🐛 Bug Egg"] = "Dragonfly",
    ["🌼 Oasis Egg"] = "Fennec Fox",
    ["🐝 Bee Egg"] = "Queen Bee",
    ["🌙 Night Egg"] = "Raccoon",
    ["🚫🐝 Anti-Bee Egg"] = "Disco Bee",
    ["🦖 Dino Egg"] = "T-Rex",
    ["🧬 Primal Egg"] = "Spinosaurus",
    ["🌴 Paradise Egg"] = "Mimic Octopus" 
}

-- Egg icons
local eggIcons = {
    ["Common Egg"] = "🥚",
    ["Uncommon Egg"] = "🥕",
    ["Rare Egg"] = "💎",
    ["Legendary Egg"] = "🌟",
    ["Bug Egg"] = "🐛",
    ["Mythical Egg"] = "🦊",
    ["Common Summer Egg"] = "☀️",
    ["Rare Summer Egg"] = "🏜️",
    ["Paradise Egg"] = "🌴",
    ["Oasis Egg"] = "🌼",
    ["Bee Egg"] = "🐝",
    ["Mythical Summer Egg"] = "🔥",
    ["Night Egg"] = "🌙",
    ["Anti-Bee Egg"] = "🚫🐝",
    ["Dino Egg"] = "🦖",
    ["Primal Egg"] = "🧬"
}

-- Utility to get the base egg name from a model's name
local function extractEggName(modelName)
    return string.match(modelName, "^(.-) Egg") and (string.match(modelName, "^(.-) Egg") .. " Egg")
end

-- Store timers and update data
local eggData = {}

-- Setup ESP on each egg
for _, eggModel in pairs(eggsFolder:GetChildren()) do
    local baseName = extractEggName(eggModel.Name)
    if baseName and eggPets[baseName] and eggModel:FindFirstChild("Egg Part") then
        local eggPart = eggModel:FindFirstChild("Egg Part")
        
        -- Billboard GUI
        local gui = Instance.new("BillboardGui")
        gui.Size = UDim2.new(0, 200, 0, 50)
        gui.StudsOffset = Vector3.new(0, 3, 0)
        gui.AlwaysOnTop = true
        gui.Name = "EggLabel"
        gui.Parent = eggPart

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.Parent = gui

        -- Save data
        eggData[eggModel] = {
            baseName = baseName,
            label = label,
            countdown = 0
        }
    end
end

-- Update loop
RunService.Heartbeat:Connect(function(dt)
    for egg, data in pairs(eggData) do
        data.countdown = data.countdown + dt
        if data.countdown >= 10 then
            data.countdown = 0
            local pets = eggPets[data.baseName]
            local icon = eggIcons[data.baseName] or "🥚"
            if pets and #pets > 0 then
                local chosen = pets[math.random(1, #pets)]
                data.label.Text = string.format("%s %s: %s", icon, data.baseName, chosen)
            end
        end
    end
end)


