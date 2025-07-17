local eggs = {
    ["🥚 Common Egg"] = {"Dog", "Bunny", "Golden Lab"}
}

local function createBillboard(name, part)
    local gui = Instance.new("BillboardGui")
    gui.Name = "EggESP"
    gui.Adornee = part
    gui.Size = UDim2.new(0, 200, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0.5
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Text = name

    gui.Parent = part
    return label
end

local function startESP(model, eggName)
    local eggPart = model:FindFirstChild("Egg Part", true)
    if not eggPart then return end

    local label = createBillboard(eggName, eggPart)
    local pets = eggs[eggName]
    if not pets then return end

    coroutine.wrap(function()
        while model.Parent do
            label.Text = eggName .. " | " .. pets[math.random(1, #pets)]
            wait(10)
        end
    end)()
end

-- Scan workspace for eggs
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("Model") and obj.Name == "PetEgg" then
        local tag = obj:FindFirstChild("Rarity") or obj:FindFirstChildWhichIsA("StringValue", true)
        if tag and tag.Value == "🥚 Common Egg" then
            startESP(obj, tag.Value)
        end
    end
end
