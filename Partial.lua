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

local function getPetListFromName(name)
    for eggName, petList in pairs(eggs) do
        if name:lower():find(eggName:match("[%w%s]+"):lower()) then
            return petList
        end
    end
    return nil
end

local function addESP(model, petList)
    local part = model:FindFirstChildWhichIsA("BasePart", true)
    if not part then return end

    if part:FindFirstChild("PetESP") then return end -- Prevent duplicates

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard

    -- Start pet name randomizer
    spawn(function()
        while true do
            if petList and #petList > 0 then
                local randomPet = petList[math.random(1, #petList)]
                label.Text = "🎲 " .. randomPet
            else
                label.Text = "Unknown Egg"
            end
            wait(10)
        end
    end)
end

-- Scan all models in the workspace for eggs
for _, descendant in ipairs(workspace:GetDescendants()) do
    if descendant:IsA("Model") and descendant.Name:lower():find("egg") then
        local petList = getPetListFromName(descendant.Name)
        if petList then
            addESP(descendant, petList)
        end
    end
end
