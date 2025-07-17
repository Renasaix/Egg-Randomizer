-- Mock data for testing
local eggs = {
    ["🥚 Common Egg"] = {"Dog", "Bunny", "Golden Lab"}
}

-- Create mock egg model in workspace
local function createEggMock(name, pos)
    local model = Instance.new("Model")
    model.Name = name

    local part = Instance.new("Part")
    part.Name = "Egg Part"
    part.Size = Vector3.new(2, 2, 2)
    part.Position = pos
    part.Anchored = true
    part.CanCollide = false
    part.BrickColor = BrickColor.Random()
    part.Parent = model

    model.PrimaryPart = part
    model.Parent = workspace

    return model
end

-- Add BillboardGui to egg
local function addVisualESP(model, petList)
    local gui = Instance.new("BillboardGui")
    gui.Name = "PetESP"
    gui.Adornee = model.PrimaryPart
    gui.Size = UDim2.new(0, 200, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.Parent = model.PrimaryPart

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
            label.Text = model.Name .. "\n🎲 " .. pet .. " (" .. timer .. "s)"
            wait(1)
            timer -= 1
        end
    end)
end

-- Spawn fake eggs for demo
local pos = Vector3.new(0, 5, 0)
for eggName, pets in pairs(eggs) do
    local mockEgg = createEggMock(eggName, pos)
    addVisualESP(mockEgg, pets)
    pos += Vector3.new(5, 0, 0)
end
