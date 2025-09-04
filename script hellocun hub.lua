-- Hellocun Speed Hub – Full Template with Info Tab --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local VALID_KEY = "hellocunvip.111"

-- Create GUI
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "HellocunHub"

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 560, 0, 540)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -270)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- Title Bar (Red)
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(220, 20, 60)

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Hellocun Hub"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 30

-- Tab bar (Green)
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 50)
tabBar.BackgroundTransparency = 1

local tabNames = {
    "Auto Raid", "Auto Up Sea", "Auto Level", "Sea Event",
    "Event Lightning", "RED Event", "Auto Up V4", "Ðánh Quái",
    "Tele+Ðánh Ngu?i", "Info"
}

local tabButtons = {}
local contentFrames = {}

-- Functions to build UI
local function createTabButton(name, index, total)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1/total, 0, 1, 0)
    btn.Position = UDim2.new((index-1)/total, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Text = name
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(0, 210, 105) end)
    btn.MouseLeave:Connect(function()
        if not contentFrames[name].Visible then btn.BackgroundColor3 = Color3.fromRGB(0, 170, 85) end
    end)
    return btn
end

local function createContentFrame()
    local f = Instance.new("Frame", mainFrame)
    f.Size = UDim2.new(1, 0, 1, -95)
    f.Position = UDim2.new(0, 0, 0, 95)
    f.BackgroundTransparency = 1
    f.Visible = false
    return f
end

local function createKeyToggleUI(parent, buttonText)
    local keyBox = Instance.new("TextBox", parent)
    keyBox.Size = UDim2.new(0, 260, 0, 35)
    keyBox.Position = UDim2.new(0, 15, 0, 15)
    keyBox.PlaceholderText = "Nh?p key"
    keyBox.TextSize = 20
    keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    keyBox.TextColor3 = Color3.new(1,1,1)
    keyBox.Font = Enum.Font.SourceSans

    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.Size = UDim2.new(0, 260, 0, 40)
    toggleBtn.Position = UDim2.new(0, 15, 0, 60)
    toggleBtn.Text = buttonText
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.TextSize = 22
    toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    toggleBtn.TextColor3 = Color3.new(1,1,1)

    local statusLabel = Instance.new("TextLabel", parent)
    statusLabel.Size = UDim2.new(1, -30, 0, 25)
    statusLabel.Position = UDim2.new(0, 15, 1, -40)
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    statusLabel.Font = Enum.Font.SourceSans
    statusLabel.TextSize = 16
    statusLabel.Text = ""

    return keyBox, toggleBtn, statusLabel
end

-- Build tabs & content
for i, name in ipairs(tabNames) do
    tabButtons[i] = createTabButton(name, i, #tabNames)
    contentFrames[name] = createContentFrame()
end

contentFrames[tabNames[1]].Visible = true
tabButtons[1].BackgroundColor3 = Color3.fromRGB(0, 210, 105)

for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for _, frame in pairs(contentFrames) do frame.Visible = false end
        for _, b in ipairs(tabButtons) do b.BackgroundColor3 = Color3.fromRGB(0, 170, 85) end
        contentFrames[tabNames[i]].Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 210, 105)
    end)
end

-- Setup toggle visuals
local toggles = {}
for _, tabName in ipairs(tabNames) do
    local frame = contentFrames[tabName]
    if tabName ~= "Info" then
        local keyBox, toggleBtn, statusLabel = createKeyToggleUI(frame, "Start " .. tabName)
        toggles[tabName] = {
            keyBox = keyBox,
            toggleBtn = toggleBtn,
            statusLabel = statusLabel,
            running = false
        }
        toggleBtn.MouseButton1Click:Connect(function()
            local t = toggles[tabName]
            if t.keyBox.Text ~= VALID_KEY then
                t.statusLabel.Text = "Key không dúng!"
                return
            end
            t.running = not t.running
            if t.running then
                t.toggleBtn.Text = "Stop " .. tabName
                t.toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)