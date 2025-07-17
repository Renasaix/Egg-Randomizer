for _, egg in ipairs(workspace:GetDescendants()) do
    if egg:IsA("Model") and egg.Name == "Common Egg" then
        local part = egg:FindFirstChild("Egg Part")
        if part and not part:FindFirstChild("PetESP") then
            local label = Instance.new("BillboardGui", part)
            label.Name = "PetESP"
            label.Size = UDim2.new(0, 200, 0, 50)
            label.StudsOffset = Vector3.new(0, 3, 0)
            label.AlwaysOnTop = true

            local text = Instance.new("TextLabel", label)
            text.Size = UDim2.new(1, 0, 1, 0)
            text.TextScaled = true
            text.BackgroundTransparency = 1
            text.TextColor3 = Color3.fromRGB(255, 255, 255)
            text.Font = Enum.Font.GothamBold

            local pets = {"Dog", "Bunny", "Golden Lab"}
            coroutine.wrap(function()
                while true do
                    text.Text = "🥚 Common Egg: " .. pets[math.random(1, #pets)]
                    wait(10)
                end
            end)()
        end
    end
end
