--  hellocun GUI - Speed Style Trng Hng, Không Key, RED Event Support
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- To GUI chính
local Window = Rayfield:CreateWindow({
    Name = " hellocun Hub | Speed Style",
    LoadingTitle = "hellocun GUI",
    LoadingSubtitle = "ang ti ...",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

--  Giao din trng hng pastel
Rayfield:ChangeTheme({
    Background = Color3.fromRGB(255, 255, 255),
    Topbar = Color3.fromRGB(255, 182, 193),
    Text = Color3.fromRGB(0, 0, 0),
    ElementBackground = Color3.fromRGB(255, 240, 245),
    ElementStroke = Color3.fromRGB(255, 182, 193),
    SectionBackground = Color3.fromRGB(255, 240, 245),
    Divider = Color3.fromRGB(255, 182, 193),
    Slider = Color3.fromRGB(255, 182, 193),
    Toggle = Color3.fromRGB(255, 182, 193),
    Button = Color3.fromRGB(255, 182, 193),
    Dropdown = Color3.fromRGB(255, 182, 193),
    Input = Color3.fromRGB(255, 182, 193),
    Notification = Color3.fromRGB(255, 182, 193)
})

-- Tabs
local autoTab = Window:CreateTab(" Auto")
local infoTab = Window:CreateTab(" Info")

--  Auto Câu Cá
autoTab:CreateToggle({
    Name = " Auto Câu Cá",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFish = Value
        spawn(function()
            while _G.AutoFish do
                task.wait(1)
                local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("RemoteEvent") then
                    tool.RemoteEvent:FireServer("Cast")
                    task.wait(2)
                    tool.RemoteEvent:FireServer("Catch")
                end
            end
        end)
    end
})

--  Auto Farm Level (simple version)
autoTab:CreateToggle({
    Name = " Auto Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        spawn(function()
            while _G.AutoFarm do
                task.wait()
                pcall(function()
                    local enemies = workspace.Enemies and workspace.Enemies:GetChildren()
                    for _, mob in pairs(enemies or {}) do
                        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            local player = game.Players.LocalPlayer
                            local char = player.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char:PivotTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                end
                            end
                            break
                        end
                    end
                end)
            end
        end)
    end
})

--  Auto RED EVENT Blox Fruits
autoTab:CreateToggle({
    Name = " Auto RED EVENT (Sea Beast - Blox Fruits)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoRed = Value
        spawn(function()
            while _G.AutoRed do
                task.wait(0.5)
                pcall(function()
                    for _, obj in pairs(workspace:GetChildren()) do
                        if obj:IsA("Model") and (obj.Name:find("SeaBeast") or obj.Name:find("Red") or obj.Name:find("Pirate")) then
                            if obj:FindFirstChild("HumanoidRootPart") then
                                local char = game.Players.LocalPlayer.Character
                                if char and char:FindFirstChild("HumanoidRootPart") then
                                    char:PivotTo(obj.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                                    local tool = char:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool:Activate()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
})

--  Auto ánh Quái Có Hiu ng Sét (Lightning Farm)
autoTab:CreateToggle({
    Name = " Auto Lightning Farm",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoLightningFarm = Value
        spawn(function()
            while _G.AutoLightningFarm do
                task.wait(0.3)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    if not char then return end

                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local tool = char:FindFirstChildOfClass("Tool")
                    if not hrp or not tool then return end

                    local enemies = workspace:FindFirstChild("Enemies")
                    if not enemies then return end

                    for _, mob in pairs(enemies:GetChildren()) do
                        local mobHRP = mob:FindFirstChild("HumanoidRootPart")
                        local mobHum = mob:FindFirstChild("Humanoid")
                        if mobHRP and mobHum and mobHum.Health > 0 then
                            -- Dch chuyn ti quái
                            hrp.CFrame = mobHRP.CFrame * CFrame.new(0, 10, 0)

                            -- ánh quái
                            tool:Activate()

                            -- To hiu ng sét
                            local lightning = Instance.new("Part")
                            lightning.Anchored = true
                            lightning.CanCollide = false
                            lightning.Size = Vector3.new(0.2, 20, 0.2)
                            lightning.CFrame = CFrame.new(mobHRP.Position + Vector3.new(0, 10, 0))
                            lightning.BrickColor = BrickColor.new("Electric blue")
                            lightning.Material = Enum.Material.Neon
                            lightning.Name = "LightningEffect"
                            lightning.Parent = workspace

                            game:GetService("Debris"):AddItem(lightning, 0.3)
                            break
                        end
                    end
                end)
            end
        end)
    end
})

--  Info Tab
infoTab:CreateParagraph({
    Title = " Thông Tin Ngi Chi",
    Content = "Tên: " .. game.Players.LocalPlayer.Name ..
             "Level: " .. (game.Players.LocalPlayer:FindFirstChild("Data") and game.Players.LocalPlayer.Data.Level.Value or "???")
})
