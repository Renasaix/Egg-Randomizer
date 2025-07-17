-- Egg data (with emojis)
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
    ["🐝 Bee Egg"] = {"Bee", "Honey Bee", "Bear Bee", "Petal Bee", "Queen Bee"},
    ["🌙 Night Egg"] = {"Hedgehog", "Frog", "Echo Frog", "Night Owl", "Raccoon"},
    ["🚫🐝 Anti-Bee Egg"] = {"Wasp", "Tarantula Hawk", "Moth", "Butterfly", "Disco Bee"},
    ["🦖 Dinosaur Egg"] = {"Raptor", "Triceratops", "Stegosaurus", "Pterodactyl", "Brontosaurus", "T-Rex"},
    ["🧬 Primal Egg"] = {"Parasaurolophus", "Iguanodon", "Pachycephalosaurus", "Dilophosaurus", "Ankylosaurus", "Spinosaurus"}
}

-- Attach ESP label to eggs
local function addEggESP(model, displayName, petList)
    local part = model:FindFirstChild("Egg Part") or model:FindFirstChildWhichIsA("BasePart")
    if not part then return end

    if part:FindFirstChild("PetESP") then return end -- already added

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
    label.TextStrokeTransparency = 0.3
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = "🎲 Loading..."
    label.Parent = gui

    -- Timer and pet randomizer
    spawn(function()
        local timer = 15
        while gui.Parent and model.Parent do
            if timer <= 0 then
                timer = 15
            end
            local pet = petList[math.random(1, #petList)]
            label.Text = displayName .. "\n🎲 " .. pet .. " (" .. timer .. "s)"
            wait(1)
            timer -= 1
        end
    end)
end

-- Scan all eggs in workspace
for _, model in ipairs(workspace:GetDescendants()) do
    if model:IsA("Model") and model.Name:match("Egg") then
        for eggName, pets in pairs(eggs) do
            if model.Name:lower():match(eggName:match("[%w%s]+"):lower()) then
                addEggESP(model, eggName, pets)
                break
            end
        end
    end
end
