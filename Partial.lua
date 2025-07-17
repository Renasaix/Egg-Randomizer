local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

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

-- Store label data
local labelData = {}

-- Extract egg name from model name
local function getEggKeyFromModel(modelName)
    for eggKey in pairs(eggs) do
        if modelName:match("^" .. eggKey) then
            return eggKey
        end
    end
    return nil
end

-- Create label above egg
local function createEggLabel(eggModel, eggKey)
    if not eggModel:IsA("Model") and not eggModel:IsA("BasePart") then return end

    local attachmentPart = eggModel:FindFirstChild("Head") or eggModel:FindFirstChildWhichIsA("BasePart")
    if not attachmentPart then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "EggESP"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = attachmentPart
    billboard.Parent = eggModel

    local title = Instance.new("TextLabel")
    title.Name = "EggTitle"
    title.Size = UDim2.new(1, 0, 0.5, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = eggKey
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextStrokeTransparency = 0.6
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = billboard

    local petLabel = Instance.new("TextLabel")
    petLabel.Name = "PetName"
    petLabel.Size = UDim2.new(1, 0, 0.5, 0)
    petLabel.Position = UDim2.new(0, 0, 0.5, 0)
    petLabel.BackgroundTransparency = 1
    petLabel.Text = "..."
    petLabel.TextColor3 = Color3.new(1, 1, 1)
    petLabel.Font = Enum.Font.Gotham
    petLabel.TextScaled = true
    petLabel.Parent = billboard

    labelData[eggModel] = {
        eggKey = eggKey,
        petLabel = petLabel,
        timer = 0
    }
end

-- Initial scan for eggs
for _, obj in ipairs(Workspace:GetDescendants()) do
    if obj:IsA("Model") or obj:IsA("BasePart") then
        local eggKey = getEggKeyFromModel(obj.Name)
        if eggKey and not obj:FindFirstChild("EggESP", true) then
            createEggLabel(obj, eggKey)
        end
    end
end

-- Update pet names every 10 seconds
RunService.Heartbeat:Connect(function(dt)
    for eggModel, data in pairs(labelData) do
        if eggModel and eggModel.Parent and data.petLabel and data.petLabel.Parent then
            data.timer = data.timer + dt
            if data.timer >= 10 then
                data.timer = 0
                local pets = eggs[data.eggKey]
                if pets and #pets > 0 then
                    local chosen = pets[math.random(1, #pets)]
                    local isRare = rarePets[data.eggKey] == chosen or (rarePets[data.eggKey] and math.random() > 0.7)
                    data.petLabel.Text = chosen
                    data.petLabel.TextColor3 = isRare and Color3.fromRGB(255, 215, 0) or Color3.new(1, 1, 1)
                end
            end
        end
    end
end)
