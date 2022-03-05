--[[
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/BracketRewrite/main/Library.lua"))()
-- or
local Library = loadstring(game:GetObjects("rbxassetid://7974127463")[1].Source)()
]]

repeat task.wait() until game.IsLoaded
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/TypeWriter.lua"))()
if getgenv().hackExecuted then NotifyLib:TypeWrite("<font size=\"30\"><font color=\"rgb(63,126,252)\"><b>ⓘ</b></font></font> Script already executed!",1,0) return end
getgenv().hackExecuted = true

-- dependencies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- creds AlexR32#0157 for modules
local ConfigSystem = Debug and loadfile("Modules/ConfigSystem.lua")() or loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/ConfigSystem.lua"))()

-- edit stuff below please don't forget
local function SaveConfig() 
    if isfile("script config") then
        ConfigSystem.WriteJSON(Config, "Kranz's Scripts/script config.JSON") -- PLEASE FUTURE ME EDIT THIS
    else
        makefolder("Kranz's Scripts")
        ConfigSystem.WriteJSON(Config, "Kranz's Scripts/script config.JSON") -- PLEASE FUTURE ME EDIT THIS
    end
end

local function LoadConfig()
    if isfile("script config") then
        getgenv().Config = ConfigSystem.ReadJSON("Kranz's Scripts/script config.JSON", Config)
    else
        makefolder("Kranz's Scripts")
        ConfigSystem.WriteJSON(Config, "Kranz's Scripts/script config.JSON") -- PLEASE FUTURE ME EDIT THIS
    end
end

getgenv().Config = {
    UI = {
        Name = "Game",
        Enabled = true,
        Keybind = "RightShift",
        Color = Color3.fromRGB(255,128,64),
        Background = "Floral",
        BackgroundId = "rbxassetid://5553946656",
        BackgroundColor = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0
    },


}
LoadConfig()

-- ui lib
local Library = loadstring(game:GetObjects("rbxassetid://7974127463")[1].Source)()
local Window = Library({Name = Config.UI.Name,Enaled = Config.UI.Enabled, Color = Config.UI.color,Position = UDim2.new(0.5,-248,0.5,-248)}) do
    local MainTab = Window:AddTab({Name = "Main"}) do
        -- Scripts and stuff

    end
    local SettingsTab = Window:AddTab({Name = "Settings"}) do
        local MainSection = SettingsTab:AddSection({Name = "Main Section", Side = "Left"}) do
            MainSection:AddToggle({Name = "Enabled", value = Window.Enabled, Callback = function(State) 
                Window:Toggle(State)
            end}):AddBind({Key = Config.UI.Keybind,Callback = function(Bool, Key)
                Config.UI.Keybind = Key or "NONE"
            end, Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"}})

            MainSection:AddColorpicker({Name = "Color", Color = Window.Color, Callback = function(Color) 
                Config.UI.Color = Color
                Window:ChangeColor(Color)
            end})
        end

        SettingsTab:AddButton({Name = "Server Hop",Side = "Left",Callback = function()
            -- Credits to Infinite Yield for serverhop
            local x = {}
            for _, v in ipairs(HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
                if type(v) == "table" and v.id ~= game.JobId then
                    x[#x + 1] = v.id
                end
            end
            if #x > 0 then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
            else
                NotifyLib:TypeWrite("<font size=\"30\"><font color=\"rgb(252,126,63)\"><b>⚠</b></font></font> couldn't find a server",15,0)
            end
        end})

        local BackgroundSection = SettingsTab:AddSection({Name = "Background",Side = "Right"}) do
            BackgroundSection:AddDropdown({Name = "Image",Default = Config.UI.Background,
            List = {"Legacy","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"},
            Callback = function(String)
                -- Credits to Jan for cool patterns 
                Config.UI.Background = String
                if String == "Legacy" then
                    Window.Background.Image = "rbxassetid://2151741365"
                    Config.UI.BackgroundId = "rbxassetid://2151741365"
                elseif String == "Hearts" then
                    Window.Background.Image = "rbxassetid://6073763717"
                    Config.UI.BackgroundId = "rbxassetid://6073763717"
                elseif String == "Abstract" then
                    Window.Background.Image = "rbxassetid://6073743871"
                    Config.UI.BackgroundId = "rbxassetid://6073743871"
                elseif String == "Hexagon" then
                    Window.Background.Image = "rbxassetid://6073628839"
                    Config.UI.BackgroundId = "rbxassetid://6073628839"
                elseif String == "Circles" then
                    Window.Background.Image = "rbxassetid://6071579801"
                    Config.UI.BackgroundId = "rbxassetid://6071579801"
                elseif String == "Lace With Flowers" then
                    Window.Background.Image = "rbxassetid://6071575925"
                    Config.UI.BackgroundId = "rbxassetid://6071575925"
                elseif String == "Floral" then
                    Window.Background.Image = "rbxassetid://5553946656"
                    Config.UI.BackgroundId = "rbxassetid://5553946656"
                end
            end})
            BackgroundSection:AddTextbox({Name = "Custom Image",Text = "",Placeholder = "rbxassetid://ImageId",Callback = function(String)
                Window.Background.Image = String
                Config.UI.BackgroundId = String
            end})
            Window.Background.Image = Config.UI.BackgroundId
            Window.Background.ImageColor3 = Config.UI.BackgroundColor
            BackgroundSection:AddColorpicker({Name = "Color",Color = Window.Background.ImageColor3,Callback = function(Color)
                Config.UI.BackgroundColor = Color
                Window.Background.ImageColor3 = Color
            end})
            Window.Background.ImageTransparency = Config.UI.BackgroundTransparency
            BackgroundSection:AddSlider({Name = "Transparency",Min = 0,Max = 1,Precise = 2,Value = Window.Background.ImageTransparency,Callback = function(Number)
                Config.UI.BackgroundTransparency = Number
                Window.Background.ImageTransparency = Number
            end})
            BackgroundSection:AddSlider({Name = "Tile Offset",Min = 74, Max = 296,Value = Window.Background.TileSize.X.Offset,Callback = function(Number)
                Window.Background.TileSize = UDim2.new(0,Number,0,Number)
            end})
            BackgroundSection:AddSlider({Name = "Tile Scale",Min = 0, Max = 1,Precise = 2,Value = Window.Background.TileSize.X.Scale,Callback = function(Number)
                Window.Background.TileSize = UDim2.new(Number,0,Number,0)
            end})
        end

        local CreditsSection = SettingsTab:AddSection({"Credits Section", Side = "Right"}) do
            CreditsSection:AddLabel({Text = "Thanks infinite yield for server hop"})
            CreditsSection:AddLabel({Text = "Thanks to Jan For This Awesome Patterns"})
            CreditsSection:AddLabel({Text = "Thanks to el3tric for Bracket V2 (Remade to Bracket V3.1) by AlexR32#0157"})
            CreditsSection:AddLabel({Text = "Thanks AlexR32#0157 for config and notify system and custom image background script"})
            CreditsSection:AddLabel({Text = "And Kranz#0737 For Making This Awesome Script!"})
        end
    end

end

-- Config saving
PlayerService.PlayerRemoving:Connect(function(Player)
    if Player == LocalPlayer then SaveConfig() end
end)

--[[
local Library = loadstring(game:GetObjects("rbxassetid://7974127463")[1].Source)()
local Window = Library({Name = "Window",Color = Color3.new(1,0.5,0.25),Size = UDim2.new(0,496,0,496),Position = UDim2.new(0.5,-248,0.5,-248)}) do
    --Window:ChangeName("Window")
    --Window:ChangeSize(UDim2.new(0,496,0,496))
    --Window:ChangePosition(UDim2.new(0.5,-248,0.5,-248))
    --Window:ChangeColor(Color3.new(1,0.5,0.25))
    --Window:Toggle(true)
    --Window.Background -- ImageLabel
    local Tab = Window:AddTab({Name = "Tab"}) do
        --Tab:ChangeName("Tab")

        --Side might be "Left", "Right" or nil for auto side choose
        --if callback nil then it will be replaced with print function
        Tab:AddDivider({Text = "Divider",Side = "Left"})

        local Label = Tab:AddLabel({Text = "Label",Side = "Left"})
        --Label:ChangeText("Label")

        local Button = Tab:AddButton({Name = "Button",Side = "Left",Callback = function()end})
        --Button:ChangeName("Button")
        --Button:ChangeCallback(function()end)
        --Button:AddToolTip("ToolTip")

        local Toggle = Tab:AddToggle({Name = "Toggle",Side = "Left",Value = false,Callback = function(Bool)end})
        --Toggle:ChangeName("Toggle")
        --Toggle:ChangeValue(true)
        --Toggle:ChangeCallback(function(Bool)end)
        --Toggle:AddToolTip("ToolTip")
        --Toggle:AddBind({Key = "NONE",Mouse = false,Callback = function(Bool,Key)end,Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"}})

        local Slider = Tab:AddSlider({Name = "Slider",Side = "Left",Min = 0,Max = 100,Value = 50,Precise = 2,Unit = "",Callback = function(Number)end})
        --Slider:ChangeName("Slider")
        --Slider:ChangeValue(50)
        --Slider:ChangeCallback(function(Number)end)
        --Slider:AddToolTip("ToolTip")

        local Textbox = Tab:AddTextbox({Name = "Textbox",Side = "Left",Text = "Text",Placeholder = "Placeholder",NumberOnly = false,Callback = function(String)end})
        --Textbox:ChangeName("Textbox")
        --Textbox:ChangeText("Text")
        --Textbox:ChangePlaceholder("Placeholder")
        --Textbox:ChangeCallback(function(String)end)
        --Textbox:AddToolTip("ToolTip")

        local Keybind = Tab:AddBind({Name = "Keybind",Side = "Left",Key = "NONE",Mouse = false,Callback = function(Bool,Key)end,Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"}})
        --Keybind:ChangeName("Keybind")
        --Keybind:ChangeCallback(function(Bool,Key)end)
        --Keybind:AddToolTip("ToolTip")

        local Dropdown = Tab:AddDropdown({Name = "Dropdown",Side = "Left",Default = game.Players.LocalPlayer.Name, List = workspace:GetChildren(),Callback = function(String)end})
        --Dropdown:AddOption("Option")
        --Dropdown:RemoveOption("Option")
        --Dropdown:SelectOption("Option")
        --Dropdown:ChangeName("Dropdown")
        --Dropdown:AddToolTip("ToolTip")

        local Colorpicker = Tab:AddColorpicker({Name = "Colorpicker",Side = "Left",Color = Color3.new(1,0,0),Callback = function(Color)end})
        --Colorpicker:ChangeName("Colorpicker")
        --Colorpicker:ChangeCallback(function(Color3)end)
        --Colorpicker:ChangeValue(Color3.new(1,0,0))
        --Colorpicker:AddToolTip("ToolTip")

        local Section = Tab:AddSection({Name = "Section",Side = "Right"}) do
            --Same Elements as in tab but without side option
            Section:AddDivider()
            Section:AddLabel()
            Section:AddButton()
            Section:AddToggle()
            Section:AddSlider()
            Section:AddTextbox()
            Section:AddBind()
            Section:AddDropdown({List = workspace:GetChildren()})
            Section:AddColorpicker()
        end
    end
end
]]