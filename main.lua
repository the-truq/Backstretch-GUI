--lib
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local colors = {
	Background = Color3.fromRGB(20, 20, 20),
	Header = Color3.fromRGB(20, 20, 20),
	TextColor = Color3.fromRGB(255,255,255),
	ElementColor = Color3.fromRGB(20, 20, 20),
	SchemeColor = Color3.fromRGB(50,50,200)
}

--vars
local toggleState = false
local SelectedCar = 1
local tMusic = false
local MusicIDnumber = 0

--functions
local function SpawnCar(SelectedCar)
	SelectedCar = SelectedCar
	local args = {
		[1] = SelectedCar,
		print("Function Ran")
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Car"):WaitForChild("CarFunc"):InvokeServer(unpack(args))
end

local function ToggleUnderGlow(toggleState)
	local args = {
		[1] = "Underglow",
		[2] = toggleState
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Car"):WaitForChild("Customize"):FireServer(unpack(args))
end

local function SetUnderGlow(UnderglowColor)
	local args = {
		[1] = "UnderglowColor",
		[2] = UnderglowColor
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Car"):WaitForChild("Customize"):FireServer(unpack(args))
end

local function SetRimsColor(RimsColor)
	local args = {
		[1] = "RimsColor",
		[2] = RimsColor
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Car"):WaitForChild("Customize"):FireServer(unpack(args))
end

local function RunMusic(tMusic, MusicIDnumber)
	local args = {
		[1] = tMusic,
		[2] = MusicIDnumber
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Car"):WaitForChild("Music"):InvokeServer(unpack(args))
end

--Window
local Window = Library.CreateLib("BackstretchGUI v0.2", colors)


--Tabs
local CarSpawnTab = Window:NewTab("Car Spawn")
local CustomizeTab = Window:NewTab("Customize")
local MusicTab = Window:NewTab("Music")
local CreditsTab = Window:NewTab("Credits")

--Sections
local CarSpawner = CarSpawnTab:NewSection("Car Spawner")
local CarDropDown = CarSpawnTab:NewSection("Car Drop Down Menu")
local Underglow = CustomizeTab:NewSection("Underglow Settings")
local RimColor = CustomizeTab:NewSection("Rim Color Settings")
local Music = MusicTab:NewSection("Music Settings")
local Credits = CreditsTab:NewSection("Credits")
local CustomTheme = CreditsTab:NewSection("Theme Customizer")

--Toggles
Underglow:NewToggle("Underglow Toggle", "Enable/Disable underglow", function(state)
	if state then
		toggleState = true
		ToggleUnderGlow(toggleState)
		print("Underglow On!")
	else
		toggleState = false
		ToggleUnderGlow(toggleState)
		print("Underglow Off!")
	end
end)

Music:NewToggle("Music Toggle", "Enable/Disable music", function(state1)
	if state1 then
		tMusic = true
		print("Music Playing!")
		RunMusic(tMusic, MusicIDnumber)
	else
		tMusic = false
		print("Music Paused!")
	end
end)

--TextBoxes
CarSpawner:NewTextBox("Car Selector", "Input your desired car ID", function(SelectedCar)
	local SelectedCarString = SelectedCar
	local SelectedCarNumber = tonumber(SelectedCarString) 
	print(SelectedCarNumber)
	SpawnCar(SelectedCarNumber)
end)
Music:NewTextBox("Music ID Input", "Input your desired music ID", function(MusicID)
	MusicID = MusicID
	local MusicIDString = MusicID
	local MusicIDnumber = tonumber(MusicIDString) 
	print(MusicIDnumber)
	RunMusic(tMusic, MusicIDnumber)
end)

--Buttons



--Color Pickers
Underglow:NewColorPicker("Underglow Color", "Select the color of your underglow", Color3.fromRGB(255,255,255), function(UnderglowColor)
	SetUnderGlow(UnderglowColor)
	wait(.001)
	print(UnderglowColor)
end)

RimColor:NewColorPicker("Rims Color", "Select the color of your rims", Color3.fromRGB(0,0,0), function(RimsColor)
	SetRimsColor(RimsColor)
	wait(.001)
	print(RimsColor)
end)

--Custom Theme
for theme, color in pairs(colors) do
	CustomTheme:NewColorPicker(theme, "Change your "..theme, color, function(color3)
		Library:ChangeColor(theme, color3)
	end)
end
