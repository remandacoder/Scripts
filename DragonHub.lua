local executor = identifyexecutor and string.lower(identifyexecutor()) or "" 

if string.find(executor, "xeno") or string.find(executor, "solara") or Solara or Xeno then 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/Azure%20Latch%3A%20Solara%20Edition%20(OS)"))()
    return
end

if game.PlaceId == 139609232261520 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/hgghhghghhgg"))()
else

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/ui"))() -- yo ts ui :rofl:

local win = ui:Create({
    Name = "Celeron's GUI (Azure Latch)",
    ThemeColor = Color3.fromRGB(152, 58, 201),
	ThemeGradient = Color3.fromRGB(95, 11, 143),
    StartupSound = "rbxassetid://6958727243",
    ThemeFont = Enum.Font.GothamBold,
	ToggledSideBar = true
})

local hometab = win:Tab("Home")
local maintab = win:Tab("Blatant")
local maintab2 = win:Tab("Silent")
local funtab = win:Tab("Movesets")
local teleporttab = win:Tab("Teleports")
local exploittab = win:Tab("Exploits")
local misctab = win:Tab("Others")
local helptab = win:Tab("Info")

hometab:Label("Script Made By Celeron! Check Info For Additional Credits.")
hometab:Label("Join The Discord Server In Info For Updates / Suggestions.")
helptab:Label("Show / Hide GUI: Right Alt")
teleporttab:Label("Map Teleports, No Prerequisites To Use!")
misctab:Label("Miscellaneous Features, They Give No Advantages In-Game!")
exploittab:Label("This Tab Comes With Useful Features.")

--- buffers brrrrrr
local buffers = setmetatable({}, {__index = function(_, k) return k end})

NET = (function()
    local Packets = require(game:GetService("ReplicatedStorage"):WaitForChild("packets"))
    local warned = {}
    
    local function warnOnce(key, message)
        if not warned[key] then 
            warned[key] = true
            warn("[net shim] " .. message) 
        end
    end
    
    local function convertToString(inputData)
        if type(inputData) == "string" then return inputData end
        if typeof(inputData) == "buffer" then return buffer.tostring(inputData) end
    end
    
    local netShim = {}
    
    function netShim.FireServer(_, dataBuffer, actionsList)
        local bufferType = convertToString(dataBuffer)
        
        if bufferType == "base" then
            if type(actionsList) ~= "table" then return end
            
            for _, primaryAction in ipairs(actionsList) do
                if type(primaryAction) == "table" then
                    local success = pcall(Packets.bytenet_use.send, primaryAction)
                    if not success then 
                        warnOnce("use_" .. tostring(primaryAction), "bytenet_use execution failed for: '" .. tostring(primaryAction) .. "'") 
                    end
                end
            end
            
        elseif bufferType == "grabball" then
            local success = pcall(Packets.bytenet_findBall.send, actionsList)
            if not success then 
                warnOnce("grab", "bytenet_findBall execution channel failed.") 
            end
        end
    end
    
    netShim.fireServer = netShim.FireServer
    return netShim
end)()
---

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

helptab:Button("Copy Owner Discord Username", "Copies The Owner's Discord Username To Your Clipboard.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Discord Username",
        Text = "Copied to your clipboard!",
        Duration = 3,
        Button1 = "alright fella",
    })
    setclipboard("celeronstilltuff")
end)

helptab:Button("Copy Discord Server Invite", "Copies The Discord Invite To Your Clipboard.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Discord Invite",
        Text = "Copied to your clipboard!",
        Duration = 3,
        Button1 = "alright fella",
    })
    setclipboard("https://discord.gg/mFusYUmyry")
end)

helptab:Label("Script Credits.")

helptab:Label("Main Scripter: Celeron.")
helptab:Label("Custom UI + Some Features: Daffy.")
helptab:Label("GK Anywhere Feature: Ashura.")

if math.random(1,50) == 1 then
    hometab:Banner("17327779381", 385)
else
    hometab:Banner("93012899590948", 135)
end

notifsup = maintab2:Folder("Notification Suppression.", Color3.fromRGB(169, 5, 255), true)
notifsup:Label("Notification Suppression: Useful When Streaming.")

local suppressNotifs = false
notifsup:Toggle("Suppress Notifications", "Suppresses Notifications On Some Features, Made For Competitive Players.", function()
    suppressNotifs = not suppressNotifs
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Notifications",
        Text = suppressNotifs and "Suppressed." or "Removed Suppression.",
        Duration = 1
    })
end)

local spawns = {}
for _, obj in ipairs(workspace:GetDescendants()) do
	if obj:IsA("SpawnLocation") then
		table.insert(spawns, obj)
	end
end

meta = maintab:Folder("Metavision Features.", Color3.fromRGB(169, 5, 255), true)
meta:Label("Metavision Features.")

meta:Button("Metavision V1", "This Feature Emulates Having Isagi's Metavision From The Show.", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/FVgs7bQw"))()
end)

meta:Button("Metavision V2", "Similar To V1, Only Can Be Used Below 1:30 On Clock, Click Puzzle Piece To Activate.", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/HfpQBAsF"))()
end)

ballfolder = maintab:Folder("Ball Features.", Color3.fromRGB(169, 5, 255), true)
ballfolder:Label("Ball Features.")

local autoGoalState = {
    enabled = false,
    conn = nil
}

ballfolder:Toggle("Auto Goal", "Attempts To Steal The Ball And Score.", function()
    autoGoalState.enabled = not autoGoalState.enabled
    game.StarterGui:SetCore("SendNotification", {
        Title = "Auto Goal",
        Text = autoGoalState.enabled and "Enabled." or "Disabled.",
        Duration = 1
    })
    
    if autoGoalState.enabled then
        local players = game:GetService("Players")
        local runservice = game:GetService("RunService")
        local replicatedstorage = game:GetService("ReplicatedStorage")
        local map = workspace:WaitForChild("map")
        local agoal, bgoal = map:WaitForChild("Agoal"), map:WaitForChild("Bgoal")
        local localplayer = players.LocalPlayer
        
        local function ingame()
            local state = localplayer.Character and localplayer.Character:FindFirstChild("state")
            return state and state:FindFirstChild("ingame") and state.ingame.Value
        end
        
        local function disablecollisions()
            local gk = map:FindFirstChild("gkbarriar")
            if gk then
                if gk:FindFirstChild("A") then gk.A.CanCollide = false end
                if gk:FindFirstChild("B") then gk.B.CanCollide = false end
            end
            if agoal then agoal.CanCollide = false end
            if bgoal then bgoal.CanCollide = false end
        end
        
        local function stealball()
            local root = localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart")
            local ball = workspace.Terrain:FindFirstChild("Ball")
            if root and ball then
                root.CFrame = CFrame.new(ball.Position.X, 0, ball.Position.Z)
            end
            for _, plr in pairs(players:GetPlayers()) do
                if plr ~= localplayer and plr.Character then
                    local otherball = plr.Character:FindFirstChild("Ball")
                    local otherroot = plr.Character:FindFirstChild("HumanoidRootPart")
                    local localroot = localplayer.Character:FindFirstChild("HumanoidRootPart")
                    if otherball and otherroot and localroot then
                        localroot.CFrame = otherball.CFrame
                        NET:FireServer(
                            buffer.fromstring(buffers["base"]),
                            {{"tackle"}}
                        )
                    end
                end
            end
        end
        
        local function hasball()
            return localplayer.Character and localplayer.Character:FindFirstChild("Ball") ~= nil
        end
        
        autoGoalState.conn = runservice.RenderStepped:Connect(function()
            if not autoGoalState.enabled then return end
            pcall(function()
                if not ingame() then return end
                disablecollisions()
                stealball()
                if hasball() then
                    local root = localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart")
                    local goal = localplayer.Team.Name == "A" and bgoal or agoal
                    if root and goal then
                        root.CFrame = goal.CFrame
                        task.wait(0.185)
                        NET:FireServer(
                            buffer.fromstring(buffers["base"]),
                            {{"kick", 20, false, vector.create(0, 1, 0)}}
                        )
                    end
                end
            end)
        end)
    else
        if autoGoalState.conn then
            autoGoalState.conn:Disconnect()
            autoGoalState.conn = nil
        end
    end
end)

local alwaysBallState = {
    enabled = false,
    conn = nil
}

ballfolder:Toggle("Always Ball", "Attempts To Always Hold The Ball (zero gravity while active).", function()
    alwaysBallState.enabled = not alwaysBallState.enabled
    game.StarterGui:SetCore("SendNotification", {
        Title = "Always Ball",
        Text = alwaysBallState.enabled and "Enabled." or "Disabled.",
        Duration = 1
    })
    
    if alwaysBallState.enabled then
        workspace.Gravity = 0
        alwaysBallState.conn = coroutine.wrap(function()
            while alwaysBallState.enabled do
                local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local ball = workspace.Terrain:FindFirstChild("Ball")
                if root and ball then
                    root.CFrame = CFrame.new(ball.Position)
                end
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= game.Players.LocalPlayer and plr.Character then
                        local otherball = plr.Character:FindFirstChild("Ball")
                        local otherroot = plr.Character:FindFirstChild("HumanoidRootPart")
                        if otherball and otherroot and root then
                            root.CFrame = otherball.CFrame
                            NET:FireServer(
                                buffer.fromstring(buffers["base"]),
                                {{"tackle"}}
                            )
                        end
                    end
                end
                task.wait(0.1)
            end
        end)()
    else
        workspace.Gravity = 196.2
    end
end)

local flowPartData = {
    LocalPlayer = game:GetService("Players").LocalPlayer,
    ByteNetReliable = NET,
    flowPart = nil,
    flowActive = false,
    flowConnection = nil,
    originalCFrame = nil
}

flowPartData.flowPart = Instance.new("Part")
flowPartData.flowPart.Size = Vector3.new(150, 1, 150)
flowPartData.flowPart.Anchored = true
flowPartData.flowPart.CanCollide = true
flowPartData.flowPart.Position = Vector3.new(-782, 2500, 1262)
flowPartData.flowPart.Parent = workspace

ballfolder:Button("Get Flow (Req. Ball)", "Click To Attempt Getting Flow. Click Again To Cancel.", function()
    local char = flowPartData.LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if flowPartData.flowActive then
        flowPartData.flowActive = false
        if flowPartData.flowConnection then
            task.cancel(flowPartData.flowConnection)
            flowPartData.flowConnection = nil
        end
        if flowPartData.originalCFrame then
            root.CFrame = flowPartData.originalCFrame
        end
        return
    end

    flowPartData.flowActive = true
    flowPartData.originalCFrame = root.CFrame

    root.CFrame = flowPartData.flowPart.CFrame + Vector3.new(0, 5, 0)
    task.wait(0.67)

    flowPartData.flowConnection = task.spawn(function()
        local playerFolder = workspace:WaitForChild("characters"):WaitForChild(flowPartData.LocalPlayer.Name)
        local flow = playerFolder:WaitForChild("state"):WaitForChild("flow")
        local gks = {A = workspace.gks:FindFirstChild("A"), B = workspace.gks:FindFirstChild("B")}
        local preferredGK = nil
        local playerTeam = flowPartData.LocalPlayer.Team

        if playerTeam then
            local teamName = playerTeam.Name:lower()
            if teamName:find("a") or teamName == "red" then
                preferredGK = gks.A or gks.B
            elseif teamName:find("b") or teamName == "blue" then
                preferredGK = gks.B or gks.A
            end
        end

        if not preferredGK then
            game.StarterGui:SetCore("SendNotification", {
                Title = "oops!!! error!!",
                Text = "no AI gk found. cannot get flow.",
                Duration = 5
            })
            if flowPartData.originalCFrame and root and root.Parent then
                root.CFrame = flowPartData.originalCFrame
            end
            flowPartData.flowActive = false
            return
        end

        local function findBall()
            return workspace.Terrain:FindFirstChild("Ball")
                or char:FindFirstChild("Ball", true)
                or playerFolder:FindFirstChild("Ball", true)
        end

        local function iHaveBall(ball)
            return ball.Parent ~= nil
                and (ball:IsDescendantOf(char) or ball:IsDescendantOf(playerFolder))
        end

        local function waitForBall(ball, timeout, stopAtFullFlow)
            local start = os.clock()
            while flowPartData.flowActive and os.clock() - start < timeout do
                if stopAtFullFlow and flow.Value >= 100 then
                    return false
                end

                if not ball or not ball.Parent then
                    ball = findBall()
                elseif iHaveBall(ball) then
                    return true
                elseif ball.Parent == workspace.Terrain then
                    root.CFrame = ball.CFrame + Vector3.new(0, 5, 0)
                end

                task.wait(0.05)
            end
            return false
        end

        while flowPartData.flowActive and flow.Value < 100 do
            for i = 1, 25 do
                if not flowPartData.flowActive or flow.Value >= 100 then break end
                flowPartData.ByteNetReliable:FireServer(
                    buffer.fromstring(buffers["base"]),
                    { { "kick", 1, false, vector.create(0, 1, 0) } }
                )
                task.wait(0.15)
            end

            if not flowPartData.flowActive or flow.Value >= 100 then break end
            task.wait(0.5)

            local ball = findBall()

            local targetGK = preferredGK
            if targetGK then
                local targetCFrame = targetGK.PrimaryPart and targetGK.PrimaryPart.CFrame or targetGK:GetPivot()
                root.CFrame = targetCFrame + Vector3.new(0, 5, 0)
            end
            task.wait(0.25)

            for i = 1, 2 do
                if not flowPartData.flowActive or flow.Value >= 100 then break end
                flowPartData.ByteNetReliable:FireServer(
                    buffer.fromstring(buffers["base"]),
                    { { "kick", 1, false, vector.create(0, 1, 0) } }
                )
                task.wait(0.12)
            end

            if not flowPartData.flowActive or flow.Value >= 100 then break end
            task.wait(1)

            local got = waitForBall(ball, 30, true)
            if not got and flowPartData.flowActive and flow.Value < 100 then
            end

            if not flowPartData.flowActive or flow.Value >= 100 then break end
            task.wait(0.2)
            root.CFrame = flowPartData.flowPart.CFrame + Vector3.new(0, 5, 0)
            task.wait(0.5)
        end

        task.wait(0.5)

        if flowPartData.flowActive and flow.Value >= 100 then
            waitForBall(findBall(), 15, false)
        end

        task.wait(0.75)
        if flowPartData.flowActive and root and root.Parent and flowPartData.originalCFrame then
            root.CFrame = flowPartData.originalCFrame
        end

        flowPartData.flowActive = false
        flowPartData.flowConnection = nil
    end)
end)

local stealActive = false

ballfolder:Button("Steal Ball", "Repeatedly Attempts To Get The Ball. Click Again To Cancel.", function()
    local hrp = flowPartData.LocalPlayer.Character and flowPartData.LocalPlayer.Character.HumanoidRootPart
    if not hrp then return end

    if stealActive then
        stealActive = false
        return
    end

    stealActive = true

    spawn(function()
        while stealActive and hrp and hrp.Parent and not flowPartData.LocalPlayer.Character:FindFirstChild("Ball") do
            local ball = workspace.Terrain:FindFirstChild("Ball")
            if ball then
                hrp.CFrame = CFrame.new(ball.Position)
            end

            for _, p in game.Players:GetPlayers() do
                if not stealActive then break end
                if p ~= flowPartData.LocalPlayer then
                    local b = p.Character and p.Character:FindFirstChild("Ball")
                    if b then
                        hrp.CFrame = b.CFrame
                        flowPartData.ByteNetReliable:FireServer(buffer.fromstring(buffers["base"]), {{"tackle"}})
                    end
                end
            end

            task.wait(0.05)
        end

        stealActive = false
    end)
end)

ballfolder:Button("Bring Ball", "Steals The Ball Then Teleports Back. Click Again To Cancel.", function()
    local hrp = flowPartData.LocalPlayer.Character and flowPartData.LocalPlayer.Character.HumanoidRootPart
    if not hrp then return end

    if stealActive then
        stealActive = false
        return
    end

    stealActive = true

    spawn(function()
        local orig = hrp.CFrame

        while stealActive and hrp and hrp.Parent and not flowPartData.LocalPlayer.Character:FindFirstChild("Ball") do
            local ball = workspace.Terrain:FindFirstChild("Ball")
            if ball then
                hrp.CFrame = CFrame.new(ball.Position)
            end

            for _, p in game.Players:GetPlayers() do
                if not stealActive then break end
                if p ~= flowPartData.LocalPlayer then
                    local ob = p.Character and p.Character:FindFirstChild("Ball")
                    if ob then
                        hrp.CFrame = ob.CFrame
                        flowPartData.ByteNetReliable:FireServer(buffer.fromstring(buffers["base"]), {{"tackle"}})
                    end
                end
            end

            task.wait(0.05)
        end

        if stealActive and hrp and hrp.Parent and flowPartData.LocalPlayer.Character:FindFirstChild("Ball") then
            hrp.CFrame = orig
        end

        stealActive = false
    end)
end)


ballfolder:Button("Steal Ball (Aiku)", "Repeatedly Attempts To Get The Ball Via Reflex Tackle. Click Again To Cancel.", function()
    local hrp = flowPartData.LocalPlayer.Character and flowPartData.LocalPlayer.Character.HumanoidRootPart
    if not hrp then return end

    if stealActive then
        stealActive = false
        return
    end

    stealActive = true

    spawn(function()
        while stealActive and hrp and hrp.Parent and not flowPartData.LocalPlayer.Character:FindFirstChild("Ball") do
            local ball = workspace.Terrain:FindFirstChild("Ball")
            if ball then
                hrp.CFrame = CFrame.new(ball.Position)
            end

            for _, p in game.Players:GetPlayers() do
                if not stealActive then break end
                if p ~= flowPartData.LocalPlayer then
                    local b = p.Character and p.Character:FindFirstChild("Ball")
                    if b then
                        hrp.CFrame = b.CFrame
                        flowPartData.ByteNetReliable:FireServer(buffer.fromstring(buffers["base"]), {{"skill2"}})
                    end
                end
            end

            task.wait(0.05)
        end

        stealActive = false
    end)
end)

ballfolder:Button("Bring Ball (Aiku)", "Steals The Ball Via Reflex Tackle Then Teleports Back. Click Again To Cancel.", function()
    local hrp = flowPartData.LocalPlayer.Character and flowPartData.LocalPlayer.Character.HumanoidRootPart
    if not hrp then return end

    if stealActive then
        stealActive = false
        return
    end

    stealActive = true

    spawn(function()
        local orig = hrp.CFrame

        while stealActive and hrp and hrp.Parent and not flowPartData.LocalPlayer.Character:FindFirstChild("Ball") do
            local ball = workspace.Terrain:FindFirstChild("Ball")
            if ball then
                hrp.CFrame = CFrame.new(ball.Position)
            end

            for _, p in game.Players:GetPlayers() do
                if not stealActive then break end
                if p ~= flowPartData.LocalPlayer then
                    local ob = p.Character and p.Character:FindFirstChild("Ball")
                    if ob then
                        hrp.CFrame = ob.CFrame
                        flowPartData.ByteNetReliable:FireServer(buffer.fromstring(buffers["base"]), {{"skill2"}})
                    end
                end
            end

            task.wait(0.7)
        end

        if stealActive and hrp and hrp.Parent and flowPartData.LocalPlayer.Character:FindFirstChild("Ball") then
            hrp.CFrame = orig
        end

        stealActive = false
    end)
end)

nocd = maintab:Folder("No Cooldown Features.", Color3.fromRGB(169, 5, 255), true)
nocd:Label("No Cooldown Features. Please Note This Is Exclusive To PC.")

userInputService = game:GetService("UserInputService")
runService = game:GetService("RunService")
starterGui = game:GetService("StarterGui")
player = game.Players.LocalPlayer

dashState = {
    ForwardRushEnabled = false,
    SideDashEnabled = false,
    rushing = false,
    sideDashing = false,
    dashBindsSetup = false,
    lastForwardRush = 0,
    lastSideDash = 0,
    character = nil,
    humanoid = nil,
    rootPart = nil
}

forward_animm = "rbxassetid://79394729551302"
sideright_animm = "rbxassetid://114016332539655"
sideleft_animm = "rbxassetid://100207093237932"

function updateCharacter()
    dashState.character = player.Character or player.CharacterAdded:Wait()
    dashState.humanoid = dashState.character:WaitForChild("Humanoid")
    dashState.rootPart = dashState.character:WaitForChild("HumanoidRootPart")
end

updateCharacter()
player.CharacterAdded:Connect(updateCharacter)

function noty(title, text)
    starterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 2
    })
end

function isAnimationPlaying(animId)
    if not dashState.humanoid then return false end
    local tracks = dashState.humanoid:GetPlayingAnimationTracks()
    for _, track in ipairs(tracks) do
        if track.Animation and track.Animation.AnimationId == animId then
            return true
        end
    end
    return false
end

function isAnySideDashPlaying()
    return isAnimationPlaying(sideright_animm) or isAnimationPlaying(sideleft_animm)
end

function clearPreviousDashForces()
    if not dashState.rootPart then return end
    for _, child in ipairs(dashState.rootPart:GetChildren()) do
        if child:IsA("BodyVelocity") and child.Name:match("^DashBV_") then
            child:Destroy()
        end
    end
end

function forwardRush()
    if not dashState.ForwardRushEnabled or not dashState.humanoid or not dashState.rootPart then return end
    if tick() - dashState.lastForwardRush < 0.75 then return end
    if isAnimationPlaying(forward_animm) then return end

    dashState.lastForwardRush = tick()
    dashState.rushing = true
    clearPreviousDashForces()

    local animator = dashState.humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", dashState.humanoid)
    local animation = Instance.new("Animation")
    animation.AnimationId = forward_animm
    local animationTrack = animator:LoadAnimation(animation)
    animationTrack:Play()

    task.delay(0, function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://105267293181745"
        sound.Parent = dashState.rootPart
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end)

    local bv = Instance.new("BodyVelocity")
    bv.Name = "DashBV_" .. tostring(os.clock())
    bv.MaxForce = Vector3.new(2000000, 20000, 2000000)
    bv.P = 1500
    bv.Parent = dashState.rootPart

    local dashId = "ForwardRush_" .. tostring(os.clock())
    runService:BindToRenderStep(dashId, Enum.RenderPriority.Character.Value + 10, function()
        if not dashState.rootPart or not dashState.rootPart.Parent or not bv or not bv.Parent then
            runService:UnbindFromRenderStep(dashId)
            if bv then bv:Destroy() end
            dashState.rushing = false
            return
        end
        bv.Velocity = dashState.rootPart.CFrame.LookVector * 100
    end)

    task.delay(0.5, function()
        runService:UnbindFromRenderStep(dashId)
        if bv then bv:Destroy() end
        dashState.rushing = false
    end)
end

function sideDash(direction)
    if not dashState.SideDashEnabled or not dashState.humanoid or not dashState.rootPart then return end
    if tick() - dashState.lastSideDash < 0.3 then return end
    if isAnySideDashPlaying() then return end

    dashState.lastSideDash = tick()
    dashState.sideDashing = true
    clearPreviousDashForces()

    local targetAnimId = (direction == "right") and sideright_animm or sideleft_animm
    local animator = dashState.humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", dashState.humanoid)
    local animation = Instance.new("Animation")
    animation.AnimationId = targetAnimId
    local animationTrack = animator:LoadAnimation(animation)
    animationTrack:Play()

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://71212694698006"
    sound.Parent = dashState.rootPart
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)

    local bv = Instance.new("BodyVelocity")
    bv.Name = "DashBV_" .. tostring(os.clock())
    bv.MaxForce = Vector3.new(2000000, 20000, 2000000)
    bv.P = 1500
    bv.Parent = dashState.rootPart

    local dashId = "SideDash_" .. tostring(os.clock())
    runService:BindToRenderStep(dashId, Enum.RenderPriority.Character.Value + 10, function()
        if not dashState.rootPart or not dashState.rootPart.Parent or not bv or not bv.Parent then
            runService:UnbindFromRenderStep(dashId)
            if bv then bv:Destroy() end
            dashState.sideDashing = false
            return
        end
        local rightVec = dashState.rootPart.CFrame.RightVector
        bv.Velocity = rightVec * (direction == "right" and 75 or -75)
    end)

    task.delay(0.4, function()
        runService:UnbindFromRenderStep(dashId)
        if bv then bv:Destroy() end
        dashState.sideDashing = false
    end)
end

nocd:Toggle("No Rush Cooldown", "Emulates Having No Rush Cooldown.", function()
    dashState.ForwardRushEnabled = not dashState.ForwardRushEnabled
    noty("No Rush CD", dashState.ForwardRushEnabled and "Enabled." or "Disabled.")
end)

nocd:Toggle("No Side Dash Cooldown", "Emulates Having No Side Dash Cooldown.", function()
    dashState.SideDashEnabled = not dashState.SideDashEnabled
    noty("No Side Dash CD", dashState.SideDashEnabled and "Enabled." or "Disabled.")
end)

if not dashState.dashBindsSetup then
    dashState.dashBindsSetup = true
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F then
            forwardRush()
        elseif input.KeyCode == Enum.KeyCode.Q then
            local isA = userInputService:IsKeyDown(Enum.KeyCode.A)
            local isD = userInputService:IsKeyDown(Enum.KeyCode.D)
            if isD then
                sideDash("right")
            elseif isA then
                sideDash("left")
            end
        end
    end)
end

breakball = maintab:Folder("Break Ball Features.", Color3.fromRGB(169, 5, 255), true)
breakball:Label("Break Ball Features.")

breakball:Button("Break Ball (Player Method, Req. Ball)", "Breaks The Ball By Going Extremely High Up.", function()
    local baseplatePosition = Vector3.new(-190, 14864566, 492)
    local partSize = Vector3.new(10, 1, 10)
    local gap = 0

    for x = 0, 2 do
        for z = 0, 2 do
            local part = Instance.new("Part")
            part.Size = partSize
            part.Anchored = true
            part.Position = baseplatePosition + Vector3.new(x * (partSize.X + gap), 0, z * (partSize.Z + gap))
            part.Parent = workspace
        end
    end

    local lplr = game.Players.LocalPlayer
    local character = lplr.Character or lplr.CharacterAdded:Wait()

    character:WaitForChild("HumanoidRootPart").CFrame =
        CFrame.new(baseplatePosition + Vector3.new(0, 100000000000000, 0))
end)

breakball:Button("Break Ball (Ball Method, Req. Ball)", "Breaks The Ball By Kicking It Out Of Bounds.", function()
    local lplr = game.Players.LocalPlayer
    local character = lplr.Character or lplr.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local virtualInputManager = game:GetService("VirtualInputManager")

    if humanoidRootPart then
        local originalPosition = humanoidRootPart.Position
        humanoidRootPart.CFrame = CFrame.new(Vector3.new(-390, 475, 354))
        task.wait(0.3)
        virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait(0.1)
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        task.wait(0.3)
        humanoidRootPart.CFrame = CFrame.new(originalPosition)
    end
end)

breakball:Button("Permanent Break Ball (Req. Ball)", "Breaks The Ball By Placing It In The Void.", function()
    workspace.FallenPartsDestroyHeight = -50000
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(1, -49999, 1))
end)

ballmag = maintab2:Folder("Ball Magnet Features.", Color3.fromRGB(169, 5, 255), true)
ballmag:Label("Original Ball Magnet: Allows You To Grab The Ball From Further Away.")

local ballMagnetState = {
    active = false,
    conn = nil,
    lastFire = 0,
    fire_intrv = 0.01,
    radius = 1,
    hrp = nil,
    use_bind_held = false,
    vizEnabled = false,
    hitbox = nil,
    vizLoop = nil,
    bind_key = nil,
    input_conn = nil,
    toggle = nil,
    set_bind = nil,
    aliases = {
        ["0"] = "Zero", ["1"] = "One", ["2"] = "Two", ["3"] = "Three", ["4"] = "Four",
        ["5"] = "Five", ["6"] = "Six", ["7"] = "Seven", ["8"] = "Eight", ["9"] = "Nine",
        ctrl = "LeftControl", lctrl = "LeftControl", rctrl = "RightControl", control = "LeftControl",
        shift = "LeftShift", lshift = "LeftShift", rshift = "RightShift",
        alt = "LeftAlt", lalt = "LeftAlt", ralt = "RightAlt",
        caps = "CapsLock", esc = "Escape", enter = "Return", del = "Delete", ins = "Insert",
        bksp = "Backspace", pgup = "PageUp", pgdn = "PageDown",
        ["-"] = "Minus", ["="] = "Equals", [";"] = "Semicolon", ["'"] = "Quote",
        [","] = "Comma", ["."] = "Period", ["/"] = "Slash", ["\\"] = "BackSlash",
        ["["] = "LeftBracket", ["]"] = "RightBracket", ["`"] = "Backquote",
        num0 = "KeypadZero", num1 = "KeypadOne", num2 = "KeypadTwo", num3 = "KeypadThree",
        num4 = "KeypadFour", num5 = "KeypadFive", num6 = "KeypadSix", num7 = "KeypadSeven",
        num8 = "KeypadEight", num9 = "KeypadNine",
        mouse1 = "MouseButton1", m1 = "MouseButton1",
        mouse2 = "MouseButton2", m2 = "MouseButton2",
        mouse3 = "MouseButton3", m3 = "MouseButton3"
    }
}

ballMagnetState.set_bind = function(text)
    text = tostring(text or ""):match("^%s*(.-)%s*$"):lower()

    if text == "" or text == "none" or text == "clear" then
        ballMagnetState.bind_key = nil
        game.StarterGui:SetCore("SendNotification", {
            Title = "Ball Magnet Bind",
            Text = "Bind Is Currently Unbound.",
            Duration = 1
        })
        return
    end

    for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
        if item.Name:lower() == text or item.Name == ballMagnetState.aliases[text] then
            ballMagnetState.bind_key = item
            game.StarterGui:SetCore("SendNotification", {
                Title = "Ball Magnet Bind",
                Text = "Bind Set To: " .. item.Name .. ".",
                Duration = 2
            })
            return
        end
    end

    for _, item in ipairs(Enum.UserInputType:GetEnumItems()) do
        if item.Name:lower() == text or item.Name == ballMagnetState.aliases[text] then
            ballMagnetState.bind_key = item
            game.StarterGui:SetCore("SendNotification", {
                Title = "Ball Magnet Bind",
                Text = "Bind Set To: " .. item.Name .. ".",
                Duration = 2
            })
            return
        end
    end

    game.StarterGui:SetCore("SendNotification", {
        Title = "Ball Magnet Bind",
        Text = "Invalid Key Detected:'" .. text .. "'. Bind Was Not Bound.",
        Duration = 3
    })
end

ballMagnetState.toggle = function()
    ballMagnetState.active = not ballMagnetState.active

    game.StarterGui:SetCore("SendNotification", {
        Title = "Ball Magnet",
        Text = ballMagnetState.active and "Enabled." or "Disabled.",
        Duration = 1
    })

    if ballMagnetState.active then
        if ballMagnetState.conn then
            ballMagnetState.conn:Disconnect()
        end

        ballMagnetState.conn = RunService.Heartbeat:Connect(function()
            local radius = ballMagnetState.radius or 1
            if radius < 2 then return end

            local ball = Workspace.Terrain:FindFirstChild("Ball")
            if not ball then return end

            if ballMagnetState.hrp then
                local dist = (ballMagnetState.hrp.Position - ball.Position).Magnitude

                if ballMagnetState.use_bind_held then
                    if not ballMagnetState.bind_key then return end
                    if ballMagnetState.bind_key.EnumType == Enum.KeyCode then
                        if not game:GetService("UserInputService"):IsKeyDown(ballMagnetState.bind_key) then return end
                    elseif ballMagnetState.bind_key.EnumType == Enum.UserInputType then
                        if not game:GetService("UserInputService"):IsMouseButtonPressed(ballMagnetState.bind_key) then return end
                    else
                        return
                    end
                end

                if dist <= radius and (time() - ballMagnetState.lastFire) >= ballMagnetState.fire_intrv then
                    ballMagnetState.lastFire = time()
                    pcall(function()
                        NET:FireServer(buffer.fromstring(buffers["grabball"]))
                    end)
                end
            end
        end)
    else
        if ballMagnetState.conn then
            ballMagnetState.conn:Disconnect()
            ballMagnetState.conn = nil
        end
    end
end

ballmag:Toggle("Ball Magnet", "Ball Magnet, Uses Set Radius As Range.", function()
    ballMagnetState.toggle()
end)

ballmag:Textbox("Ball Magnet Bind", "Enter Key (Example: E, M1, Mouse2). Blank Or None Unbinds.", function(v)
    ballMagnetState.set_bind(v)
end)

ballmag:Slider("Ball Magnet Radius", 7, 7, 15, 0.5, function(v)
    ballMagnetState.radius = v
end)

ballmag:Toggle("Ball Magnet On Bind Held", "If Enabled, Ball Magnet Only Grabs While The Bind Key Is Held Down.", function()
    ballMagnetState.use_bind_held = not ballMagnetState.use_bind_held

    game.StarterGui:SetCore("SendNotification", {
        Title = "Ball Magnet On Bind Held",
        Text = ballMagnetState.use_bind_held and "Enabled." or "Disabled.",
        Duration = 1
    })
end)

local function setupCharacter(char)
    ballMagnetState.hrp = char:WaitForChild("HumanoidRootPart", 10)
end

if Players.LocalPlayer.Character then
    setupCharacter(Players.LocalPlayer.Character)
end

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    setupCharacter(char)
end)

ballmag:Toggle("Ball Magnet Radius Hitbox", "Shows The Magnet's Radius Hitbox.", function()
    ballMagnetState.vizEnabled = not ballMagnetState.vizEnabled

    game.StarterGui:SetCore("SendNotification", {
        Title = "Ball Magnet Radius Hitbox",
        Text = ballMagnetState.vizEnabled and "Enabled." or "Disabled.",
        Duration = 1
    })

    local function removeHitbox()
        if ballMagnetState.hitbox then
            ballMagnetState.hitbox:Destroy()
            ballMagnetState.hitbox = nil
        end
    end

    local function stopVizLoop()
        if ballMagnetState.vizLoop then
            ballMagnetState.vizLoop:Disconnect()
            ballMagnetState.vizLoop = nil
        end
    end

    if not ballMagnetState.vizEnabled then
        stopVizLoop()
        removeHitbox()
        return
    end

    stopVizLoop()

    ballMagnetState.vizLoop = RunService.Heartbeat:Connect(function()
        if not ballMagnetState.vizEnabled or not ballMagnetState.active then
            removeHitbox()
            return
        end

        local terrain = workspace:FindFirstChild("Terrain")
        local ball = terrain and terrain:FindFirstChild("Ball")
        if not ball or not ball:IsA("MeshPart") then
            removeHitbox()
            return
        end

        local radius = ballMagnetState.radius or 1
        if radius < 2 then
            removeHitbox()
            return
        end

        if not ballMagnetState.hitbox then
            local hitbox = Instance.new("Part")
            hitbox.Name = "BallMagnetRange"
            hitbox.Shape = Enum.PartType.Ball
            hitbox.Material = Enum.Material.Neon
            hitbox.Color = Color3.fromRGB(15, 155, 155)
            hitbox.Transparency = 0.9
            hitbox.CanCollide = false
            hitbox.CanTouch = false
            hitbox.CanQuery = false
            hitbox.Anchored = true
            hitbox.Massless = true
            hitbox.Parent = workspace
            ballMagnetState.hitbox = hitbox
        end

        local d = radius * 2
        local hitbox = ballMagnetState.hitbox
        hitbox.Size = Vector3.new(d, d, d)
        hitbox.CFrame = ball.CFrame
    end)
end)

autodrib = maintab2:Folder("Auto Dribble / Counter Features.", Color3.fromRGB(169, 5, 255), true)
autodrib:Label("Set The Auto-Counter Number To Your Character's Counter Move.")

local tick = tick
local ipairs = ipairs
local pairs = pairs
local unpack = unpack

local autoSkillState = {
    suppressNotifs = false,
    autoSkills = {
        ["toggleDribble"] = "dribble",
        ["toggleCounter1"] = "skill1",
        ["toggleCounter2"] = "skill2",
        ["toggleCounter3"] = "skill3",
        ["toggleCounter4"] = "skill4",
        ["toggleCounter5"] = "skill5",
        ["toggleTSpecial"] = "Tspecialer"
    },
    toggleDribble = false,
    toggleCounter1 = false,
    toggleCounter2 = false,
    toggleCounter3 = false,
    toggleCounter4 = false,
    toggleCounter5 = false,
    toggleTSpecial = false,
    keybindsEnabled = false,
    keybindSetup = false,
    cooldowns = {},
    showActiveCounters = false,
    useClosestTeammate = false,
    mCD = 65,
    fireRate = 0.05,
    playerCooldown = 0.33,
}

local player = Players.LocalPlayer
local localplayer = player
local playerGui = player:WaitForChild("PlayerGui")

local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local extraHud = playerGui:WaitForChild("ExtraHud")
local fpsCounter = extraHud:WaitForChild("FPSCounter")
local icon = fpsCounter:WaitForChild("icon")

local existingGui = playerGui:FindFirstChild("cubies")
if existingGui then
    existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "cubies"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local cubesizeeee = 15
local gapbetweenuisyesireallylikelongvariablenameshowdyouknow = 3           
local icantrememberwhatthisisgapxtho = 10    
local offsetfrompingui = 30 

local layoutCounters = {
    {key = "toggleDribble", labelText = "Z"},
    {key = "toggleCounter1", labelText = "1"},
    {key = "toggleCounter2", labelText = "2"},
    {key = "toggleCounter3", labelText = "3"},
    {key = "toggleCounter4", labelText = "4"},
    {key = "toggleCounter5", labelText = "5"},
    {key = "toggleTSpecial", labelText = "L"},
}

local visualCubeElements = {}

local positionCubes

local function updcounterui()
    if not autoSkillState.showActiveCounters then 
        screenGui.Enabled = false
        return 
    else
        screenGui.Enabled = true
        if #screenGui:GetChildren() == 0 then
            positionCubes()
            return
        end
    end

    for idx, configuration in ipairs(layoutCounters) do
        local frameElement = visualCubeElements[idx]
        if frameElement then
            local isToggledActive = autoSkillState[configuration.key]
            if isToggledActive then
                frameElement.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            else
                frameElement.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end

function positionCubes()
    local iconPos = icon.AbsolutePosition
    local iconSize = icon.AbsoluteSize
    
    local startX = iconPos.X
    local startY = iconPos.Y + iconSize.Y + offsetfrompingui
    
    screenGui:ClearAllChildren()
    visualCubeElements = {}
    
    for i, configuration in ipairs(layoutCounters) do
        local labelText = configuration.labelText
        local frame = Instance.new("Frame")
        frame.Name = "Cube_" .. labelText
        
        local posX = startX
        local posY = startY + ((i - 1) * (cubesizeeee + gapbetweenuisyesireallylikelongvariablenameshowdyouknow))
        
        frame.Size = UDim2.new(0, cubesizeeee, 0, cubesizeeee)
        frame.Position = UDim2.new(0, posX, 0, posY)
        frame.BorderSizePixel = 0
        frame.Parent = screenGui
        
        visualCubeElements[i] = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label_" .. labelText
        
        local labelX = posX + cubesizeeee + icantrememberwhatthisisgapxtho
        label.Size = UDim2.new(0, cubesizeeee, 0, cubesizeeee)
        label.Position = UDim2.new(0, labelX, 0, posY)
        label.Text = labelText
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.TextSize = 14
        label.Font = Enum.Font.SourceSansBold
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.TextYAlignment = Enum.TextYAlignment.Center
        label.Parent = screenGui
    end
    
    for idx, configuration in ipairs(layoutCounters) do
        local frameElement = visualCubeElements[idx]
        if frameElement then
            local isToggledActive = autoSkillState[configuration.key]
            if isToggledActive then
                frameElement.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            else
                frameElement.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end

task.wait(1)
if autoSkillState.showActiveCounters then
    positionCubes()
else
    screenGui.Enabled = false
end
icon:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
    if autoSkillState.showActiveCounters then
        positionCubes()
    end
end)

icon:GetPropertyChangedSignal("AbsolutePosition"):Connect(positionCubes)


local steal_anims = {
    "rbxassetid://109744655458082",
    "rbxassetid://113088324958896",
    "rbxassetid://96801747244950",
    "rbxassetid://130345228612384",
    "rbxassetid://82417661349987"
}

local function notify2(title, text, duration)
    if not autoSkillState.suppressNotifs then
        StarterGui:SetCore("SendNotification", { Title = title, Text = text, Duration = duration or 2 })
    end
end

local buffer = buffer or { fromstring = function(str) return str end }
local connections = {}
local byteNetReliable = NET

local function hasball()
    return localplayer.Character and localplayer.Character:FindFirstChild("Ball") ~= nil
end

local function getcteammate()
    local character = localplayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, closestDistSq = nil, math.huge
    local pPos = root.Position
    local pTeam = localplayer.Team
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= localplayer and plr.Team == pTeam and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local distSq = (pPos - hrp.Position).Magnitude ^ 2
                if distSq < closestDistSq then
                    closestDistSq = distSq
                    closest = plr
                end
            end
        end
    end
    return closest
end

local function fireSkill(skillName, targetPlayer)
    if not hasball() then return end
    local args
    if autoSkillState.useClosestTeammate and targetPlayer then
        local targetChar = targetPlayer.Character
        args = { buffer.fromstring(buffers["base"]), {{ skillName, targetChar }} }
    else
        args = { buffer.fromstring(buffers["base"]), {{ skillName }} }
    end
    byteNetReliable:FireServer(unpack(args))
end

local toggleKeys = {"toggleCounter1", "toggleCounter2", "toggleCounter3", "toggleCounter4", "toggleCounter5"}

function montackleanim(animator, targetPlayer)
    if connections[targetPlayer] and connections[targetPlayer].animLoop then
        connections[targetPlayer].animLoop:Disconnect()
    end

    local animConnection = animator.AnimationPlayed:Connect(function(animTrack)
        local isTackle = false
        for _, id in ipairs(steal_anims) do
            if animTrack.Animation.AnimationId == id then
                isTackle = true
                break
            end
        end
        if not isTackle then return end

        if targetPlayer.Team == localplayer.Team then return end

        local lastFire = 0
        local loopConn
        loopConn = game:GetService("RunService").Heartbeat:Connect(function()
            if not animTrack.IsPlaying or not hasball() then
                if loopConn then loopConn:Disconnect() end
                return
            end

            local now = tick()
            if autoSkillState.cooldowns[targetPlayer] and now - autoSkillState.cooldowns[targetPlayer] < autoSkillState.playerCooldown then
                return
            end
            if now - lastFire < autoSkillState.fireRate then return end
            
            lastFire = now

            local myChar = localplayer.Character
            local root = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local targetHRP = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

            if root and targetHRP and (root.Position - targetHRP.Position).Magnitude > autoSkillState.mCD then
                return
            end

            local closestTeammate = autoSkillState.useClosestTeammate and getcteammate() or nil

            for _, key in ipairs(toggleKeys) do
                if autoSkillState[key] then
                    fireSkill(autoSkillState.autoSkills[key], closestTeammate)
                end
            end
            if autoSkillState.toggleTSpecial then
                fireSkill(autoSkillState.autoSkills["toggleTSpecial"], closestTeammate)
            end
            if autoSkillState.toggleDribble then
                fireSkill(autoSkillState.autoSkills["toggleDribble"], closestTeammate)
            end

            autoSkillState.cooldowns[targetPlayer] = now
        end)

        connections[targetPlayer] = connections[targetPlayer] or {}
        connections[targetPlayer].animLoop = loopConn
    end)

    connections[targetPlayer] = connections[targetPlayer] or {}
    connections[targetPlayer].animatorConn = animConnection
end

function setupPlayer(plr)
    if plr == localplayer then return end

    local function onCharAdded(char)
        if connections[plr] then
            for _, conn in pairs(connections[plr]) do
                if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
            end
        end

        local humanoid = char:WaitForChild("Humanoid", 6)
        if not humanoid then return end

        local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 4)
        if animator then
            montackleanim(animator, plr)
        end
    end

    if plr.Character then onCharAdded(plr.Character) end
    plr.CharacterAdded:Connect(onCharAdded)
end

for _, plr in ipairs(Players:GetPlayers()) do
    setupPlayer(plr)
end

Players.PlayerAdded:Connect(setupPlayer)
Players.PlayerRemoving:Connect(function(plr)
    if connections[plr] then
        for _, conn in pairs(connections[plr]) do
            if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
        end
        connections[plr] = nil
    end
end)

function createAutoCounter(label, toggleKey)
    autodrib:Toggle(label, function()
        if autoSkillState.keybindsEnabled then
            notify2("calm error", "hey! dont try using gui toggles if u got keybinds on!!! 😡", 3)
            return
        end
        autoSkillState[toggleKey] = not autoSkillState[toggleKey]
        notify2(label, autoSkillState[toggleKey] and "Enabled." or "Disabled.", 3)
        updcounterui()
    end)
end

autodrib:Button("Auto Counter Info", "This Comes With Instructions On How To Use The Feature Below.", function()
    local StarterGui = game:GetService("StarterGui")

    StarterGui:SetCore("SendNotification", {
        Title = "Auto Counter Info",
        Text = "Dribble: Z, T-Special: L.",
        Duration = 10
    }) task.wait(0.5)
    StarterGui:SetCore("SendNotification", {
        Title = "Auto Counter Info",
        Text = "C Stands For Counter, C1: X, C2: C, C3: V, C4: N, C5: M.",
        Duration = 10
    })
end)

autodrib:Toggle("Show Active Auto Counters", "Shows Your Currently Toggled Auto Counters.", function()
    autoSkillState.showActiveCounters = not autoSkillState.showActiveCounters
    notify2("Status GUI", autoSkillState.showActiveCounters and "Enabled." or "Disabled.", 3)
    updcounterui()
end)

autodrib:Toggle("Toggle Keybinds", "Allows You To Toggle The Counters Using Binds.", function()
    autoSkillState.keybindsEnabled = not autoSkillState.keybindsEnabled
    notify2("Keybinds", autoSkillState.keybindsEnabled and "Enabled." or "Disabled.", 3)
    updcounterui()
end)

autodrib:Toggle("Use Closest Teammate", "When Enabled, Skills Will Target Your Closest Teammate (Pass Based Counters Only).", function()
    autoSkillState.useClosestTeammate = not autoSkillState.useClosestTeammate
    notify2("Closest Teammate", autoSkillState.useClosestTeammate and "Enabled." or "Disabled.", 3)
end)

autodrib:Slider("Counter Radius", 65, 25, 75, 1, function(v)
    autoSkillState.mCD = v
end)

createAutoCounter("Auto Dribble", "toggleDribble")
createAutoCounter("Auto Counter (Move One)", "toggleCounter1")
createAutoCounter("Auto Counter (Move Two)", "toggleCounter2")
createAutoCounter("Auto Counter (Move Three)", "toggleCounter3")
createAutoCounter("Auto Counter (Move Four)", "toggleCounter4")
createAutoCounter("Auto Counter (Move Five)", "toggleCounter5")
createAutoCounter("T Special", "toggleTSpecial")

if not autoSkillState.keybindSetup then
    autoSkillState.keybindSetup = true
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or not autoSkillState.keybindsEnabled then return end
        local keyMap = {
            [Enum.KeyCode.Z] = {"toggleDribble", "Auto Dribble"},
            [Enum.KeyCode.X] = {"toggleCounter1", "Auto Counter (Move One)"},
            [Enum.KeyCode.C] = {"toggleCounter2", "Auto Counter (Move Two)"},
            [Enum.KeyCode.V] = {"toggleCounter3", "Auto Counter (Move Three)"},
            [Enum.KeyCode.N] = {"toggleCounter4", "Auto Counter (Move Four)"},
            [Enum.KeyCode.M] = {"toggleCounter5", "Auto Counter (Move Five)"},
            [Enum.KeyCode.L] = {"toggleTSpecial", "T Special"}
        }
        local mapping = keyMap[input.KeyCode]
        if mapping then
            local toggleKey, label = unpack(mapping)
            autoSkillState[toggleKey] = not (autoSkillState[toggleKey] or false)
            notify2(label, autoSkillState[toggleKey] and "Enabled." or "Disabled.", 3)
            updcounterui()
        end
    end)
end

autogoal = maintab:Folder("Auto Goal Features.", Color3.fromRGB(169, 5, 255), true)
autogoal:Label("Auto Goal: Automatically Does Auto Goal Steps Instantly, Use In 5v5.")

autogoal:Button("Isagi U-20 Goal", "Attempts To Do Isagi's U-20 Auto Goal By Teleporting To The Designated Area.", function()
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = plr.Character.HumanoidRootPart
        
        if plr.Team == game.Teams:FindFirstChild("A") then
            hrp.CFrame = CFrame.new(-536, 3, 999)
        elseif plr.Team == game.Teams:FindFirstChild("B") then
            hrp.CFrame = CFrame.new(-537, 3, 1549)
        end
        task.wait(0.2)
        NET:FireServer(
            buffer.fromstring(buffers["base"]),
            { { "skill3"} }
        )
    end
end)

autogoal:Button("Nagi Dream Goal", "Attempts To Do Nagi's Control Move Auto Goal In Flow.", function()
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = plr.Character.HumanoidRootPart
        
        if plr.Team == game.Teams:FindFirstChild("A") then
            hrp.CFrame = CFrame.new(-459, 3, 862)
        elseif plr.Team == game.Teams:FindFirstChild("B") then
            hrp.CFrame = CFrame.new(-611, 3, 1682) * CFrame.Angles(0, math.rad(180), 0)
        end
        task.wait(0.2)
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        task.wait(0.2)
        NET:FireServer(
            buffer.fromstring(buffers["base"]),
            { { "skill2", true } }
        )
    end
end)

autogoal:Button("Barou Devour Goal", "Attempts To Do Barou's Devour Auto Goal By Teleporting Behind Two Enemy Players.", function()
    local plr = game.Players.LocalPlayer

    local function countEnemyTeamMembers()
        local op = game.Teams:FindFirstChild("A")
        if plr.Team == game.Teams:FindFirstChild("A") then
            op = game.Teams:FindFirstChild("B")
        end
        local count = 0
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Team == op then
                count += 1
            end
        end
        return count
    end
    
    local function getTwoRandomEnemies()
        local enemies = {}
        local op = game.Teams:FindFirstChild("A")
        if plr.Team == game.Teams:FindFirstChild("A") then
            op = game.Teams:FindFirstChild("B")
        end
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= plr and player.Team == op then
                table.insert(enemies, player)
            end
        end
        
        for i = #enemies, 2, -1 do
            local j = math.random(1, i)
            enemies[i], enemies[j] = enemies[j], enemies[i]
        end

        return enemies[1], enemies[2]
    end
    
    if countEnemyTeamMembers() >= 2 then
        local p1, p2 = getTwoRandomEnemies()
        if not p1 or not p2 then return end

        local function tpToPlayer(targetPlayer)
            local char = plr.Character or plr.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            local targetRoot = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

            if root and targetRoot then
                root.CFrame = targetRoot.CFrame
            end
        end

        tpToPlayer(p1)
        task.wait(0.3)
        tpToPlayer(p2)
        
        task.wait(0.3)
        
        if plr.Team == game.Teams:FindFirstChild("A") then
            plr.Character.HumanoidRootPart.Position = Vector3.new(-625, 3, 925)
        elseif plr.Team == game.Teams:FindFirstChild("B") then
            plr.Character.HumanoidRootPart.Position = Vector3.new(-588, 3, 1643)
        end
    end
end)

local add = maintab:Folder("Fun Features.", Color3.fromRGB(169, 5, 255), true)
add:Label("Fun Features: Pretty Fun Features I'd Say.")

local AnimationId = "rbxassetid://106978014114973"
local safety = Vector3.new(-540, 3, 1274)
mapFolmain = workspace.map.map.sanam.main
local floorAie = workspace.map.map.sanam.main.Size

workspace.map.map.sanam.main.Size = Vector3.new(floorAie.X, 2, floorAie.Z)
workspace.map.map.sanam.main.Position += Vector3.new(0, (floorAie.Y - 2) / 2, 0)

invisState = {
    active = false,
    character = nil,
    humanoid = nil,
    animationTrack = nil
}

local function stopInvisibility()
    if invisState.animationTrack then
        invisState.animationTrack:Stop()
        invisState.animationTrack:Destroy()
        invisState.animationTrack = nil
    end
    if invisState.humanoid then
        invisState.humanoid.CameraOffset = Vector3.new(0, 0, 0)
    end
end

local function startInvisibility()
    stopInvisibility()
    if not invisState.humanoid then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = AnimationId
    local track = invisState.humanoid:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Action4
    track.Looped = false
    track:Play(0)
    track:AdjustSpeed(0)
    invisState.animationTrack = track
end

local function setupCharacter(char)
    invisState.character = char
    invisState.humanoid = char:WaitForChild("Humanoid", 5)

    if invisState.active then
        task.wait(0.1)
        startInvisibility()
    end
end
RunService.RenderStepped:Connect(function()
    if not invisState.active then return end
    if not invisState.humanoid or not invisState.character then return end

    invisState.humanoid.CameraOffset = Vector3.new(0, 0, 0)

    local rootPart = invisState.character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local rayOrigin = rootPart.Position
        local rayDirection = Vector3.new(0, -500, 0)
        local raycastResult = Workspace:Raycast(rayOrigin, rayDirection)

        if not raycastResult then
            rootPart.CFrame = CFrame.new(safety)
            return
        end
        
        local floorTop = mapFolmain.Position.Y + mapFolmain.Size.Y / 2
        if rootPart.Position.Y > floorTop + 20 then
            local _, yaw, _ = rootPart.CFrame:ToOrientation()
            rootPart.CFrame = CFrame.new(rootPart.Position.X, floorTop + 3, rootPart.Position.Z) * CFrame.Angles(0, yaw, 0)
            rootPart.AssemblyLinearVelocity = Vector3.zero
            rootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end
end)

player.CharacterAdded:Connect(setupCharacter)

if player.Character then
    setupCharacter(player.Character)
end

add:Toggle("Invisibility (Method: Animation)", "Makes You Almost Fully Invisible To Other Players Using An Animation.", function(v)
    invisState.active = v
    if v then
        startInvisibility()
    else
        stopInvisibility()
    end
end)

passingState = {
    InfiniteRangePassing = false,
    busy = false
}

local plr = Players.LocalPlayer
local mouse = plr:GetMouse()
local Camera = workspace.CurrentCamera
local passpass = NET

local keyToSkill = {
    [Enum.KeyCode.One]   = "skill1",
    [Enum.KeyCode.Two]   = "skill2",
    [Enum.KeyCode.Three] = "skill3",
    [Enum.KeyCode.Four]  = "skill4",
}

local function getClosestPlayerToCursor()
    local mousePos = UserInputService:GetMouseLocation()
    local closestChar, closestDist = nil, math.huge
    local char, hum, hrp, screenPos, onScreen, dist

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr and p.Team == plr.Team then
            char = p.Character
            if not char then continue end
            hum = char:FindFirstChild("Humanoid")
            hrp = char:FindFirstChild("HumanoidRootPart")

            if hum and hrp and hum.Health > 0 then
                screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestChar = char
                    end
                end
            end
        end
    end

    return closestChar
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if not passingState.InfiniteRangePassing then return end
    if passingState.busy then return end
    if plr.Team == game.Teams.lobby then return end

    local skillName = keyToSkill[input.KeyCode]
    if not skillName then return end

    local targetChar = getClosestPlayerToCursor()
    if not targetChar then return end

    passingState.busy = true

    passpass:FireServer(
        buffer.fromstring(buffers["base"]),
        {
            {
                skillName,
                targetChar
            }
        }
    )

    task.delay(0.1, function()
        passingState.busy = false
    end)
end)

add:Toggle("Infinite Range Passing", "Pass To The Closest Teammate To Your Mouse From Anywhere.", function(v)
    passingState.InfiniteRangePassing = v
    StarterGui:SetCore("SendNotification", {
        Title = "Infinite Pass",
        Text = v and "Enabled." or "Disabled.",
        Duration = 5
    })
end)

add:Toggle("Auto Break Server (Demon's Contract)", "When Using Demon's Contract With Kunigami, It Will Automatically Reset.", function(v)
    local Players = game:GetService("Players")
    local StarterGui = game:GetService("StarterGui")

    getgenv().AutoBreakServerEnabled = v

    StarterGui:SetCore("SendNotification", {
        Title = "Auto Break Server",
        Text = v and "Enabled." or "Disabled.",
        Duration = 3
    })

    if getgenv().AutoBreakServerConnection then
        getgenv().AutoBreakServerConnection:Disconnect()
        getgenv().AutoBreakServerConnection = nil
    end

    getgenv().DemonContractActive = false

    if not v then return end

    local function hookCharacter(char)
        local humanoid = char:WaitForChild("Humanoid")
        local animator = humanoid:WaitForChild("Animator")

        if getgenv().AutoBreakServerConnection then
            getgenv().AutoBreakServerConnection:Disconnect()
        end

        getgenv().AutoBreakServerConnection = animator.AnimationPlayed:Connect(function(track)
            if not getgenv().AutoBreakServerEnabled or getgenv().DemonContractActive then
                return
            end

            if track.Animation and track.Animation.AnimationId == "rbxassetid://91509980165830" then
                getgenv().DemonContractActive = true

                task.delay(2, function()
                    getgenv().DemonContractActive = false

                    local charNow = Players.LocalPlayer.Character
                    if getgenv().AutoBreakServerEnabled and charNow then
                        local hum = charNow:FindFirstChildOfClass("Humanoid")
                        if hum then
                            hum.Health = 0
                        end
                    end
                end)
            end
        end)
    end

    if Players.LocalPlayer.Character then
        hookCharacter(Players.LocalPlayer.Character)
    end

    Players.LocalPlayer.CharacterAdded:Connect(hookCharacter)
end)

add:Button("Steal Screen Time (funny)", "Click Z To Disable, Steals Screen Time.", function()
    local plr = game.Players.LocalPlayer
    local char = plr.Character
    local cam = workspace.CurrentCamera

    local stopped = false

    game.UserInputService.InputBegan:Connect(function(key, bg)
        if bg then return end

        if key.KeyCode == Enum.KeyCode.Z then
            stopped = true
        end
    end)

    local ogPos = plr.Character.HumanoidRootPart.Position
    local incut = false
    local anim = nil
    local bg = nil
    local bp = nil

    local function CleanupFloat()
        if bg then bg:Destroy() bg = nil end
        if bp then bp:Destroy() bp = nil end
    end

    local con
    con = game["Run Service"].RenderStepped:Connect(function()
        if stopped then
            CleanupFloat()
            con:Disconnect()
            return
        end

        if char ~= plr.Character then char = plr.Character end
        local hum = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")

        if cam.CameraType == Enum.CameraType.Scriptable then
            if incut == false then
                anim = hum.Animator:LoadAnimation(game:GetService("ReplicatedStorage").emoteWiki.myanimefans.Animation)
                anim.Looped = true
                anim:Play()
                anim:AdjustSpeed(4)

                bg = Instance.new("BodyGyro")
                bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bg.P = 10000
                bg.D = 500
                bg.Parent = root

                bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.P = 10000
                bp.D = 500
                bp.Parent = root
            end
            incut = true

            local targetCFrame = cam.CFrame * CFrame.new(0, -1.3, -2.3) * CFrame.Angles(0, math.rad(180), 0)
            bp.Position = targetCFrame.Position
            bg.CFrame = targetCFrame
        else
            if incut == true then
                incut = false
                if anim then
                    anim:Stop()
                end
                CleanupFloat()
                root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                root.CFrame = CFrame.new(ogPos)
                root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
            ogPos = root.Position
        end
    end)
end)

add:Button("Goalkeeper Anywhere (Rejoin To Disable.)", "Allows You To Do GK Side Dashes Instead!", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Goalkeeper Anywhere",
        Text = "If You Don't See GK Animations, Your Executor Doesn't Support The Required Functions.",
        Duration = 10,
        Button1 = "ok my executor is fine",
        Button2 = "aw man my executor sucks"
    })

    local module = game:GetService("ReplicatedStorage").util.actionUtil
    local env = require(module)

    local oldfunc
    oldfunc = hookfunction(env.checkGK, function (...)
        return true
    end)
end)

oth = maintab:Folder("Other Blatant Features.", Color3.fromRGB(169, 5, 255), true)
oth:Label("Other Blatant Features: It's In The Name.")

local blatantState = {
    enabled = false,
    loopConnection = nil
}

local rs = game:GetService("RunService")
local sg = game:GetService("StarterGui")
local ws = game:GetService("Workspace")

local function setCollide(state)
    local a = ws.map.gkbarriar.Abarriar
    local b = ws.map.gkbarriar.Bbarriar
    local ag = ws.map.Agoal
    local bg = ws.map.Bgoal

    if a then a.CanCollide = state end
    if b then b.CanCollide = state end
    if ag then ag.CanCollide = state end
    if bg then bg.CanCollide = state end
end

oth:Toggle("Blatant Mode", "Removes Collisions With Goal Boxes.", function()
    blatantState.enabled = not blatantState.enabled
    if blatantState.enabled then
        blatantState.loopConnection = rs.Heartbeat:Connect(function() setCollide(false) end)
        sg:SetCore("SendNotification",{Title="Blatant Mode",Text="Enabled.",Duration=3})
    else
        if blatantState.loopConnection then blatantState.loopConnection:Disconnect() blatantState.loopConnection = nil end
        setCollide(true)
        sg:SetCore("SendNotification",{Title="Blatant Mode",Text="Disabled.",Duration=3})
    end
end)

local nostunState = {
    enabled = false
}

local nostunPlayer = game.Players.LocalPlayer

local function applyNoStun()
    if not nostunState.enabled then return end
    local c = nostunPlayer.Character
    if not c then return end
    local h = c:FindFirstChild("Humanoid")
    if h then
        h.WalkSpeed = 40
        h.JumpPower = 50
        h:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
end

local function setupCharacter(char)
    if nostunState.enabled then
        applyNoStun()
    end
end

nostunPlayer.CharacterAdded:Connect(setupCharacter)

if nostunPlayer.Character then
    setupCharacter(nostunPlayer.Character)
end

oth:Toggle("No Stun", "Overrides The Stunned State So You Can Move.", function(v)
    nostunState.enabled = v
    if v then
        game.StarterGui:SetCore("SendNotification", {Title="No Stun", Text="Enabled"})
        applyNoStun()
    else
        game.StarterGui:SetCore("SendNotification", {Title="No Stun", Text="Disabled"})
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if nostunState.enabled then
        applyNoStun()
    end
end)

local brickSpamState = {
    running = false
}

oth:Toggle("Spam Brick Sound (5v5 + GK Only.)", "This SHOULD Be Self Explanatory.", function(state)
    brickSpamState.running = state

    if brickSpamState.running then
        sg:SetCore("SendNotification", {
            Title = "Brick Spam";
            Text = "Enabled.";
            Duration = 3
        })

        task.spawn(function()
            local char = game.Players.LocalPlayer.Character
            local root = char:WaitForChild("HumanoidRootPart")

            local team = game.Players.LocalPlayer.Team and game.Players.LocalPlayer.Team.Name
            local targetPos

            if team == "A" then
                targetPos = Vector3.new(-510, 3, 1706)
            elseif team == "B" then
                targetPos = Vector3.new(-559, 3, 843)
            end

            if targetPos then
                while brickSpamState.running do
                    root.CFrame = CFrame.new(targetPos)
                    task.wait(0.1)

                    local args = {
                        buffer.fromstring(buffers["base"]),
                        {
                            {
                                "kick",
                                27,
                                false,
                                vector.create(0, 1, 0)
                            }
                        }
                    }
                    NET:FireServer(unpack(args))

                    task.wait(0.05)
                end
            end
        end)
    else
        sg:SetCore("SendNotification", {
            Title = "Brick Spam";
            Text = "Disabled.";
            Duration = 3
        })
    end
end)

if not workspace:FindFirstChild("ddddegrdgdhgrgtedrhgdrtg") then
    local p = Instance.new("Part")
    p.Name = "ddddegrdgdhgrgtedrhgdrtg"
    p.Size = Vector3.new(1000, 1, 1000)
    p.Transparency = 1
    p.Anchored = true
    p.CanCollide = true
    p.Position = Vector3.new(5000, 750, 5000)
    p.Parent = workspace
end

murder = maintab:Folder("''This Isn't Soccer Anymore''! Features.", Color3.fromRGB(169, 5, 255), true)
murder:Label("Evil Features: You Are Killing People In A Soccer Match??")

attackmode = "KILL, KILL, KILL!"
youareamurderer = false
originalCFrame = nil

local connection

murder:Button("Evil Info", "This Comes With Instructions On How To Use The Feature Below.", function()
    StarterGui:SetCore("SendNotification", {
        Title = "Evil Info",
        Text = "KILL, KILL, KILL! will kill the victim.",
        Duration = 10
    }) 
    task.wait(0.5)
    StarterGui:SetCore("SendNotification", {
        Title = "Evil Info",
        Text = "New Commentator! will send the victim to the commentator box.",
        Duration = 10
    })
end)

grabz = {
    "rbxassetid://123994829903056",
    "rbxassetid://73092083880817",
    "rbxassetid://114866946968143",
    "rbxassetid://88690614253524",
    "rbxassetid://107389719253201",
	"rbxassetid://133382731392749"
}

function isgrabbing(animTrack)
    if not animTrack.Animation then return false end
    local animId = animTrack.Animation.AnimationId
    for _, id in ipairs(grabz) do
        if animId == id or animId:find(id) then
            return true
        end
    end
    return false
end

function killthemNOW()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    local character = game:GetService("Players").LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    
    connection = humanoid.AnimationPlayed:Connect(function(animTrack)
        if not youareamurderer then return end
        if not isgrabbing(animTrack) then return end
        
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local originalCFrame = root.CFrame
        task.wait(0.2)
        
        local targetPos
        if attackmode == "KILL, KILL, KILL!" then
            targetPos = Vector3.new(5000, 760, 5000)
        elseif attackmode == "New Commentator?" then
            targetPos = Vector3.new(-6, 2, 3237)
        elseif attackmode == "PrisonA" then
            targetPos = Vector3.new(-512, 3, 1731)
        elseif attackmode == "PrisonB" then
            targetPos = Vector3.new(-558, 3, 816)
        else
            return
        end
        
        local isAnimPlaying = true
        local teleportLoop = game:GetService("RunService").Heartbeat:Connect(function()
            if isAnimPlaying and root and root.Parent then
                root.CFrame = CFrame.new(targetPos)
            end
        end)
        
        local killConn
        killConn = animTrack.Stopped:Connect(function()
            if killConn then killConn:Disconnect() end
            isAnimPlaying = false
            if teleportLoop then teleportLoop:Disconnect() end
            if root and root.Parent then
                root.CFrame = originalCFrame
            end
        end)
        
        task.delay(10, function()
            if killConn then killConn:Disconnect() end
            if teleportLoop then teleportLoop:Disconnect() end
            isAnimPlaying = false
        end)
    end)
end

murder:Toggle("THIS ISN'T SOCCER ANYMORE!", "When Using Certain Grab Moves, This Will DEVOUR The Victim.", function(state)
    youareamurderer = state
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "evil ass soccer mode",
        Text = youareamurderer and "you're a dead man!! im sending you straight to hell!" or "you're a good man arthur morgan.",
        Duration = 4
    })

    if youareamurderer and game:GetService("Players").LocalPlayer.Character then
        killthemNOW()
    end
end)

murder:Dropdown("Attack Method", {"KILL, KILL, KILL!", "New Commentator?", "PrisonA", "PrisonB"}, function(v) 
    attackmode = v
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Attack Method",
        Text = "Attack Method: " .. attackmode,
        Duration = 3
    })
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    task.wait(1)
    
    if youareamurderer then
        killthemNOW()
    end
end)

if game:GetService("Players").LocalPlayer.Character then
    killthemNOW()
end

th = maintab:Folder("Trap Helper.", Color3.fromRGB(169, 5, 255), true)
th:Label("Trap Helper: Automatically Moves Toward Ball During Trap Moves.")

local trapAnims = {
    "rbxassetid://73387016994281",
    "rbxassetid://101043441232233",
    "rbxassetid://96593185131882",
    "rbxassetid://116422938520670",
    "rbxassetid://90734196141468",
    "rbxassetid://85349589701503",
    "rbxassetid://120351399679118"
}

local trapState = {
    enabled = false,
    detected = false,
    armTime = 0,
    active = false,
    track = nil,
    ball = nil,
    conn = nil,
    alignOri = nil
}

local armWindow = 0.35
local trapMaxDist = 50
local trapSpeed = 50

local function findBall()
    local terrain = workspace.Terrain
    if terrain then
        local b = terrain:FindFirstChild("Ball")
        if b and b:IsA("BasePart") then return b end
    end
end

local function cleanupTrap()
    if trapState.conn then 
        trapState.conn:Disconnect() 
        trapState.conn = nil 
    end
    trapState.active = false
    trapState.track = nil
    trapState.ball = nil
    if trapState.alignOri then 
        trapState.alignOri:Destroy() 
        trapState.alignOri = nil 
    end
end

local function startLerpToBall(hrp, ball, track)
    if (ball.Position - hrp.Position).Magnitude > trapMaxDist then return end

    trapState.ball = ball
    trapState.track = track
    trapState.active = true

    if trapState.alignOri then trapState.alignOri:Destroy() end
    local ao = Instance.new("AlignOrientation")
    ao.Name = "TrapFaceAlign"
    ao.Mode = Enum.OrientationAlignmentMode.OneAttachment
    ao.Attachment0 = hrp:FindFirstChild("RootAttachment") or Instance.new("Attachment", hrp)
    ao.RigidityEnabled = false
    ao.MaxTorque = 20000
    ao.Responsiveness = 1000
    ao.Parent = hrp
    trapState.alignOri = ao

    if trapState.conn then trapState.conn:Disconnect() end

    trapState.conn = RunService.RenderStepped:Connect(function(dt)
        if not trapState.track or not trapState.track.IsPlaying then
            cleanupTrap()
            return
        end

        if not trapState.ball or not trapState.ball.Parent then
            cleanupTrap()
            return
        end

        local cur = hrp.Position
        local tgt = trapState.ball.Position - Vector3.new(0, 3, 0)
        local dir = tgt - cur
        local dist = dir.Magnitude

        if dist > trapMaxDist or dist < 0.5 then
            cleanupTrap()
            return
        end

        local move = dir.Unit * (trapSpeed * dt)
        hrp.CFrame = CFrame.new(cur + move) * hrp.CFrame.Rotation

        local ballFlat = Vector3.new(trapState.ball.Position.X, hrp.Position.Y, trapState.ball.Position.Z)
        if trapState.alignOri then
            trapState.alignOri.CFrame = CFrame.lookAt(hrp.Position, ballFlat)
        end
    end)

    track.Stopped:Connect(function()
        cleanupTrap()
    end)
end

local function hookTraps(char)
    local animator = char:WaitForChild("Humanoid"):WaitForChild("Animator")
    local hrp = char:WaitForChild("HumanoidRootPart")

    animator.AnimationPlayed:Connect(function(track)
        if not trapState.enabled then return end
        if not track.Animation then return end

        local id = track.Animation.AnimationId
        for _, animId in ipairs(trapAnims) do
            if id == animId and os.clock() >= trapState.armTime then
                trapState.detected = true

                task.delay(0.05, function()
                    if track.IsPlaying then
                        local ball = findBall()
                        if ball then
                            startLerpToBall(hrp, ball, track)
                        end
                    end
                end)

                break
            end
        end
    end)
end

local function setupCharacter(char)
    hookTraps(char)
end

if player.Character then
    setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    local code = input.KeyCode.Value
    if code < Enum.KeyCode.One.Value or code > Enum.KeyCode.Five.Value then return end

    if trapState.active then return end

    trapState.armTime = os.clock()
    trapState.detected = false

    task.delay(armWindow, function()
        if not trapState.detected then return end

        local char = player.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local ball = findBall()
        if ball then
            local tracks = char.Humanoid.Animator:GetPlayingAnimationTracks()
            for _, track in ipairs(tracks) do
                if track.Animation and table.find(trapAnims, track.Animation.AnimationId) then
                    startLerpToBall(hrp, ball, track)
                    break
                end
            end
        end
    end)
end)

th:Toggle("Trap Helper", function(state)
    trapState.enabled = state
    StarterGui:SetCore("SendNotification", {
        Title = "Trap Helper",
        Text = state and "Enabled." or "Disabled.",
        Duration = 1
    })
end)

th:Slider("Trap Helper Max Distance", 50, 50, 200, 1, function(v)
    trapMaxDist = v
end)

th:Slider("Trap Helper Speed", 50, 50, 1000, 1, function(v)
    trapSpeed = v
end)

local d = maintab:Folder("Distance Move Buffs.", Color3.fromRGB(169, 5, 255), true)
d:Label("Distance Move Buffs: Buffs Movement Based Moves.")

local player = Players.LocalPlayer
local rs = RunService

local DashConfigs = {
    Tackle = {
        animId = "rbxassetid://109744655458082",
        sliderVar = "tackleDist",
        duration = 0.4,
        cooldown = 0.15,
        wait = 0
    },
    Rush = {
        animId = "rbxassetid://79394729551302",
        sliderVar = "rushDist",
        duration = 0.4,
        cooldown = 0.15,
        wait = 0.15
    },
    GKDash = {
        animId = "rbxassetid://90537955276413",
        sliderVar = "gkDist",
        duration = 0.55,
        cooldown = 0.15,
        wait = 0.05
    },
    Naruhaya = {
        animId = "rbxassetid://82240286756891",
        sliderVar = "naruhayaDist",
        duration = 0.45,
        cooldown = 0.15,
        wait = 0.33
    },
    Raumdeuter = {
        animIds = {["rbxassetid://81582265162782"] = true},
        sliderVar = "raumDist",
        duration = 0.55,
        cooldown = 0.15,
        wait = 0.1
    },
    DraconicRush = {
        animId = "rbxassetid://95359966795185",
        sliderVar = "dracDist",
        duration = 0.625,
        cooldown = 0.15,
        wait = 0.175
    },
    StepOvers = {
        animId = "rbxassetid://84063609284472",
        sliderVar = "stepDist",
        duration = 0.15,
        cooldown = 0.15,
        wait = 1.275
    },
    KaiserOffBall = {
        animId = "rbxassetid://110660551661470",
        sliderVar = "kaiserDist",
        duration = 0.55,
        cooldown = 0.15,
        wait = 0.15
    },
    OcclusionBreak = {
        animId = "rbxassetid://116181317759538",
        sliderVar = "occlusionDist",
        duration = 1.0,
        cooldown = 0.15,
        wait = 0.2
    },
    DivingHeader = {
        animId = "rbxassetid://91506202951715",
        sliderVar = "divingDist",
        duration = 0.35,
        cooldown = 0.15,
        wait = 0.05
    },
    ReflexTackle = {
        animId = "rbxassetid://113088324958896",
        sliderVar = "reflexDist",
        duration = 0.2,
        cooldown = 0.15,
        wait = 0
    },
    RazorBreak = {
        animIds = {
            ["rbxassetid://131681055843039"] = "Front",
            ["rbxassetid://114963791456755"] = "Left",
            ["rbxassetid://115966658644919"] = "Right",
            ["rbxassetid://122404546980503"] = "Back",
            ["rbxassetid://70754845580062"] = "RightBack",
            ["rbxassetid://128061536134952"] = "LeftBack",
            ["rbxassetid://71501932579824"] = "FrontRight",
            ["rbxassetid://96632954418440"] = "FrontLeft",
            ["rbxassetid://70397727954557"] = "Front",
            ["rbxassetid://131196726012273"] = "Front"
        },
        sliderVar = "razorDist",
        duration = 0.35,
        cooldown = 0.15,
        wait = 0.1,
        isDirectional = true
    },
    CutIn = {
        animIds = {
            ["rbxassetid://71217538180364"] = true,
            ["rbxassetid://87853371514282"] = true
        },
        sliderVar = "dragDist",
        duration = 1.0,
        cooldown = 0.15,
        wait = 0.2
    },
    HeroInstinct = {
        animId = "rbxassetid://82417661349987",
        sliderVar = "instinctDist",
        duration = 1.25,
        cooldown = 0.15,
        wait = 0.33
    },
    CloseQuarterDribble = {
        animId = "rbxassetid://94171465685487",
        sliderVar = "quarterDist",
        duration = 2.25,
        cooldown = 0.15,
        wait = 0.18
    },
    SpeedyTurn = {
        animId = "rbxassetid://109145068926350",
        sliderVar = "speedyDist",
        duration = 0.7,
        cooldown = 0.15,
        wait = 0.05
    },
    Fetch = {
        animId = "rbxassetid://110734304480469",
        sliderVar = "fetchDist",
        duration = 0.525,
        cooldown = 0.15,
        wait = 0.125
    },
    GoGo = {
        animId = "rbxassetid://111297568709238",
        sliderVar = "gogoDist",
        duration = 0.35,
        cooldown = 0.15,
        wait = 0.55
    },
    GuardDog = {
        animId = "rbxassetid://111439544531399",
        sliderVar = "guardDist",
        duration = 0.35,
        cooldown = 0.15,
        wait = 0.1
    },
    ZombieDribble = {
        animId = "rbxassetid://102294508090597",
        sliderVar = "zombDist",
        duration = 1.7,
        cooldown = 0.15,
        wait = 0.15
    },
    Creative = {
        animId = "rbxassetid://77926234700416",
        sliderVar = "creativeDist",
        duration = 0.2,
        cooldown = 0.15,
        wait = 0.85
    },
    GlacialCut = {
        animId = "rbxassetid://116769918041530",
        sliderVar = "glacialDist",
        duration = 0.5,
        cooldown = 0.15,
        wait = 0.425
    },
    Beautiful = {
        animIds = {
            ["rbxassetid://132788854309681"] = true,
            ["rbxassetid://138985718053619"] = true
        },
        sliderVar = "beautifulDist",
        duration = 0.3,
        cooldown = 0.15,
        wait = 0
    },
    ControlVar = {
        animId = "rbxassetid://77370115011368",
        sliderVar = "controlVarDist",
        duration = 0.3,
        cooldown = 0.15,
        wait = 0.1
    },
    Corvine = {
        animId = "rbxassetid://79459013513539",
        sliderVar = "corvineDist",
        duration = 0.4,
        cooldown = 0.15,
        wait = 1.1
    },
    Kusarigama = {
        animId = "rbxassetid://84772583028665",
        sliderVar = "kusarDist",
        duration = 0.55,
        cooldown = 0.15,
        wait = 0
    },
    ShadowStep = {
        animIds = {
            ["rbxassetid://133810381664491"] = true,
            ["rbxassetid://139230259021390"] = true
        },
        sliderVar = "shadowDist",
        duration = 0.3,
        cooldown = 0.15,
        wait = 0
    },
    SilentSteal = {
        animId = "rbxassetid://89782964116671",
        sliderVar = "silentDist",
        duration = 0.55,
        cooldown = 0.15,
        wait = 0.1
    },
    NutmegReflex = {
        animId = "rbxassetid://73266865968554",
        sliderVar = "reflexNutmegDist",
        duration = 0.25,
        cooldown = 0.15,
        wait = 0.05
    },
    TwinSteps = {
        animId = "rbxassetid://106299517516303",
        sliderVar = "twinStepsDist",
        duration = 0.15,
        cooldown = 0.15,
        wait = 1.75
    },
    KingsPath = {
        animId = "rbxassetid://73560885704292",
        sliderVar = "kingsDist",
        duration = 1.175,
        cooldown = 0.15,
        wait = 0.4
    },
    MachCutIn = {
        animIds = {
            ["rbxassetid://133945265328817"] = true,
            ["rbxassetid://88448030655006"] = true
        },
        sliderVar = "machDist",
        duration = 0.15,
        cooldown = 0.15,
        wait = 0.625
    },
    GoldenZone = {
        animId = "rbxassetid://132426354821688",
        sliderVar = "goldenDist",
        duration = 2.0,
        cooldown = 0.15,
        requiresBall = true,
        wait = 0.15
    },
    Devour = {
        animId = "rbxassetid://117921992582675",
        sliderVar = "devourMaxDist",
        speed = 150,
        cooldown = 0.15,
        isUnlimited = true,
        wait = 0.2
    }
}

local Distances = {}
for _, cfg in pairs(DashConfigs) do
    Distances[cfg.sliderVar] = 0
end

local ActiveDashes = {}
local cachedHRP = nil
local renderConn = nil

local ZERO = Vector3.new()
local DEFAULT_DIR = Vector3.new(0,0,1)

local DirectionOffsets = {
    Front = Vector3.new(0, 0, 1),
    Back = Vector3.new(0, 0, -1),
    Left = Vector3.new(-1, 0, 0),
    Right = Vector3.new(1, 0, 0),
    FrontLeft = Vector3.new(-1, 0, 1).Unit,
    FrontRight = Vector3.new(1, 0, 1).Unit,
    LeftBack = Vector3.new(-1, 0, -1).Unit,
    RightBack = Vector3.new(1, 0, -1).Unit,
}

local function updateDashes(dt)
    for i = #ActiveDashes, 1, -1 do
        local dash = ActiveDashes[i]
        local hrp = dash.hrp
        if not hrp or not hrp.Parent then
            table.remove(ActiveDashes, i)
            continue
        end

        local step = dash.cfg.isUnlimited and (dash.speed * dt) or math.min(dash.speed * dt, dash.remaining)
        local moveDir

        if dash.isDirectional then
            local baseLook = hrp.CFrame.LookVector
            local right = baseLook:Cross(Vector3.new(0,1,0))
            local offset = dash.offset
            moveDir = (right * -offset.X + baseLook * offset.Z).Unit
        else
            local look = hrp.CFrame.LookVector
            moveDir = Vector3.new(look.X, 0, look.Z).Unit
            if moveDir.Magnitude < 0.01 then
                moveDir = DEFAULT_DIR
            end
        end

        local newPos = hrp.Position + moveDir * step
        hrp.CFrame = CFrame.new(newPos.X, hrp.Position.Y, newPos.Z) * CFrame.new(ZERO, moveDir)

        dash.remaining = dash.remaining - step
        if dash.remaining <= 0 then
            table.remove(ActiveDashes, i)
        end
    end
    
    if #ActiveDashes == 0 and renderConn then
        renderConn:Disconnect()
        renderConn = nil
    end
end

local function startUpdateIfNeeded()
    if not renderConn and #ActiveDashes > 0 then
        renderConn = game:GetService("RunService").RenderStepped:Connect(updateDashes)
    end
end

local function startDash(hrp, cfg, track, directionName)
    local dist = Distances[cfg.sliderVar]
    if dist <= 0 then return end
    
    task.delay(cfg.wait or 0, function()
        if not hrp or not hrp.Parent then return end
        
        local dash = {
            hrp = hrp,
            remaining = dist,
            cfg = cfg,
            isDirectional = cfg.isDirectional == true
        }
        
        if dash.isDirectional and directionName then
            dash.offset = DirectionOffsets[directionName] or Vector3.new(0,0,1)
        end

        if cfg.isUnlimited then
            dash.remaining = math.huge
            dash.speed = cfg.speed
            if track then
                local stoppedConn
                stoppedConn = track.Stopped:Connect(function()
                    dash.remaining = 0
                    if stoppedConn then stoppedConn:Disconnect() end
                end)
            end
        else
            dash.speed = dist / cfg.duration
        end
        
        table.insert(ActiveDashes, dash)
        startUpdateIfNeeded()
    end)
end

local function onAnimationPlayed(track)
    if not track.Animation then return end
    local id = track.Animation.AnimationId
    
    for _, cfg in pairs(DashConfigs) do
        local match = false
        local directionName = nil
        
        if cfg.animId and id == cfg.animId then
            match = true
        elseif cfg.animIds then
            if cfg.isDirectional then
                directionName = cfg.animIds[id]
                if directionName then match = true end
            elseif cfg.animIds[id] then
                match = true
            end
        end
        
        if match then
            if cachedHRP and cachedHRP.Parent then
                if cfg.requiresBall then
                    local ball = cachedHRP.Parent:FindFirstChild("Ball")
                    if not ball or not ball:IsA("MeshPart") then continue end
                end
                startDash(cachedHRP, cfg, track, directionName)
            end
        end
    end
end

local function setupCharacter(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end
    local animator = hum:WaitForChild("Animator", 5)
    if not animator then return end
    cachedHRP = char:WaitForChild("HumanoidRootPart", 5)
    if not cachedHRP then return end
    animator.AnimationPlayed:Connect(onAnimationPlayed)
end

if player.Character then
    setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

d:Label("Universal Movement Buffs.")
d:Slider("Tackle Distance", 0, 0, 75, 1, function(v)
    Distances.tackleDist = v
end)

d:Slider("Rush Distance", 0, 0, 75, 1, function(v)
    Distances.rushDist = v
end)

d:Slider("GK Front Dive Distance", 0, 0, 75, 1, function(v)
    Distances.gkDist = v
end)

d:Label("Isagi Movement Buffs.")
d:Slider("Naruhaya Footwork Distance", 0, 0, 200, 1, function(v)
    Distances.naruhayaDist = v
end)

d:Label("NEL Isagi Movement Buffs.")
d:Slider("Raumdeuter Distance", 0, 0, 200, 1, function(v)
    Distances.raumDist = v
end)

d:Label("Shidou Movement Buffs.")
d:Slider("Draconic Rush Distance", 0, 0, 200, 1, function(v)
    Distances.dracDist = v
end)

d:Label("Bachira Movement Buffs.")
d:Slider("Step Overs Distance", 0, 0, 200, 1, function(v)
    Distances.stepDist = v
end)

d:Label("Kaiser Movement Buffs.")
d:Slider("Off The Ball Distance", 0, 0, 200, 1, function(v)
    Distances.kaiserDist = v
end)

d:Label("Rin Movement Buffs.")
d:Slider("Occlusion Break Distance", 0, 0, 200, 1, function(v)
    Distances.occlusionDist = v
end)

d:Label("Gagamaru Movement Buffs.")
d:Slider("Diving Header Distance", 0, 0, 125, 1, function(v)
    Distances.divingDist = v
end)

d:Label("Aiku Movement Buffs.")
d:Slider("Reflex Tackle Distance", 0, 0, 125, 1, function(v)
    Distances.reflexDist = v
end)

d:Label("Yukimiya Movement Buffs.")
d:Slider("Razor Break Distance", 0, 0, 35, 1, function(v)
    Distances.razorDist = v
end)

d:Slider("Drag Scissors Distance", 0, 0, 100, 1, function(v)
    Distances.dragDist = v
end)

d:Label("Kunigami Movement Buffs.")
d:Slider("Hero's Instinct Distance", 0, 0, 300, 1, function(v)
    Distances.instinctDist = v
end)

d:Label("Don Lorenzo Movement Buffs.")
d:Slider("Zombie Dribble Distance", 0, 0, 250, 1, function(v)
    Distances.zombDist = v
end)

d:Label("Sae Movement Buffs.")

d:Slider("Beautiful Destruction Distance", 0, 0, 33, 1, function(v)
    Distances.beautifulDist = v
end)

d:Slider("Beautiful Destruction: Side Variant Distance", 0, 0, 25, 1, function(v)
    Distances.creativeDist = v
end)

d:Slider("Nutmeg: Reflex Distance", 0, 0, 50, 1, function(v)
    Distances.reflexNutmegDist = v
end)

d:Label("Barou Movement Buffs.")
d:Slider("King's Path Distance", 0, 0, 750, 1, function(v)
    Distances.kingsDist = v
end)

d:Slider("DEVOUR. Distance", 0, 0, 500, 1, function(v)
    Distances.devourMaxDist = v
end)

d:Label("Nagi Movement Buffs.")
d:Slider("Control Distance (Ground Variant)", 0, 0, 30, 1, function(v)
    Distances.controlVarDist = v
end)

d:Label("Chigiri Movement Buffs.")
d:Slider("Mach Cut-In Distance", 0, 0, 200, 1, function(v)
    Distances.machDist = v
end)

d:Slider("Golden Zone Distance (Req. Ball)", 0, 0, 400, 1, function(v)
    Distances.goldenDist = v
end)

d:Label("Reo Movement Buffs.")
d:Slider("Twin Steps Distance", 0, 0, 75, 1, function(v)
    Distances.twinStepsDist = v
end)

d:Label("Hiori Movement Buffs.")

d:Slider("Glacial Cut (Variant: Forward) Distance", 0, 0, 175, 1, function(v)
    Distances.glacialDist = v
end)

d:Label("Kurona Movement Buffs.")
d:Slider("Close Quarter Dribble Distance", 0, 0, 250, 1, function(v)
    Distances.quarterDist = v
end)

d:Slider("Go-Go! Distance", 0, 0, 100, 1, function(v)
    Distances.gogoDist = v
end)

d:Slider("Guard Dog Distance", 0, 0, 100, 1, function(v)
    Distances.guardDist = v
end)

d:Slider("Speedy Turn Distance", 0, 0, 250, 1, function(v)
    Distances.speedyDist = v
end)

d:Slider("Fetch Distance", 0, 0, 100, 1, function(v)
    Distances.fetchDist = v
end)

d:Label("Karasu Movement Buffs.")
d:Slider("Silent Steal Distance", 0, 0, 125, 1, function(v)
    Distances.silentDist = v
end)

d:Slider("Corvine Distance", 0, 0, 100, 1, function(v)
    Distances.corvineDist = v
end)

d:Label("Otoya Movement Buffs.")

d:Slider("Kusarigama Distance", 0, 0, 75, 1, function(v)
    Distances.kusarDist = v
end)

d:Slider("Shadow Step Distance", 0, 0, 50, 1, function(v)
    Distances.shadowDist = v
end)

autoact = maintab2:Folder("Auto Activate Features.", Color3.fromRGB(169, 5, 255), true)
autoact:Label("Auto Activate: Activates The Move When Ball Within Range.")

local auto_activate_state = {
    distance = 10,
    toggle_state = false,
    move_number = 1,
    db = true,
    mode = "Hold",
    min_height = 0,
    use_bind_held = false,
    bind_key = nil,
    input_conn = nil,
    toggle = nil,
    set_bind = nil,
    aliases = {
        ["0"] = "Zero", ["1"] = "One", ["2"] = "Two", ["3"] = "Three", ["4"] = "Four",
        ["5"] = "Five", ["6"] = "Six", ["7"] = "Seven", ["8"] = "Eight", ["9"] = "Nine",
        ctrl = "LeftControl", lctrl = "LeftControl", rctrl = "RightControl", control = "LeftControl",
        shift = "LeftShift", lshift = "LeftShift", rshift = "RightShift",
        alt = "LeftAlt", lalt = "LeftAlt", ralt = "RightAlt",
        caps = "CapsLock", esc = "Escape", enter = "Return", del = "Delete", ins = "Insert",
        bksp = "Backspace", pgup = "PageUp", pgdn = "PageDown",
        ["-"] = "Minus", ["="] = "Equals", [";"] = "Semicolon", ["'"] = "Quote",
        [","] = "Comma", ["."] = "Period", ["/"] = "Slash", ["\\"] = "BackSlash",
        ["["] = "LeftBracket", ["]"] = "RightBracket", ["`"] = "Backquote",
        num0 = "KeypadZero", num1 = "KeypadOne", num2 = "KeypadTwo", num3 = "KeypadThree",
        num4 = "KeypadFour", num5 = "KeypadFive", num6 = "KeypadSix", num7 = "KeypadSeven",
        num8 = "KeypadEight", num9 = "KeypadNine"
    }
}

auto_activate_state.set_bind = function(text)
    text = tostring(text or ""):match("^%s*(.-)%s*$"):lower()

    if text == "" or text == "none" or text == "clear" then
        auto_activate_state.bind_key = nil
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Auto Activate Bind",
            Text = "Bind Is Currently Unbound.",
            Duration = 1
        })
        return
    end

    for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
        if item.Name:lower() == text or item.Name == auto_activate_state.aliases[text] then
            auto_activate_state.bind_key = item
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Auto Activate Bind",
                Text = "Bind Set To: " .. item.Name .. ".",
                Duration = 2
            })
            return
        end
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Activate Bind",
        Text = "Invalid Key Detected:'" .. text .. "'. Bind Was Not Bound.",
        Duration = 3
    })
end

auto_activate_state.toggle = function()
    auto_activate_state.toggle_state = not auto_activate_state.toggle_state

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Activate",
        Text = auto_activate_state.toggle_state and "Enabled." or "Disabled.",
        Duration = 1
    })
end

autoact:Toggle("Auto Activate", "Toggles The Feature On.", function(v)
    auto_activate_state.toggle_state = v
end)

autoact:Textbox("Auto Activate Bind", "Enter Key (Example: E, Q, LeftAlt). Blank Or None Unbinds.", function(v)
    auto_activate_state.set_bind(v)
end)

autoact:Toggle("Auto Activate On Bind Held", "If Enabled, Auto Activate Only Runs While The Bind Key Is Held Down.", function(v)
    auto_activate_state.use_bind_held = v

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Activate On Bind Held",
        Text = v and "Enabled." or "Disabled.",
        Duration = 1
    })
end)

autoact:Textbox("Auto Activate Move Number", "Example: 1, 2, 3, 4, 5.", function(v)
    local num = tonumber(v)
    if num and num <= 5 and num > 0 then
        auto_activate_state.move_number = num
    end
end)

autoact:Slider("Auto Activate Distance", 10, 3, 70, 0.5, function(v)
    auto_activate_state.distance = v
end)

autoact:Slider("Auto Activate Ball Height", 0, 0, 50, 0.5, function(v)
    auto_activate_state.min_height = v
end)

autoact:Dropdown("Auto Activate Mode", {"Hold", "Toggle"}, function(v)
    auto_activate_state.mode = v
    if auto_activate_state.toggle_state ~= nil then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Auto Activate Mode",
            Text = "Current Mode: " .. auto_activate_state.mode,
            Duration = 3
        })
    end
end)

auto_activate_state.input_conn = game:GetService("UserInputService").InputBegan:Connect(function(input, bg)
    if bg then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if auto_activate_state.mode == "Hold" then
            auto_activate_state.db = false
        else
            auto_activate_state.db = not auto_activate_state.db
        end
    end

    if auto_activate_state.bind_key and input.KeyCode == auto_activate_state.bind_key and not auto_activate_state.use_bind_held then
        auto_activate_state.toggle()
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input, bg)
    if bg then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if auto_activate_state.mode == "Hold" then
            auto_activate_state.db = true
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    local held_ok = not auto_activate_state.use_bind_held
        or (auto_activate_state.bind_key ~= nil and game:GetService("UserInputService"):IsKeyDown(auto_activate_state.bind_key))

    if not auto_activate_state.toggle_state or not held_ok or auto_activate_state.db then
        if game.CoreGui:FindFirstChild("AutoActGui") then
            game.CoreGui.AutoActGui:Destroy()
        end
        return
    end

    if not game.CoreGui:FindFirstChild("AutoActGui") then
        local gui = Instance.new("ScreenGui")
        gui.Name = "AutoActGui"

        local dot = Instance.new("Frame")
        dot.Name = "IndicatorDot"
        dot.Size = UDim2.new(0, 20, 0, 20)
        dot.Position = UDim2.new(0, 20, 1, -40)
        dot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        dot.BorderSizePixel = 0
        dot.Parent = gui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot

        gui.Parent = game.CoreGui
    end

    local char = game.Players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ball = game.Workspace.Terrain:FindFirstChild("Ball")
    if not ball then return end

    local distance = (hrp.Position - ball.Position).Magnitude

    if distance <= auto_activate_state.distance then
        if auto_activate_state.min_height > 0 then
            local relative_height = ball.Position.Y - (hrp.Position.Y - 2)
            if relative_height < auto_activate_state.min_height then
                return
            end
        end

        NET:FireServer("base", {{"skill" .. auto_activate_state.move_number}})
    end
end)

local autoline = maintab2:Folder("Auto Line Up Features.", Color3.fromRGB(169, 5, 255), true)
autoline:Label("Auto Line Ups: Helps You Aim At Certain Areas.")

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local character, hrp, humanoid
local padCount = 0
local targetCount = 0
local camLockConnection = nil
local activeTarget = nil
local currentLineupMode = "Freeze"
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isCurrentlyLocked = false

local lineup = {
	bind_key = Enum.UserInputType.MouseButton2,
	isKeyBind = false
}

lineup.set_bind = function(text)
	text = tostring(text or ""):match("^%s*(.-)%s*$"):lower()

	if text == "" or text == "none" or text == "clear" then
		lineup.bind_key = Enum.UserInputType.MouseButton2
		lineup.isKeyBind = false
		StarterGui:SetCore("SendNotification", {
			Title = "Lineup Lock Bind",
			Text = "Reset to Right Mouse Button (M2).",
			Duration = 2
		})
		return
	end

	local aliases = {
		["m1"] = Enum.UserInputType.MouseButton1,
		["lmb"] = Enum.UserInputType.MouseButton1,
		["left"] = Enum.UserInputType.MouseButton1,
		["leftclick"] = Enum.UserInputType.MouseButton1,
		["mousebutton1"] = Enum.UserInputType.MouseButton1,
		["mouse1"] = Enum.UserInputType.MouseButton1,

		["m2"] = Enum.UserInputType.MouseButton2,
		["rmb"] = Enum.UserInputType.MouseButton2,
		["right"] = Enum.UserInputType.MouseButton2,
		["rightclick"] = Enum.UserInputType.MouseButton2,
		["mousebutton2"] = Enum.UserInputType.MouseButton2,
		["mouse2"] = Enum.UserInputType.MouseButton2,

		["m3"] = Enum.UserInputType.MouseButton3,
		["mmb"] = Enum.UserInputType.MouseButton3,
		["middle"] = Enum.UserInputType.MouseButton3,
		["middleclick"] = Enum.UserInputType.MouseButton3,
		["mousebutton3"] = Enum.UserInputType.MouseButton3,
		["mouse3"] = Enum.UserInputType.MouseButton3,

		["0"] = "Zero", ["1"] = "One", ["2"] = "Two", ["3"] = "Three", ["4"] = "Four",
		["5"] = "Five", ["6"] = "Six", ["7"] = "Seven", ["8"] = "Eight", ["9"] = "Nine",
		ctrl = "LeftControl", lctrl = "LeftControl", rctrl = "RightControl", control = "LeftControl",
		shift = "LeftShift", lshift = "LeftShift", rshift = "RightShift",
		alt = "LeftAlt", lalt = "LeftAlt", ralt = "RightAlt",
		caps = "CapsLock", esc = "Escape", enter = "Return", del = "Delete", ins = "Insert",
		bksp = "Backspace", pgup = "PageUp", pgdn = "PageDown",
		["-"] = "Minus", ["="] = "Equals", [";"] = "Semicolon", ["'"] = "Quote",
		[","] = "Comma", ["."] = "Period", ["/"] = "Slash", ["\\"] = "BackSlash",
		["["] = "LeftBracket", ["]"] = "RightBracket", ["`"] = "Backquote",
		num0 = "KeypadZero", num1 = "KeypadOne", num2 = "KeypadTwo", num3 = "KeypadThree",
		num4 = "KeypadFour", num5 = "KeypadFive", num6 = "KeypadSix", num7 = "KeypadSeven",
		num8 = "KeypadEight", num9 = "KeypadNine"
	}

	if typeof(aliases[text]) == "EnumItem" and aliases[text].EnumType == Enum.UserInputType then
		lineup.bind_key = aliases[text]
		lineup.isKeyBind = false

		local pretty = ({
			[Enum.UserInputType.MouseButton1] = "Left Mouse Button (M1)",
			[Enum.UserInputType.MouseButton2] = "Right Mouse Button (M2)",
			[Enum.UserInputType.MouseButton3] = "Middle Mouse Button (M3)",
		})[lineup.bind_key] or tostring(lineup.bind_key)

		StarterGui:SetCore("SendNotification", {
			Title = "Lineup Lock Bind",
			Text = "Bind Set To: " .. pretty .. ".",
			Duration = 2
		})
		return
	end

	for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
		if item.Name:lower() == text or item.Name == aliases[text] then
			lineup.bind_key = item
			lineup.isKeyBind = true
			StarterGui:SetCore("SendNotification", {
				Title = "Lineup Lock Bind",
				Text = "Bind Set To: " .. item.Name .. ".",
				Duration = 2
			})
			return
		end
	end

	StarterGui:SetCore("SendNotification", {
		Title = "Lineup Lock Bind",
		Text = "Invalid Key: '" .. text .. "'. Bind not changed.",
		Duration = 3
	})
end

lineup.is_active = function()
	if lineup.isKeyBind then
		return UserInputService:IsKeyDown(lineup.bind_key)
	end
	return UserInputService:IsMouseButtonPressed(lineup.bind_key)
end

local function updateCharacterRefs(char)
	character = char
	hrp = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
end

if player.Character then
	updateCharacterRefs(player.Character)
end
player.CharacterAdded:Connect(updateCharacterRefs)

local function stopCamLock()
	activeTarget = nil
	if camLockConnection then
		camLockConnection:Disconnect()
		camLockConnection = nil
	end
end

local function resetLineupPhysics()
	if humanoid then
		humanoid.WalkSpeed = 30
	end
end

local function applyLineupMode()
	if currentLineupMode == "Freeze" then
		if humanoid then
			humanoid.WalkSpeed = 0
		end
	elseif currentLineupMode == "Slowness" then
		if humanoid then
			humanoid.WalkSpeed = 5
		end
	end
end

autoline:Dropdown("Lineup Mode", {"Freeze", "Slowness"}, function(v)
	currentLineupMode = v
	if isCurrentlyLocked then
		applyLineupMode()
	else
		resetLineupPhysics()
	end
end)

autoline:Textbox("Lineup Lock Bind", "Enter Key (Example: E, Q, LeftAlt, m1, m2, m3). Blank Or None Resets To M2.", function(v)
	lineup.set_bind(v)
	stopCamLock()
	if isCurrentlyLocked then
		isCurrentlyLocked = false
		resetLineupPhysics()
	end
end)

local function pad(pos, color)
	padCount += 1
	local p = Instance.new("Part")
	p.Name = "pad" .. padCount
	p.Size = Vector3.new(4, 4, 4)
	p.Position = pos
	p.Transparency = 0.65
	p.Anchored = true
	p.CanCollide = false
	p.Color = color
	p.Material = Enum.Material.SmoothPlastic
	p.Parent = Workspace
end

local function target(pos, color)
	targetCount += 1
	local t = Instance.new("Part")
	t.Name = "target" .. targetCount
	t.Shape = Enum.PartType.Ball
	t.Size = Vector3.new(7, 7, 7)
	t.Position = pos
	t.Anchored = true
	t.CanCollide = false
	t.Color = color
	t.Material = Enum.Material.Neon
	t.Parent = Workspace
end

local function getPadUnderPlayer()
	if not hrp then return nil end
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {character}
	params.FilterType = Enum.RaycastFilterType.Blacklist
	local result = Workspace:Raycast(hrp.Position, Vector3.new(0, -6, 0), params)
	if result and result.Instance then
		return result.Instance.Name:match("^pad(%d+)$")
	end
	return nil
end

local function startCamLock(targetPart)
	activeTarget = targetPart
	if camLockConnection then
		camLockConnection:Disconnect()
	end
	camLockConnection = RunService.RenderStepped:Connect(function()
		if not activeTarget then
			if camLockConnection then
				camLockConnection:Disconnect()
				camLockConnection = nil
			end
			return
		end
		camera.CFrame = CFrame.new(camera.CFrame.Position, activeTarget.Position)
	end)
end

if isMobile then
	RunService.RenderStepped:Connect(function()
		if not hrp or not character then return end

		local hasBall = false
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("MeshPart") and child.Name:lower():match("ball") then
				hasBall = true
				break
			end
		end

		if not hasBall then
			if activeTarget then
				stopCamLock()
			end
			return
		end

		local padIndex = getPadUnderPlayer()
		if padIndex then
			local targetPart = Workspace:FindFirstChild("target" .. padIndex)
			if targetPart and activeTarget ~= targetPart then
				startCamLock(targetPart)
			end
		else
			if activeTarget then
				stopCamLock()
			end
		end
	end)
else
	RunService.RenderStepped:Connect(function()
		local shouldBeLocked = lineup.is_active() and hrp and humanoid

		if not shouldBeLocked then
			if isCurrentlyLocked then
				isCurrentlyLocked = false
				resetLineupPhysics()
				stopCamLock()
			end
			return
		end

		local padIndex = getPadUnderPlayer()
		if not padIndex then
			if isCurrentlyLocked then
				isCurrentlyLocked = false
				resetLineupPhysics()
				stopCamLock()
			end
			return
		end

		local targetPart = Workspace:FindFirstChild("target" .. padIndex)
		if not targetPart then
			if isCurrentlyLocked then
				isCurrentlyLocked = false
				resetLineupPhysics()
			end
			return
		end

		if not isCurrentlyLocked then
			isCurrentlyLocked = true
		end

		if activeTarget ~= targetPart then
			startCamLock(targetPart)
		end

		applyLineupMode()
	end)
end

autoline:Toggle("Sae Line Ups", "Sae's Drive Shot Line Ups.", function(s)
	if s then
		StarterGui:SetCore("SendNotification", {
			Title = "Sae Line Ups",
			Text = "Enabled.",
			Duration = 3
		})

		local colors = {
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(255, 182, 193),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(255, 182, 193),
		}

		local goalRelative = {
			{pad = Vector3.new(-58, -9, -127), target = Vector3.new(71, 35, -13)},
			{pad = Vector3.new(-38, -9, -171), target = Vector3.new(70, 18, -13)},
			{pad = Vector3.new(-16, -9, -176), target = Vector3.new(45, 45, -14)},
			{pad = Vector3.new(15, -9, -174),  target = Vector3.new(25, 25, -14)},
			{pad = Vector3.new(48, -9, -161),  target = Vector3.new(20, 32, -14)},
			{pad = Vector3.new(71, -9, -134),  target = Vector3.new(22, 5, -12)},
			{pad = Vector3.new(86, -9, -113),  target = Vector3.new(31, 19, -14)},
			{pad = Vector3.new(99, -9, -137),  target = Vector3.new(29, 34, -14)},
			{pad = Vector3.new(-47, -9, -145), target = Vector3.new(53, 28, -14)},
			{pad = Vector3.new(132, -9, -111), target = Vector3.new(30, 8, -13)},

			{pad = Vector3.new(58, -9, 127),   target = Vector3.new(-71, 35, 13)},
			{pad = Vector3.new(38, -9, 171),   target = Vector3.new(-70, 18, 13)},
			{pad = Vector3.new(16, -9, 176),   target = Vector3.new(-45, 45, 14)},
			{pad = Vector3.new(-15, -9, 174),  target = Vector3.new(-25, 25, 14)},
			{pad = Vector3.new(-48, -9, 161),  target = Vector3.new(-20, 32, 14)},
			{pad = Vector3.new(-71, -9, 134),  target = Vector3.new(-22, 5, 12)},
			{pad = Vector3.new(-86, -9, 113),  target = Vector3.new(-31, 19, 14)},
			{pad = Vector3.new(-99, -9, 137),  target = Vector3.new(-29, 34, 14)},
			{pad = Vector3.new(47, -9, 145),   target = Vector3.new(-53, 28, 14)},
			{pad = Vector3.new(-132, -9, 111), target = Vector3.new(-30, 8, 13)},
		}

		local map = Workspace:WaitForChild("map", 8)
		if not map then return end

		local agoal = map:FindFirstChild("Agoal")
		local bgoal = map:FindFirstChild("Bgoal")

		local agoalPos = agoal.Position
		local bgoalPos = bgoal.Position

		for i = 1, 20 do
			local entry = goalRelative[i]
			if not entry then continue end

			local basePos = (i <= 10) and agoalPos or bgoalPos
			local col = colors[(i - 1) % #colors + 1]

			pad(basePos + entry.pad, col)
			target(basePos + entry.target, col)
		end

	else
		StarterGui:SetCore("SendNotification", {
			Title = "Sae Line Ups",
			Text = "Disabled.",
			Duration = 3
		})

		for i = 1, padCount do
			local p = Workspace:FindFirstChild("pad" .. i)
			if p then p:Destroy() end
		end

		for i = 1, targetCount do
			local t = Workspace:FindFirstChild("target" .. i)
			if t then t:Destroy() end
		end

		padCount = 0
		targetCount = 0
	end
end)

autoline:Toggle("Kaiser Line Ups", "Kaiser's Impact Magnus Line Ups.", function(k)
	if k then
		StarterGui:SetCore("SendNotification", {
			Title = "Kaiser Line Ups",
			Text = "Enabled.",
			Duration = 3
		})

		local colors = {
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(255, 182, 193),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(255, 182, 193),
		}

		local goalRelative = {
			{pad = Vector3.new(-76, -9, 140),  target = Vector3.new(108, 19, 14)},
			{pad = Vector3.new(-35, -9, 178),  target = Vector3.new(80, -5, 14)},
			{pad = Vector3.new(17, -9, 170),   target = Vector3.new(26, 18, 14)},
			{pad = Vector3.new(81, -9, 178),   target = Vector3.new(35, 34, 14)},
			{pad = Vector3.new(54, -9, 165),   target = Vector3.new(34, 2, 14)},
			{pad = Vector3.new(-55, -9, 171),  target = Vector3.new(87, -1, 14)},
			{pad = Vector3.new(-13, -9, 161),  target = Vector3.new(76, 15, 14)},
			{pad = Vector3.new(-42, -9, 122),  target = Vector3.new(73, 5, 14)},
			{pad = Vector3.new(61, -9, 114),   target = Vector3.new(35, 16, 14)},
			{pad = Vector3.new(130, -9, 110),  target = Vector3.new(50, 25, 14)},
			{pad = Vector3.new(110, -9, 151),  target = Vector3.new(34, 25, 14)},
			{pad = Vector3.new(39, -9, 194),   target = Vector3.new(32, 28, 14)},

			{pad = Vector3.new(76, -9, -140),  target = Vector3.new(-108, 19, -14)},
			{pad = Vector3.new(35, -9, -178),  target = Vector3.new(-80, -5, -14)},
			{pad = Vector3.new(-17, -9, -170), target = Vector3.new(-26, 18, -14)},
			{pad = Vector3.new(-81, -9, -178), target = Vector3.new(-35, 34, -14)},
			{pad = Vector3.new(-54, -9, -165), target = Vector3.new(-34, 2, -14)},
			{pad = Vector3.new(55, -9, -171),  target = Vector3.new(-87, -1, -14)},
			{pad = Vector3.new(13, -9, -161),  target = Vector3.new(-76, 15, -14)},
			{pad = Vector3.new(42, -9, -122),  target = Vector3.new(-73, 5, -14)},
			{pad = Vector3.new(-61, -9, -114), target = Vector3.new(-35, 16, -14)},
			{pad = Vector3.new(-130, -9, -110),target = Vector3.new(-50, 25, -14)},
			{pad = Vector3.new(-110, -9, -151),target = Vector3.new(-34, 25, -14)},
			{pad = Vector3.new(-39, -9, -194), target = Vector3.new(-32, 28, -14)},
		}

		local map = Workspace:WaitForChild("map", 8)
		if not map then return end

		local agoal = map:FindFirstChild("Agoal")
		local bgoal = map:FindFirstChild("Bgoal")

		local agoalPos = agoal.Position
		local bgoalPos = bgoal.Position

		for i = 1, 24 do
			local entry = goalRelative[i]
			if not entry then continue end

			local basePos = (i <= 12) and bgoalPos or agoalPos
			local col = colors[(i - 1) % #colors + 1]

			pad(basePos + entry.pad, col)
			target(basePos + entry.target, col)
		end

	else
		StarterGui:SetCore("SendNotification", {
			Title = "Kaiser Line Ups",
			Text = "Disabled.",
			Duration = 3
		})

		for i = 1, padCount do
			local p = Workspace:FindFirstChild("pad" .. i)
			if p then p:Destroy() end
		end

		for i = 1, targetCount do
			local t = Workspace:FindFirstChild("target" .. i)
			if t then t:Destroy() end
		end

		padCount = 0
		targetCount = 0
	end
end)

autoline:Toggle("Yukimiya Line Ups", "Yukimiya's Gyro Shot Line Ups.", function(y)
	if y then
		StarterGui:SetCore("SendNotification", {
			Title = "Yukimiya Line Ups",
			Text = "Enabled.",
			Duration = 3
		})

		local colors = {
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(0, 255, 0),
		}

		local goalRelative = {
			{pad = Vector3.new(3, -9, -216),   target = Vector3.new(68, 144, -16)},
			{pad = Vector3.new(62, -9, -193),  target = Vector3.new(50, 91, -16)},
			{pad = Vector3.new(-39, -9, -128), target = Vector3.new(6, 0, -12)},
			{pad = Vector3.new(-32, -9, -134), target = Vector3.new(15, 8, -15)},
			{pad = Vector3.new(-142, -9, -97), target = Vector3.new(81, 65, -16)},
			{pad = Vector3.new(-69, -9, -212), target = Vector3.new(158, 223, -16)},
			{pad = Vector3.new(32, -9, -130),  target = Vector3.new(-10, 24, -14)},
			{pad = Vector3.new(-115, -9, -160),target = Vector3.new(33, 72, -14)},
			{pad = Vector3.new(-92, -9, -188), target = Vector3.new(99, 133, -13)},
			{pad = Vector3.new(-40, -9, -208), target = Vector3.new(50, 116, -14)},
			{pad = Vector3.new(57, -9, -122),  target = Vector3.new(-8, 23, -15)},

			{pad = Vector3.new(-3, -9, 216),   target = Vector3.new(-68, 144, 16)},
			{pad = Vector3.new(-62, -9, 193),  target = Vector3.new(-50, 91, 16)},
			{pad = Vector3.new(39, -9, 128),   target = Vector3.new(-6, 0, 12)},
			{pad = Vector3.new(32, -9, 134),   target = Vector3.new(-15, 8, 15)},
			{pad = Vector3.new(142, -9, 97),   target = Vector3.new(-81, 65, 16)},
			{pad = Vector3.new(69, -9, 212),   target = Vector3.new(-158, 223, 16)},
			{pad = Vector3.new(-32, -9, 130),  target = Vector3.new(10, 24, 14)},
			{pad = Vector3.new(115, -9, 160),  target = Vector3.new(-33, 72, 14)},
			{pad = Vector3.new(92, -9, 188),   target = Vector3.new(-99, 133, 13)},
			{pad = Vector3.new(40, -9, 208),   target = Vector3.new(-50, 116, 14)},
			{pad = Vector3.new(-57, -9, 122),  target = Vector3.new(8, 23, 15)},
		}

		local map = Workspace:WaitForChild("map", 8)
		if not map then return end

		local agoal = map:FindFirstChild("Agoal")
		local bgoal = map:FindFirstChild("Bgoal")

		local agoalPos = agoal.Position
		local bgoalPos = bgoal.Position

		for i = 1, 22 do
			local entry = goalRelative[i]
			if not entry then continue end

			local basePos = (i <= 11) and agoalPos or bgoalPos
			local col = colors[(i - 1) % #colors + 1]

			pad(basePos + entry.pad, col)
			target(basePos + entry.target, col)
		end

	else
		StarterGui:SetCore("SendNotification", {
			Title = "Yukimiya Line Ups",
			Text = "Disabled.",
			Duration = 3
		})

		for i = 1, padCount do
			local p = Workspace:FindFirstChild("pad" .. i)
			if p then p:Destroy() end
		end

		for i = 1, targetCount do
			local t = Workspace:FindFirstChild("target" .. i)
			if t then t:Destroy() end
		end

		padCount = 0
		targetCount = 0
	end
end)

autoline:Toggle("Karasu Line Ups", "Karasu's Dive Bomb Line Ups.", function(kar)
	if kar then
		StarterGui:SetCore("SendNotification", {
			Title = "Karasu Line Ups",
			Text = "Enabled.",
			Duration = 3
		})

		local colors = {
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 128, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(128, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(128, 255, 0),
			Color3.fromRGB(120, 72, 0),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(0, 0, 0),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 128, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(128, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(128, 255, 0),
			Color3.fromRGB(120, 72, 0),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(0, 0, 0)
		}

		local goalRelative = {
			{pad = Vector3.new(66, -9, 135),   target = Vector3.new(-44, 39, 14)},
			{pad = Vector3.new(24, -9, 159),   target = Vector3.new(-70, 19, 13)},
			{pad = Vector3.new(43, -9, 147),   target = Vector3.new(-72, 34, 13)},
			{pad = Vector3.new(-12, -9, 160),  target = Vector3.new(-23, 25, 14)},
			{pad = Vector3.new(-46, -9, 184),  target = Vector3.new(5, 110, 14)},
			{pad = Vector3.new(-76, -9, 160),  target = Vector3.new(-6, 74, 14)},
			{pad = Vector3.new(-28, -9, 178),  target = Vector3.new(-11, 65, 14)},
			{pad = Vector3.new(-96, -9, 134),  target = Vector3.new(-25, 45, 14)},
			{pad = Vector3.new(-47, -9, 142),  target = Vector3.new(-19, 18, 14)},
			{pad = Vector3.new(47, -9, 124),   target = Vector3.new(-67, 20, 13)},

			{pad = Vector3.new(-66, -9, -135), target = Vector3.new(44, 39, -14)},
			{pad = Vector3.new(-24, -9, -159), target = Vector3.new(70, 19, -13)},
			{pad = Vector3.new(-43, -9, -147), target = Vector3.new(72, 34, -13)},
			{pad = Vector3.new(12, -9, -160),  target = Vector3.new(23, 25, -14)},
			{pad = Vector3.new(46, -9, -184),  target = Vector3.new(-5, 110, -14)},
			{pad = Vector3.new(76, -9, -160),  target = Vector3.new(6, 74, -14)},
			{pad = Vector3.new(28, -9, -178),  target = Vector3.new(11, 65, -14)},
			{pad = Vector3.new(96, -9, -134),  target = Vector3.new(25, 45, -14)},
			{pad = Vector3.new(47, -9, -142),  target = Vector3.new(19, 18, -14)},
			{pad = Vector3.new(-47, -9, -124), target = Vector3.new(67, 20, -13)},
		}

		local map = Workspace:WaitForChild("map", 8)
		if not map then return end

		local agoal = map:FindFirstChild("Agoal")
		local bgoal = map:FindFirstChild("Bgoal")

		local agoalPos = agoal.Position
		local bgoalPos = bgoal.Position

		for i = 1, 20 do
			local entry = goalRelative[i]
			if not entry then continue end

			local basePos = (i <= 10) and bgoalPos or agoalPos
			local col = colors[i]

			pad(basePos + entry.pad, col)
			target(basePos + entry.target, col)
		end

	else
		StarterGui:SetCore("SendNotification", {
			Title = "Karasu Line Ups",
			Text = "Disabled.",
			Duration = 3
		})

		for i = 1, padCount do
			local p = Workspace:FindFirstChild("pad" .. i)
			if p then p:Destroy() end
		end

		for i = 1, targetCount do
			local t = Workspace:FindFirstChild("target" .. i)
			if t then t:Destroy() end
		end

		padCount = 0
		targetCount = 0
	end
end)

autoline:Toggle("Rin Line Ups", "Rin's Curve Shot Line Ups.", function(r)
	if r then
		StarterGui:SetCore("SendNotification", {
			Title = "Rin Line Ups",
			Text = "Enabled.",
			Duration = 3
		})

		local colors = {
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 0, 255),
		}

		local goalRelative = {
			{pad = Vector3.new(62, -9, 121),   target = Vector3.new(-29, -9, 38)},
			{pad = Vector3.new(35, -9, 150),   target = Vector3.new(-26, -9, 50)},
			{pad = Vector3.new(0, -9, 161),    target = Vector3.new(-33, 39, 14)},
			{pad = Vector3.new(-28, -9, 154),  target = Vector3.new(-16, 28, 14)},
			{pad = Vector3.new(-56, -9, 135),  target = Vector3.new(-28, 10, 14)},
			{pad = Vector3.new(21, -9, 161),   target = Vector3.new(-40, -6, 13)},
			{pad = Vector3.new(-107, -9, 113), target = Vector3.new(-89, -9, 90)},
			{pad = Vector3.new(-133, -9, 102), target = Vector3.new(-27, 0, 15)},
			{pad = Vector3.new(-78, -9, 128),  target = Vector3.new(-27, 9, 17)},
			{pad = Vector3.new(50, -9, 135),   target = Vector3.new(-44, -3, 13)},

			{pad = Vector3.new(-62, -9, -121), target = Vector3.new(29, -9, -38)},
			{pad = Vector3.new(-35, -9, -150), target = Vector3.new(26, -9, -50)},
			{pad = Vector3.new(0, -9, -161),   target = Vector3.new(33, 39, -14)},
			{pad = Vector3.new(28, -9, -154),  target = Vector3.new(16, 28, -14)},
			{pad = Vector3.new(56, -9, -135),  target = Vector3.new(28, 10, -14)},
			{pad = Vector3.new(-21, -9, -161), target = Vector3.new(40, -6, -13)},
			{pad = Vector3.new(107, -9, -113), target = Vector3.new(89, -9, -90)},
			{pad = Vector3.new(133, -9, -102), target = Vector3.new(27, 0, -15)},
			{pad = Vector3.new(78, -9, -128),  target = Vector3.new(27, 9, -17)},
			{pad = Vector3.new(-50, -9, -135), target = Vector3.new(44, -3, -13)},
		}

		local map = Workspace:WaitForChild("map", 8)
		if not map then return end

		local agoal = map:FindFirstChild("Agoal")
		local bgoal = map:FindFirstChild("Bgoal")

		local agoalPos = agoal.Position
		local bgoalPos = bgoal.Position

		for i = 1, 20 do
			local entry = goalRelative[i]
			if not entry then continue end

			local basePos = (i <= 10) and bgoalPos or agoalPos
			local col = colors[(i - 1) % #colors + 1]

			pad(basePos + entry.pad, col)
			target(basePos + entry.target, col)
		end

	else
		StarterGui:SetCore("SendNotification", {
			Title = "Rin Line Ups",
			Text = "Disabled.",
			Duration = 3
		})

		for i = 1, padCount do
			local p = Workspace:FindFirstChild("pad" .. i)
			if p then p:Destroy() end
		end

		for i = 1, targetCount do
			local t = Workspace:FindFirstChild("target" .. i)
			if t then t:Destroy() end
		end

		padCount = 0
		targetCount = 0
	end
end)

autoline:Toggle("Rin Flow Line Ups", "Rin's Kill Shot Line Ups.", function(k)
	if k then
		StarterGui:SetCore("SendNotification", {
			Title = "Rin Flow Line Ups",
			Text = "Enabled.",
			Duration = 3
		})

		local colors = {
			Color3.fromRGB(147, 112, 219),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(147, 112, 219),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(147, 112, 219),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(147, 112, 219),
			Color3.fromRGB(255, 0, 0),
		}

		local goalRelative = {
			{pad = Vector3.new(-134, -9, 266), target = Vector3.new(-73, -9, 74)},
			{pad = Vector3.new(51, -9, 237),   target = Vector3.new(-87, 34, 13)},
			{pad = Vector3.new(-189, -9, 192), target = Vector3.new(-65, 24, 13)},
			{pad = Vector3.new(111, -9, 187),  target = Vector3.new(-116, 16, 13)},

			{pad = Vector3.new(134, -9, -266), target = Vector3.new(73, -9, -74)},
			{pad = Vector3.new(-51, -9, -237), target = Vector3.new(87, 34, -13)},
			{pad = Vector3.new(189, -9, -192), target = Vector3.new(65, 24, -13)},
			{pad = Vector3.new(-111, -9, -187),target = Vector3.new(116, 16, -13)},
		}

		local map = Workspace:WaitForChild("map", 8)
		if not map then return end

		local agoal = map:FindFirstChild("Agoal")
		local bgoal = map:FindFirstChild("Bgoal")

		local agoalPos = agoal.Position
		local bgoalPos = bgoal.Position

		for i = 1, 8 do
			local entry = goalRelative[i]
			if not entry then continue end

			local basePos = (i <= 4) and bgoalPos or agoalPos
			local col = colors[i]

			pad(basePos + entry.pad, col)
			target(basePos + entry.target, col)
		end

	else
		StarterGui:SetCore("SendNotification", {
			Title = "Rin Flow Line Ups",
			Text = "Disabled.",
			Duration = 3
		})

		for i = 1, padCount do
			local p = Workspace:FindFirstChild("pad" .. i)
			if p then p:Destroy() end
		end

		for i = 1, targetCount do
			local t = Workspace:FindFirstChild("target" .. i)
			if t then t:Destroy() end
		end

		padCount = 0
		targetCount = 0
	end
end)

local linecreator = maintab2:Folder("Line Up Creator Features.", Color3.fromRGB(169, 5, 255), true)
linecreator:Label("Line Up Creator: Create Your Own Lineups!")

linecreator:Button("Copy Lineup Code", "Click To Log A Lineup At The Current Position & Target.", function()
    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer
    local char = lp.Character

    if not char or not char:FindFirstChild("HumanoidRootPart") then
        return
    end

    local hrp = char.HumanoidRootPart

    local camera = workspace.CurrentCamera
    local viewport = camera.ViewportSize

    local ray = camera:ViewportPointToRay(
        viewport.X / 2,
        viewport.Y / 2
    )

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {
        char,
        workspace.map.gkbarriar.Abarriar,
        workspace.map.gkbarriar.Bbarriar
    }
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local result = workspace:Raycast(ray.Origin, ray.Direction * 5000, params)
    if not result then
        return
    end

    local hitPos = result.Position

    local map = workspace:FindFirstChild("map")
    if not map then
        return
    end

    local aGoal = map:FindFirstChild("Agoal")
    local bGoal = map:FindFirstChild("Bgoal")

    if not aGoal or not bGoal then
        return
    end

    local aPos = aGoal.Position
    local bPos = bGoal.Position

    local distA = (hrp.Position - aPos).Magnitude
    local distB = (hrp.Position - bPos).Magnitude

    local useA = distA <= distB
    local goalPos = useA and aPos or bPos

    local targetOffset = hitPos - goalPos
    local playerOffset = hrp.Position - goalPos

    local function r(n)
        return math.round(n)
    end

    local code = string.format(
        "t(%d,%d,%d)p(%d,%d,%d)%s",
        r(targetOffset.X),
        r(targetOffset.Y),
        r(targetOffset.Z),
        r(playerOffset.X),
        r(playerOffset.Y),
        r(playerOffset.Z),
        useA and "a" or "b"
    )

    setclipboard(code)

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Custom Lineup Copied!",
        Text = code,
        Duration = 5
    })
end)

local lineupColorsss = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 128, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(128, 255, 0),
    Color3.fromRGB(120, 72, 0),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(0, 0, 0)
}

linecreator:Textbox("Enter Lineup Code(s)", "Enter Lineup Codes (seperated by commas). Enter Nothing To Disable.", function(text)
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if not hrp then
        return
    end

    local map = workspace:FindFirstChild("map")
    if not map then
        return
    end

    local agoal = map:FindFirstChild("Agoal")
    local bgoal = map:FindFirstChild("Bgoal")

    if not agoal or not bgoal then
        return
    end

    for i = 1, padCount do
        local p = workspace:FindFirstChild("pad" .. i)
        if p then
            p:Destroy()
        end
    end

    for i = 1, targetCount do
        local t = workspace:FindFirstChild("target" .. i)
        if t then
            t:Destroy()
        end
    end

    padCount = 0
    targetCount = 0

    local colorIndex = 1

    for tx, ty, tz, px, py, pz, goalLetter in text:gmatch(
        "t%((%-?[%d%.]+),(%-?[%d%.]+),(%-?[%d%.]+)%)p%((%-?[%d%.]+),(%-?[%d%.]+),(%-?[%d%.]+)%)([ab])"
    ) do
        local playerOffset = Vector3.new(
            tonumber(px),
            tonumber(py) - 3,
            tonumber(pz)
        )

        local targetOffset = Vector3.new(
            tonumber(tx),
            tonumber(ty),
            tonumber(tz)
        )

        local goalPos = goalLetter == "a"
            and agoal.Position
            or bgoal.Position

        local col = lineupColorsss[((colorIndex - 1) % #lineupColorsss) + 1]

        pad(goalPos + playerOffset, col)
        target(goalPos + targetOffset, col)

        colorIndex += 1
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Lineups Loaded",
        Text = string.format("%d lineup(s) created.", colorIndex - 1),
        Duration = 5
    })
end)

local autopos = maintab2:Folder("Auto Position Features.", Color3.fromRGB(169, 5, 255), true)
autopos:Label("Auto Position: Automatically Sets Certain Positions.")

local autoPositionState = {
    CF = false,
    GK = false,
    CFConn = nil,
    GKConn = nil
}

buffer = buffer or {
    fromstring = function(str)
        return str
    end
}

local function firePacketsIfNear()
    local char = game:GetService("Players").LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end


    if (root.Position - Vector3.new(-371, 13, -1599)).Magnitude <= 15 or
       (root.Position - Vector3.new(-196, 13, -1599)).Magnitude <= 15 then

        local P = require(game:GetService("ReplicatedStorage"):WaitForChild("packets"))


        pcall(function() P.bytenet_selectRole.send({index = 1, t = "A"}) end)
        pcall(function() P.bytenet_selectRole.send({index = 1, t = "B"}) end)
    end
end

local function fireGKPackets()
    local P = require(game:GetService("ReplicatedStorage"):WaitForChild("packets"))


    pcall(function() P.bytenet_selectRole.send({index = 5, t = "A"}) end)
    pcall(function() P.bytenet_selectRole.send({index = 5, t = "B"}) end)
end

autopos:Toggle("Auto Pick CF", "Automatically Picks Center Field Position On Respawn Or Enable.", function()
    autoPositionState.CF = not autoPositionState.CF

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Pick CF",
        Text = autoPositionState.CF and "Enabled." or "Disabled.",
        Duration = 1
    })

    if autoPositionState.CF then
        autoPositionState.CFConn = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.3)
            firePacketsIfNear()
        end)

        task.spawn(function()
            repeat task.wait() until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            firePacketsIfNear()
        end)
    else
        if autoPositionState.CFConn then
            autoPositionState.CFConn:Disconnect()
            autoPositionState.CFConn = nil
        end
    end
end)

autopos:Toggle("Auto Pick GK", "Automatically Picks Goalkeeper Position On Respawn Or Enable.", function()
    autoPositionState.GK = not autoPositionState.GK

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Pick GK",
        Text = autoPositionState.GK and "Enabled." or "Disabled.",
        Duration = 1
    })

    if autoPositionState.GK then
        autoPositionState.GKConn = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.3)
            fireGKPackets()
        end)

        task.spawn(function()
            repeat task.wait() until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            fireGKPackets()
        end)
    else
        if autoPositionState.GKConn then
            autoPositionState.GKConn:Disconnect()
            autoPositionState.GKConn = nil
        end
    end
end)

local autogk = maintab2:Folder("Auto Goalkeeper Features.", Color3.fromRGB(169, 5, 255), true)
autogk:Label("Auto Goalkeeper: Automatically Plays As GK For You.")

autogk:Button("Celeron's Auto GK", "V Toggles Auto GK, Y Toggles Metavision, LeftAlt Toggles Corner Gui & F4 To Disable.", function()
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local buffers = setmetatable({}, {__index = function(_, k) return k end})

NET = (function()
    local Packets = require(game:GetService("ReplicatedStorage"):WaitForChild("packets"))
    local warned = {}

    local function warnOnce(key, message)
        if not warned[key] then
            warned[key] = true
            warn("[net shim] " .. message)
        end
    end

    local function convertToString(inputData)
        if type(inputData) == "string" then return inputData end
        if typeof(inputData) == "buffer" then return buffer.tostring(inputData) end
    end

    local netShim = {}

    function netShim.FireServer(_, dataBuffer, actionsList)
        local bufferType = convertToString(dataBuffer)

        if bufferType == "base" then
            if type(actionsList) ~= "table" then return end

            for _, primaryAction in ipairs(actionsList) do
                if type(primaryAction) == "table" then
                    local success = pcall(Packets.bytenet_use.send, primaryAction)
                    if not success then
                        warnOnce("use_" .. tostring(primaryAction), "bytenet_use execution failed for: '" .. tostring(primaryAction) .. "'")
                    end
                end
            end

        elseif bufferType == "grabball" then
            local success = pcall(Packets.bytenet_findBall.send, actionsList)
            if not success then
                warnOnce("grab", "bytenet_findBall execution channel failed.")
            end
        end
    end

    netShim.fireServer = netShim.FireServer
    return netShim
end)()

local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local Config = {
    TackleDistance = _G.TackleDistance or 16,
    MaxDist = _G.MaxDist or 80,
    MaxJump = _G.MaxJump or 22,
    SegmentCount = _G.SegmentCount or 150,
    TimeStep = _G.TimeStep or 0.02,
    LineWidth = _G.LineWidth or 0.25,
    LMode = _G.LMode or false,
    AutoD = _G.AutoD or false,
    JumpHeightTrigger = _G.JumpHeightTrigger or 7,
    Keybinds = _G.Keybinds,
}

local gkKeybinds = {
    metav  = "Y",
    autogkfuncs    = "V",
    toggleuicorner = "LeftAlt",
    unload = "F4",
}

local Gravity      = Vector3.new(0, -workspace.Gravity, 0)
local SegmentCount = Config.SegmentCount
local TimeStep     = Config.TimeStep
local LineWidth    = Config.LineWidth

local holderConn, inputConn, heartbeatConn
local unload

local function getKey(name)
    local binds = Config.Keybinds or {}
    local keyName = binds[name] or gkKeybinds[name]
    local keyCode = Enum.KeyCode[keyName]
    if not keyCode then
        return Enum.KeyCode[gkKeybinds[name]]
    end
    return keyCode
end

local justReleasedBall = false
local ballHolder = ReplicatedStorage.workspace.ballHolder
local lastHolder = ballHolder.Value

holderConn = ballHolder.Changed:Connect(function()
    if Config.AutoD then
        return
    end
    local newHolder = ballHolder.Value
    if lastHolder == Players.LocalPlayer.Character and newHolder == nil then
        justReleasedBall = true
    else
        justReleasedBall = false
    end
    lastHolder = newHolder
end)

local indicatorGui = Instance.new("ScreenGui")
indicatorGui.Parent = game.Players.LocalPlayer.PlayerGui
indicatorGui.IgnoreGuiInset = true
indicatorGui.ResetOnSpawn = false

local indicator = Instance.new("Frame", indicatorGui)
indicator.Size = UDim2.new(0.012, 0, 0.025, 0)
indicator.BackgroundColor3 = Color3.new(1, 0, 0.0156863)
indicator.Position = UDim2.new(0.988, 0, 0.975, 0)

local function createSegmentPart()
    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.Material = Enum.Material.Neon
    p.Color = Color3.new(1, 1, 1)
    p.Transparency = 1
    p.Size = Vector3.new(LineWidth, LineWidth, 1)
    p.Parent = workspace
    return p
end

local segments = nil
if not Config.LMode then
    segments = {}
    for i = 1, SegmentCount do
        segments[i] = createSegmentPart()
    end
end

local function hideSegments()
    if not segments then
        return
    end
    for _, part in ipairs(segments) do
        part.Transparency = 1
    end
end

local function shouldShowTrajectory()
    return _G.metav and not Config.LMode
end

_G.metav = true
_G.autogkfuncs = false
if Config.LMode then
    _G.metav = false
end

inputConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == getKey("unload") then
        unload()

    elseif input.KeyCode == getKey("metav") then
        _G.metav = not _G.metav

    elseif input.KeyCode == getKey("autogkfuncs") then
        _G.autogkfuncs = not _G.autogkfuncs
        if _G.autogkfuncs then
            indicator.BackgroundColor3 = Color3.new(0, 1, 0)
        else
            indicator.BackgroundColor3 = Color3.new(1, 0, 0)
        end

    elseif input.KeyCode == getKey("toggleuicorner") then
        indicator.Visible = not indicator.Visible
    end
end)

local function faceTowards(hrp, point)
    local dir = (point - hrp.Position).Unit
    local target = hrp.Position + dir
    hrp.CFrame = CFrame.lookAt(hrp.Position, Vector3.new(target.X, hrp.Position.Y, target.Z))
end

local function sendSkill(name)
    NET:FireServer(buffer.fromstring(buffers.base), { { name } })
end

local terrain = workspace.Terrain
local ballCache = nil
local ballSearchAt = 0

local function getBall()
    local ball = terrain:FindFirstChild("Ball")
    if ball then
        ballCache = ball
        return ball
    end
    if ballCache and ballCache.Parent then
        return ballCache
    end
    local now = os.clock()
    if now - ballSearchAt >= 0.5 then
        ballSearchAt = now
        ballCache = workspace:FindFirstChild("Ball", true)
    end
    return ballCache
end

local function getBallVelocity(ball)
    if ball.Parent == terrain then
        local cf = ReplicatedStorage:FindFirstChild("CFBall")
        local vv = cf and cf:FindFirstChild("velocity")
        local sv = cf and cf:FindFirstChild("speed")
        if vv and sv then
            return vv.Value * sv.Value
        end
    end
    return ball.AssemblyLinearVelocity
end

heartbeatConn = RunService.Heartbeat:Connect(function()
    local show = shouldShowTrajectory()
    if not show then
        hideSegments()
    end

    local ball = getBall()
    if not ball then hideSegments() return end

    local character = Players.LocalPlayer.Character
    if not character then hideSegments() return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then hideSegments() return end

    if ballHolder.Value == character or ball:IsDescendantOf(character) then
        hideSegments()
        return
    end

    if (ball.Position - hrp.Position).Magnitude >= Config.MaxDist then
        hideSegments()
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then hideSegments() return end

    local velocity = getBallVelocity(ball)
    if velocity.Magnitude == 0 then hideSegments() return end

    local startPos = ball.Position
    local prevPoint = startPos
    local hrpPos = hrp.Position

    local reachSpeed = 0
    if _G.autogkfuncs then reachSpeed = 155 end

    for i = 1, SegmentCount do
        local t = i * TimeStep
        local point = startPos + velocity * t + 0.5 * Gravity * t * t
        local seg = segments and segments[i]
        local segLen = (point - prevPoint).Magnitude

        if segLen > 0 then
            local toPoint = point - hrpPos
            local reachPoint = hrpPos + toPoint.Unit * math.min(reachSpeed * t, toPoint.Magnitude)
            local gap = (point - reachPoint).Magnitude

            local dash = gap <= Config.TackleDistance
                and _G.autogkfuncs
                and not justReleasedBall

            if dash then
                if show then
                    seg.Color = Color3.new(0, 0, 1)
                end
                if point.Y <= Config.MaxJump then
                    if point.Y >= hrp.Position.Y + Config.JumpHeightTrigger
                        and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    faceTowards(hrp, point)
                    sendSkill("tackle")
                    return
                end
            else
                if show then
                    seg.Color = Color3.new(1, 1, 1)
                end
            end

            if show and seg then
                seg.Transparency = 0
                seg.Size = Vector3.new(LineWidth, LineWidth, segLen)
                seg.CFrame = CFrame.lookAt(prevPoint, point) * CFrame.new(0, 0, -segLen / 2)
            elseif seg then
                seg.Transparency = 1
            end
        else
            if seg then
                seg.Transparency = 1
            end
        end

        prevPoint = point
    end
end)

unload = function()
    if heartbeatConn then heartbeatConn:Disconnect() heartbeatConn = nil end
    if holderConn then holderConn:Disconnect() holderConn = nil end
    if inputConn then inputConn:Disconnect() inputConn = nil end

    if segments then
        for _, part in ipairs(segments) do
            part:Destroy()
        end
        segments = nil
    end

    if indicatorGui then
        indicatorGui:Destroy()
        indicatorGui = nil
    end

    ballCache = nil
    justReleasedBall = false
    lastHolder = nil

    _G.metav = nil
    _G.autogkfuncs = nil
end
end)

autogk:Button("Daffy's Auto GK", "Reset Or Click F4 To Disable.", function()
    local gkPlayerState = {
        plr = Players.LocalPlayer,
        char = nil,
        cam = workspace.CurrentCamera,
        hum = nil,
        hrp = nil,
        originalCamType = nil,
        originalCamCFrame = nil,
        guii = nil,
        cambu = nil,
        gerg = nil,
        dot = nil,
        kind = "",
        align = nil,
        onn = true,
        pause = false,
        ballHolder = nil,
        lastHolder = nil,
        remote = nil,
        con = nil,
        kill = nil
    }

    gkPlayerState.char = gkPlayerState.plr.Character or gkPlayerState.plr.CharacterAdded:Wait()
    gkPlayerState.hum = gkPlayerState.char:WaitForChild("Humanoid")
    gkPlayerState.hrp = gkPlayerState.char:WaitForChild("HumanoidRootPart")

    gkPlayerState.originalCamType = gkPlayerState.cam.CameraType
    gkPlayerState.originalCamCFrame = gkPlayerState.cam.CFrame

    gkPlayerState.guii = Instance.new("ScreenGui")
    gkPlayerState.guii.Parent = gkPlayerState.plr.PlayerGui

    gkPlayerState.cambu = Instance.new("TextButton")
    gkPlayerState.cambu.Text = "Camera Mode"
    gkPlayerState.cambu.Size = UDim2.new(0.159,0,0.109,0)
    gkPlayerState.cambu.Position = UDim2.new(0.317,0,0.444,0)
    gkPlayerState.cambu.TextScaled = true
    gkPlayerState.cambu.Parent = gkPlayerState.guii

    gkPlayerState.gerg = Instance.new("TextButton")
    gkPlayerState.gerg.Text = "Body Mode"
    gkPlayerState.gerg.Size = UDim2.new(0.159,0,0.109,0)
    gkPlayerState.gerg.Position = UDim2.new(0.524,0,0.444,0)
    gkPlayerState.gerg.TextScaled = true
    gkPlayerState.gerg.Parent = gkPlayerState.guii

    gkPlayerState.dot = Instance.new("Frame")
    gkPlayerState.dot.Size = UDim2.new(0.012,0,0.025,0)
    gkPlayerState.dot.Position = UDim2.new(0.988,0,0.975,0)
    gkPlayerState.dot.BackgroundColor3 = Color3.fromRGB(0,255,0)
    gkPlayerState.dot.BorderSizePixel = 0
    gkPlayerState.dot.Parent = gkPlayerState.guii

    gkPlayerState.cambu.MouseButton1Up:Connect(function()
        gkPlayerState.kind = "cam"
    end)
    gkPlayerState.gerg.MouseButton1Up:Connect(function()
        gkPlayerState.kind = "body"
    end)

    repeat task.wait() until gkPlayerState.kind ~= ""
    gkPlayerState.cambu:Destroy()
    gkPlayerState.gerg:Destroy()

    local function getBall()
        return workspace.Terrain:FindFirstChild("Ball")
    end

    if gkPlayerState.kind == "body" then
        gkPlayerState.hum.AutoRotate = false
        gkPlayerState.align = Instance.new("AlignOrientation")
        gkPlayerState.align.Mode = Enum.OrientationAlignmentMode.OneAttachment
        gkPlayerState.align.Attachment0 = gkPlayerState.hrp:WaitForChild("RootAttachment")
        gkPlayerState.align.Responsiveness = 300
        gkPlayerState.align.MaxTorque = math.huge
        gkPlayerState.align.Enabled = false
        gkPlayerState.align.Parent = gkPlayerState.hrp
    end

    gkPlayerState.ballHolder = ReplicatedStorage.workspace.ballHolder
    gkPlayerState.lastHolder = gkPlayerState.ballHolder.Value

    gkPlayerState.ballHolder.Changed:Connect(function()
        local cur = gkPlayerState.ballHolder.Value
        if gkPlayerState.lastHolder == gkPlayerState.char and cur == nil then
            gkPlayerState.pause = true
            task.delay(0.7, function()
                gkPlayerState.pause = false
            end)
        end
        gkPlayerState.lastHolder = cur
    end)

    gkPlayerState.remote = NET

    local function cleanup()
        gkPlayerState.onn = false

        if gkPlayerState.align then
            gkPlayerState.align:Destroy()
        end

        gkPlayerState.cam.CameraType = gkPlayerState.originalCamType
        gkPlayerState.cam.CFrame = gkPlayerState.originalCamCFrame

        if gkPlayerState.guii then
            gkPlayerState.guii:Destroy()
        end
    end

    gkPlayerState.con = RunService.RenderStepped:Connect(function()
        if not gkPlayerState.onn then
            gkPlayerState.con:Disconnect()
            return
        end

        local ball = getBall()
        if not ball or gkPlayerState.plr.Team == game.Teams.lobby or gkPlayerState.pause then
            if gkPlayerState.align then gkPlayerState.align.Enabled = false end
            return
        end

        if gkPlayerState.kind == "cam" then
            gkPlayerState.cam.CameraType = Enum.CameraType.Scriptable
            gkPlayerState.cam.CFrame = CFrame.lookAt(gkPlayerState.cam.CFrame.Position, ball.Position)

        elseif gkPlayerState.kind == "body" then
            gkPlayerState.align.Enabled = true
            local dir = ball.Position - gkPlayerState.hrp.Position
            dir = Vector3.new(dir.X, 0, dir.Z)
            if dir.Magnitude > 0.01 then
                gkPlayerState.align.CFrame = CFrame.lookAt(Vector3.zero, dir)
            end
        end

        local dist = (gkPlayerState.hrp.Position - ball.Position).Magnitude
        if dist <= 60 then
            if ball.Position.Y >= gkPlayerState.hrp.Position.Y + 6 then
                gkPlayerState.hum.Jump = true
            else
                gkPlayerState.hum.Jump = false
            end

            gkPlayerState.remote:FireServer(
                buffer.fromstring(buffers.base),
                {
                    { "tackle" }
                }
            )
        end
    end)

    gkPlayerState.kill = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.F4 then
            cleanup()
            gkPlayerState.kill:Disconnect()
            gkPlayerState.con:Disconnect()
        end
    end)

    repeat task.wait() until gkPlayerState.hum.Health <= 0 or gkPlayerState.plr.Team == game.Teams.lobby
    cleanup()
    gkPlayerState.kill:Disconnect()
    gkPlayerState.con:Disconnect()
end)

local airdr = maintab2:Folder("Air Dribble Features.", Color3.fromRGB(169, 5, 255), true)
airdr:Label("Air Dribble: Dribbles The Ball Through The Air.")

local bindKey = Enum.KeyCode.LeftAlt

local airDribbleState = {
    enabled = false,
    isHolding = false,
    lastKick = 0
}

local cooldown = 0.255

local function notiy(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Air Dribble",
        Text = text,
        Duration = 2
    })
end

airdr:Toggle("Air Dribble", "Kicks The Ball Forward Infront Of You And Up.", function()
    airDribbleState.enabled = not airDribbleState.enabled
    notiy(airDribbleState.enabled and "Enabled." or "Disabled.")
end)

airdr:Textbox("Air Dribble Bind", "Enter Key (Example: E, Q, LeftAlt.)", function(text)
    if typeof(text) ~= "string" then
        bindKey = Enum.KeyCode.LeftAlt
        notiy("Invalid Key. Bind Is Now LeftAlt.")
        return
    end

    local formatted = text:gsub("%s+", "")
    local success, key = pcall(function()
        return Enum.KeyCode[formatted]
    end)

    if success and key then
        bindKey = key
        notiy("Bind Set To: " .. key.Name)
    else
        bindKey = Enum.KeyCode.LeftAlt
        notiy("Invalid Key. Bind Is Now LeftAlt.")
    end
end)

local player = Players.LocalPlayer
local holdingConnection = nil

local function performAirDribble()
    local now = tick()
    if now - airDribbleState.lastKick < cooldown then
        return
    end

    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and root) then return end

    airDribbleState.lastKick = now

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://76587445975710"
    local track = hum:LoadAnimation(anim)
    track:Play()

    local dir = root.CFrame.LookVector
    local kickVec = Vector3.new(dir.X * 0.75, 0.65, dir.Z * 0.75)

    NET:FireServer(buffer.fromstring(buffers["base"]), {
        { "kick", 28, false, kickVec }
    })
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp or input.KeyCode ~= bindKey then return end
    if not airDribbleState.enabled then return end

    airDribbleState.isHolding = true

    performAirDribble()

    if holdingConnection then holdingConnection:Disconnect() end
    holdingConnection = RunService.Heartbeat:Connect(function()
        if airDribbleState.isHolding and airDribbleState.enabled then
            performAirDribble()
        else
            holdingConnection:Disconnect()
            holdingConnection = nil
        end
    end)
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == bindKey then
        airDribbleState.isHolding = false
        if holdingConnection then
            holdingConnection:Disconnect()
            holdingConnection = nil
        end
    end
end)

local shotfeats = maintab2:Folder("Shooting Assistance Based Features.", Color3.fromRGB(169, 5, 255), true)
shotfeats:Label("Shooting Assistance Based Features.: Assists With Shooting Moves.")

run_service = game:GetService("RunService")
player = game:GetService("Players").LocalPlayer
starter_gui = game:GetService("StarterGui")
pcall(function() run_service:UnbindFromRenderStep("shot_predictor") end)
for _, name in ipairs({"clear_trajectory_lines", "ClearTrajectoryLines"}) do
	if _G[name] then pcall(_G[name]) end
end
for _, child in ipairs(workspace:GetChildren()) do
	if child.Name == "DecodedTrajectories" or child.Name == "TrajectoryRings" then child:Destroy() end
end

st_mode = "follow"
st_linethickness = 0.2
st_styleconfig = {
	sae = {length = 135, mindist = 125, maxdist = 135, maxentry = 75, skill = "skill3", aiminset = 0.25, aimdrop = 0.75},
	kaiser = {length = 160, mindist = 145, maxdist = 160, maxentry = 95, skill = "skill2", aiminset = 0.25, aimdrop = 0.5},
	yukimiya = {length = 185, mindist = 175, maxdist = 185, maxentry = 50, skill = "skill1", aiminset = 0.5, aimdrop = 1},
	rin = {length = 180, mindist = 164, maxdist = 182, maxentry = 75, skill = "skill3", aiminset = 4, aimdrop = 4},
	karasu = {length = 125, mindist = 115, maxdist = 125, maxentry = 100, skill = "skill3", aiminset = 1, aimdrop = -6},
}
st_defaultconfig = {length = 60, mindist = 0, maxdist = 200, maxentry = 75}
st_currentconfig = st_defaultconfig
st_currentlinelength = 60
st_pitchoffset = 3
st_linecolors = {Color3.fromRGB(255,170,0), Color3.fromRGB(0,200,255), Color3.fromRGB(255,80,200)}
st_autotop = false
st_snapdist = 100
st_requirefacing = false
st_cornerinset = 1.5
st_aiminset = 4
st_aimdrop = 4
st_locktol = 6
st_requirereach = true
st_wallsize = 5
st_wallstart = 6
st_wallend = 6
st_wallstep = 2
st_slowfactor = 0
st_slowcooldown = 3
st_hidemarkers = true
st_autofire = true
st_showrings = true
st_ringthickness = 1.2
st_ringheight = 0.5
st_ringcolor = Color3.fromRGB(255, 255, 255)
st_ringtransparency = 0.75
st_firecooldown = 3
st_firecount = 10
st_fireduration = 1
st_freeze = true
st_goals = nil
st_goalnames = {"goal"}
st_goalexclude = {"keeper", "gk", "barri", "zone", "area", "line", "sign", "box"}
st_goalminwidth = 10

st_autotop_blacklist = {
	rin = true,
	yukimiya = true,
}

user_input_service = game:GetService("UserInputService")
st_autotop_held = false
st_autotop_bind = Enum.UserInputType.MouseButton2
st_bind_aliases = {
	["0"] = "Zero", ["1"] = "One", ["2"] = "Two", ["3"] = "Three", ["4"] = "Four",
	["5"] = "Five", ["6"] = "Six", ["7"] = "Seven", ["8"] = "Eight", ["9"] = "Nine",
	ctrl = "LeftControl", lctrl = "LeftControl", rctrl = "RightControl", control = "LeftControl",
	shift = "LeftShift", lshift = "LeftShift", rshift = "RightShift",
	alt = "LeftAlt", lalt = "LeftAlt", ralt = "RightAlt",
	caps = "CapsLock", esc = "Escape", enter = "Return", del = "Delete", ins = "Insert",
	bksp = "Backspace", pgup = "PageUp", pgdn = "PageDown",
	["-"] = "Minus", ["="] = "Equals", [";"] = "Semicolon", ["'"] = "Quote",
	[","] = "Comma", ["."] = "Period", ["/"] = "Slash", ["\\"] = "BackSlash",
	["["] = "LeftBracket", ["]"] = "RightBracket", ["`"] = "Backquote",
	num0 = "KeypadZero", num1 = "KeypadOne", num2 = "KeypadTwo", num3 = "KeypadThree",
	num4 = "KeypadFour", num5 = "KeypadFive", num6 = "KeypadSix", num7 = "KeypadSeven",
	num8 = "KeypadEight", num9 = "KeypadNine",
	mouse1 = "MouseButton1", m1 = "MouseButton1",
	mouse2 = "MouseButton2", m2 = "MouseButton2",
	mouse3 = "MouseButton3", m3 = "MouseButton3",
}

function st_set_autotop_bind(text)
	text = tostring(text or ""):match("^%s*(.-)%s*$"):lower()
	if text == "" or text == "none" or text == "clear" then
		st_autotop_bind = Enum.UserInputType.MouseButton2
		starter_gui:SetCore("SendNotification", {
			Title = "Auto Top Bins Bind",
			Text = "Bind Reset To M2.",
			Duration = 2,
		})
		return
	end
	for _, item in ipairs(Enum.KeyCode:GetEnumItems()) do
		if item.Name:lower() == text or item.Name == st_bind_aliases[text] then
			st_autotop_bind = item
			starter_gui:SetCore("SendNotification", {
				Title = "Auto Top Bins Bind",
				Text = "Bind Set To: " .. item.Name .. ".",
				Duration = 2,
			})
			return
		end
	end
	for _, item in ipairs(Enum.UserInputType:GetEnumItems()) do
		if item.Name:lower() == text or item.Name == st_bind_aliases[text] then
			st_autotop_bind = item
			starter_gui:SetCore("SendNotification", {
				Title = "Auto Top Bins Bind",
				Text = "Bind Set To: " .. item.Name .. ".",
				Duration = 2,
			})
			return
		end
	end
	starter_gui:SetCore("SendNotification", {
		Title = "Auto Top Bins Bind",
		Text = "Invalid Key: '" .. text .. "'. Bind Not Changed.",
		Duration = 3,
	})
end

function st_bind_matches(input)
	if not st_autotop_bind then return false end
	if typeof(st_autotop_bind) == "EnumItem" then
		if st_autotop_bind.EnumType == Enum.KeyCode then
			return input.KeyCode == st_autotop_bind
		elseif st_autotop_bind.EnumType == Enum.UserInputType then
			return input.UserInputType == st_autotop_bind
		end
	end
	return false
end

st_input_began_conn = user_input_service.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if st_bind_matches(input) then
		st_autotop_held = true
	end
end)

st_input_ended_conn = user_input_service.InputEnded:Connect(function(input, gpe)
	if st_bind_matches(input) then
		st_autotop_held = false
		st_hold_end()
		st_slow_stop(false)
		st_clear_rings()
		lock_cache = nil
	end
end)

st_shotsbystyle = {
	sae = [=[
TRJ1|-8000|-54383,301,127243|-1736,-7|44|7qsD2ak83H59BqG_chrCuGvhBhxCmF9hBnoCmDtcr7BsB1VxlCArX5hC5B5Tj9BrDnQztB1DxK1yBvF9J1uBvGpHltB1HnFrwB7JxDplBhCd7oB2DcpiB8CyC7hB6BiEphBK-F7elBuHnbjCgI_ejEqLxb9CkMrakB6MhXWsL5UJoKnbpCwN3SCoJ_RA8IxUVkK7SCqJlRHwIvPB2HtPAyHpOAiHlOAiHtNA0G_IAuEtMAkG_LA-FxKAmFhKAgFvJA2EAAA,
TRJ1|8000|-41412,301,120644|-1736,-60|44|5v5C2qG08mHzuB-b1X5wB6b9W9wByapV_vBwY9SzqBuUhPpoBiS1MntBsS3LlpBkPzInkB4LzF5f-InD_gB8HvBlgBmGQndkEqCjd0CoExbegGnaV4HxV3B6H5WpDmKhX5E-L9WxGsMzRnGyJzShIgKrQrI8IjRlKoJ_P7K2IxNxKqH9O_MkIlO7N0HzM3N6GpLxNkG7L1PuGrLvQkGtKxQ2FpKhSyFxJ_RmF9JtUsFlH9P8DtIjUyEhI_UsEvH9UiE1H_WkEpGzUuDjD1K2B,
TRJ1|5263|-42489,301,120830|-6064,-258|42|540Cy2BkorHp9BylBzlBpzBuelep4BigBxf16BkgBjf18B0fjet2B2a7Y79BkctZ32BoXrU16BgWjS9mBqNrKnwBmO9J3oBwKtGpqB4I9D7oB-FRpa6CevbyB4C1cIyE3bnBsGpZvC0H3e_E2L1WpF4KlZvH2M9TzHmKtT1I8JrTjK8JtT7L8JnShNsJzQrNuIvP_N-HhOlOkHhP_Q4H1M5PuGnNlS4G7L_RiGrL3S6FxK_SsF9M1Z0GhIxRiE9G_PyDzIrVsElDtI2B
]=],
	kaiser = [=[TRJ1|-8000|-54309,301,123885|-1493,-887|44|jusDub8txH7-C-I1Il4CiH9Jz-CmGxMh1CmEnNp1C2CzP5pCY1P9lCX9Q3mCvC3Tt9B5DvT7tBhEnQvzBhGvU_vBjHjVrwBhJjYtnBlJnWllB7HpXvjBmD7YnhBiFlanfsD_b3ayB7a1UAvX_SLnW5EB1FdBfDAFn2BrJ3zC7VPvhB5PI9XhNZ3TpM9BxS1MTnTpMBxS_LVjS3JD5O9IFtNhKDnPzIA_MxIA_MzHAxL3IAlNtHAnLjGAnJhGAjJhCAlD,TRJ1|8000|-54309,301,123885|-1125,-1323|44|57rD-8BmgxH9kBkX3M_tCwwB7czxCoyBrgBtrC8tBngB_8B2kBjcl5B-hBzc53BygBjejvBibzblyBoc_fvjBwT9Ylb2OpUztB0XjmB3Z-MzXxc4NjdrXwK9arWqJld1R6G7ZzR6F7d9MuD9ZvMoC7dzJQxcpHhBpchFnC7ZxFvEpflE1E5X7DzF5V_DvH9WtDpHpT1DxJhVlDpJ3R1DzM7UtDtNxTlD1OpS5ChO3PrClNrNxC3PzOvCjRlOlClQpM9B1P_K_B7RvL9BnS5K3B_R9Jb1J9E,
TRJ1|2170|-52677,301,125277|4276,8249|44|1mlD4qBgp2H-9ByWwsB6kCmYm0BykCwX81B4kC4W24Bm_B-Ti3BqyBiPsuBi1B8Og0B4uBgMkxBkoBsJktBimB4HwuBygByFirB8f-D8uBmUwB4gB0XMwqBkXxB6vBoN1C8gB2L5DwhB8I3EqfuHnGkhBsFtHghBmDpI6fuBpMgpBI9IuZI3KsbIpMsbGjNoaI9O0aI1TkfE3L0QG9P4UG_PkTExQmSExP6PGrL4UEuG4PEsIuPEkH2OEwFmOEwDgMCkCqMEQqMEdmLAAA,
TRJ1|894|-53540,301,127267|-2913,-9439|43|5irDokBws1HzzBkJj4B5jCoKxuC75B2H3lC52BiGrlCh0BiEnmCvrBiCl-B5jBK92B5fd9zBve5C92Bja9D9yBhWlF7vB9U_GhzBlR1IzxBxNtJ_tBxI3IlkBjHzKjnB5E7I7nBvCkC1jBJ0E3iB6B-DxiBsDoC5e0EgBnfgFV_gBsEjCxcuF3EpjBiErFra8D5CrZoDoB7UkDuBvUiDG1TsDpB_V2ClCvRyCRzQqCGrPyCZxQoCN1OoCGxO8BFjM-BD1M-BB1M4BAtLqBAnI,
TRJ1|2550|-53596,301,125279|5031,-7494|44|ljoD6tB6uyHoH2Uh9BoP6jBntD8Ngbz1CgO2WprCgR2WjvCoSoU3qC4RiQ7_BoTqOt9B4T6L53BuU0JxzByS-GjqB8VkG1sBsXwE5qBgUsC3gB0dmB9qBgYV1eoYjCtbqb1Dzb2crFrZ6Y3FnT0Z9GtRmd7IpR4b5JtP-X7JnN2YzLxN2WhMvMyUtMpLqWhPpM2T7O5K6S1PrKkR3PtJgRlRrJ2NhPvHoPnStIoP7TrImN1SnHgN5RlHmM0C1G4LqKvG0K6I5F6L-HvG8KmG_FAAA,
TRJ1|5072|-53596,301,125279|5660,-2837|44|tonD-6BgkzHgqB4oBn-BmsBipB9-B6qB4lBj6B6mB6gB3yBorBqiBt1BiuBmiBv1ByoBwc9sBqiBiWjjBolBqW5jBwoBqWnkBmmBmTvf2jB-P1awiB4NtXkhBwLlU2hBiKlSmjB0ItQqjB8G7N8eqE7J4lBmDhJwgBgBrFokBdjDudnCL-jB7E2BsZ7EqB0VrFmBsX7GoBuZlJsB2Y3KqB2StJgBuW_MoBiQxKa6S7NiBwQ1Nc8StRgBoQ5Qc4MrOW8OzSaoMxQUwNhUYyJvPQgM7UU2LjWWAAA]=],
	yukimiya = [=[TRJ1|-8000|-64006,301,109665|1701,-350|44|315DqiB-70GuyBsGhVw-BuGrXuiDwH5f8hC4CjRizCaxQukC3BhJm6BhD3E8wBzEHo7BpHkD49BlK8HmrBzIsIkvBnLyMgvBXoQoiCkGudqiB8BsS4iBQkVilBrBwZomB3DiequBlH0mB4fgB2akdyBwY8eAgakdvC0YsYLwUiWB0SwXT6TqULkRwbDmXuTAsQqOAiMiSAmP4RAgPuMAuKyMA0K8JAqI0PAmN2KAgJ-JAsIkIA8GuIAiHkKAyIkIA6GiBAe,
TRJ1|8000|-64006,301,109665|1653,-531|44|tt6DgzC220GyemXzSw0B0lB1cyiC6sBlgB87B0lB9YonC6nBrWg1BoblNg0BsXhIqsBgS9Dm3B2SOoyB0OiEwnB8IgH8lB-GgJunB8E8M62B-CwXwnBLyUsjBnCoVgb9CiSktBhI6iBuiBpI4bmerJwY0a_JyV-Z1LkVykBlU2d6TxMiQqZ1SyUiRpO8N-SzRsPuV3WuRoRhUgOuO5S4LiNxS0K8RrcwOgOpYsL-L5W2JmLlXkJuKpXuIkNxgB0K6IjLmH4IoKkH2HuLoGuI-K6GsJiK2H8E-E-D,
TRJ1|2518|-64006,301,109665|8448,-3245|42|lk6Dg7But0G-6BiY9kBizByT7d41BwS9bq9B4Tzdi5CoX5hBogCgO1Ti9BoK1NswBwG_H-pCwF7E40BwBU8uBZmE2vBlDmI89BlH4PgvB3H8P0uBhK4TiiB_ImRyqBhNyYmsB1PybghBxN8UqnB5S-Y0gB9R4U-gB7U8Uid3UuSkYnTqP4XjOiPgaqJyQ0b6LwRiTiGkMgS8DuL8RqBqL4TfyMqQ5DsK0NlF0IiNnHqI0Q_MyKgLnEgHiLkEgH2JoDkGkKYuGsJpB-F0DpBqC,
TRJ1|3271|-64006,301,109665|7854,-3019|42|ln6DuiCyu0G8jB0SxXwhCmfzmB47B0angBo5C6iBnoBogCyVrXo-BkSjSi7BoOxMkmC2MhI81B6GvBi1BkE2C6pBuBiFimBNuHk3B1DwPgxBvFuRwlBlGyQymB_H0TmhC5RkoBsfrKkU2e9LgUyjBjQqX0hBjSgWuclR0Ssf5VyU8XzS0P-Z9WgRiX_WkPkZ5buQyShQkM4QqHgL0VsNmO4O2H2JyP4FkKsMwCmI-OG4JyL7ByH4JvDsG-I7E8FqJ5GiGsM7MkI0JxKqGgFqBoD,
TRJ1|5505|-64006,301,109665|5163,-2482|43|_x6DyuCuq0GogBkY7ZozC45Bn8BmnBsYpY0gB-SpSyrCooB_kB80B-YrVgvB0TnP6vBuR9LymC2UpKsuB4KzC6uBiIoB-wB0FyFmrBuCsIgvBE8MsmB7BqN6mB3DkQ-xB1HgZoxBnK-bgiBrJ4Tmd3JiRue5L8RskBpRqV-iBtTwUwanRwPoT9NqLwU3QgMkehc2R2TvUwLwTrWuLuU7agM0R1ZqK8OzX4IsNnX6HqMlXoHsLpK0GsQuQ0J2K4KoGwJgIyF4I2FkFkMwEkHgJeoF8CL2B,
TRJ1|2359|-64006,301,109665|8543,-3317|42|3j6Dm5B8s0Gu7B-WxlBwwByRzc49B-TngB4-BuS5d8_C8WrkB-xB4JnP20BmIxMg8B6GhKs7BgElFuoCcMmqBtByD2rBpD4Gs3B_GsNq0B5IuQgzB3LqVsnBvKgT2iB7KsTq1B7TghBgoB7QgZ-YpMyPuc1P6R-kBnXiXmdxUqSsYjQmP4T8CsM-UsIiN6d4K2SiQyEgKoUsD2MsPgB0JiSjBoLoXvFyO8OjGqJwOlIiJwPpJ2JgOK4I-K4C6G4KkB4G0KpB0G4KhE4GuHtC0E,
TRJ1|1006|-64006,301,109665|8938,-4131|43|vi6D4kB8k0G-wBkI9iB-1CsLz3B8nCqHpqB-3C0EjrBiiCcnb6zBjB5Ro0B3C3OwyBjErLkiCrIhJ2qB3GlDygCvMJmsBnKoDsqBrLiGq8B0BuNmuBiEuNs5B2DiVqdIkN0mBnBkTwvBhEuYwmBzF2T-mB1D8TmcsCuO6mBe6Tmf1B8P6YtD2MkY2BqMgbH6N8ZNmNmUJqKmSHqJqUDsKiTA2JqQAsIkMAmG0LA-FgQAkI4KAwFgMAkGqKAqFuJA6EyLA8F0DA8B,
TRJ1|5502|-64006,301,109665|5409,-1898|43|9r6DyuCuz0Gy4BomB1iBiqBmb7XonC0qBpjB-jCmkB7awkC0hB_W6yBgWxMsvBiSjI2sBiPzE44B4PZ4tBuK0CyvBiI-G2mB0E0I01BkD4Q-yBH4UwtBrDoXmgB_D8SmkBvGoY2rBrKggB2gBzJmYgiBxMsZkW5JwQ-pBtWofkYhPgSqUrOmPwVlRgQkX9UqRmY7YgS6S1ViO-QzV0MsPzVuL6S5diOsMlVmJwMrXsJ4L9X4IoO5B0K2M0MuJ8JoKsH-H4G-F4HoF4FyJ8DkHwIesG8FbsE]=],
	rin = [=[TRJ1|3134|-45834,301,99436|-7476,4130|43|577CqzB0yiG3rC0d4CrxCifiFjhD0jB4Jz0D0oByRtmCgYiMpHwCoBpBOIruCmVqc7lEkiB21B7gCuO0fryB2HiiBzgBmD4ajiByB8gBziBpB-oB_VxC4exRzD2cvR1FqiBvPtHykBlN_IsmBrOpN0uBhLtMokB3HnKuZzJvOufhMnVynBlHpOyXjItS2arIpVsbnG3RuU5GxVsWvGzWsVrFzUyRlF7ViRzFxXsSvEC2OjE0JwNhEkKqNlE0I6N1D2FkM1DwDiM_CiB8JlDVsKpBhBsE,TRJ1|-7988|-55163,301,104390|66,1755|43|xusD2jB4puGhWwK2yBvuB8V41DtfyOy5C3eiOqkDlW4J63CpOgG6oC9IsDm8B1G-B0qCnBP65BoCrCm4BuF9DwyBsGjEklBwNlIg4BmOpIipB0RjKkqByXnN0sBgX5M-jBgWlMigB8G5DgKoBX8Bk9BrN-9BgoB_B0oBkckE8csXqDgY-UqBwVoUP6U-SvCuTwSxEgT8ShHuT4N5GkOmOxByOyNgD-N2M8BiN-NDqOsNnC4NgJrDoJmMKwMkHSsHuIN0IsHtByHsIK0IwHL2H,TRJ1|8000|-54842,301,112978|114,1733|43|j7rDw_Bw2-GrhB-qB4gCtjBswByrC_vB8mC2zD1V2jBs9B7VopBirCxO-hBkiClJ2e2gC_D-V2xBe4W65B6C0MgjBgIgPqvB2MmMuuBmOmIsmBuRmF-iBiUkDkhBwVeydmZdyd0YxC2Y4alE6XodvGqZ0ZzHkWuX5ImUmYjL8U0T5K-Q4TvMgR2VhQ4SuQ7NmOgQrP4NoRxS8O8V_a8SwM1R4KoM5SyK4M3VgL-MvYmL6KpWqJyJxVoI8IxV0H4J_ZuIyJ3boIqF3Q0EiHxXiGmFvSuE,TRJ1|6857|-54842,301,112978|480,3622|44|v0rDm-Bs4-G7S-c0uB3lB0_BuqDrZmuB0vCpW4vBw2ClOukBilC3JiiBwkC5E4bm7BRiVowBoDiXi5BsDsQ2pBuL-N8sB-M2LqpBwRiKwqBuRsG4hBiVoE-gBkYkCmfuYA2akiBtC0fgd9DyWkhBrG-XscrHqU8cxJ2Uqa5K8S2WnLqQwVnMsPgUpNqO0S_NsN0RjP0MmRrQqMuM_M-IuU5X2O-MjRoJgP5V4K8L5SwI6NlY-JuL7VmIiLjX8HkKnXqHuK7ZwH8I5XqGuI1YiGuHtXsFAAA,TRJ1|5662|-54842,301,112978|826,5440|44|hzrDs8B-5-GpQoZwrB3b6rBksC5ZmxB07C5Q0iBiiCxR2qBi1CjNsqBs5C7DmckhCPwUgyBiD8SmyBqGuQ6vBkIiNypBwK8JykBuR8LsxBsGkEwRqBc2DIEUuyCkFyrD4hB9BkiByfpE8Z0dzFsV-fhIwW8c1JoU0bnLuT-WlLkQqY5NiR8VrOsPoX1RqQsPpN6KqRtQmMiTtUsN2Q_T4LwOnTkKuOjVmK0PrZgL2K_SuH0MvY8IsKjWqHuK9XqHkKtZkHiJtYsGmI9X4FgG_PoEAAA,TRJ1|5220|-54842,301,112978|1240,6002|43|xvrD87Bk8-GjOoZ6tB3aq0BgiD5T-rBi1C5S0yBumD_I-hByoC3DsZy5BPmc8jC0C-RuuBwF2R-wB2JkRi0BkL2M-qBmOsK4oB4SyImpBiY0GmqBiYmDgiBuba8fwbjBmbod_CwYmjBtFmZ2epG4T2gBzI2UwcvJgS-YjK6PyarM6QsbvPqRsfhV6TkT_OkMkQlOmKsQ5PsKiUzV0M6S1W-LqMtQ6H6OxVsJsOjXiJ4NpY2IwJ_RgG0MnagIiK9WsG4Kta6G6JhamG8IpN0F-DqDwC,TRJ1|2752|-54842,301,112978|1838,8676|44|turD8wB6h_GpNkS6wBlZslBupDlQibqwCnO0b82ClLwe6oDhEsS2kCSyQwmCoDsNy-BwG8IqyBkK6Hm1BiO4F00B6PiD4sB-UiB8uB-c7B0yBqU9CidygBrGqnB6WtFoXwdhImaiiBnKka8dlK-Uwc9K4TyhBvPoX2etQmVuXvOmQsVzO6O4U7PqO0fnb8V8SvSgNoQ3RqLuS3V2MmSzX0MoOvK6JkN8FiJyMgJ2I4O8JmK2N6GuJmL8D4HyJ0B0GsJGwG0J3B0G0IlD-FmI5E2F0BjBkB]=],
	karasu = [=[TRJ1|8000|-54942,301,119074|-1469,-926|44|r9sDktC8kmH1RmW1hB9f6kBz4Bhb8dtuBrhB8hBx1B9hBwf3yB5cyYroBjeoXnnBjnBobrvB7emSlhB5S-J5SxdyNjbhkB6NxdvX6GxQ7XyFjP3XkErNxX2CtL_ZoBzKtYFlIpRJzF5CBdZAHndnGxCr2B1MnEzd_JtB9U7IXvRjJTnRpKRxUrOT7RjOR9OrNPhQlQPjN1ON_MhQN1MjRLxJhOJrM9TNjKzRJ9J5SJ5H7PH1I_SJhHvQFlIxUH3BvEB,TRJ1|-8000|-54942,301,119074|-1618,-630|44|x9sDygBopnHliB6J3lBlvBqL_wBxvBuK_vB5wBuJrvBl3B6IhzBvtB4F7nBxuBmErmBvoBqCtf_mBgBzcpmBP_Z1mB3BtY1tBhEhaxjBxElSxlBrGjR_hBnHrN5kBrJnMnhB_J9I5hBzLhH1arK3D1cpMtC7Y3IV_a0Dahb-FmCrXqEgCtXkDgC5SsB0B5YEkCtUtB4BnT7C2BhSjEwBvRvFwBvP3FsB5PoBsBpOgCmBxOaoBzLNgBpNhCmB_LvCgBxLMgBtKCepJfYpKHexEDM,TRJ1|5090|-54942,301,119074|-5777,-2529|43|7rtDioCwrmH_cmYxlBnpBogB5yB1sBihB30B51B2kBz7BtlBqX7mBpxBwbjvBziB2Rhf1fqOlajqByQ1fzcyJvTndsIlSrnB6IvVjgBsFlPta0CpK7ZmBvI3aBhHzaxBpF_Z9CpD1ZrExBtYvFI9Y_G8BrVpHiC7V9ImCxVpKmC5StK8BhRzK2BtU1OiCjQ_M0BzS7Q8B1O_OuBnPhRyB7LxOmBtOvTuB1LjRmB7KzRiB1J3QgBvJ1RezJlTe9JxVgB1J1WgBpInIaAAA,TRJ1|4207|-54942,301,119074|-6887,-2769|42|1wtD4kCgsmH7boUthB_sBwepzBl5BokB_9B5eqS7f1xBobvwB_sBkW7oB3iBuPrd3wBiTjmBjd8J7UnfsJ5U1tB-K_a9bkFzOhnB6EvR5hBiCtM1iBErKrZlB_F1YxC_DrahE1ChiBpHZxXtGkBpXzHwChYtJ8CzWrK4CtS3JmC5T7LsCjT_MqC5RxNkChRzOiClQnP-BtRrSkC9L3NuBlQ1U-BzKzOqBpN9TyBpMnUwB3MhXyBtJlSkBtIxMgBxKmGoB1J4KmB_CmDM,TRJ1|2129|-54942,301,119074|-8883,-2813|43|n_sD0nBqsnHvlByPplB_kCiZ9_B1hBwLre1nCmWr9BrqByLniB3zBmMrnBh0BsKhlBlsBmHrd1uBuFncvjB-C7ThlByB5S9jBErQ3jBpBrO3yB3E1QzfrEvI3blF3FndxGxErgB_I5CrY9HTpctKc_YpKoCzarMgEnY1M8DpZ9OkEjSzLgD7SxNkDnSpO-CtS9NiD5WgD4D7OuGuC_RmH-CpQmF0CzPmDyC5OoBuCnNNmC3MhCiCtLtD8B9LpFgC_LtH-BnJ7GwBhHzFmBAAA,TRJ1|6545|-54942,301,119074|-3929,-1351|43|z2sD42BgunHhkBgftpBtqByiBtuB5lBsd3nB9sBmhBntBn1BukBhyB7uBud9oBvrBoZxjBzjBsStazjB4QtY7vByTrdpc4JlPhiBkKrQ5ZoG3KnjBsGjM_c6DlI_f8BpGrYAlDvWjBxBjiB9DMxTvD0BhalGgE3UjG-D5V_HoE3T1I8DpSrJyDzShL0DpLvHoCpW3QsE5OzM8CjNvMyCjP9P-CjMhOsCjMtPsChLnPkC5MrTwChKxQgC3KnTkC9HnPwBxKjWiCxIlT2BjJpW6BpElLa,TRJ1|5428|-54942,301,119074|-5521,-1898|43|x3sDi1B4tnHziBoc5nBxpBkfpsBx_ButBnhCr1BmjBpzBrjB2V_f9jByU3eroBuVvgBvlBkShcvrB6S7dxdkLpSlgB2KnSvhBuJ9QnhB2H3OnemFpL5dwDnJ7c8BhHtaI1EtanB9C3ZzCjBnZ_DUlYlFmCnZ7GgE3T1G2DzV1IgE3TlJ2DhRpJmD_QtKmD_U5O-D3S_OwDnS3QuDjRzRmDnNnPuC_N3R0ClKhO-B7L3RmCrLtSkC1K7SgC5K5UgCxJ9T6BvI_SyBzJvX6BvCnGQ,TRJ1|4960|-54942,301,119074|-6115,-2146|42|53sDg0BstnHjgB8YvkBjkB0atnBt0BukBv2BhrBwchrBnqBia9nBrqBmY3lBtnB6U_gBvmBwS_dnlBmQ_avkBiOlY1jB8LtVvkBuK7TnfmH7OvnBwG1PtiB-DvL3XmBjG3aApFjgB3BlEnWtCrBjY5DFvbhGgCjV5F8C5X9HkExVzI4DnV_J4DhYnNoErS5LmDtR1MiD7NnLuCpWlU-DpO1OwC9OjR0CrN7QqClR7XiD3M1TmC_K5S-BvIpPwB5LtXiCxJrU2B7KrZ-B1EhJa,TRJ1|4648|-54942,301,119074|-6511,-2241|42|r4sDkzB0tnH7lBicjqBvxBuiBp0B51BojBl2BxyB-enwBxnBsWxjB5mBsU7gB1lBmShe3qB6S7fhlBuOrZxiB4LvVztBmNzZzgBsH3P7euFjNnjBqEzM3a-B9HtdS5GvfrB7E1e9C5CjY7DL1ZvFsBjYtG6CtXzHgE9VxI8DvUtJ2D9UhL2DjTzLuD1S9MqD9QlNgD5P3N6CxP7O6ChMzMkCtQlT-CjO_RwCxLnQiCpNpUsC5NtXuCzKvT-BjLtW-BxJ1U2B3J5N4BxD0DU,TRJ1|4102|-54942,301,119074|-7163,-2369|42|h6sD6xButnH9jBuYvmB7zBqhBj1Bh0Bsf5yBlvBuaxrB7nB6U_iBrtBgW1lBnwBoVtlBvqBwQne7kB2MnY_lBqL5WzwB2L3Z9dyF7N5fuE9MprBwDtO5aWjHndX7F3mBtD7E3d7Ef_azFUxXpGoCvXxH4DjdvLqF3V_JgE3U_K4DlT5LyD_SnNuDxR1NoDpQhO-C5PjP-CrOnP0C5O9Q2CtRxWmDtM1RqCnK1P8BhMhUmCpLvUkCxJzS2BhLnGiCnI8HwB9I2J0BAAA
]=],
}

alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
alphabet_index = {}
for i = 1, #alphabet do alphabet_index[alphabet:sub(i, i)] = i - 1 end

function st_decode(tok)
	p = tok:split("|")
	n = tonumber(p[5])
	pp = p[3]:split(",")
	lk = p[4]:split(",")
	if p[1] ~= "TRJ1" or not n then return end
	pos = Vector3.new(tonumber(pp[1]), tonumber(pp[2]), tonumber(pp[3])) / 100
	f = Vector3.new(tonumber(lk[1]) / 1e4, 0, tonumber(lk[2]) / 1e4)
	f = f.Magnitude < 1e-3 and Vector3.new(0, 0, -1) or f.Unit
	r = Vector3.new(-f.Z, 0, f.X)
	values = {}
	v = 0
	m = 1
	for c in p[6]:gmatch(".") do
		d = alphabet_index[c]
		if not d then return end
		v = v + (d % 32) * m
		if d >= 32 then
			m = m * 32
		else
			values[#values + 1] = v % 2 == 1 and -(v + 1) / 2 or v / 2
			v = 0
			m = 1
		end
	end
	if m ~= 1 or #values ~= n * 3 then return end
	w = {}
	rel = {}
	x = 0
	y = 0
	z = 0
	for i = 1, n do
		x = x + values[i * 3 - 2]
		y = y + values[i * 3 - 1]
		z = z + values[i * 3]
		pt = Vector3.new(x, y, z) / 100
		d = pt - pos
		w[i] = pt
		rel[i] = Vector3.new(d:Dot(r), d.Y, d:Dot(f))
	end
	return {pitch = tonumber(p[2]) / 100, world = w, rel = rel}
end

folder = Instance.new("Folder")
folder.Name = "DecodedTrajectories"

function st_make_part(color, ball)
	p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Material = Enum.Material.Neon
	p.Color = color
	if ball then
		p.Shape = Enum.PartType.Ball
		p.Size = Vector3.one * 0.8
	end
	p.Parent = folder
	return p
end

function st_layout(l, pts)
	style = st_find_style()
	hide_for_autotop = st_autotop and st_autotop_held and not st_autotop_blacklist[style]
	line_alpha = hide_for_autotop and 1 or 0
	for i = 1, #pts - 1 do
		a = pts[i]
		b = pts[i + 1]
		d = (b - a).Magnitude
		seg = l.segments[i]
		seg.Transparency = line_alpha
		seg.Size = Vector3.new(st_linethickness, st_linethickness, math.max(d, 0.01))
		seg.CFrame = d > 0.01 and CFrame.lookAt(a:Lerp(b, 0.5), b) or CFrame.new(b)
	end
	for i = #pts, #l.segments do
		l.segments[i].Transparency = 1
	end
	l.start_marker.Position = pts[1]
	l.end_marker.Position = pts[#pts]
	marker_alpha = (hide_for_autotop and st_hidemarkers) and 1 or 0
	l.start_marker.Transparency = marker_alpha
	l.end_marker.Transparency = marker_alpha
end

ray_params = RaycastParams.new()
ray_params.FilterType = Enum.RaycastFilterType.Exclude
ray_params.RespectCanCollide = true
ignore = {}

function st_cast(a, b)
	for _ = 1, 5 do
		hit = workspace:Raycast(a, b - a, ray_params)
		if not hit or hit.Instance.Parent ~= workspace.Terrain then return hit end
		table.insert(ignore, hit.Instance)
		ray_params.FilterDescendantsInstances = ignore
	end
end

anchors = {}
live = nil
enabled = false
path_count = nil

cached_style = ""
cached_style_time = 0

function st_find_style()
	now = os.clock()
	if now - cached_style_time < 0.4 then
		return cached_style
	end
	cached_style_time = now
	for _, holder in ipairs({player, player.Character}) do
		if holder then
			for name, value in pairs(holder:GetAttributes()) do
				if name:lower() == "style" then
					cached_style = tostring(value):lower()
					return cached_style
				end
			end
			for _, child in ipairs(holder:GetChildren()) do
				if child.Name:lower() == "style" and child:IsA("ValueBase") then
					cached_style = tostring(child.Value):lower()
					return cached_style
				end
			end
		end
	end
	cached_style = ""
	return cached_style
end

function st_sample(rel, u)
	x = u * (#rel - 1) + 1
	i = math.min(math.floor(x), #rel - 1)
	return rel[i]:Lerp(rel[i + 1], x - i)
end

function st_new_line(color, count)
	l = {segments = {}, start_marker = st_make_part(Color3.fromRGB(0, 255, 0), true), end_marker = st_make_part(Color3.fromRGB(255, 0, 0), true)}
	for i = 1, count - 1 do
		l.segments[i] = st_make_part(color)
	end
	return l
end

function st_rebuild()
	folder:ClearAllChildren()
	anchors = {}
	live = nil
	style = tostring(st_find_style()):lower()
	st_currentconfig = st_styleconfig[style] or st_defaultconfig
	st_currentlinelength = st_currentconfig.length
	data = st_shotsbystyle[style]
	if not data then
		task.wait(1)
		starter_gui:SetCore("SendNotification", {
			Title = "invalid style",
			Text = "this style doesnt have base curve shot or isnt added yet.",
			Duration = 3,
			Button1 = "alright fella",
		})
		st_clear_rings()
		return
	end
	data = data:gsub(",%s*TRJ1", "\nTRJ1")
	count = 0
	for tok in data:gmatch("TRJ1|[%w%-_|,]+") do
		shot = st_decode(tok)
		if shot then
			shot.pitch = math.max(shot.pitch, st_pitchoffset)
			table.insert(anchors, shot)
			count = math.max(count, #shot.world)
		end
	end
	if #anchors == 0 then
		st_clear_rings()
		return
	end
	table.sort(anchors, function(a, b) return a.pitch < b.pitch end)
	path_count = count
	for _, shot in ipairs(anchors) do
		shot.pts = {}
		for k = 1, count do
			shot.pts[k] = st_sample(shot.rel, (k - 1) / (count - 1))
		end
	end
	if st_mode == "world" then
		for i, shot in ipairs(anchors) do
			st_layout(st_new_line(st_linecolors[(i - 1) % #st_linecolors + 1], #shot.world), shot.world)
		end
	else
		live = st_new_line(st_linecolors[1], count)
	end
end

function st_plane_hit(q, dc, h)
	ph_best = math.huge
	ph_bk = 1
	ph_bs = 0
	ph_ax = math.sqrt(q[1].X ^ 2 + q[1].Z ^ 2)
	ph_ay = q[1].Y
	for k = 1, #q - 1 do
		ph_b = q[k + 1]
		ph_bx = math.sqrt(ph_b.X ^ 2 + ph_b.Z ^ 2)
		ph_by = ph_b.Y
		ph_vx = ph_bx - ph_ax
		ph_vy = ph_by - ph_ay
		ph_l2 = ph_vx * ph_vx + ph_vy * ph_vy
		ph_s = ph_l2 > 1e-9 and math.clamp(((dc - ph_ax) * ph_vx + (h - ph_ay) * ph_vy) / ph_l2, 0, 1) or 0
		ph_ex = ph_ax + ph_vx * ph_s - dc
		ph_ey = ph_ay + ph_vy * ph_s - h
		ph_e = ph_ex * ph_ex + ph_ey * ph_ey
		if ph_e < ph_best then
			ph_best = ph_e
			ph_bk = k
			ph_bs = ph_s
		end
		ph_ax = ph_bx
		ph_ay = ph_by
	end
	return math.sqrt(ph_best), ph_bk, ph_bs
end

function st_blend_for(pitch)
	lo = anchors[1]
	hi = anchors[1]
	for i = 1, #anchors - 1 do
		if pitch <= anchors[i + 1].pitch then
			lo = anchors[i]
			hi = anchors[i + 1]
			break
		end
	end
	t = hi.pitch > lo.pitch and (pitch - lo.pitch) / (hi.pitch - lo.pitch) or 0
	return lo, hi, t
end

function st_path_q(pitch, n)
	lo, hi, t = st_blend_for(pitch)
	q = {}
	for k = 1, n do
		q[k] = lo.pts[k]:Lerp(hi.pts[k], t)
	end
	return q
end

goals = {}
goals_time = 0
fire_ready_at = 0
fire_hold = nil

slow_active = false
slow_end = 0
slow_ready_at = 0
slow_base = nil
slow_hum = nil
was_locked = false

function st_slow_stop(start_cooldown)
	if slow_active and slow_hum and slow_hum.Parent and slow_base then
		slow_hum.WalkSpeed = slow_base
	end
	if slow_active and start_cooldown then
		slow_ready_at = os.clock() + st_slowcooldown
	end
	slow_active = false
	slow_base = nil
	slow_hum = nil
end

function st_slow_tick()
	if not slow_active then return end
	char = player.Character
	hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum or hum ~= slow_hum then
		slow_active = false
		slow_base = nil
		slow_hum = nil
		return
	end
	if os.clock() >= slow_end then
		st_slow_stop(true)
		return
	end
	hum.WalkSpeed = slow_base * st_slowfactor
end

function st_slow_begin()
	if slow_active or os.clock() < slow_ready_at then return end
	char = player.Character
	hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	slow_active = true
	slow_hum = hum
	slow_base = hum.WalkSpeed
	slow_end = os.clock() + st_fireduration
	hum.WalkSpeed = slow_base * st_slowfactor
end

function st_fire_skill()
	skill = st_currentconfig.skill
	if not skill or os.clock() < fire_ready_at then return end
	if not NET or not buffers then return end
	fire_ready_at = os.clock() + st_fireduration + st_firecooldown
	task.spawn(function()
		for i = 1, st_firecount do
			pcall(function()
				NET:FireServer(buffer.fromstring(buffers["base"]), {{skill}})
			end)
			if i < st_firecount then task.wait(st_fireduration / st_firecount) end
		end
	end)
	return true
end

function st_hold_end()
	fire_hold = nil
end

function st_hold_freeze(h)
	h.root.CFrame = h.cf
	h.root.AssemblyLinearVelocity = Vector3.zero
	h.root.AssemblyAngularVelocity = Vector3.zero
end

function st_hold_begin(lock, root)
	h = {lock = lock, root = root, stop_at = os.clock() + st_fireduration, cf = root.CFrame}
	fire_hold = h
	if st_freeze then st_hold_freeze(h) end
	task.delay(st_fireduration, function()
		if fire_hold == h then st_hold_end() end
	end)
end

function st_target_goal()
	team = player.Team and player.Team.Name
	map = workspace:FindFirstChild("map")
	if not map then return nil end
	if team == "A" then return map:FindFirstChild("Bgoal") end
	if team == "B" then return map:FindFirstChild("Agoal") end
	return nil
end

function st_goal_name_ok(name)
	name = name:lower()
	ok = false
	for _, k in ipairs(st_goalnames) do
		if name:find(k, 1, true) then ok = true end
	end
	if not ok then return false end
	for _, k in ipairs(st_goalexclude) do
		if name:find(k, 1, true) then return false end
	end
	return true
end

function st_goal_info(inst)
	if inst:IsA("Model") then
		cf, size = inst:GetBoundingBox()
	else
		cf = inst.CFrame
		size = inst.Size
	end
	axes = {{cf.RightVector, size.X}, {cf.UpVector, size.Y}, {cf.LookVector, size.Z}}
	table.sort(axes, function(a, b) return math.abs(a[1].Y) > math.abs(b[1].Y) end)
	wa = axes[2]
	da = axes[3]
	if da[2] > wa[2] then
		wa = da
		da = axes[2]
	end
	return {
		inst = inst,
		center = cf.Position,
		height = axes[1][2],
		width = wa[2],
		depth = da[2],
		wdir = Vector3.new(wa[1].X, 0, wa[1].Z).Unit,
		ddir = Vector3.new(da[1].X, 0, da[1].Z).Unit,
	}
end

function st_find_goals()
	if os.clock() - goals_time < 3 then return goals end
	goals_time = os.clock()
	goals = {}
	list = {}
	if st_goals then
		for _, g in ipairs(st_goals) do table.insert(list, g) end
	else
		root = workspace:FindFirstChild("map") or workspace
		picked = {}
		for _, d in ipairs(root:GetDescendants()) do
			if (d:IsA("Model") or d:IsA("BasePart")) and st_goal_name_ok(d.Name) and not d:IsDescendantOf(workspace.Terrain) then
				nested = false
				a = d.Parent
				while a and a ~= root do
					if picked[a] then nested = true end
					a = a.Parent
				end
				container = false
				if d:IsA("Model") then
					for _, c in ipairs(d:GetChildren()) do
						if c:IsA("Model") and st_goal_name_ok(c.Name) then container = true end
					end
				end
				if not nested and not container then
					picked[d] = true
					table.insert(list, d)
				end
			end
		end
	end
	for _, inst in ipairs(list) do
		ok, info = pcall(st_goal_info, inst)
		if ok and info.width >= st_goalminwidth then table.insert(goals, info) end
	end
	return goals
end

function st_goal_corners(g, from)
	s = (from - g.center):Dot(g.ddir) >= 0 and 1 or -1
	front = g.center + g.ddir * (s * g.depth / 2)
	aimdrop = st_currentconfig.aimdrop or st_aimdrop
	aiminset = st_currentconfig.aiminset or st_aiminset
	top = Vector3.new(front.X, g.center.Y + g.height / 2 - 1 - st_cornerinset - aimdrop, front.Z)
	w = g.width / 2 - 1 - st_cornerinset - aiminset
	return {top + g.wdir * w, top - g.wdir * w}, front, g.ddir * -s
end

function st_near_dist(pts, pos)
	best = math.huge
	for k = 1, #pts - 1 do
		a = pts[k]
		b = pts[k + 1]
		v = b - a
		l2 = v:Dot(v)
		s = l2 > 1e-9 and math.clamp((pos - a):Dot(v) / l2, 0, 1) or 0
		best = math.min(best, (a + v * s - pos).Magnitude)
	end
	return best
end

function st_build_wall_list()
	list = {}
	for _, v in ipairs(ignore) do table.insert(list, v) end
	for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
		if p.Character then table.insert(list, p.Character) end
	end
	for _, g in ipairs(st_find_goals()) do
		if g.inst then table.insert(list, g.inst) end
	end
	table.insert(list, ring_folder)
	table.insert(list, folder)
	return list
end

function st_wall_clear(pts, pos, base_list)
	list = {}
	for i = 1, #base_list do list[i] = base_list[i] end
	params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.RespectCanCollide = true
	params.FilterDescendantsInstances = list
	origin = pts[1]
	first = #pts
	for k = 1, #pts do
		if (pts[k] - origin).Magnitude >= st_wallstart then
			first = k
			break
		end
	end
	size = Vector3.new(st_wallsize, st_wallsize, 0.2)
	step = math.max(1, st_wallstep)
	k = first
	a = pts[first]
	while k < #pts do
		nk = math.min(k + step, #pts)
		b = pts[nk]
		dir = b - a
		if dir.Magnitude > 0.05 then
			cf = CFrame.lookAt(a, b)
			for _ = 1, 6 do
				hit = workspace:Blockcast(cf, size, dir, params)
				if not hit then break end
				if (hit.Position - pos).Magnitude <= st_wallend then return true end
				if hit.Instance.Parent == workspace.Terrain or hit.Normal.Y > 0.7 then
					table.insert(list, hit.Instance)
					params.FilterDescendantsInstances = list
				else
					return false
				end
			end
		end
		a = b
		k = nk
	end
	return true
end

lock_cache = nil
lock_cache_time = 0
lock_throttle = 0.07
last_origin = Vector3.zero
last_look = Vector3.zero

function st_find_lock(origin, look)
	style = st_find_style()
	if st_autotop_blacklist[style] then return nil end
	if not st_shotsbystyle[style] then return nil end
	now = os.clock()
	look_flat = Vector3.new(look.X, 0, look.Z)
	moved = (origin - last_origin).Magnitude > 1.2
	turned = look_flat.Magnitude > 0.01 and last_look.Magnitude > 0.01 and look_flat.Unit:Dot(last_look.Unit) < 0.985
	if lock_cache and (now - lock_cache_time) < lock_throttle and not moved and not turned then
		return lock_cache
	end
	if #anchors == 0 or not path_count then return nil end
	if look_flat.Magnitude < 1e-3 then
		if st_requirefacing then return nil end
		look_flat = Vector3.new(0, 0, 1)
	end
	look_flat = look_flat.Unit
	target_goal = st_target_goal()
	if not target_goal then return nil end
	corners = {}
	mind = st_currentconfig.mindist
	maxd = st_currentconfig.maxdist
	for _, g in ipairs(st_find_goals()) do
		if g.inst ~= target_goal and not g.inst:IsDescendantOf(target_goal) then continue end
		pts, front, into = st_goal_corners(g, origin)
		to = Vector3.new(front.X - origin.X, 0, front.Z - origin.Z)
		dist = to.Magnitude
		if dist > 1 and dist >= mind and dist <= maxd and (not st_requirefacing or to.Unit:Dot(look_flat) > 0.2) then
			mid = (pts[1] + pts[2]) / 2
			half = (pts[1] - pts[2]).Magnitude / 2
			for _, c in ipairs(pts) do
				inward = Vector3.new(mid.X - c.X, 0, mid.Z - c.Z)
				table.insert(corners, {
					pos = c,
					inward = inward.Magnitude > 1e-6 and inward.Unit or Vector3.zero,
					maxslide = math.min(half, 10),
					into = into,
				})
			end
		end
	end
	if #corners == 0 then
		lock_cache = nil
		return nil
	end
	wall_list = st_build_wall_list()
	pmin = anchors[1].pitch
	pmax = anchors[#anchors].pitch
	n = path_count
	steps = math.max(1, math.ceil((pmax - pmin) * 0.55))
	paths = {}
	for i = 0, steps do
		p = pmin + (pmax - pmin) * i / steps
		paths[i] = {p = p, q = st_path_q(p, n)}
	end
	cur_r = Vector3.new(-look_flat.Z, 0, look_flat.X)
	cur_pitch = math.clamp(math.deg(math.asin(math.clamp(look.Y, -1, 1))), pmin, pmax)
	cur_q = st_path_q(cur_pitch, n)
	cur_pts = {}
	for k = 1, #cur_q do
		cur_pts[k] = origin + cur_r * cur_q[k].X + Vector3.new(0, cur_q[k].Y, 0) + look_flat * cur_q[k].Z
	end
	function solve(pos)
		sv_dc = Vector3.new(pos.X - origin.X, 0, pos.Z - origin.Z).Magnitude
		sv_h = pos.Y - origin.Y
		sv_best = nil
		for i = 0, steps do
			sv_e, sv_k, sv_s = st_plane_hit(paths[i].q, sv_dc, sv_h)
			if not sv_best or sv_e < sv_best.err then
				sv_best = {err = sv_e, p = paths[i].p, k = sv_k, s = sv_s, q = paths[i].q}
			end
		end
		if not sv_best then return nil end
		sv_c = sv_best.p
		for i = -6, 6 do
			sv_p = math.clamp(sv_c + i * 0.15, pmin, pmax)
			sv_q = st_path_q(sv_p, n)
			sv_e, sv_k, sv_s = st_plane_hit(sv_q, sv_dc, sv_h)
			if sv_e < sv_best.err then
				sv_best = {err = sv_e, p = sv_p, k = sv_k, s = sv_s, q = sv_q}
			end
		end
		return sv_best
	end
	function evaluate(pos, sol, into)
		if not sol or sol.err > st_locktol then return end
		if st_requirefacing and st_near_dist(cur_pts, pos) > st_snapdist then return end
		ev_qs = sol.q[sol.k]:Lerp(sol.q[sol.k + 1], sol.s)
		ev_dx = pos.X - origin.X
		ev_dz = pos.Z - origin.Z
		ev_fx = ev_dx * ev_qs.Z + ev_dz * ev_qs.X
		ev_fz = ev_dz * ev_qs.Z - ev_dx * ev_qs.X
		ev_m = math.sqrt(ev_fx * ev_fx + ev_fz * ev_fz)
		if ev_m < 1e-6 then return end
		ev_fx = ev_fx / ev_m
		ev_fz = ev_fz / ev_m
		ev_f = Vector3.new(ev_fx, 0, ev_fz)
		ev_r = Vector3.new(-ev_fz, 0, ev_fx)
		ev_seg = sol.q[sol.k + 1] - sol.q[sol.k]
		ev_hdir = ev_f * ev_seg.Z + ev_r * ev_seg.X
		ev_entry = ev_hdir.Magnitude > 1e-6 and ev_hdir.Unit:Dot(into) or 0
		if ev_entry < math.cos(math.rad(st_currentconfig.maxentry)) then return end
		ev_pts = {}
		ev_len = 0
		for j = 1, sol.k do
			ev_pts[j] = origin + ev_r * sol.q[j].X + Vector3.new(0, sol.q[j].Y, 0) + ev_f * sol.q[j].Z
		end
		ev_pts[sol.k + 1] = pos
		for j = 2, #ev_pts do
			ev_len = ev_len + (ev_pts[j] - ev_pts[j - 1]).Magnitude
		end
		if st_requirereach and ev_len > st_currentlinelength then return end
		if not st_wall_clear(ev_pts, pos, wall_list) then return end
		ev_rad = math.rad(sol.p)
		return {dir = Vector3.new(ev_fx * math.cos(ev_rad), math.sin(ev_rad), ev_fz * math.cos(ev_rad)), k = sol.k, s = sol.s, pos = pos}
	end
	lk_best = nil
	for _, c in ipairs(corners) do
		slide = 0
		while slide <= c.maxslide do
			pos = c.pos + c.inward * slide
			res = evaluate(pos, solve(pos), c.into)
			if res then
				res.slide = slide
				res.near = st_near_dist(cur_pts, pos)
				if not lk_best or res.slide < lk_best.slide - 1e-6 or (math.abs(res.slide - lk_best.slide) < 1e-6 and res.near < lk_best.near) then
					lk_best = res
				end
				break
			end
			slide = slide + 1.8
		end
	end
	lock_cache = lk_best
	lock_cache_time = now
	last_origin = origin
	last_look = look_flat
	return lk_best
end

ring_folder = Instance.new("Folder")
ring_folder.Name = "TrajectoryRings"
ring_key = nil

function st_clear_rings()
	if ring_key then
		ring_folder:ClearAllChildren()
		ring_key = nil
	end
end

function st_make_ring(center, radius, color)
	count = math.clamp(math.ceil(radius / 3.5), 20, 96)
	prev = nil
	for i = 0, count do
		a = i / count * math.pi * 2
		pt = center + Vector3.new(math.cos(a) * radius, 0, math.sin(a) * radius)
		if prev then
			seg = Instance.new("Part")
			seg.Anchored = true
			seg.CanCollide = false
			seg.CanQuery = false
			seg.CanTouch = false
			seg.CastShadow = false
			seg.Material = Enum.Material.SmoothPlastic
			seg.Color = color
			seg.Transparency = st_ringtransparency
			seg.Size = Vector3.new(st_ringthickness, st_ringthickness, (pt - prev).Magnitude + 0.15)
			seg.CFrame = CFrame.lookAt(prev:Lerp(pt, 0.5), pt)
			seg.Parent = ring_folder
		end
		prev = pt
	end
end

function st_update_rings(origin)
	style = st_find_style()
	if not st_shotsbystyle[style] or st_autotop_blacklist[style] then
		st_clear_rings()
		return
	end
	target = st_target_goal()
	goal = nil
	if target then
		for _, g in ipairs(st_find_goals()) do
			if g.inst == target or g.inst:IsDescendantOf(target) then
				goal = g
				break
			end
		end
	end
	if not goal then
		st_clear_rings()
		return
	end
	_, front = st_goal_corners(goal, origin)
	cfg = st_styleconfig[style] or st_defaultconfig
	ex = {ring_folder, folder, goal.inst}
	for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
		if p.Character then table.insert(ex, p.Character) end
	end
	params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.RespectCanCollide = true
	params.FilterDescendantsInstances = ex
	hit = workspace:Raycast(Vector3.new(front.X, goal.center.Y + 5, front.Z), Vector3.new(0, -200, 0), params)
	ground = hit and hit.Position.Y or (goal.center.Y - goal.height / 2)
	center = Vector3.new(front.X, ground + st_ringheight, front.Z)
	key = string.format("%d,%d,%d,%d,%d", math.floor(center.X + 0.5), math.floor(center.Z + 0.5), math.floor(center.Y * 10), cfg.mindist, cfg.maxdist)
	if key ~= ring_key then
		st_clear_rings()
		ring_key = key
		mind = cfg.mindist
		maxd = cfg.maxdist
		if mind > 0 then
			st_make_ring(center, mind, st_ringcolor)
		end
		st_make_ring(center, maxd, st_ringcolor)
	end
	if ring_folder.Parent ~= workspace then
		ring_folder.Parent = workspace
	end
end

ring_last = 0
ring_conn = run_service.Heartbeat:Connect(function()
	if os.clock() - ring_last < 0.3 then return end
	ring_last = os.clock()
	if not (st_autotop and st_autotop_held and st_showrings) then
		st_clear_rings()
		return
	end
	char = player.Character
	root = char and char:FindFirstChild("HumanoidRootPart")
	if root then st_update_rings(root.Position) end
end)

function st_render()
	st_slow_tick()
	cam = workspace.CurrentCamera
	root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not enabled or not live or not cam or not root then
		was_locked = false
		return
	end
	ignore = {
		folder,
		ring_folder,
		player.Character,
	}
	if workspace:FindFirstChild("map") and workspace.map:FindFirstChild("gkbarriar") then
		if workspace.map.gkbarriar:FindFirstChild("Abarriar") then table.insert(ignore, workspace.map.gkbarriar.Abarriar) end
		if workspace.map.gkbarriar:FindFirstChild("Bbarriar") then table.insert(ignore, workspace.map.gkbarriar.Bbarriar) end
	end
	ray_params.FilterDescendantsInstances = ignore
	look = cam.CFrame.LookVector
	lock = nil
	if fire_hold and fire_hold.root.Parent and os.clock() < fire_hold.stop_at then
		lock = fire_hold.lock
		if st_freeze then st_hold_freeze(fire_hold) end
	else
		if fire_hold then st_hold_end() end
		lock = st_autotop and st_autotop_held and st_find_lock(root.Position, look)
	end
	rising = lock and not was_locked
	if rising then st_slow_begin() end
	was_locked = lock and true or false
	if lock then
		look = lock.dir
		cam.CFrame = CFrame.lookAt(cam.CFrame.Position, cam.CFrame.Position + look)
		if rising and st_autofire and st_fire_skill() then
			st_hold_begin(lock, root)
		end
	end
	f = Vector3.new(look.X, 0, look.Z)
	if f.Magnitude < 1e-3 then return end
	f = f.Unit
	r = Vector3.new(-f.Z, 0, f.X)
	pitch = math.clamp(math.deg(math.asin(math.clamp(look.Y, -1, 1))), anchors[1].pitch, anchors[#anchors].pitch)
	q = st_path_q(pitch, #live.segments + 1)
	pts = {}
	for k = 1, #q do
		pts[k] = root.Position + r * q[k].X + Vector3.new(0, q[k].Y, 0) + f * q[k].Z
	end
	if lock then
		pts[lock.k + 1] = pts[lock.k]:Lerp(pts[lock.k + 1], lock.s)
		for j = #pts, lock.k + 2, -1 do
			pts[j] = nil
		end
	end
	travelled = 0
	for k = 2, #pts do
		step = pts[k] - pts[k - 1]
		if travelled + step.Magnitude > st_currentlinelength then
			pts[k] = pts[k - 1] + step.Unit * (st_currentlinelength - travelled)
			for j = #pts, k + 1, -1 do
				pts[j] = nil
			end
			break
		end
		travelled = travelled + step.Magnitude
	end
	for k = 2, #pts do
		hit = st_cast(pts[k - 1], pts[k])
		if hit then
			for j = #pts, k + 1, -1 do
				pts[j] = nil
			end
			pts[k] = hit.Position
			break
		end
	end
	st_layout(live, pts)
end

run_service:BindToRenderStep("shot_predictor", Enum.RenderPriority.Camera.Value + 1, st_render)
render_conn = {Disconnect = function() run_service:UnbindFromRenderStep("shot_predictor") end}

connections = {}

function watch(holder)
	table.insert(connections, holder.AttributeChanged:Connect(function(name)
		if enabled and name:lower() == "style" then
			cached_style_time = 0
			st_rebuild()
		end
	end))
end

watch(player)
if player.Character then watch(player.Character) end
table.insert(connections, player.CharacterAdded:Connect(function(char)
	watch(char)
	cached_style_time = 0
	if enabled then st_rebuild() end
end))

_G.clear_trajectory_lines = function()
	st_hold_end()
	st_autotop_held = false
	render_conn:Disconnect()
	ring_conn:Disconnect()
	if st_input_began_conn then st_input_began_conn:Disconnect() end
	if st_input_ended_conn then st_input_ended_conn:Disconnect() end
	ring_folder:Destroy()
	st_slow_stop(false)
	for _, c in ipairs(connections) do c:Disconnect() end
	folder:Destroy()
end

shotfeats:Toggle("Shot Predictor", "Shows Predicted (NOT EXACT) Trajectory Of Style's Base Curve Shot.", function(state)
	enabled = state
	if enabled then
		st_rebuild()
		folder.Parent = workspace
	else
		folder.Parent = nil
		st_clear_rings()
	end
	starter_gui:SetCore("SendNotification", {Title = "Shot Predictor", Text = enabled and "Enabled." or "Disabled.", Duration = 3})
end)

shotfeats:Toggle("Auto Top Bins", "Req. Shot Predictor On. Hold Bind While Within Rings To Lock Onto Top Bins.", function(state)
	st_autotop = state
	if not state then
		st_autotop_held = false
		st_hold_end()
		st_slow_stop(false)
		st_clear_rings()
		lock_cache = nil
	end
	goals_time = 0
	n = #st_find_goals()
	msg = not state and "Disabled." or n == 0 and "No Goal Found. Disable The Feature, Pick A Team, & Re-Enable." or "Enabled. Hold M2 (Or Your Bind) To Use."
	starter_gui:SetCore("SendNotification", {Title = "Auto Top Bins", Text = msg, Duration = 3})
end)

if shotfeats.Textbox or shotfeats.Input or shotfeats.Box then
	local box_fn = shotfeats.Textbox or shotfeats.Input or shotfeats.Box
	box_fn(shotfeats, "Auto Top Bins Bind", "Enter Key (Example: E, M1, Mouse2). Default Is M2. Blank Resets To M2.", function(text)
		st_set_autotop_bind(text)
	end)
else
	_G.st_set_autotop_bind = st_set_autotop_bind
end

local othersil = maintab2:Folder("Other Features.", Color3.fromRGB(169, 5, 255), true)
othersil:Label("Other Features: Self Explanatory, Other Silent Features.")

local qteState = {
    enabled = false
}

othersil:Toggle("Auto QuickTimeEvent", "Automatically Does QuickTimeEvents, How Else Can I Explain It?", function()
qteState.enabled = not qteState.enabled

local function sendNotification(status)
    if not autoSkillState.suppressNotifs then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "QuickTimeEvent",
            Text = status,
            Duration = 1
        })
    end
end

local function convertNumberToKeyText(text)
    local numberMap = {
        ["1"] = "One", ["2"] = "Two", ["3"] = "Three", ["4"] = "Four", ["5"] = "Five",
        ["6"] = "Six", ["7"] = "Seven", ["8"] = "Eight", ["9"] = "Nine", ["0"] = "Zero"
    }
    return numberMap[text] or text
end

local function isShadeOfGreen(color)
    return color.G > color.R and color.G > color.B
end

local function checkQTE()
    local player = game:GetService("Players").LocalPlayer
    if qteState.enabled and player and player:FindFirstChild("PlayerGui") then
        local qteGui = player.PlayerGui:FindFirstChild("Qte")
        if qteGui and qteGui:FindFirstChild("QTE") then
            for _, descendant in ipairs(qteGui.QTE:GetDescendants()) do
                if descendant:IsA("Frame") or descendant:IsA("TextLabel") then
                    if isShadeOfGreen(descendant.BackgroundColor3) then
                        local textLabel = qteGui.QTE:FindFirstChild("TextLabel")
                        if textLabel then
                            local keyText = convertNumberToKeyText(textLabel.Text)
                            local keyCode = Enum.KeyCode[keyText]
                            if keyCode then
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode, false, game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode, false, game)
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(checkQTE)

sendNotification(qteState.enabled and "Enabled." or "Disabled.")
end)

othersil:Button("Auto QuickTimeEvent (Mobile Version)", "Automatically Does QuickTimeEvents, Rejoin To Disable.", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/mobile%20autoqte%20thingy"))()
end)

local teamHighlightActive = false
local highlightFolder = nil

local function notiy(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Team Highlighting",
        Text = text,
        Duration = 2
    })
end

local function cleanHighlights()
    if highlightFolder then
        highlightFolder:Destroy()
        highlightFolder = nil
    end
end

local function applyHighlights()
    cleanHighlights()
    if not teamHighlightActive then return end

    highlightFolder = Instance.new("Folder")
    highlightFolder.Name = "ActiveTeamHighlights"
    highlightFolder.Parent = game:GetService("CoreGui")

    local localPlayer = game:GetService("Players").LocalPlayer
    if not localPlayer then return end

    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= localPlayer and p.Character then
            local color = (p.Team == localPlayer.Team) and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(255, 50, 50)
            
            local hl = Instance.new("Highlight")
            hl.Name = p.Name .. "_Highlight"
            hl.FillColor = color
            hl.FillTransparency = 0.65
            hl.OutlineColor = color
            hl.OutlineTransparency = 0.2
            hl.Adornee = p.Character
            hl.Parent = highlightFolder
        end
    end
end

othersil:Toggle("Team Highlighting", "Highlights Your Teammates / Enemies Accordingly.", function()
    teamHighlightActive = not teamHighlightActive
    notiy(teamHighlightActive and "Enabled." or "Disabled.")
    
    if teamHighlightActive then
        applyHighlights()
        
        getgenv().HighlightConn1 = game:GetService("Players").PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                task.wait(0.5)
                applyHighlights()
            end)
            p:GetPropertyChangedSignal("Team"):Connect(applyHighlights)
        end)
        
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p ~= game:GetService("Players").LocalPlayer then
                p.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    applyHighlights()
                end)
                p:GetPropertyChangedSignal("Team"):Connect(applyHighlights)
            else
                p:GetPropertyChangedSignal("Team"):Connect(applyHighlights)
            end
        end

        getgenv().HighlightConn2 = game:GetService("RunService").Heartbeat:Connect(function()
            if not teamHighlightActive then return end
            local localPlayer = game:GetService("Players").LocalPlayer
            for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                if p ~= localPlayer and p.Character and not highlightFolder:FindFirstChild(p.Name .. "_Highlight") then
                    applyHighlights()
                    break
                end
            end
        end)
    else
        cleanHighlights()
        if getgenv().HighlightConn1 then getgenv().HighlightConn1:Disconnect() end
        if getgenv().HighlightConn2 then getgenv().HighlightConn2:Disconnect() end
    end
end)

getgenv().AutoStealState = getgenv().AutoStealState or { enabled = false, connections = {} } 
state = getgenv().AutoStealState 

othersil:Toggle("Auto Steal Ball", "Automatically Attempts To Steal When Opponent Whiffs A Counter.", function(v) 
    Players = game:GetService("Players") 
    RunService = game:GetService("RunService") 
    lp = Players.LocalPlayer 
    state.enabled = v 
    animId = "rbxassetid://87049473772388" 
    
    function getHRP(char) 
        return char and char:FindFirstChild("HumanoidRootPart") 
    end 
    
    function stareAt(targetHRP, opponentPlayer) 
        char = lp.Character 
        hrp = getHRP(char) 
        if not hrp or not targetHRP then return end 
        
        if (hrp.Position - targetHRP.Position).Magnitude > 30 then return end
        
        start = tick() 
        conn = RunService.RenderStepped:Connect(function() 
            if not state.enabled or tick() - start > 0.5 then 
                conn:Disconnect() 
                return 
            end 
            pos = hrp.Position 
            tpos = targetHRP.Position 
            hrp.CFrame = CFrame.lookAt(pos, Vector3.new(tpos.X, pos.Y, tpos.Z)) 

			local args = {
    			buffer.fromstring(buffers["base"]),{{"tackle"}}}
			NET:FireServer(unpack(args)) 

        end) 
    end 
    
    function hookCharacter(plr, char) 
        hum = char:WaitForChild("Humanoid") 
        animator = hum:WaitForChild("Animator") 
        conn = animator.AnimationPlayed:Connect(function(track) 
            if not state.enabled then return end 
            if track.Animation and track.Animation.AnimationId == animId then 
                stareAt(getHRP(char), plr) 
            end 
        end) 
        table.insert(state.connections, conn) 
    end 
    
    function hookPlayer(plr) 
        if plr == lp then return end 
        if plr.Character then 
            hookCharacter(plr, plr.Character) 
        end 
        table.insert(state.connections, plr.CharacterAdded:Connect(function(char) 
            hookCharacter(plr, char) 
        end)) 
    end 
    
    if not v then 
        for _, c in ipairs(state.connections) do 
            c:Disconnect() 
        end 
        table.clear(state.connections) 
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Auto Steal",
            Text = "Disabled.",
            Duration = 2
        })
        return 
    end 
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Steal",
        Text = "Enabled.",
        Duration = 2
    })
    
    for _, p in ipairs(Players:GetPlayers()) do 
        hookPlayer(p) 
    end 
    table.insert(state.connections, Players.PlayerAdded:Connect(hookPlayer)) 
end)

local cutsceneState = {
    nocutscene = false
}

othersil:Toggle("No Cutscene", "Shitty Feature For Right Now That Disables Cutscenes.", function()
    cutsceneState.nocutscene = not cutsceneState.nocutscene
    local StarterGui = game:GetService("StarterGui")
    local SoundService = game:GetService("SoundService")
    local tempFolder = SoundService:FindFirstChild("celerontemp") or Instance.new("Folder", SoundService)
    tempFolder.Name = "celerontemp"
    local crowdSound = SoundService:FindFirstChild("football-crowd-3-69245") or tempFolder:FindFirstChild("football-crowd-3-69245")

    StarterGui:SetCore("SendNotification", {
        Title = "No Cutscene",
        Text = cutsceneState.nocutscene and "Enabled." or "Disabled.",
        Duration = 1
    })

    if cutsceneState.nocutscene then
        if crowdSound and crowdSound:IsDescendantOf(SoundService) then
            local clone = crowdSound:Clone()
            clone.Parent = tempFolder
            crowdSound:Stop()
            crowdSound:Destroy()
        end
    else
        local stored = tempFolder:FindFirstChild("football-crowd-3-69245")
        if stored then
            stored.Parent = SoundService
            stored:Play()
        end
    end
end)

local iframeState = {
    enabled = false,
    activeDots = {},
    dotSize = UDim2.new(0, 6, 0, 6),
    offset = Vector3.new(0, 3, 0),
    updateInterval = 0.2
}

othersil:Toggle("IFrame Indicator", "Shows The I-Frame Status Of All Players. (Green = Off, Red = On.)", function()
    iframeState.enabled = not iframeState.enabled

    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "IFrame Indicator",
        Text = iframeState.enabled and "Enabled." or "Disabled.",
        Duration = 3
    })

    local charactersFolder = workspace:FindFirstChild("characters")
    if not charactersFolder then return end

    local function createDot(char)
        if iframeState.activeDots[char] then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local gui = Instance.new("BillboardGui")
        gui.Name = "IframeDot"
        gui.Size = UDim2.new(0, 12, 0, 12)
        gui.StudsOffset = iframeState.offset
        gui.AlwaysOnTop = true
        gui.Adornee = hrp
        gui.Parent = hrp
        local dot = Instance.new("Frame")
        dot.Size = iframeState.dotSize
        dot.Position = UDim2.new(0.5, -3, 0.5, -3)
        dot.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
        dot.BorderSizePixel = 0
        dot.BackgroundTransparency = 0
        dot.Parent = gui
        iframeState.activeDots[char] = dot
    end

    local function updateDot(char, dot)
        local state = char:FindFirstChild("state")
        local iframe = state and state:FindFirstChild("iframe")
        if iframe and iframe:IsA("BoolValue") then
            dot.BackgroundColor3 = iframe.Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
        else
            dot.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
        end
    end

    local function clearDots()
        for char, dot in pairs(iframeState.activeDots) do
            if dot and dot.Parent then
                dot.Parent:Destroy()
            end
        end
        iframeState.activeDots = {}
    end

    if iframeState.enabled then
        for _, char in ipairs(charactersFolder:GetChildren()) do
            createDot(char)
        end
        charactersFolder.ChildAdded:Connect(function(char)
            task.wait(0.5)
            if iframeState.enabled then
                createDot(char)
            end
        end)
        task.spawn(function()
            while iframeState.enabled do
                for char, dot in pairs(iframeState.activeDots) do
                    if char and dot then
                        updateDot(char, dot)
                    end
                end
                for _, char in ipairs(charactersFolder:GetChildren()) do
                    if not iframeState.activeDots[char] then
                        createDot(char)
                    end
                end
                task.wait(iframeState.updateInterval)
            end
        end)
    else
        clearDots()
    end
end)

othersil:Button("Fix Duplicate Ball", "I Don't Know If This Is Still An Issue But Removes Duplicate Balls If Existent.", function()
    for _, obj in ipairs(workspace.Terrain:GetDescendants()) do
        if obj:IsA("MeshPart") and obj.Name == "Ball" then
            obj:Destroy()
        end
    end
end)

local bindKey = Enum.KeyCode.Y

local formlessState = {
    enabled = false
}

local function notiy(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Formless",
        Text = text,
        Duration = 2
    })
end

othersil:Toggle("Auto Formless", "Shidou Only Formless Macro.", function()
    formlessState.enabled = not formlessState.enabled
    notiy(formlessState.enabled and "Enabled." or "Disabled.")

    if formlessState.inputConnection then
        formlessState.inputConnection:Disconnect()
        formlessState.inputConnection = nil
    end

    if formlessState.enabled then
        formlessState.inputConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
            if gp or input.KeyCode ~= bindKey then return end
            if game:GetService("UserInputService").MouseBehavior ~= Enum.MouseBehavior.LockCenter then return end

            local LP = game:GetService("Players").LocalPlayer
            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            hum.AutoRotate = false

            local Camera = workspace.CurrentCamera
            local camType = Camera.CameraType
            local camSubject = Camera.CameraSubject
            local camCF = Camera.CFrame
            local flipped = camCF * CFrame.Angles(0, math.rad(180), 0)

            Camera.CameraType = Enum.CameraType.Scriptable
            Camera.CFrame = flipped

            task.delay(0.1, function()
                if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                    Camera.CameraSubject = LP.Character:FindFirstChildOfClass("Humanoid")
                    Camera.CameraType = Enum.CameraType.Custom
                else
                    Camera.CameraSubject = camSubject
                    Camera.CameraType = camType
                end
                hum.AutoRotate = true
            end)

            task.wait(0.15)

            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://76587445975710"
            local track = hum:LoadAnimation(anim)
            track:Play()

            local dir = hrp.CFrame.LookVector
            local kickVec = vector.create(dir.X * 0.5, 1, dir.Z * 0.5)

            local remote = NET
            remote:FireServer(buffer.fromstring(buffers["base"]), { { "kick", 25, false, kickVec } })
            NET:FireServer(
                buffer.fromstring(buffers["base"]), { { "skill1" } }
            )
        end)
    end
end)

othersil:Textbox("Formless Keybind", "Enter Key (Example: Y, V, L.)", function(text)
    if typeof(text) ~= "string" then
        bindKey = Enum.KeyCode.Y
        notiy("Invalid Key. Bind Is Now Y.")
        return
    end

    local formatted = text:gsub("%s+", "")
    local success, key = pcall(function()
        return Enum.KeyCode[formatted]
    end)

    if success and key then
        bindKey = key
        notiy("Bind Set To: " .. key.Name)
    else
        bindKey = Enum.KeyCode.Y
        notiy("Invalid Key. Bind Is Now Y.")
    end
end)

local mobile = maintab2:Folder("Mobile Silent Features.", Color3.fromRGB(169, 5, 255), true)
mobile:Label("Mobile Silent Features: Silent Features Ported To Mobile.")

local mobform = {
    gui = nil,
    active = false
}

local function trigger()
    if game:GetService("UserInputService").MouseBehavior ~= Enum.MouseBehavior.LockCenter then return end
    local lp = game:GetService("Players").LocalPlayer
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    hum.AutoRotate = false
    local cam = workspace.CurrentCamera
    local camType = cam.CameraType
    local camSubject = cam.CameraSubject
    local camCF = cam.CFrame
    local flipped = camCF * CFrame.Angles(0, math.rad(180), 0)

    cam.CameraType = Enum.CameraType.Scriptable
    cam.CFrame = flipped

    task.delay(0.1, function()
        if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
            cam.CameraSubject = lp.Character:FindFirstChildOfClass("Humanoid")
            cam.CameraType = Enum.CameraType.Custom
        else
            cam.CameraSubject = camSubject
            cam.CameraType = camType
        end
        if hum and hum.Parent then
            hum.AutoRotate = true
        end
    end)

    task.wait(0.15)

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://76587445975710"
    local track = hum:LoadAnimation(anim)
    track:Play()

    local dir = hrp.CFrame.LookVector
    local kickVec = Vector3.new(dir.X * 0.5, 1, dir.Z * 0.5)

    NET:FireServer(buffer.fromstring(buffers["base"]), { { "kick", 25, false, kickVec } })
    NET:FireServer(buffer.fromstring(buffers["base"]), { { "skill1" } })
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function show()
    if mobform.gui then return end
    local pg = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local sg = Instance.new("ScreenGui")
    sg.Name = "FormlessMobile"
    sg.ResetOnSpawn = false
    sg.Parent = pg
    mobform.gui = sg

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = UDim2.new(0.5, -50, 0.5, -50)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.BorderSizePixel = 0
    btn.Text = "Formless"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.AutoButtonColor = true
    btn.Parent = sg

    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0, 8)
    cr.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)

    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    end)

    btn.Activated:Connect(trigger)

    makeDraggable(btn)
end

local function hide()
    if mobform.gui then
        mobform.gui:Destroy()
        mobform.gui = nil
    end
end

mobile:Button("Auto Formless (Mobile Button.)", "Click Again To Remove Button.", function()
    mobform.active = not mobform.active
    if mobform.active then
        show()
    else
        hide()
    end
end)

local airDribble = {
    gui = nil,
    active = false,
    enabled = true
}

local function trigger()
    if not airDribble.enabled then return end
    local char = game:GetService("Players").LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://76587445975710"
    hum:LoadAnimation(anim):Play()

    local dir = hrp.CFrame.LookVector
    local kickVec = Vector3.new(dir.X * 0.75, 0.65, dir.Z * 0.75)

    NET:FireServer(
        buffer.fromstring(buffers["base"]),
        { { "kick", 28, false, kickVec } }
    )
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function show()
    if airDribble.gui then return end
    local sg = Instance.new("ScreenGui")
    sg.Name = "AirDribbleMobile"
    sg.ResetOnSpawn = false
    sg.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    airDribble.gui = sg

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = UDim2.new(0.5, -50, 0.5, -50)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.BorderSizePixel = 0
    btn.Text = "Air Dribble"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.AutoButtonColor = true
    btn.Parent = sg

    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0, 8)
    cr.Parent = btn

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15) end)
    btn.Activated:Connect(trigger)
    makeDraggable(btn)
end

local function hide()
    if airDribble.gui then
        airDribble.gui:Destroy()
        airDribble.gui = nil
    end
end

mobile:Button("Air Dribble (Mobile Button)", "Click Again To Remove Button.", function()
    airDribble.active = not airDribble.active
    if airDribble.active then show() else hide() end
end)

mobilessss = maintab2:Folder("Mobile Simulation Features.", Color3.fromRGB(169, 5, 255), true)

getgenv().MobileKeySystem = getgenv().MobileKeySystem or { key = "", buttons = {} }

local function normalizeKey(key)
    if not key then return nil end
    key = tostring(key):gsub("%s+", ""):lower()
    local map = {
        leftalt = "LeftAlt",
        rightalt = "RightAlt",
        leftshift = "LeftShift",
        rightshift = "RightShift",
        leftctrl = "LeftControl",
        rightctrl = "RightControl",
        enter = "Return",
        returnkey = "Return",
        space = "Space",
        backspace = "Backspace",
        delete = "Delete",
        tab = "Tab",
        escape = "Escape",
    }
    if map[key] then return map[key] end
    if key:find("mouse") then return nil end
    if #key == 1 and key:match("%a") then return key:upper() end
    if key:match("^%d$") then return key end
    return key:sub(1,1):upper() .. key:sub(2)
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

mobilessss:Textbox("Key To Simulate", "Enter Key To Simulate (Example: C, Z, LeftAlt.)", function(v)
    getgenv().MobileKeySystem.key = normalizeKey(v)
end)

mobilessss:Button("Create Mobile PC Key", "Creates A Mobile PC Key.", function()
    local key = getgenv().MobileKeySystem.key
    if not key then return end

    local sg = Instance.new("ScreenGui")
    sg.Name = "MobileKey_" .. key
    sg.ResetOnSpawn = false
    sg.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = UDim2.new(0.5, math.random(-150, 150), 0.5, math.random(-150, 150))
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.BorderSizePixel = 0
    btn.Text = key
    btn.BackgroundTransparency = 0.4
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.Parent = sg

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local vim = game:GetService("VirtualInputManager")
    local holding = false

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if not holding then
                holding = true
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                vim:SendKeyEvent(true, Enum.KeyCode[key], false, game)
            end
        end
    end)

    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if holding then
                holding = false
                btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                vim:SendKeyEvent(false, Enum.KeyCode[key], false, game)
            end
        end
    end)

    makeDraggable(btn)
    table.insert(getgenv().MobileKeySystem.buttons, sg)
end)

mobilessss:Button("Remove Mobile PC Keys", "Removes All Mobile PC Keys.", function()
    for _, v in ipairs(getgenv().MobileKeySystem.buttons) do
        if v then v:Destroy() end
    end
    table.clear(getgenv().MobileKeySystem.buttons)
end)

funtab:Label("Celeron's Movesets, Recommend Using In Normal Servers.")

funtab:Button("Goku Moveset (Req. Isagi)", "Click F4 To Disable.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Credits",
        Text = "brought to you by celeron!",
        Duration = 5,
        Button1 = "OK",
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/goku%20moveset%20(azl)",true))()
end)

funtab:Button("Aizen Moveset (Req. Isagi)", "Click F4 To Disable.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Credits",
        Text = "brought to you by celeron!",
        Duration = 5,
        Button1 = "OK",
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/aizen%20moveset",true))()
end)

funtab:Button("Loki Moveset (V2) (Req. Isagi.)", "Click F4 To Disable, Rejoin To Fix Isagi Music.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Credits",
        Text = "brought to you by celeron!",
        Duration = 5,
        Button1 = "OK",
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/loki%20v2"))()
end)

funtab:Button("Ronaldo Moveset (V3) (Req. Shidou)", "Click F4 To Disable.", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/ronaldov3"))()
end)

funtab:Label("Daffy's Movesets.")

funtab:Button("Gojo Moveset (Req. Isagi.)", "Click F4 To Disable.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Credits",
        Text = "brought to you by daffy!",
        Duration = 5,
        Button1 = "OK",
    })
    loadstring(game:HttpGet("https://pastebin.com/raw/TH8xDy9X"))()
end)

funtab:Button("Hugo Moveset (Early Access.) (Req. Kunigami)", "Click F4 To Disable, Rejoin To Fix Kunigami Music.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Credits",
        Text = "brought to you by daffy!",
        Duration = 5,
        Button1 = "OK",
    })
loadstring(game:HttpGet("https://pastebin.com/raw/ND6yrPyk"))()
end)

funtab:Button("Naoya Moveset (Req. Sae)", "Click F4 To Disable.", function()
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Credits",
        Text = "brought to you by daffy!",
        Duration = 5,
        Button1 = "OK",
    })
    loadstring(game:HttpGet("https://pastebin.com/raw/PDwm0ZcF"))()
end)

misctab:Button("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

teleporttab:Button("Middle Field", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-540, 3, 1274)
end)

teleporttab:Button("Commentator Area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6, 2, 3237)
end)

teleporttab:Button("Goal Box (A)", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-537, 3, 1575)
end)

teleporttab:Button("Goal Box (B)", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-534, 3, 974)
end)

misctab:Toggle("Enable All Dubs / Voicelines", "Enables Dub Voicelines For All Styles.", function(sts)
    local lp = game:GetService("Players").LocalPlayer
    local setting = lp:FindFirstChild("setting")

    if setting then
        for _, child in ipairs(setting:GetChildren()) do
            if string.sub(string.lower(child.Name), 1, 3) == "dub" then
                child.Value = sts
            end
        end
    end

    game.StarterGui:SetCore("SendNotification", {
        Title = "Dub Voicelines",
        Text = sts and "Enabled." or "Disabled.",
        Duration = 1
    })
end)

misctab:Label("Emotes.")

local emoteStates = {
    toosie = false,
    sae = false,
    assumptions = false
}

misctab:Toggle("Toosie Slide", function()
    emoteStates.toosie = not emoteStates.toosie

    local animationId = "rbxassetid://95959941666543"
    local soundId = "rbxassetid://1845341094"

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")

    local animation = Instance.new("Animation")
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)

    local sound

    if emoteStates.toosie then
        animationTrack:Play()
        sound = Instance.new("Sound")
        sound.Name = "Toosie Slide"
        sound.SoundId = soundId
        sound.Looped = true
        sound.Parent = game.SoundService
        sound:Play()
    else
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:Stop()
        end

        local existingSound = game.SoundService:FindFirstChild("Toosie Slide")
        if existingSound then
            existingSound:Stop()
            existingSound:Destroy()
        end
    end
end)

misctab:Toggle("Sae Pose", function()
    emoteStates.sae = not emoteStates.sae

    local animationId = "rbxassetid://136812327261825"
    local soundId = "rbxassetid://1843404009"

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")

    local animation = Instance.new("Animation")
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)

    local sound

    if emoteStates.sae then
        animationTrack:Play()
        sound = Instance.new("Sound")
        sound.Name = "Sae Pose"
        sound.SoundId = soundId
        sound.Volume = 1
        sound.Looped = true
        sound.Parent = game.SoundService
        sound:Play()
    else
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:Stop()
        end

        local existingSound = game.SoundService:FindFirstChild("Sae Pose")
        if existingSound then
            existingSound:Stop()
            existingSound:Destroy()
        end
    end
end)

misctab:Toggle("Assumptions", function()
    emoteStates.assumptions = not emoteStates.assumptions

    local animationId = "rbxassetid://108778663919542"
    local soundId = "rbxassetid://137023124734348"

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")

    local animation = Instance.new("Animation")
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)

    local sound

    if emoteStates.assumptions then
        animationTrack:Play()
        sound = Instance.new("Sound")
        sound.Name = "Assumptions"
        sound.SoundId = soundId
        sound.PlaybackSpeed = 0.17
        sound.Volume = 0.6
        sound.Looped = true
        sound.Parent = game.SoundService

        local eq = Instance.new("EqualizerSoundEffect")
        eq.LowGain = 10
        eq.MidGain = 0
        eq.HighGain = 4
        eq.Parent = sound

        sound:Play()
    else
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:Stop()
        end

        local existingSound = game.SoundService:FindFirstChild("Assumptions")
        if existingSound then
            existingSound:Stop()
            existingSound:Destroy()
        end
    end
end)

misctab:Button("Akuma Taunt", function()
    local animationId = "rbxassetid://111005363990501"
    local soundId = "rbxassetid://133370927301258"

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")

    local animation = Instance.new("Animation")
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)

    local sound = Instance.new("Sound")
    sound.Name = "Akuma Taunt"
    sound.SoundId = soundId
    sound.Volume = 10
    sound.Parent = game.SoundService

    animationTrack:Play()
    sound:Play()

    sound.Ended:Connect(function()
        sound:Destroy()
    end)

    animationTrack.Stopped:Connect(function()
        animationTrack:Stop()
    end)
end)

misctab:Button("Cartoon Fall", function()
    local animationId = "rbxassetid://98064370044269"
    local soundIds = { "rbxassetid://8663054927", "rbxassetid://4979513906" }

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")

    local animation = Instance.new("Animation")
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)

    local sound = Instance.new("Sound")
    sound.Name = "Ragdoll"
    sound.Volume = 10
    sound.Parent = game.SoundService

    local currentIndex = 1

    local function playNextSound()
        if currentIndex <= #soundIds then
            sound.SoundId = soundIds[currentIndex]
            sound:Play()

            sound.Ended:Connect(function()
                currentIndex = currentIndex + 1
                playNextSound()
            end)
        else
            sound:Destroy()
        end
    end
    animationTrack:Play()
    playNextSound()
end)

misctab:Button("Spit", function()
    local animationId = "rbxassetid://97257010665720"
    local soundId = "rbxassetid://18111052648"

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")

    local animation = Instance.new("Animation")
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)

    local sound = Instance.new("Sound")
    sound.Name = "Spit"
    sound.SoundId = soundId
    sound.Volume = 2
    sound.Parent = game.SoundService

    animationTrack:Play()
    sound:Play()

    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end)

exploittab:Label("Semi-Private Server: People MAY Still Join Depending On Updates.")

exploittab:Button("Semi-Private Server Info", "This Comes With Instructions On How To Use The Feature Below.", function()
    local StarterGui = game:GetService("StarterGui")

    StarterGui:SetCore("SendNotification", {
        Title = "Semi-Private Server Info",
        Text = "If you end up in a server with another player, block someone.",
        Duration = 10
    }) task.wait(0.5)
    StarterGui:SetCore("SendNotification", {
        Title = "Semi-Private Server Info",
        Text = "After blocking a player in that server, run the feature to create a server again!",
        Duration = 10
    })
end)

exploittab:Button("Semi-Private Server (Method: 11v11)", "This Feature Creates A Server Where You Can Farm Goals / Quests!", function()
    game:GetService("TeleportService"):Teleport(85946466968831, game.Players.LocalPlayer)
end)

exploittab:Label("Farming Safety Mode: Protects You While Farming.")

players_service_58214 = game:GetService("Players")
run_service_93071 = game:GetService("RunService")
starter_gui_41826 = game:GetService("StarterGui")

if workspace:FindFirstChild("sfjusrjgdtriugji") then
    workspace.sfjusrjgdtriugji:Destroy()
end

Instance.new("Part", workspace).Name = "sfjusrjgdtriugji"; workspace.sfjusrjgdtriugji.Size = Vector3.new(512, 1, 512) ; workspace.sfjusrjgdtriugji.Transparency = 1 ;workspace.sfjusrjgdtriugji.Position = Vector3.new(-426, 1700, 1443); workspace.sfjusrjgdtriugji.Anchored = true

safe_positions_67352 = {
    goal_farm = Vector3.new(-765, 3, 1304),
    save_farm = Vector3.new(-805, 3, 1100),
    kick_spot = Vector3.new(-426, 1705, 1443)
}

safety_state_20948 = {
    limit = nil,
    enabled = false,
    active = false,
    resume_goal = false,
    resume_kick = false,
    saved_cframe = nil,
    sequence_id = 0
}

function notify_85613(title, text, duration)
    starter_gui_41826:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 2})
end

function teleport_exact_31759(position)
    local char = players_service_58214.LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        char:PivotTo(CFrame.new(position))
    end
end

function teleport_to_safe_74280(position)
    local char = players_service_58214.LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        local angle = math.random() * math.pi * 2
        local distance = math.sqrt(math.random()) * 50
        local offset = Vector3.new(math.cos(angle) * distance, 3, math.sin(angle) * distance)
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        char:PivotTo(CFrame.new(position + offset))
    end
end

exploittab:Textbox("Safety Player Limit", "Set The Limit Of Players Before The Farm Protects You.", function(v)
    local n = tonumber(v)
    if n then
        safety_state_20948.limit = n
    else
        safety_state_20948.limit = nil
    end
end)

exploittab:Toggle("Enable Farming Safety Mode", "Toggles The Above Feature.", function(v)
    safety_state_20948.enabled = v
    notify_85613("Farming Safety Mode", v and "Enabled." or "Disabled.", 2)
end)

exploittab:Label("Goal Farming: Use At Your Own Risk, I Am Not Responsible For Bans.")

goal_farm_state_52097 = {
    enabled = false,
    cf_conn = nil,
    render_conn = nil,
    stop_at = nil,
    goal = 0,
    desc = "not-started",
    busy = false,
    track_id = 0
}

buffer = buffer or {
    fromstring = function(str)
        return str
    end
}

goal_players_16843 = game:GetService("Players")
goal_map_folder_89405 = workspace:WaitForChild("map")
goal_a_goal_37126 = goal_map_folder_89405:WaitForChild("Agoal")
goal_b_goal_60581 = goal_map_folder_89405:WaitForChild("Bgoal")
goal_local_player_24730 = goal_players_16843.LocalPlayer

function is_in_game_95318()
    local char = goal_local_player_24730.Character
    local state = char and char:FindFirstChild("state")
    local ingame = state and state:FindFirstChild("ingame")
    return ingame and ingame.Value or false
end

function disable_collision_boxes_48267()
    local map = workspace:FindFirstChild("map")
    if not map then return end
    local gk = map:FindFirstChild("gkbarriar")
    local a_goal = map:FindFirstChild("Agoal")
    local b_goal = map:FindFirstChild("Bgoal")
    if gk then
        local a_bar = gk:FindFirstChild("A")
        local b_bar = gk:FindFirstChild("B")
        if a_bar then a_bar.CanCollide = false end
        if b_bar then b_bar.CanCollide = false end
    end
    if a_goal then a_goal.CanCollide = false end
    if b_goal then b_goal.CanCollide = false end
end

function goal_farm_blocked_71093()
    return safety_state_20948.active or not goal_farm_state_52097.enabled
end

function steal_ball_13582()
    local char = goal_local_player_24730.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local ball = workspace.Terrain:FindFirstChild("Ball")
    if root and ball then
        task.wait(0.5)
        if goal_farm_blocked_71093() then return end
        root.CFrame = CFrame.new(ball.Position.X, 0, ball.Position.Z)
    end
    for _, opp in pairs(goal_players_16843:GetPlayers()) do
        if goal_farm_blocked_71093() then return end
        if opp ~= goal_local_player_24730 then
            local o_char = opp.Character
            local o_ball = o_char and o_char:FindFirstChild("Ball")
            local o_root = o_char and o_char:FindFirstChild("HumanoidRootPart")
            if o_ball and o_root and root then
                task.wait(0.5)
                if goal_farm_blocked_71093() then return end
                root.CFrame = o_ball.CFrame
                NET:FireServer(unpack({buffer.fromstring(buffers["base"]), {{"tackle"}}}))
            end
        end
    end
end

function has_ball_86904()
    local char = goal_local_player_24730.Character
    return char and char:FindFirstChild("Ball") ~= nil
end

function disconnect_goal_farm_29671()
    if goal_farm_state_52097.cf_conn then
        goal_farm_state_52097.cf_conn:Disconnect()
        goal_farm_state_52097.cf_conn = nil
    end
    if goal_farm_state_52097.render_conn then
        goal_farm_state_52097.render_conn:Disconnect()
        goal_farm_state_52097.render_conn = nil
    end
    goal_farm_state_52097.busy = false
end

function stop_goal_farm_logic_53748()
    goal_farm_state_52097.enabled = false
    goal_farm_state_52097.track_id = goal_farm_state_52097.track_id + 1
    disconnect_goal_farm_29671()
end

function stop_goal_farm_80215()
    if not goal_farm_state_52097.enabled then return end
    stop_goal_farm_logic_53748()
    notify_85613("Goal Farm", "Target Reached! :3", 2)
end

function track_goals_loop_46139()
    goal_farm_state_52097.track_id = goal_farm_state_52097.track_id + 1
    local id = goal_farm_state_52097.track_id
    task.spawn(function()
        local goals = goal_local_player_24730:WaitForChild("leaderstats"):WaitForChild("goals")
        while goal_farm_state_52097.enabled and goal_farm_state_52097.track_id == id do
            task.wait(1)
            if goal_farm_state_52097.stop_at and goals.Value >= goal_farm_state_52097.stop_at then
                stop_goal_farm_80215()
                return
            end
        end
    end)
end

function start_goal_farm_97462()
    goal_farm_state_52097.enabled = true
    disconnect_goal_farm_29671()

    goal_farm_state_52097.cf_conn = goal_local_player_24730.CharacterAdded:Connect(function()
        task.wait(1)
        if goal_farm_state_52097.enabled and not safety_state_20948.active then
            firePacketsIfNear()
        end
    end)

    task.spawn(function()
        repeat task.wait() until goal_local_player_24730.Character and goal_local_player_24730.Character:FindFirstChild("HumanoidRootPart")
        if goal_farm_state_52097.enabled and not safety_state_20948.active then
            firePacketsIfNear()
        end
    end)

    goal_farm_state_52097.render_conn = run_service_93071.RenderStepped:Connect(function()
        if goal_farm_blocked_71093() or goal_farm_state_52097.busy then return end
        goal_farm_state_52097.busy = true

        pcall(function()
            if not is_in_game_95318() then return end
            disable_collision_boxes_48267()
            steal_ball_13582()

            if goal_farm_blocked_71093() then return end

            if has_ball_86904() then
                local char = goal_local_player_24730.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local target_goal = goal_local_player_24730.Team.Name == "A" and goal_b_goal_60581 or goal_a_goal_37126

                if root and target_goal then
                    task.wait(0.75)
                    if goal_farm_blocked_71093() then return end
                    root.CFrame = target_goal.CFrame

                    task.wait(0.175)
                    if goal_farm_blocked_71093() then return end
                    NET:FireServer("base", {{"kick", 50, false, vector.create(0, 1, 0)}})

                    firePacketsIfNear()
                end
            end
        end)

        goal_farm_state_52097.busy = false
    end)

    track_goals_loop_46139()
end

exploittab:Button("Goal Farm Info", "This Comes With Instructions On How To Use The Feature Below.", function()
    notify_85613("Goal Farm Info", "Turn The Feature On For BOTH ACCOUNTS On SEPERATE TEAMS.", 10)
end)

exploittab:Button("Goal Farm", "Automatically Farms Goals For You.", function()
    if goal_farm_state_52097.enabled then
        stop_goal_farm_logic_53748()
        notify_85613("Goal Farm", "Disabled.", 1)
    else
        start_goal_farm_97462()
        notify_85613("Goal Farm", "Enabled.", 1)
    end
end)

exploittab:Textbox("Goal Target", "Enter A Number Of Goals To Stop Farming At.", function(v)
    local num = tonumber(v)
    if num then
        goal_farm_state_52097.stop_at = num
        notify_85613("Goal Target", "Goal Target: " .. num, 2)
    else
        goal_farm_state_52097.stop_at = math.huge
        notify_85613("Goal Target", "Invalid Target, Farm Will Be Infinite.", 2)
    end
end)

exploittab:Label("Save Farming: Use At Your Own Risk, I Am Not Responsible For Bans.")

exploittab:Button("Save Farm Info", "This Comes With Instructions On How To Use The Feature Below.", function()
    notify_85613("Save Farm Info", "Use When Score Is Tied, Farming Account Must Be GK On TEAM A, And Helper Account As CF On TEAM B.", 10)
end)

exploittab:Button("Farming Account Position TP", "Use This Feature On FARMING ACCOUNT Before Enabling Automatic Kicking.", function()
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(workspace.map.Agoal.CFrame.Position + Vector3.new(-26.38, -4.69, -20.02)) * CFrame.Angles(-3.14, 1.56, 3.14))
end)

exploittab:Button("Helper Account Position TP", "Use This Feature On HELPER ACCOUNT Before Enabling Automatic Kicking.", function()
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(workspace.map.Agoal.CFrame.Position + Vector3.new(-61.76, -4.64, -20.32)) * CFrame.Angles(3.14, -1.56, 3.14))
end)

if getgenv().automatickickingpower == nil then
    getgenv().automatickickingpower = 22
end

exploittab:Textbox("Kick Power", "Sets The Power Of The Automatic Kicking (Default: 22)", function(text)
    local numeric_power = tonumber(text)

    if numeric_power then
        getgenv().automatickickingpower = numeric_power
        notify_85613("Kick Power Updated", "Power: " .. tostring(numeric_power), 1.5)
    else
        getgenv().automatickickingpower = 22
        notify_85613("Invalid Number", "Power Set To Default.", 1.5)
    end
end)

function stop_auto_kick_32850()
    getgenv().automatickickingenabled = false
    getgenv().automatickickingloopid = (getgenv().automatickickingloopid or 0) + 1
    if getgenv().automatickickingconnection then
        getgenv().automatickickingconnection:Disconnect()
        getgenv().automatickickingconnection = nil
    end
end

function start_auto_kick_61927(recover_first)
    stop_auto_kick_32850()
    getgenv().automatickickingenabled = true
    local loop_id = getgenv().automatickickingloopid

    local plr = players_service_58214.LocalPlayer
    local kick_interval = 0.1
    local last_kick = 0
    local recovering = recover_first == true

    getgenv().automatickickingconnection = run_service_93071.Heartbeat:Connect(function()
        if not getgenv().automatickickingenabled or getgenv().automatickickingloopid ~= loop_id then
            if getgenv().automatickickingconnection then
                getgenv().automatickickingconnection:Disconnect()
                getgenv().automatickickingconnection = nil
            end
            return
        end

        if safety_state_20948.active then return end

        local char = plr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if recovering then
            if not root then
                return
            end
            local loose_ball = workspace.Terrain:FindFirstChild("Ball")
            if loose_ball then
                root.CFrame = CFrame.new(loose_ball.Position)
                return
            end
            recovering = false
            if safety_state_20948.saved_cframe then
                root.CFrame = safety_state_20948.saved_cframe
            end
            safety_state_20948.saved_cframe = nil
            last_kick = os.clock()
            return
        end

        local ball = char and char:FindFirstChild("Ball")

        if not root or not ball then
            return
        end

        local now = os.clock()
        if now - last_kick < kick_interval then
            return
        end
        last_kick = now

        local look = root.CFrame.LookVector
        local power = getgenv().automatickickingpower or 22

        NET:FireServer("base", {{"kick", power, false, vector.create(look.X, look.Y, look.Z)}})
    end)
end

exploittab:Button("Automatic Kicking", "Automatically Kicks The Ball Infront Of You.", function()
    if getgenv().automatickickingenabled then
        stop_auto_kick_32850()
        notify_85613("Automatic Kicking", "Disabled.", 1)
    else
        start_auto_kick_61927(false)
        notify_85613("Automatic Kicking", "Enabled.", 1)
    end
end)

function sequence_stale_75384(id)
    return safety_state_20948.sequence_id ~= id or not safety_state_20948.active
end

function enter_safety_18603()
    safety_state_20948.sequence_id = safety_state_20948.sequence_id + 1
    local id = safety_state_20948.sequence_id

    safety_state_20948.resume_goal = goal_farm_state_52097.enabled
    safety_state_20948.resume_kick = getgenv().automatickickingenabled == true

    if not safety_state_20948.resume_goal and not safety_state_20948.resume_kick then
        return
    end

    local char = players_service_58214.LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if safety_state_20948.resume_kick and root then
        safety_state_20948.saved_cframe = root.CFrame
    end

    if safety_state_20948.resume_goal then
        stop_goal_farm_logic_53748()
    end
    if safety_state_20948.resume_kick then
        stop_auto_kick_32850()
    end

    local afk_position = safety_state_20948.resume_goal and safe_positions_67352.goal_farm or safe_positions_67352.save_farm
    local needs_ball = safety_state_20948.resume_kick

    task.spawn(function()
        task.wait(0.1)
        if sequence_stale_75384(id) then return end

        if needs_ball then
            while not has_ball_86904() do
                task.wait(0.1)
                if sequence_stale_75384(id) then return end
            end
        end

        teleport_exact_31759(safe_positions_67352.kick_spot)

        task.wait(0.3)
        if sequence_stale_75384(id) then return end
        NET:FireServer("base", {{"kick", 1, false, vector.create(0, 1, 0)}})

        task.wait(0.3)
        if sequence_stale_75384(id) then return end
        teleport_to_safe_74280(afk_position)
    end)
end

function exit_safety_44091()
    safety_state_20948.sequence_id = safety_state_20948.sequence_id + 1

    local resume_goal = safety_state_20948.resume_goal
    local resume_kick = safety_state_20948.resume_kick
    safety_state_20948.resume_goal = false
    safety_state_20948.resume_kick = false

    if resume_goal then
        start_goal_farm_97462()
    end
    if resume_kick then
        start_auto_kick_61927(true)
    end
end

if getgenv().safety_monitor_connection then
    getgenv().safety_monitor_connection:Disconnect()
    getgenv().safety_monitor_connection = nil
end

getgenv().safety_monitor_connection = run_service_93071.Heartbeat:Connect(function()
    local should_be_active = safety_state_20948.enabled
        and safety_state_20948.limit ~= nil
        and #players_service_58214:GetPlayers() > safety_state_20948.limit

    if should_be_active ~= safety_state_20948.active then
        safety_state_20948.active = should_be_active
        if should_be_active then
            notify_85613("Farming Safety Mode", "Too Many Players, Farms Turned Off.", 3)
            enter_safety_18603()
        else
            notify_85613("Farming Safety Mode", "Clear, Farms Resumed.", 3)
            exit_safety_44091()
        end
    end
end)

exploittab:Label("Anti AFK: Useful For Excess Alts To Allow Farming Goals / Saves.")

getgenv().antiAFK = false
lastInputTime = tick()

game:GetService("UserInputService").InputBegan:Connect(function()
	lastInputTime = tick()
end)

task.spawn(function()
	while true do
		if getgenv().antiAFK and tick() - lastInputTime >= 60 then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
			task.wait(0.1)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
			lastInputTime = tick()
		end
		task.wait(1)
	end
end)

exploittab:Toggle("Anti AFK", function()
	getgenv().antiAFK = not getgenv().antiAFK
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Anti AFK",
		Text = getgenv().antiAFK and "Enabled." or "Disabled.",
		Duration = 3
	})
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Scripts/refs/heads/main/oldthingyep",true))()
loadstring(game:HttpGet("https://pastebin.com/raw/rQMS2B9R",true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/owner_anti_abuse_from_users"))()
end
