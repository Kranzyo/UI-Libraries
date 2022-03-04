--Game:

-- docs : https://detourious.gitbook.io/project-finity/docs
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character
local hum = char.Humanoid
local root = char:FindFirstChild("HumanoidRootPart")
 
local desc = [[
    **USE AT YOUR OWN RISK**
]]
local EnumKeys = {'Semicolon','Tab','Equals','Comma','Minus','Period','F1',"F2","F3","F4",'F5',"F6","F7",
    "F8","F9","F10","F11","F12",'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H',
    'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M','Slash','One','Two','Three',"Four","Five","Six","Seven","Eight",
    "Nine","Zero",'BackSlash','RightBracket','LeftBracket'}

-- // anti afk
for i,v in pairs(getconnections(lp.Idled)) do
	v:Disable()
end

if game:GetService("CoreGui"):FindFirstChild("FinityUI") then
    game.CoreGui.FinityUI:Destroy()
end
--[[ Back up : 
https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Finity%20Ui
https://raw.githubusercontent.com/bloodball/UI-Librarys/main/Finity%20UI%20Lib
]]
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Finity%20Ui.lua"))()
local FinityWindow = Finity.new(true, "Setup") -- name of thing
FinityWindow.ChangeToggleKey(Enum.KeyCode.BackSlash)

-- // Credits and stuff
local CreditsCategory = FinityWindow:Category("Credits and stuff")
local uiCreator = CreditsCategory:Sector("Ui Creator:")
local scriptCreator = CreditsCategory:Sector("Script Creator:")
local description = CreditsCategory:Sector("Description:")

-- // Text for credits
uiCreator:Cheat("Label", "Detourious @ v3rmillion.net") 
scriptCreator:Cheat("Label", "KayD @ v3rmillion.net")
description:Cheat("Label", desc)

-- // Main stuff
-- // speed/ jump
local misc = FinityWindow:Category("Misc")
local speed_Jump = misc:Sector("Speed/Jump")

-- // Cheat for jump and speed
speed_Jump:Cheat("Slider", "Speed", function(v)
    getgenv().Speed = v
end, {min = 16, max = 250, suffix = " Speed"})

speed_Jump:Cheat("Slider", "Jump", function(v)
    getgenv().Jump = v
end, {min = 50, max = 250, suffix = " JumpPower"})

speed_Jump:Cheat("Checkbox", "Activate Speed/Jump", function(state) 
    while state do
       task.wait()
        hum.WalkSpeed = Speed
        hum.JumpPower = Jump
    end
end)

-- // OR
--[[
    speed_Jump:Cheat("Button", "Activate Speed/Jump", function(v) 
    hum.WalkSpeed = Speed
    hum.JumpPower = Jump
end)
]]--

-- // Settings
local Settings = FinityWindow:Category("Settings")
local generalSettings = Settings:Sector("General")

generalSettings:Cheat("Dropdown", "Change Toggle Key", 
function(Option)
    FinityWindow.ChangeToggleKey(Enum.KeyCode[Option])
end,
{
options = EnumKeys
})

generalSettings:Cheat("Button", "Delete GUI", function() --Button
    game:GetService("CoreGui").FinityUI:Destroy()
    end)

--Examples

--[[
    S1:Cheat("Slider", "Render Distance", function(v) --Slider
    print("Silder value changed:", v)
    end, {min = 0, max = 1500, suffix = " studs"})
    
    
    S1:Cheat("Dropdown", "ESP Color", function(Option) --Dropdowns
    print("Dropdown option changed:", Option)
    end, {
    options = {
    "Red",
    "White",
    "Green",
    "Pink",
    "Blue"
    }
    })
    

    S1:Cheat("Textbox", "Item To Whitelist", function(v) --Textbox
    print("Textbox value changed:", v)
    end, {
    placeholder = "Item Name"
    })
    
    S1:Cheat("Button", "Reset Whitelist", function() --Button
    print("Button pressed")
    end)
    
    Check box code :
    S1:Cheat("Checkbox","Name",
    function(State)
        if not State then
            _G.on = 0
        else
            _G.on = 1
        end
        while _G.on == 1 do
            game:GetService('RunService').Stepped:wait()
        end
    end)
    
    -- Default color
Sector:Cheat("ColorPicker", "Color", function(Color) -- Color picker
  print("Color changed: " .. "R:" .. tostring(Color.R) .. "; G:" .. tostring(Color.G) .. "; B:" .. tostring(Color.B))
end, {
  color = Color3.new(0, 1, 0) -- Bright green
})

Keybind cheat type
Cheat menus are now scrollable when they are too big
New dropdown methods to allow for more dynamic options
    ^ Dropdown:AddOption(String ValueToAdd)
    ^ Dropdown:RemoveOption(String ValueToRemove)
    ^ Dropdown:SetValue(String Value) <-- Value doesn't have to exist as an option
Customizable background image
    ^ Window:ChangeBackgroundImage(String AssetURL [, Number Transparency])
New constructor parameters
    ^ Finity.new([Boolean IsDarkMode, String ProjectName, Boolean SingleColumn])
        ^ Setting the ProjectName will change the text at the top of the window
        ^ Setting the SingleColumn boolean to a UDim2 value allows for a custom window size

Bind pseudo-code:
-- No default bind
Sector:Cheat("Keybind", "Label Text", function(KeyCode)
    print("Keybind pressed: " .. KeyCode.Name)
end)

- With default bind
Sector:Cheat("Keybind", "Label Text", function(KeyCode)
    print("Keybind pressed: " .. KeyCode.Name)
end, {
    bind = DefaultBind -- KeyCode, ex: "Enum.KeyCode.LeftShift"
})

Color-picker pseudo-code:
-- No default color
Sector:Cheat("ColorPicker", "Color", function(Color)
  print("Color changed: " .. "R:" .. tostring(Color.R) .. "; G:" .. tostring(Color.G) .. "; B:" .. tostring(Color.B))
end)


-

]]
    