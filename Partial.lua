for _, egg in pairs(workspace:GetDescendants()) do
	if egg:IsA("Model") and egg.Name == "PetEgg" then
		local part = egg:FindFirstChildWhichIsA("BasePart", true)
		if part then
			local gui = Instance.new("BillboardGui")
			gui.Size = UDim2.new(0, 200, 0, 50)
			gui.StudsOffset = Vector3.new(0, 3, 0)
			gui.AlwaysOnTop = true
			gui.Adornee = part

			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.Text = "ESP TEST"
			textLabel.BackgroundTransparency = 1
			textLabel.TextColor3 = Color3.new(1, 1, 1)
			textLabel.TextScaled = true
			textLabel.Parent = gui

			gui.Parent = part
		end
	end
end
