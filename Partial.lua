--=== DEBUG EGG ESP ===
local function debug(msg) 
    print("[DEBUG EggESP] " .. tostring(msg)) 
end

-- Locate the correct parent folder
local folder = workspace
    :FindFirstChild("Farm")
    and workspace.Farm:FindFirstChild("Farm")
    and workspace.Farm.Farm:FindFirstChild("Important")
    and workspace.Farm.Farm.Important:FindFirstChild("Objects_Physical")

debug("Eggs root folder: " .. tostring(folder))

if not folder then
    return debug("❌ Could not find the 'Objects_Physical' path.")
end

-- Search for BaseParts named "PetEgg"
for _, obj in ipairs(folder:GetDescendants()) do
    if obj:IsA("BasePart") then
        debug("Found BasePart: " .. obj:GetFullName())
        if obj.Name == "PetEgg" then
            debug("✅ Found PetEgg part at: " .. obj:GetFullName())
            local mdl = obj:FindFirstAncestorOfClass("Model")
            debug("Ancestor model: " .. tostring(mdl and mdl:GetFullName()))

            -- Try building a simple test GUI
            local gui = Instance.new("BillboardGui")
            gui.Adornee = obj
            gui.Size = UDim2.new(0, 100, 0, 30)
            gui.StudsOffset = Vector3.new(0, 3, 0)
            gui.AlwaysOnTop = true
            gui.Parent = obj

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.Text = "⚙️ EGG ESP TEST"
            label.TextColor3 = Color3.new(1,1,1)
            label.TextScaled = true
            label.Parent = gui

            debug("► GUI created on part.")
        end
    end
end

debug("🔚 DEBUG END")
