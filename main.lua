-- DeepHat x uProxyz Custom Framework [ULTIMATE SPEED & AUTO-SPAWN]
-- Estética: Cyberpunk / Dark Purple / Neon

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variáveis de Controle
local NoclipActive = false
local FlyActive = false
local WalkSpeedActive = false
local InfiniteJumpActive = false
local ESPActive = false
local JumpPowerActive = false

-- Variável para salvar o local de nascimento
local AutoSpawnPos = nil 

-- Configurações de Boost
local WalkSpeedVal = 100 
local JumpPowerVal = 150 
local FlySpeed = 100
local MaxFlySpeed = 300 

-- Cores de Tema
local ThemeColor = Color3.fromRGB(170, 85, 255)
local DarkBg = Color3.fromRGB(15, 10, 20)
local AccentColor = Color3.fromRGB(45, 20, 70)
local TextColor = Color3.fromRGB(230, 230, 255)

-- [SEGURANÇA DE CARREGAMENTO]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "uProxyz_UI_Final"
local success, err = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not success then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [FUNÇÕES DE DESIGN]
local function ApplyTween(obj, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- 1. TELA DE INJEÇÃO
local InjectBtn = Instance.new("TextButton")
InjectBtn.Name = "InjectBtn"
InjectBtn.Parent = ScreenGui
InjectBtn.Size = UDim2.new(0, 180, 0, 50)
InjectBtn.Position = UDim2.new(0.5, -90, 0.5, -25)
InjectBtn.Text = "INITIALIZING..."
InjectBtn.Font = Enum.Font.Code
InjectBtn.TextSize = 20
InjectBtn.BackgroundColor3 = DarkBg
InjectBtn.TextColor3 = ThemeColor
InjectBtn.BorderSizePixel = 0

local InjectStroke = Instance.new("UIStroke")
InjectStroke.Parent = InjectBtn
InjectStroke.Color = ThemeColor
InjectStroke.Thickness = 2

-- 2. MENU PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = DarkBg
MainFrame.Size = UDim2.new(0, 230, 0, 350)
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -175)
MainFrame.Visible = false
MainFrame.BorderSizePixel = 0

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = ThemeColor
MainStroke.Thickness = 1
MainStroke.Transparency = 0.5

MakeDraggable(MainFrame)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "uPROXYZ // TECH"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = ThemeColor
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 20

-- [SISTEMA DE BOTÕES]
local function CreateTechButton(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Position = pos
    btn.Size = UDim2.new(0.85, 0, 0, 30)
    btn.Text = text:upper()
    btn.BackgroundColor3 = color or AccentColor
    btn.TextColor3 = TextColor
    btn.Font = Enum.Font.Code
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Parent = btn
    btnStroke.Color = ThemeColor
    btnStroke.Thickness = 1
    btnStroke.Transparency = 0.7
    
    return btn
end

local NoclipBtn = CreateTechButton("Noclip: OFF", UDim2.new(0.075, 0, 0.15, 0))
local FlyBtn = CreateTechButton("Fly: OFF", UDim2.new(0.075, 0, 0.25, 0))
local WalkSpeedBtn = CreateTechButton("WalkSpeed: OFF", UDim2.new(0.075, 0, 0.35, 0))
local JumpPowerBtn = CreateTechButton("JumpPower: OFF", UDim2.new(0.075, 0, 0.45, 0))
local InfiniteJumpBtn = CreateTechButton("Inf Jump: OFF", UDim2.new(0.075, 0, 0.55, 0))
local ESPBtn = CreateTechButton("ESP: OFF", UDim2.new(0.075, 0, 0.65, 0))
local TPBaseBtn = CreateTechButton("Teleport Base", UDim2.new(0.075, 0, 0.77, 0), Color3.fromRGB(0, 120, 200))
local SelfDestructBtn = CreateTechButton("Shutdown", UDim2.new(0.075, 0, 0.88, 0), Color3.fromRGB(100, 0, 0))

-- [LÓGICA DE INJEÇÃO]
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "LOADING..."
    task.wait(1)
    InjectBtn.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    ApplyTween(MainFrame, {Size = UDim2.new(0, 230, 0, 350)}, 0.5)
end)

-- [LÓGICA DE FUNÇÕES]
NoclipBtn.MouseButton1Click:Connect(function()
    NoclipActive = not NoclipActive
    NoclipBtn.Text = NoclipActive and "Noclip: ON" or "Noclip: OFF"
    NoclipBtn.TextColor3 = NoclipActive and ThemeColor or TextColor
end)

FlyBtn.MouseButton1Click:Connect(function()
    FlyActive = not FlyActive
    FlyBtn.Text = FlyActive and "Fly: ON" or "Fly: OFF"
    FlyBtn.TextColor3 = FlyActive and ThemeColor or TextColor
    
    local Character = Player.Character
    if FlyActive and Character and Character:FindFirstChild("HumanoidRootPart") then
        local BV = Instance.new("BodyVelocity")
        BV.Name = "FlyVelocity"
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.Parent = Character.HumanoidRootPart
        
        local BG = Instance.new("BodyGyro")
        BG.Name = "FlyGyro"
        BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BG.CFrame = Character.HumanoidRootPart.CFrame
        BG.Parent = Character.HumanoidRootPart
    else
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            if Character.HumanoidRootPart:FindFirstChild("FlyVelocity") then Character.HumanoidRootPart.FlyVelocity:Destroy() end
            if Character.HumanoidRootPart:FindFirstChild("FlyGyro") then Character.HumanoidRootPart.FlyGyro:Destroy() end
        end
    end
end)

WalkSpeedBtn.MouseButton1Click:Connect(function()
    WalkSpeedActive = not WalkSpeedActive
    WalkSpeedBtn.Text = WalkSpeedActive and "WalkSpeed: ON" or "WalkSpeed: OFF"
    WalkSpeedBtn.TextColor3 = WalkSpeedActive and ThemeColor or TextColor
end)

JumpPowerBtn.MouseButton1Click:Connect(function()
    JumpPowerActive = not JumpPowerActive
    JumpPowerBtn.Text = JumpPowerActive and "JumpPower: ON" or "JumpPower: OFF"
    JumpPowerBtn.TextColor3 = JumpPowerActive and ThemeColor or TextColor
end)

InfiniteJumpBtn.MouseButton1Click:Connect(function()
    InfiniteJumpActive = not InfiniteJumpActive
    InfiniteJumpBtn.Text = InfiniteJumpActive and "Inf Jump: ON" or "Inf Jump: OFF"
    InfiniteJumpBtn.TextColor3 = InfiniteJumpActive and ThemeColor or TextColor
end)

ESPBtn.MouseButton1Click:Connect(function()
    ESPActive = not ESPActive
    ESPBtn.Text = ESPActive and "ESP: ON" or "ESP: OFF"
    ESPBtn.TextColor3 = ESPActive and ThemeColor or TextColor
end)

-- [DETECTOR DE SPAWN AUTOMÁTICO]
-- Esta função roda sempre que você nasce para salvar sua posição
local function TrackSpawn()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Root = Character:WaitForChild("HumanoidRootPart", 10)
    
    if Root then
        task.wait(2) -- Espera 2 segundos para garantir que o jogo carregou o mapa
        AutoSpawnPos = Root.Position + Vector3.new(0, 3, 0) -- Salva sua posição de nascimento
        print("uProxyz: Spawn detectado e salvo!")
    end
end

-- Detecta quando você entra ou renasce
Player.CharacterAdded:Connect(TrackSpawn)
if Player.Character then task.spawn(TrackSpawn) end

-- [LOOPS DE SISTEMA]

-- Noclip, WalkSpeed, JumpPower Loop
RunService.Stepped:Connect(function()
    if Player.Character then
        local Hum = Player.Character:FindFirstChildOfClass("Humanoid")
        if Hum then
            if WalkSpeedActive then Hum.WalkSpeed = WalkSpeedVal end
            if JumpPowerActive then Hum.JumpPower = JumpPowerVal end
        end
        
        if NoclipActive then
            for _, part in pairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- Fly Loop
RunService.RenderStepped:Connect(function()
    if FlyActive and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local Root = Player.Character.HumanoidRootPart
        local Camera = workspace.CurrentCamera
        local Direction = Vector3.new(0,0,0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction = Direction + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction = Direction - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction = Direction - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction = Direction + Camera.CFrame.RightVector end
        
        if Root:FindFirstChild("FlyVelocity") then
            Root.FlyVelocity.Velocity = Direction * FlySpeed
        end
        if Root:FindFirstChild("FlyGyro") then
            Root.FlyGyro.CFrame = Camera.CFrame
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpActive and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- ESP Loop
RunService.Heartbeat:Connect(function()
    if ESPActive then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if not p.Character:FindFirstChild("uProxyzESP") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "uProxyzESP"
                    highlight.FillColor = ThemeColor
                    highlight.OutlineColor = Color3.new(1,1,1)
                    highlight.FillTransparency = 0.5
                    highlight.Parent = p.Character
                end
            end
        end
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("uProxyzESP") then
                p.Character.uProxyzESP:Destroy()
            end
        end
    end
end)

-- [TELEPORTE BASE - SISTEMA DE SPAWN DETECTADO]
TPBaseBtn.MouseButton1Click:Connect(function()
    local Character = Player.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")
    
    if Root then
        if AutoSpawnPos then
            -- Teleporta para a posição salva do seu nascimento
            Root.CFrame = CFrame.new(AutoSpawnPos)
        else
            -- Fallback se ainda não salvou o spawn
            local SpawnLoc = workspace:FindFirstChildOfClass("SpawnLocation")
            if SpawnLoc then
                Root.CFrame = SpawnLoc.CFrame + Vector3.new(0, 5, 0)
            else
                Root.CFrame = CFrame.new(0, 50, 0)
            end
        end
    end
end)

-- Self Destruct
SelfDestructBtn.MouseButton1Click:Connect(function()
    -- Limpeza Total
    NoclipActive = false
    FlyActive = false
    WalkSpeedActive = false
    InfiniteJumpActive = false
    ESPActive = false
    JumpPowerActive = false
    
    ScreenGui:Destroy()
    
    if Player.Character then
        local Root = Player.Character:FindFirstChild("HumanoidRootPart")
        if Root then
            if Root:FindFirstChild("FlyVelocity") then Root.FlyVelocity:Destroy() end
            if Root:FindFirstChild("FlyGyro") then Root.FlyGyro:Destroy() end
        end
        local Hum = Player.Character:FindFirstChildOfClass("Humanoid")
        if Hum then
            Hum.WalkSpeed = 16
            Hum.JumpPower = 50
        end
    end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("uProxyzESP") then
            p.Character.uProxyzESP:Destroy()
        end
    end
end)
