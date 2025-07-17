-- Egg ESP Script (Updated for actual PetEgg structure)
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

-- Get all PetEgg BaseParts inside game
local eggFolder = workspace:FindFirstChild("Farm")
if eggFolder and eggFolder:FindFirstChild("Farm") and eggFolder.Farm:FindFirstChild("Important") then
    eggFolder = eggFolder.Farm.Important:FindFirstChild("Objects_Physical")
else
    warn("❌ Could not find proper egg folder path.")
    return
end

for _, obj in pairs(eggFolder:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Name == "PetEgg" then
        local model = obj:FindFirstAncestorOfClass("Model")
        if model then
            local matchedName = nil
            for eggName, pets in pairs(eggs) do
                local cleanName = eggName:lower():gsub("🥚", ""):gsub("[^%w%s]", ""):gsub("egg", ""):gsub("%s+", "") -- remove emojis and spaces
                local modelName = model.Name:lower():gsub("egg", ""):gsub("%s+", "")
                if modelName:find(cleanName) then
                    matchedName = eggName
                    local petList = pets
                    local petName = petList[math.random(1, #petList)]

                    -- Create GUI
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "EggESP"
                    billboard.Adornee = obj
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = obj

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextScaled = true
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextStrokeTransparency = 0.5
                    textLabel.Font = Enum.Font.GothamBold
                    textLabel.Text = matchedName .. "\n🔄 " .. petName
                    textLabel.Parent = billboard

                    -- Timer to reroll pet every 10s, reset every 15s
                    task.spawn(function()
                        local countdown = 15
                        while true do
                            if countdown <= 0 then
                                countdown = 15
                                petName = petList[math.random(1, #petList)]
                                textLabel.Text = matchedName .. "\n🔄 " .. petName
                            end
                            countdown -= 1
                            wait(1)
                        end
                    end)
                end
            end
        end
    end
end
