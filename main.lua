-- uProxyz - Interface + módulos locais de teste
-- Interface standalone baseada nas opções presentes no arquivo enviado.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

local Settings = {
    KillAuraActive = false,
    KillAuraRange = 15,
    HitboxActive = false,
    HitboxSize = 6,
    ESP_Enabled = false,
    AimbotActive = false,
    InfiniteJumpActive = false,
    FlyActive = false,
    FlySpeed = 55,
    NoclipActive = false,
    RemoteSpamActive = false,
    AntiBanActive = false,
    RemoteSpyActive = false,
    ThemeColor = Color3.fromRGB(170, 85, 255)
}

-- Remove cópia antiga da interface
local old = CoreGui:FindFirstChild("uProxyz_UI")
if old then old:Destroy() end

-- INTERFACE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "uProxyz_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 500, 0, 500)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Settings.ThemeColor
Stroke.Thickness = 2
Stroke.Transparency = 0.2
Stroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -50, 0, 42)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "uPROXYZ // TEST"
Title.TextColor3 = Settings.ThemeColor
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 20

local Close = Instance.new("TextButton")
Close.Parent = MainFrame
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -40, 0, 8)
Close.BackgroundColor3 = Color3.fromRGB(55, 25, 70)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.Font = Enum.Font.Code
Close.TextSize = 16
Close.BorderSizePixel = 0
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

local Divider = Instance.new("Frame")
Divider.Parent = MainFrame
Divider.Size = UDim2.new(1, -30, 0, 1)
Divider.Position = UDim2.new(0, 15, 0, 48)
Divider.BackgroundColor3 = Settings.ThemeColor
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0

local Container = Instance.new("Frame")
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 15, 0, 60)
Container.Size = UDim2.new(1, -30, 1, -75)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIGridLayout")
Layout.Parent = Container
Layout.CellSize = UDim2.new(0, 220, 0, 48)
Layout.CellPadding = UDim2.new(0, 10, 0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder

local function CreateButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(45, 20, 70)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230,230,255)
    btn.Font = Enum.Font.Code
    btn.TextSize = 14
    btn.Parent = Container

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Settings.ThemeColor
    s.Transparency = 0.65
    s.Parent = btn

    return btn
end

local function SetToggle(btn, label, enabled)
    btn.Text = label .. ": " .. (enabled and "ON" or "OFF")
    btn.TextColor3 = enabled and Settings.ThemeColor or Color3.fromRGB(230,230,255)
end

local KillAuraBtn = CreateButton("Kill Aura: OFF")
local HitboxBtn = CreateButton("Hitbox: OFF")
local ESPBtn = CreateButton("ESP: OFF")
local AimbotBtn = CreateButton("Aimbot: OFF")
local InfiniteJumpBtn = CreateButton("Infinite Jump: OFF")
local FlyBtn = CreateButton("Fly: OFF")
local NoclipBtn = CreateButton("Noclip: OFF")
local RemoteSpamBtn = CreateButton("Remote Spam: OFF")
local AntiBanBtn = CreateButton("Anti-Ban: OFF")
local RemoteSpyBtn = CreateButton("Remote Spy: OFF")
local ShutdownBtn = CreateButton("SELF DESTRUCT")
ShutdownBtn.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
ShutdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Faz o botão ocupar visualmente o centro da última linha do grid.
local ShutdownPaddingLeft = Instance.new("Frame")
ShutdownPaddingLeft.Name = "SelfDestructSpacer"
ShutdownPaddingLeft.Size = UDim2.new(0, 220, 0, 48)
ShutdownPaddingLeft.BackgroundTransparency = 1
ShutdownPaddingLeft.LayoutOrder = 9998
ShutdownPaddingLeft.Parent = Container

ShutdownBtn.LayoutOrder = 9999

-- CONFIGURAÇÃO POR CLIQUE DIREITO
local ConfigPopup = Instance.new("Frame")
ConfigPopup.Name = "ConfigPopup"
ConfigPopup.Parent = ScreenGui
ConfigPopup.Size = UDim2.new(0, 250, 0, 155)
ConfigPopup.BackgroundColor3 = Color3.fromRGB(20, 14, 28)
ConfigPopup.BorderSizePixel = 0
ConfigPopup.Visible = false
ConfigPopup.ZIndex = 20
Instance.new("UICorner", ConfigPopup).CornerRadius = UDim.new(0, 8)

local ConfigStroke = Instance.new("UIStroke")
ConfigStroke.Color = Settings.ThemeColor
ConfigStroke.Thickness = 1.5
ConfigStroke.Parent = ConfigPopup

local ConfigTitle = Instance.new("TextLabel")
ConfigTitle.Parent = ConfigPopup
ConfigTitle.Position = UDim2.new(0, 12, 0, 8)
ConfigTitle.Size = UDim2.new(1, -24, 0, 25)
ConfigTitle.BackgroundTransparency = 1
ConfigTitle.Text = "CONFIG"
ConfigTitle.TextColor3 = Settings.ThemeColor
ConfigTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfigTitle.Font = Enum.Font.Code
ConfigTitle.TextSize = 16
ConfigTitle.ZIndex = 21

local ConfigValue = Instance.new("TextLabel")
ConfigValue.Parent = ConfigPopup
ConfigValue.Position = UDim2.new(0, 12, 0, 43)
ConfigValue.Size = UDim2.new(1, -24, 0, 28)
ConfigValue.BackgroundTransparency = 1
ConfigValue.TextColor3 = Color3.fromRGB(240,240,255)
ConfigValue.Font = Enum.Font.Code
ConfigValue.TextSize = 15
ConfigValue.ZIndex = 21

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = ConfigPopup
MinusBtn.Position = UDim2.new(0, 12, 0, 82)
MinusBtn.Size = UDim2.new(0, 68, 0, 36)
MinusBtn.Text = "-"
MinusBtn.Font = Enum.Font.Code
MinusBtn.TextSize = 22
MinusBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinusBtn.BackgroundColor3 = Color3.fromRGB(55,35,70)
MinusBtn.BorderSizePixel = 0
MinusBtn.ZIndex = 21
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 6)

local PlusBtn = MinusBtn:Clone()
PlusBtn.Parent = ConfigPopup
PlusBtn.Position = UDim2.new(1, -80, 0, 82)
PlusBtn.Text = "+"

local CloseConfig = Instance.new("TextButton")
CloseConfig.Parent = ConfigPopup
CloseConfig.Position = UDim2.new(0.5, -35, 0, 82)
CloseConfig.Size = UDim2.new(0, 70, 0, 36)
CloseConfig.Text = "OK"
CloseConfig.Font = Enum.Font.Code
CloseConfig.TextSize = 14
CloseConfig.TextColor3 = Color3.fromRGB(255,255,255)
CloseConfig.BackgroundColor3 = Settings.ThemeColor
CloseConfig.BorderSizePixel = 0
CloseConfig.ZIndex = 21
Instance.new("UICorner", CloseConfig).CornerRadius = UDim.new(0, 6)

local ConfigHint = Instance.new("TextLabel")
ConfigHint.Parent = ConfigPopup
ConfigHint.Position = UDim2.new(0, 12, 1, -26)
ConfigHint.Size = UDim2.new(1, -24, 0, 18)
ConfigHint.BackgroundTransparency = 1
ConfigHint.Text = "Botão direito = configurar"
ConfigHint.TextColor3 = Color3.fromRGB(155,155,175)
ConfigHint.Font = Enum.Font.Code
ConfigHint.TextSize = 11
ConfigHint.ZIndex = 21

local activeConfig = nil

local configs = {
    Hitbox = {
        title = "HITBOX SIZE",
        get = function() return Settings.HitboxSize end,
        set = function(v) Settings.HitboxSize = math.clamp(v, 2, 20) end,
        step = 1,
        suffix = " studs"
    },
    Fly = {
        title = "FLY SPEED",
        get = function() return Settings.FlySpeed end,
        set = function(v) Settings.FlySpeed = math.clamp(v, 10, 150) end,
        step = 5,
        suffix = ""
    },
    KillAura = {
        title = "KILL AURA RANGE (TEST)",
        get = function() return Settings.KillAuraRange end,
        set = function(v) Settings.KillAuraRange = math.clamp(v, 3, 50) end,
        step = 1,
        suffix = " studs"
    }
}

local function refreshConfig()
    if not activeConfig then return end
    ConfigTitle.Text = activeConfig.title
    ConfigValue.Text = tostring(activeConfig.get()) .. (activeConfig.suffix or "")
end

local function openConfig(config, button)
    activeConfig = config
    refreshConfig()

    local pos = button.AbsolutePosition
    local size = button.AbsoluteSize
    local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)

    local x = math.min(pos.X + size.X + 8, viewport.X - 260)
    local y = math.min(pos.Y, viewport.Y - 165)
    ConfigPopup.Position = UDim2.fromOffset(x, y)
    ConfigPopup.Visible = true
end

MinusBtn.MouseButton1Click:Connect(function()
    if activeConfig then
        activeConfig.set(activeConfig.get() - activeConfig.step)
        refreshConfig()
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    if activeConfig then
        activeConfig.set(activeConfig.get() + activeConfig.step)
        refreshConfig()
    end
end)

CloseConfig.MouseButton1Click:Connect(function()
    ConfigPopup.Visible = false
    activeConfig = nil
end)

HitboxBtn.MouseButton2Click:Connect(function()
    openConfig(configs.Hitbox, HitboxBtn)
end)

FlyBtn.MouseButton2Click:Connect(function()
    openConfig(configs.Fly, FlyBtn)
end)

KillAuraBtn.MouseButton2Click:Connect(function()
    openConfig(configs.KillAura, KillAuraBtn)
end)

-- DRAG
do
    local dragging = false
    local dragStart
    local startPos
    local dragInput

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local running = true
local originalHitboxes = {}

local function root(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

-- Kill Aura: simulador de alcance para teste
KillAuraBtn.MouseButton1Click:Connect(function()
    Settings.KillAuraActive = not Settings.KillAuraActive
    SetToggle(KillAuraBtn, "Kill Aura", Settings.KillAuraActive)
end)

task.spawn(function()
    while running do
        task.wait(0.15)
        if Settings.KillAuraActive then
            local myRoot = root(Player.Character)
            if myRoot then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= Player then
                        local target = root(p.Character)
                        if target and (myRoot.Position-target.Position).Magnitude <= Settings.KillAuraRange then
                            print("[uProxyz TEST] KillAura target:", p.Name)
                        end
                    end
                end
            end
        end
    end
end)

-- Hitbox
local function restoreHitboxes()
    for part, data in pairs(originalHitboxes) do
        if part and part.Parent then
            part.Size = data.Size
            part.Transparency = data.Transparency
            part.CanCollide = data.CanCollide
        end
    end
    table.clear(originalHitboxes)
end

HitboxBtn.MouseButton1Click:Connect(function()
    Settings.HitboxActive = not Settings.HitboxActive
    SetToggle(HitboxBtn, "Hitbox", Settings.HitboxActive)
    if not Settings.HitboxActive then restoreHitboxes() end
end)

task.spawn(function()
    while running do
        task.wait(0.3)
        if Settings.HitboxActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player then
                    local hrp = root(p.Character)
                    if hrp then
                        if not originalHitboxes[hrp] then
                            originalHitboxes[hrp] = {
                                Size=hrp.Size,
                                Transparency=hrp.Transparency,
                                CanCollide=hrp.CanCollide
                            }
                        end
                        hrp.Size = Vector3.new(Settings.HitboxSize,Settings.HitboxSize,Settings.HitboxSize)
                        hrp.Transparency = 0.6
                        hrp.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- ESP
local function removeESP(char)
    if not char then return end
    for _, v in ipairs(char:GetDescendants()) do
        if v.Name == "DeepHat_ESP" or v.Name == "DeepHat_Name" then
            v:Destroy()
        end
    end
end

local function createESP(p)
    local hrp = root(p.Character)
    if not hrp or hrp:FindFirstChild("DeepHat_ESP") then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "DeepHat_ESP"
    box.Adornee = hrp
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Size = Vector3.new(4,6,1)
    box.Color3 = Settings.ThemeColor
    box.Transparency = 0.5
    box.Parent = hrp

    local bill = Instance.new("BillboardGui")
    bill.Name = "DeepHat_Name"
    bill.Adornee = hrp
    bill.Size = UDim2.new(0,140,0,40)
    bill.StudsOffset = Vector3.new(0,3,0)
    bill.AlwaysOnTop = true
    bill.Parent = hrp

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1,1)
    label.BackgroundTransparency = 1
    label.Text = p.Name
    label.TextColor3 = Settings.ThemeColor
    label.TextSize = 14
    label.Font = Enum.Font.Code
    label.Parent = bill
end

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESP_Enabled = not Settings.ESP_Enabled
    SetToggle(ESPBtn, "ESP", Settings.ESP_Enabled)

    if not Settings.ESP_Enabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then removeESP(p.Character) end
        end
    end
end)

task.spawn(function()
    while running do
        task.wait(0.5)
        if Settings.ESP_Enabled then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player then createESP(p) end
            end
        end
    end
end)

-- Aimbot: mantém a opção como detector de alvo para teste
AimbotBtn.MouseButton1Click:Connect(function()
    Settings.AimbotActive = not Settings.AimbotActive
    SetToggle(AimbotBtn, "Aimbot", Settings.AimbotActive)
end)

-- MOVEMENT TESTS
-- Feitos para ambiente de teste/anti-cheat.

InfiniteJumpBtn.MouseButton1Click:Connect(function()
    Settings.InfiniteJumpActive = not Settings.InfiniteJumpActive
    SetToggle(InfiniteJumpBtn, "Infinite Jump", Settings.InfiniteJumpActive)
end)

UserInputService.JumpRequest:Connect(function()
    if not running or not Settings.InfiniteJumpActive then return end
    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local flyAttachment
local flyVelocity
local flyConnection

local function stopFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
    if flyAttachment then
        flyAttachment:Destroy()
        flyAttachment = nil
    end
end

local function startFly()
    stopFly()

    local char = Player.Character
    local hrp = root(char)
    if not hrp then return end

    flyAttachment = Instance.new("Attachment")
    flyAttachment.Name = "uProxyz_FlyAttachment"
    flyAttachment.Parent = hrp

    flyVelocity = Instance.new("LinearVelocity")
    flyVelocity.Name = "uProxyz_FlyVelocity"
    flyVelocity.Attachment0 = flyAttachment
    flyVelocity.MaxForce = math.huge
    flyVelocity.VectorVelocity = Vector3.zero
    flyVelocity.Parent = hrp

    flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not running or not Settings.FlyActive or not hrp.Parent then
            return
        end

        local camera = workspace.CurrentCamera
        if not camera then return end

        local direction = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction += camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction -= camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction -= camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction += camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction += Vector3.yAxis
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction -= Vector3.yAxis
        end

        if direction.Magnitude > 0 then
            direction = direction.Unit
        end

        flyVelocity.VectorVelocity = direction * Settings.FlySpeed
    end)
end

FlyBtn.MouseButton1Click:Connect(function()
    Settings.FlyActive = not Settings.FlyActive
    SetToggle(FlyBtn, "Fly", Settings.FlyActive)

    if Settings.FlyActive then
        startFly()
    else
        stopFly()
    end
end)

local noclipConnection
local noclipOriginal = {}

local function stopNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end

    for part, oldValue in pairs(noclipOriginal) do
        if part and part.Parent then
            part.CanCollide = oldValue
        end
    end
    table.clear(noclipOriginal)
end

local function startNoclip()
    stopNoclip()

    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if not running or not Settings.NoclipActive then return end

        local char = Player.Character
        if not char then return end

        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                if noclipOriginal[obj] == nil then
                    noclipOriginal[obj] = obj.CanCollide
                end
                obj.CanCollide = false
            end
        end
    end)
end

NoclipBtn.MouseButton1Click:Connect(function()
    Settings.NoclipActive = not Settings.NoclipActive
    SetToggle(NoclipBtn, "Noclip", Settings.NoclipActive)

    if Settings.NoclipActive then
        startNoclip()
    else
        stopNoclip()
    end
end)

-- Opções mantidas na interface em modo de teste
RemoteSpamBtn.MouseButton1Click:Connect(function()
    Settings.RemoteSpamActive = not Settings.RemoteSpamActive
    SetToggle(RemoteSpamBtn, "Remote Spam", Settings.RemoteSpamActive)
    print("[uProxyz TEST] Remote Spam:", Settings.RemoteSpamActive)
end)

AntiBanBtn.MouseButton1Click:Connect(function()
    Settings.AntiBanActive = not Settings.AntiBanActive
    SetToggle(AntiBanBtn, "Anti-Ban", Settings.AntiBanActive)
    print("[uProxyz TEST] Anti-Ban:", Settings.AntiBanActive)
end)

RemoteSpyBtn.MouseButton1Click:Connect(function()
    Settings.RemoteSpyActive = not Settings.RemoteSpyActive
    SetToggle(RemoteSpyBtn, "Remote Spy", Settings.RemoteSpyActive)
    print("[uProxyz TEST] Remote Spy:", Settings.RemoteSpyActive)
end)

local function shutdown()
    if not running then return end
    running = false
    Settings.HitboxActive = false
    Settings.ESP_Enabled = false
    Settings.InfiniteJumpActive = false
    Settings.FlyActive = false
    Settings.NoclipActive = false
    stopFly()
    stopNoclip()
    restoreHitboxes()

    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then removeESP(p.Character) end
    end

    ScreenGui:Destroy()
end

ShutdownBtn.MouseButton1Click:Connect(shutdown)
Close.MouseButton1Click:Connect(shutdown)

print("[uProxyz] Interface carregada.")
