-- Egg Pet Randomizer GUI (Final Version with Control Panel)

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
    ["🏜️ Rare Summer Egg"] = {"Sea Turtle", "Toucan", "Flamingo", "Seal", "Orangutan"},
    ["🌴 Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["🌼 Oasis Egg"] = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"},
    ["🐝 Bee Egg"] = {"Bee", "Drone Bee", "Queen Bee"},
    ["🔥 Mythical Summer Egg"] = {"Red Fox", "Golden Deer", "Mimic Octopus"},
    ["🌙 Night Egg"] = {"Bat", "Night Owl", "Moth", "Raccoon"},
    ["🚫🐝 Anti-Bee Egg"] = {"Dust Bee", "Angry Bee", "Robot Bee", "Disco Bee"}
}

local rarePets = {
    ["🦊 Mythical Egg"] = "Red Fox",
    ["🔥 Mythical Summer Egg"] = "Mimic Octopus",
    ["🐛 Bug Egg"] = "Dragonfly",
    ["🌼 Oasis Egg"] = "Fennec Fox",
    ["🐝 Bee Egg"] = "Queen Bee",
    ["🌙 Night Egg"] = "Raccoon",
    ["🚫🐝 Anti-Bee Egg"] = "Disco Bee"
}

local selectedEgg = "🐛 Bug Egg"
local countdown = 5
local autoRandomize = true
local autoStop = false

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "EggPetRandomizer"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 650, 0, 320)
frame.Position = UDim2.new(0.5, -325, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🥚 Egg Pet Randomizer 🐾"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local petDisplay = Instance.new("TextLabel", frame)
petDisplay.Position = UDim2.new(0, 10, 0, 40)
petDisplay.Size = UDim2.new(1, -20, 0, 50)
petDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
petDisplay.Text = "Random Pet: ???"
petDisplay.TextColor3 = Color3.new(1, 1, 1)
petDisplay.Font = Enum.Font.GothamBold
petDisplay.TextScaled = true

-- Control Panel
local controlFrame = Instance.new("Frame", frame)
controlFrame.Position = UDim2.new(1, -180, 0, 10)
controlFrame.Size = UDim2.new(0, 170, 0, 100)
controlFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
controlFrame.BorderSizePixel = 1

local autoStopBtn = Instance.new("TextButton", controlFrame)
autoStopBtn.Size = UDim2.new(1, 0, 0, 30)
autoStopBtn.Position = UDim2.new(0, 0, 0, 0)
autoStopBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
autoStopBtn.TextColor3 = Color3.new(1, 1, 1)
autoStopBtn.Font = Enum.Font.GothamSemibold
autoStopBtn.TextScaled = true
autoStopBtn.Text = "🛑 Auto Stop: " .. (autoStop and "ON" or "OFF")
autoStopBtn.MouseButton1Click:Connect(function()
	autoStop = not autoStop
	autoStopBtn.Text = "🛑 Auto Stop: " .. (autoStop and "ON" or "OFF")
end)

local autoRndBtn = Instance.new("TextButton", controlFrame)
autoRndBtn.Size = UDim2.new(1, 0, 0, 30)
autoRndBtn.Position = UDim2.new(0, 0, 0, 35)
autoRndBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
autoRndBtn.TextColor3 = Color3.new(1, 1, 1)
autoRndBtn.Font = Enum.Font.GothamSemibold
autoRndBtn.TextScaled = true
autoRndBtn.Text = "🟡 Auto\nRandomizer: " .. (autoRandomize and "ON" or "OFF")
autoRndBtn.TextYAlignment = Enum.TextYAlignment.Center
autoRndBtn.MouseButton1Click:Connect(function()
	autoRandomize = not autoRandomize
	autoRndBtn.Text = "🟡 Auto\nRandomizer: " .. (autoRandomize and "ON" or "OFF")
end)

local countdownLabel = Instance.new("TextLabel", controlFrame)
countdownLabel.Size = UDim2.new(1, 0, 0, 30)
countdownLabel.Position = UDim2.new(0, 0, 0, 70)
countdownLabel.BackgroundTransparency = 1
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.Font = Enum.Font.Gotham
countdownLabel.TextScaled = true
countdownLabel.Text = "Changing in: " .. countdown

-- Scrollable Egg Selector
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 100)
scroll.Size = UDim2.new(1, -20, 0, 100)
scroll.CanvasSize = UDim2.new(0, #eggs * 130, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scroll.ScrollingDirection = Enum.ScrollingDirection.X

local x = 0
for eggName, _ in pairs(eggs) do
	local eggBtn = Instance.new("TextButton", scroll)
	eggBtn.Position = UDim2.new(0, x, 0, 0)
	eggBtn.Size = UDim2.new(0, 120, 0, 90)
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

-- Countdown Timer Auto Increase
spawn(function()
	while true do
		wait(1)
		countdown += 1
		countdownLabel.Text = "Changing in: " .. countdown
	end
end)

-- Randomizer Loop
spawn(function()
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
end)
