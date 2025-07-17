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

-- Finds all egg models in workspace local function getEggModels() local found = {} for _, model in ipairs(Workspace:GetDescendants()) do if model:IsA("Model") and model:FindFirstChild("Main") and model.Name:match("Egg") then table.insert(found, model) end end return found end

-- Create BillboardGui on egg local function createLabel(model, eggType) if model:FindFirstChild("EggESP") then return end -- Prevent duplicates

local head = model:FindFirstChild("Main")
if not head then return end

local billboard = Instance.new("BillboardGui")
billboard.Name = "EggESP"
billboard.Size = UDim2.new(0, 200, 0, 50)
billboard.StudsOffset = Vector3.new(0, 3, 0)
billboard.AlwaysOnTop = true
billboard.Adornee = head
billboard.Parent = model

local eggName = Instance.new("TextLabel")
eggName.Size = UDim2.new(1, 0, 0.5, 0)
eggName.Position = UDim2.new(0, 0, 0, 0)
eggName.BackgroundTransparency = 1
eggName.Text = "🥚 " .. eggType
eggName.TextColor3 = Color3.fromRGB(255, 255, 255)
eggName.Font = Enum.Font.GothamBold
eggName.TextScaled = true
eggName.Parent = billboard

local petLabel = Instance.new("TextLabel")
petLabel.Name = "PetLabel"
petLabel.Size = UDim2.new(1, 0, 0.5, 0)
petLabel.Position = UDim2.new(0, 0, 0.5, 0)
petLabel.BackgroundTransparency = 1
petLabel.Text = ""
petLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
petLabel.Font = Enum.Font.Gotham
petLabel.TextScaled = true
petLabel.Parent = billboard

-- Randomizer coroutine
task.spawn(function()
    local timer = 0
    while model.Parent do
        task.wait(1)
        timer += 1
        local chosen = "???"
        local isRare = false
        local pets = eggs[eggType] or {}
        if rarePets[eggType] and timer >= 10 then
            chosen = rarePets[eggType]
            isRare = true
        elseif #pets > 0 then
            chosen = pets[math.random(1, #pets)]
        end
        petLabel.Text = chosen
        petLabel.TextColor3 = isRare and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 200, 200)
        if timer >= 10 then timer = 0 end
    end
end)

end

-- Main logic for _, 
model in ipairs(getEggModels()) 
do local eggNameRaw = model.Name:split("|")[1] local trimmed = eggNameRaw:gsub("%s+$", "") createLabel(model, trimmed) end

