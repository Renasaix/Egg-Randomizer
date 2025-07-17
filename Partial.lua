-- Define all egg types and their pets
local eggPets = {
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

-- Detect and apply ESP
local function addESPToEgg(eggModel, petList)
    local part = eggModel:FindFirstChild("Egg Part") or eggModel:FindFirstChildWhichIsA("BasePart")
    if not part or part:FindFirstChild("PetESP") then return end

    local gui = Instance.new("BillboardGui")
    gui.Name = "PetESP"
    gui.Adornee = part
    gui.Size = UDim2.new(0, 200, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = "🎲 Spawning..."
    label.Parent = gui

    -- Countdown + randomizer
    spawn(function()
        local timer = 15
        while gui.Parent do
            if timer <= 0 then
                timer = 15
            end
            local pet = petList[math.random(1, #petList)]
            label.Text = eggModel.Name .. "\n🎲 " .. pet .. " (" .. timer .. "s)"
            wait(1)
            timer -= 1
        end
    end)
end

-- Search through workspace for egg models
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Model") then
        for eggName, pets in pairs(eggPets) do
            if string.find(obj.Name, eggName) then
                addESPToEgg(obj, pets)
                break
            end
        end
    end
end
