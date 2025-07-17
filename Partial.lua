local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Eggs and pets
local eggs = {
    ["🥚 Common Egg"] = {"Dog", "Bunny", "Golden Lab"},
    ["🥕 Uncommon Egg"] = {"Black Bunny", "Chicken", "Cat", "Deer"},
    ["💎 Rare Egg"] = {"Orange Tabby", "Spotted Deer", "Pig", "Monkey"},
    ["🌟 Legendary Egg"] = {"Cow", "Sea Otter", "Turtle", "Polar Bear"},
    ["🐛 Bug Egg"] = {"Snail", "Giant Ant", "Caterpillar", "Dragonfly"},
    ["🦊 Mythical Egg"] = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
    ["☀️ Common Summer Egg"] = {"Starfish", "Seagull", "Crab"},
    ["🏝️ Rare Summer Egg"] = {"Sea Turtle", "Toucan", "Flamingo", "Seal", "Orangutan"},
    ["🌴 Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["🏜️ Oasis Egg"] = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"},
    ["🐝 Bee Egg"] = {"Bee", "Drone Bee", "Queen Bee"},
    ["🔥 Mythical Summer Egg"] = {"Red Fox", "Golden Deer", "Mimic Octopus"},
    ["🌙 Night Egg"] = {"Bat", "Night Owl", "Moth", "Raccoon"},
    ["🚫🐝 Anti-Bee Egg"] = {"Dust Bee", "Angry Bee", "Robot Bee", "Disco Bee"}
}

-- Rare pet requirements
local rarePets = {
    ["🦊 Mythical Egg"] = "Red Fox",
    ["🔥 Mythical Summer Egg"] = "Mimic Octopus",
    ["🐛 Bug Egg"] = "Dragonfly",
    ["🏜️ Oasis Egg"] = "Fennec Fox",
    ["🐝 Bee Egg"] = "Queen Bee",
    ["🌙 Night Egg"] = "Raccoon",
    ["🚫🐝 Anti-Bee Egg"] = "Disco Bee"
}

local selectedEgg = "🐛 Bug Egg"
local countdown = 5
local autoRandomize = true
local autoStop = false

-- GUI setup
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "EggPetRandomizer"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 650, 0, 300)
frame.Position = UDim2.new(0.5, -325, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🥚 Egg Pet Randomizer 🐾"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Pet output
local petDisplay = Instance.new("TextLabel", frame)
petDisplay.Position = UDim2.new(0, 10, 0, 40)
petDisplay.Size = UDim2.new(1, -20, 0, 50)
petDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
petDisplay.Text = "Random Pet: ???"
petDisplay.TextColor3 = Color3.new(1, 1, 1)
petDisplay.Font = Enum.Font.GothamBold
petDisplay.TextScaled = true

-- Timer label
local timerLabel = Instance.new("TextLabel", frame)
timerLabel.Position = UDim2.new(0, 10, 0, 100)
timerLabel.Size = UDim2.new(0.45, -10, 0, 30)
timerLabel.Text = "Timer: " .. countdown .. "s"
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.BackgroundTransparency = 1
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextScaled = true

-- Increase timer button
local timerBtn = Instance.new("TextButton", frame)
timerBtn.Position = UDim2.new(0.5, 0, 0, 100)
timerBtn.Size = UDim2.new(0.5, -10, 0, 30)
timerBtn.Text = "⏫ Increase Timer"
timerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
timerBtn.TextColor3 = Color3.new(1, 1, 1)
timerBtn.Font = Enum.Font.Gotham
timerBtn.TextScaled = true
timerBtn.MouseButton1Click:Connect(function()
	countdown += 1
	timerLabel.Text = "Timer: " .. countdown .. "s"
end)

-- Auto toggle
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Position = UDim2.new(0, 10, 0, 140)
autoBtn.Size = UDim2.new(0.3, -10, 0, 30)
autoBtn.Text = "Auto: ON"
autoBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.MouseButton1Click:Connect(function()
	autoRandomize = not autoRandomize
	autoBtn.Text = "Auto: " .. (autoRandomize and "ON" or "OFF")
end)

-- Auto Stop toggle
local stopBtn = Instance.new("TextButton", frame)
stopBtn.Position = UDim2.new(0.35, 0, 0, 140)
stopBtn.Size = UDim2.new(0.3, -10, 0, 30)
stopBtn.Text = "Auto Stop: OFF"
stopBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.Gotham
stopBtn.TextScaled = true
stopBtn.MouseButton1Click:Connect(function()
	autoStop = not autoStop
	stopBtn.Text = "Auto Stop: " .. (autoStop and "ON" or "OFF")
end)

-- Scrollable egg selector
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 180)
scroll.Size = UDim2.new(1, -20, 0, 110)
scroll.CanvasSize = UDim2.new(0, #eggs * 130, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scroll.ScrollingDirection = Enum.ScrollingDirection.X

local x = 0
for eggName, _ in pairs(eggs) do
	local eggBtn = Instance.new("TextButton", scroll)
	eggBtn.Position = UDim2.new(0, x, 0, 0)
	eggBtn.Size = UDim2.new(0, 120, 0, 100)
	eggBtn.Text = eggName
	eggBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	eggBtn.TextColor3 = Color3.new(1, 1, 1)
	eggBtn.Font = Enum.Font.Gotham
	eggBtn.TextScaled = true
	eggBtn.MouseButton1Click:Connect(function()
		selectedEgg = eggName
	end)
	x += 130
end

-- Timer auto increase
task.spawn(function()
	while true do
		wait(1)
		countdown += 1
		timerLabel.Text = "Timer: " .. countdown .. "s"
	end
end)

-- Pet randomization loop
task.spawn(function()
	while true do
		if autoRandomize then
			local pets = eggs[selectedEgg] or {}
			local chosen = "???"
			local isRare = false

			if rarePets[selectedEgg] and countdown >= 10 then
				chosen = rarePets[selectedEgg]
				isRare = true
			elseif #pets > 0 then
				chosen = pets[math.random(1, #pets)]
			end

			petDisplay.Text = "Random Pet: " .. chosen
			petDisplay.TextColor3 = isRare and Color3.fromRGB(255, 215, 0) or Color3.new(1, 1, 1)

			if autoStop then autoRandomize = false end
		end
		wait(countdown)
	end
end
