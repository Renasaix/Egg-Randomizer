-- List of eggs with sample pets
local eggPets = {
    ["🥚 Common Egg"] = {"Dog", "Bunny", "Golden Lab"},
}

-- Function to pick random pet name every 10s
local function startESP(eggModel, petNames)
    local eggPart = eggModel:FindFirstChild("Egg Part", true)
    if not eggPart then 
        warn("❌ No 'Egg Part' found in: " .. eggModel:GetFullName()) 
        return 
    end

    -- Create Billboard GUI
    local gui = Instance.new("BillboardGui")
    gui.Name = "EggESP"
    gui.Adornee = eggPart
    gui.Size = UDim2.new(0, 200, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.Parent = eggPart

    -- Create text label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Text = "🥚 " .. eggModel.Name
    label.Parent = gui

    -- Randomize pet name every 10s and reset timer at 15s
    local counter = 0
    task.spawn(function()
        while gui.Parent do
            wait(1)
            counter += 1
            if counter % 10 == 0 then
                local pet = petNames[math.random(1, #petNames)]
                label.Text = "🥚 " .. pet
            end
            if counter >= 15 then
                counter = 0
            end
        end
    end)
end

-- Detect eggs inside workspace.eggs
local eggFolder = workspace:FindFirstChild("eggs")
if not eggFolder then
    warn("❌ workspace.eggs not found.")
else
    for _, model in pairs(eggFolder:GetChildren()) do
        if model:IsA("Model") then
            for eggName, pets in pairs(eggPets) do
                if string.match(model.Name, "Common Egg") then
                    print("✅ Attaching ESP to: " .. model.Name)
                    startESP(model, pets)
                end
            end
        end
    end
end
