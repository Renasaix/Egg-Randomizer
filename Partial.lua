-- Egg ESP Script for Grow a Garden
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

local eggFolder = workspace:FindFirstChild("Farm")
if eggFolder then
    eggFolder = eggFolder:FindFirstChild("Farm")
        and eggFolder.Farm:FindFirstChild("Important")
        and eggFolder.Farm.Important:FindFirstChild("Objects_Physical")
else
    warn("❌ Could not find the egg folder path.")
    return
end

for _, model in pairs(eggFolder:GetDescendants()) do
    if model:IsA("Model") and model:FindFirstChild("PetEgg") then
        local eggPart = model:FindFirstChild("PetEgg")
        if eggPart and eggPart:IsA("BasePart") then
            local eggName = model.Name
            for fullName, pets in pairs(eggs) do
                if eggName:lower():find(fullName:match("Egg") and "egg") then
                    local randomPet = pets[math.random(1, #pets)]

                    -- Billboard UI
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0, 200, 0, 60)
                    billboard.AlwaysOnTop = true
                    billboard.Adornee = eggPart
                    billboard.Name = "EggESP"
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.Parent = eggPart

                    -- Text Label
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.TextStrokeTransparency = 0.5
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.Text = fullName .. "\n🔄 " .. randomPet
                    label.Parent = billboard

                    -- Timer to reroll every 10s, reset every 15s
                    task.spawn(function()
                        local countdown = 15
                        while true do
                            if countdown <= 0 then
                                countdown = 15
                                randomPet = pets[math.random(1, #pets)]
                                label.Text = fullName .. "\n🔄 " .. randomPet
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
