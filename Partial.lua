local eggs = {
    ["🥚 Common Egg"] = {"Dog", "Bunny", "Golden Lab"}
}

-- Function to add BillboardGui above the egg
local function addESP(eggModel, petList)
    if not eggModel or not petList then return end

    local basePart = eggModel:FindFirstChildWhichIsA("BasePart", true)
    if not basePart then return end
    if basePart:FindFirstChild("PetESP") then return end

    local gui = Instance.new("BillboardGui")
    gui.Name = "PetESP"
    gui.Adornee = basePart
    gui.Size = UDim2.new(0, 200, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.Parent = basePart

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = "..."
    label.Parent = gui

    spawn(function()
        while gui.Parent do
            local pet = petList[math.random(1, #petList)]
            label.Text = "🎲 " .. pet
            wait(10)
        end
    end)
end

-- Detect Common Egg models in workspace
for _, model in ipairs(workspace:GetDescendants()) do
    if model:IsA("Model") and model.Name:lower():find("common egg") then
        print("✅ Found egg:", model.Name)
        addESP(model, eggs["🥚 Common Egg"])
    end
end
