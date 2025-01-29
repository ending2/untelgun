local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(1, 300, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 8
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = screenGui
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true

TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 0.5, -100)}):Play()

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 100, 0, 20)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "CuteEnding"
titleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.SourceSans
titleLabel.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
closeButton.Text = "X"
closeButton.Parent = frame

local closeUICorner = Instance.new("UICorner")
closeUICorner.CornerRadius = UDim.new(1, 0)
closeUICorner.Parent = closeButton

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
minimizeButton.Text = "-"
minimizeButton.Parent = frame

local minimizeUICorner = Instance.new("UICorner")
minimizeUICorner.CornerRadius = UDim.new(1, 0)
minimizeUICorner.Parent = minimizeButton

minimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 300, 0.5, -100)}):Play()
    task.wait(1)
    frame.Visible = false

    local hintBackground = Instance.new("Frame")
    hintBackground.Size = UDim2.new(0, 350, 0, 70)
    hintBackground.Position = UDim2.new(1, -370, -0.2, 0)
    hintBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    hintBackground.BackgroundTransparency = 0.3
    hintBackground.Parent = screenGui

    local hintUICorner = Instance.new("UICorner")
    hintUICorner.CornerRadius = UDim.new(0.5, 0)
    hintUICorner.Parent = hintBackground

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1, 0, 1, 0)
    hint.BackgroundTransparency = 1
    hint.Text = "오른쪽 Ctrl을 누르면 UI가 다시 나타납니다."
    hint.TextColor3 = Color3.fromRGB(255, 255, 255)
    hint.TextSize = 20
    hint.Font = Enum.Font.FredokaOne
    hint.TextWrapped = true
    hint.Parent = hintBackground

    TweenService:Create(hintBackground, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -370, 0.1, 0)}):Play()
    task.wait(3)
    hintBackground:Destroy()
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        frame.Visible = true
        TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 0.5, -100)}):Play()
    end
end)

local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(0, 60, 0, 30)
toggleFrame.Position = UDim2.new(0.5, -30, 0.55, -15)
toggleFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleFrame.Parent = frame

local toggleUICorner = Instance.new("UICorner")
toggleUICorner.CornerRadius = UDim.new(1, 0)
toggleUICorner.Parent = toggleFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 28, 0, 28)
toggleButton.Position = UDim2.new(0, 1, 0, 1)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = ""
toggleButton.Parent = toggleFrame

local toggleButtonUICorner = Instance.new("UICorner")
toggleButtonUICorner.CornerRadius = UDim.new(1, 0)
toggleButtonUICorner.Parent = toggleButton

local toggled = false
local equipLoopRunning = false

local function GetP1()
    return workspace:FindFirstChild("P1")
end

local function EquipLoop()
    equipLoopRunning = true
    while toggled and equipLoopRunning and task.wait() do
        local p1 = GetP1()
        if not toggled or not equipLoopRunning then break end
        if p1 and player.Character then
            if p1.Parent ~= workspace then
                continue
            end
            player.Character:FindFirstChild("Humanoid"):EquipTool(p1)
        end
    end
    equipLoopRunning = false
end

toggleButton.MouseButton1Click:Connect(function()
    toggled = not toggled
    local goalPosition = toggled and UDim2.new(1, -29, 0, 1) or UDim2.new(0, 1, 0, 1)
    local goalColor = toggled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 255, 255)
    TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = goalPosition, BackgroundColor3 = goalColor}):Play()

    if toggled and not equipLoopRunning then
        EquipLoop()
    end
end)

closeButton.MouseButton1Click:Connect(function()
    toggled = false
    equipLoopRunning = false
    TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 1, 0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(-1, -300, 0.5, -100)}):Play()
    task.wait(1)
    screenGui:Destroy()
end)
