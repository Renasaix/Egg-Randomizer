local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Full Egg List with Pets
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

-- Rare Pets Unlockable After Timer ≥ 10s
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

-- GUI Setup
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "EggPetRandomizer"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 250)
frame.Position = UDim2.new(0.5, -300, 0.5, -125)
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

local timerLabel = Instance.new("TextLabel", frame)
timerLabel.Position = UDim2.new(0, 10, 0, 100)
timerLabel.Size = UDim2.new(0.5, -20, 0, 30)
timerLabel.Text = "Timer: " .. countdown .. "s"
timerLabel.BackgroundTransparency = 1
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextScaled = true

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

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 140)
scroll.Size = UDim2.new(1, -20, 0, 100)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scroll.CanvasSize = UDim2.new(0, #eggs * 130, 0, 0)
scroll.ScrollBarThickness = 6
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
	x = x + 130
end

-- Pet Randomization Loop
task.spawn(function()
	while true do
		if autoRandomize then
			local pets = eggs[selectedEgg] or {}
			local picked = "???"
			local isRare = false

			if rarePets[selectedEgg] and countdown >= 10 then
				picked = rarePets[selectedEgg]
				isRare = true
			elseif #pets > 0 then
				picked = pets[math.random(1, #pets)]
			end

			petDisplay.Text = "Random Pet: " .. picked
			petDisplay.TextColor3 = isRare and Color3.fromRGB(255, 215, 0) or Color3.new(1, 1, 1)

			if autoStop then autoRandomize = false end
		end
		wait(countdown)
	end
end)
