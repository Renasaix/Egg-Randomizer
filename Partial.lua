-- Eggs and pets (sample, you can expand later)
local eggPets = {
    ["Common Egg"] = {"Dog", "Bunny", "Golden Lab"},
}

-- Create floating label (ESP) above Egg Part
local function attachESP(model, petList)
    local eggPart = model:FindFirstChild("Egg Part", true)
    if not eggPart then return end

    local gui = Instance.new("BillboardGui")
    gui.Adornee = eggPart
    gui.Size = UDim2.new(0, 200, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.Name = "EggESP"
    gui.Parent = eggPart

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = "🥚 Scanning..."
    label.Parent = gui

    -- Randomize every 10 seconds, reset at 15
    local counter = 0
    task.spawn(function()
        while gui.Parent do
            wait(1)
            counter += 1
            if counter % 10 == 0 then
                local pet = petList[math.random(1, #petList)]
                label.Text = "🥚 " .. pet
            end
            if counter >= 15 then
                counter = 0
            end
        end
    end)
end

-- Scan entire workspace for models with "Egg Part"
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("Model") and obj:FindFirstChild("Egg Part", true) then
        for key, petList in pairs(eggPets) do
            if string.find(obj.Name, key) then
                print("✅ Found egg:", obj.Name)
                attachESP(obj, petList)
                break
            end
        end
    end
end
