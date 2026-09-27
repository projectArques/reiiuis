local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")

local Library = {}
Library.Drawings      = {}
Library.Connections   = {}
Library.ThemeUpdaters = {}
Library.ConfigData    = {}
Library.CurrentThemeName = "Default"

local FONT = 0

Library.Themes = {
    Default = {
        Bg=Color3.fromRGB(14,16,22),       Bar=Color3.fromRGB(19,22,30),
        Accent=Color3.fromRGB(72,201,255), GroupBg=Color3.fromRGB(19,22,30),
        GroupBorder=Color3.fromRGB(38,44,58), GroupHead=Color3.fromRGB(24,28,38),
        TabOn=Color3.fromRGB(255,255,255), TabOff=Color3.fromRGB(122,130,148),
        Text=Color3.fromRGB(240,243,248),  Dim=Color3.fromRGB(146,153,172),
        TogOn=Color3.fromRGB(72,201,255),  TogOff=Color3.fromRGB(42,47,60),
        Thumb=Color3.fromRGB(250,251,255), Btn=Color3.fromRGB(27,31,42),
        Sep=Color3.fromRGB(34,39,52),      SlidBg=Color3.fromRGB(24,27,36),
        DropBg=Color3.fromRGB(16,18,25),   DropItem=Color3.fromRGB(25,29,39),
        DropHover=Color3.fromRGB(40,46,60),DropSel=Color3.fromRGB(36,150,210),
    },
    Neon = {
        Bg=Color3.fromRGB(10,12,22),       Bar=Color3.fromRGB(15,18,32),
        Accent=Color3.fromRGB(0,255,209),  GroupBg=Color3.fromRGB(15,18,32),
        GroupBorder=Color3.fromRGB(30,44,66), GroupHead=Color3.fromRGB(18,26,44),
        TabOn=Color3.fromRGB(0,255,209),   TabOff=Color3.fromRGB(120,145,175),
        Text=Color3.fromRGB(235,248,255),  Dim=Color3.fromRGB(145,175,200),
        TogOn=Color3.fromRGB(0,255,209),   TogOff=Color3.fromRGB(24,38,52),
        Thumb=Color3.fromRGB(250,255,255), Btn=Color3.fromRGB(22,32,48),
        Sep=Color3.fromRGB(26,40,60),      SlidBg=Color3.fromRGB(18,26,40),
        DropBg=Color3.fromRGB(12,16,26),   DropItem=Color3.fromRGB(18,26,40),
        DropHover=Color3.fromRGB(28,46,70),DropSel=Color3.fromRGB(0,180,255),
    },
    Sunset = {
        Bg=Color3.fromRGB(26,15,20),       Bar=Color3.fromRGB(38,22,28),
        Accent=Color3.fromRGB(255,140,90), GroupBg=Color3.fromRGB(34,20,26),
        GroupBorder=Color3.fromRGB(70,38,44), GroupHead=Color3.fromRGB(48,26,34),
        TabOn=Color3.fromRGB(255,140,90),  TabOff=Color3.fromRGB(190,150,155),
        Text=Color3.fromRGB(255,242,235),  Dim=Color3.fromRGB(200,168,162),
        TogOn=Color3.fromRGB(255,140,90),  TogOff=Color3.fromRGB(64,34,40),
        Thumb=Color3.fromRGB(255,248,242), Btn=Color3.fromRGB(52,28,34),
        Sep=Color3.fromRGB(62,34,40),      SlidBg=Color3.fromRGB(38,22,28),
        DropBg=Color3.fromRGB(22,12,18),   DropItem=Color3.fromRGB(34,20,26),
        DropHover=Color3.fromRGB(74,40,48),DropSel=Color3.fromRGB(255,110,70),
    },
    Ocean = {
        Bg=Color3.fromRGB(11,19,26),       Bar=Color3.fromRGB(16,28,40),
        Accent=Color3.fromRGB(80,200,255), GroupBg=Color3.fromRGB(16,28,40),
        GroupBorder=Color3.fromRGB(32,50,66), GroupHead=Color3.fromRGB(22,36,50),
        TabOn=Color3.fromRGB(80,200,255),  TabOff=Color3.fromRGB(125,160,185),
        Text=Color3.fromRGB(235,250,255),  Dim=Color3.fromRGB(152,186,202),
        TogOn=Color3.fromRGB(80,200,255),  TogOff=Color3.fromRGB(26,46,60),
        Thumb=Color3.fromRGB(248,254,255), Btn=Color3.fromRGB(24,40,54),
        Sep=Color3.fromRGB(28,46,62),      SlidBg=Color3.fromRGB(18,32,44),
        DropBg=Color3.fromRGB(13,22,30),   DropItem=Color3.fromRGB(20,34,48),
        DropHover=Color3.fromRGB(34,60,82),DropSel=Color3.fromRGB(40,160,230),
    },
    Voltage = {
        Bg=Color3.fromRGB(14,14,18),       Bar=Color3.fromRGB(22,22,28),
        Accent=Color3.fromRGB(255,225,80), GroupBg=Color3.fromRGB(20,20,26),
        GroupBorder=Color3.fromRGB(48,48,58), GroupHead=Color3.fromRGB(28,28,36),
        TabOn=Color3.fromRGB(255,225,80),  TabOff=Color3.fromRGB(160,160,172),
        Text=Color3.fromRGB(250,250,244),  Dim=Color3.fromRGB(175,175,162),
        TogOn=Color3.fromRGB(255,225,80),  TogOff=Color3.fromRGB(36,36,44),
        Thumb=Color3.fromRGB(255,255,255), Btn=Color3.fromRGB(34,34,42),
        Sep=Color3.fromRGB(40,40,50),      SlidBg=Color3.fromRGB(28,28,36),
        DropBg=Color3.fromRGB(18,18,24),   DropItem=Color3.fromRGB(28,28,36),
        DropHover=Color3.fromRGB(56,56,68),DropSel=Color3.fromRGB(210,180,50),
    },
    Dark = {
        Bg=Color3.fromRGB(14,14,20),       Bar=Color3.fromRGB(20,20,30),
        Accent=Color3.fromRGB(20,150,255), GroupBg=Color3.fromRGB(20,20,28),
        GroupBorder=Color3.fromRGB(34,34,52), GroupHead=Color3.fromRGB(26,26,38),
        TabOn=Color3.fromRGB(20,150,255),  TabOff=Color3.fromRGB(125,125,158),
        Text=Color3.fromRGB(235,235,248),  Dim=Color3.fromRGB(150,150,178),
        TogOn=Color3.fromRGB(20,150,255),  TogOff=Color3.fromRGB(34,34,52),
        Thumb=Color3.fromRGB(228,228,248), Btn=Color3.fromRGB(30,30,44),
        Sep=Color3.fromRGB(32,32,48),      SlidBg=Color3.fromRGB(26,26,40),
        DropBg=Color3.fromRGB(18,18,26),   DropItem=Color3.fromRGB(26,26,40),
        DropHover=Color3.fromRGB(42,42,64),DropSel=Color3.fromRGB(12,110,220),
    },
    Midnight = {
        Bg=Color3.fromRGB(13,13,22),       Bar=Color3.fromRGB(19,18,32),
        Accent=Color3.fromRGB(225,60,130), GroupBg=Color3.fromRGB(19,18,32),
        GroupBorder=Color3.fromRGB(38,34,60), GroupHead=Color3.fromRGB(25,22,40),
        TabOn=Color3.fromRGB(225,60,130),  TabOff=Color3.fromRGB(130,126,162),
        Text=Color3.fromRGB(240,240,252),  Dim=Color3.fromRGB(158,152,188),
        TogOn=Color3.fromRGB(225,60,130),  TogOff=Color3.fromRGB(38,34,60),
        Thumb=Color3.fromRGB(240,236,252), Btn=Color3.fromRGB(32,28,52),
        Sep=Color3.fromRGB(36,32,56),      SlidBg=Color3.fromRGB(28,24,48),
        DropBg=Color3.fromRGB(18,16,28),   DropItem=Color3.fromRGB(28,24,46),
        DropHover=Color3.fromRGB(48,38,72),DropSel=Color3.fromRGB(175,40,95),
    },
    Forest = {
        Bg=Color3.fromRGB(12,18,14),       Bar=Color3.fromRGB(17,26,20),
        Accent=Color3.fromRGB(60,210,100), GroupBg=Color3.fromRGB(17,26,20),
        GroupBorder=Color3.fromRGB(28,44,32), GroupHead=Color3.fromRGB(22,34,26),
        TabOn=Color3.fromRGB(60,210,100),  TabOff=Color3.fromRGB(118,148,124),
        Text=Color3.fromRGB(235,246,236),  Dim=Color3.fromRGB(145,172,148),
        TogOn=Color3.fromRGB(60,210,100),  TogOff=Color3.fromRGB(26,42,30),
        Thumb=Color3.fromRGB(228,242,232), Btn=Color3.fromRGB(22,36,26),
        Sep=Color3.fromRGB(24,38,28),      SlidBg=Color3.fromRGB(18,30,22),
        DropBg=Color3.fromRGB(13,20,16),   DropItem=Color3.fromRGB(20,32,24),
        DropHover=Color3.fromRGB(32,54,38),DropSel=Color3.fromRGB(36,155,68),
    },
}

Library.AccentOverride = nil

local baseTransMap = {}
local notifyList = {}
local _disabledElems = {}
local _tipObjs = nil

local function getTip()
    if not _tipObjs then
        local bg = Drawing.new("Square")
        bg.Filled = true; bg.ZIndex = 99; bg.Rounding = 6; bg.Visible = false; bg.Transparency = 1
        baseTransMap[bg] = 1
        table.insert(Library.Drawings, bg)
        local txt = Drawing.new("Text")
        txt.Size = 12; txt.Font = FONT; txt.Outline = false; txt.ZIndex = 100; txt.Visible = false; txt.Transparency = 1
        baseTransMap[txt] = 1
        table.insert(Library.Drawings, txt)
        _tipObjs = {bg = bg, txt = txt}
    end
    return _tipObjs
end

local function T()
    local theme = Library.Themes[Library.CurrentThemeName]
    if not theme then return Library.Themes.Default end
    if Library.AccentOverride then
        return setmetatable({ Accent = Library.AccentOverride }, { __index = theme })
    end
    return theme
end
local function th(f) table.insert(Library.ThemeUpdaters, f) end

local function d(class, props)
    local obj = Drawing.new(class)
    baseTransMap[obj] = props.Transparency or 1
    for k,v in pairs(props) do pcall(function() obj[k]=v end) end
    table.insert(Library.Drawings, obj)
    return obj
end

local function removeDrawing(obj)
    pcall(function() obj.Visible = false end)
    pcall(function() obj:Remove() end)
    for i = #Library.Drawings, 1, -1 do
        if Library.Drawings[i] == obj then
            table.remove(Library.Drawings, i)
            break
        end
    end
    baseTransMap[obj] = nil
end

local function on(sig, fn)
    local c = sig:Connect(fn); table.insert(Library.Connections, c); return c
end
local function over(pos, sz)
    local m = UserInputService:GetMouseLocation()
    return m.X>=pos.X and m.X<=pos.X+sz.X and m.Y>=pos.Y and m.Y<=pos.Y+sz.Y
end
local function fv(v) return Vector2.new(math.floor(v.X), math.floor(v.Y)) end
local function keyName(kc)
    if not kc then return "None" end
    local s = tostring(kc)
    return s:match("KeyCode%.(.+)") or s:match("UserInputType%.(.+)") or s
end

function Library:GetThemeNames()
    local names = {}
    for name in pairs(Library.Themes) do
        names[#names + 1] = name
    end
    table.sort(names)
    return names
end

function Library:CreateLoader(opts)
    opts = opts or {}
    local title = opts.Title or "BHub Remastered"
    local subtitle = opts.Subtitle or "Initializing"

    local camera = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
    local vp = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local panelW = math.clamp(opts.Width or 380, 320, 480)
    local panelH = 160
    local pos = Vector2.new(math.floor((vp.X - panelW) / 2), math.floor((vp.Y - panelH) / 2))

    local dim = d("Square", {Filled=true, Color=Color3.new(0, 0, 0), Transparency=0.55, Visible=true, ZIndex=200, Size=vp, Position=Vector2.new(0, 0)})
    local panel = d("Square", {Filled=true, Color=T().Bg, Visible=true, ZIndex=201, Rounding=14, Size=Vector2.new(panelW, panelH), Position=pos})
    local border = d("Square", {Filled=false, Color=T().GroupBorder, Visible=true, ZIndex=201, Rounding=14, Thickness=1, Size=Vector2.new(panelW, panelH), Position=pos})
    local accent = d("Square", {Filled=true, Color=T().Accent, Visible=true, ZIndex=202, Rounding=14, Size=Vector2.new(panelW, 4), Position=pos})
    local accentMask = d("Square", {Filled=true, Color=T().Bg, Visible=true, ZIndex=203, Size=Vector2.new(panelW, 4), Position=pos + Vector2.new(0, 2)})
    local titleText = d("Text", {Text=title, Size=18, Font=FONT, Outline=false, Color=T().Text, Visible=true, ZIndex=204, Position=pos + Vector2.new(20, 18)})
    local stageText = d("Text", {Text=subtitle, Size=13, Font=FONT, Outline=false, Color=T().Dim, Visible=true, ZIndex=204, Position=pos + Vector2.new(20, 46)})
    local progressBg = d("Square", {Filled=true, Color=T().SlidBg, Visible=true, ZIndex=202, Rounding=6, Size=Vector2.new(panelW - 40, 10), Position=pos + Vector2.new(20, 106)})
    local progressFill = d("Square", {Filled=true, Color=T().Accent, Visible=true, ZIndex=203, Rounding=6, Size=Vector2.new(1, 10), Position=pos + Vector2.new(20, 106)})
    local percentText = d("Text", {Text="0%", Size=12, Font=FONT, Outline=false, Color=T().Dim, Visible=true, ZIndex=204, Position=pos + Vector2.new(panelW - 56, 80)})

    local loader = { Progress = 0, Stage = subtitle }

    function loader:SetStage(text, progress)
        if text then
            self.Stage = text
            stageText.Text = text
        end
        if progress ~= nil then
            self.Progress = math.clamp(progress, 0, 1)
            progressFill.Size = Vector2.new(math.max((panelW - 40) * self.Progress, 1), 10)
            percentText.Text = tostring(math.floor(self.Progress * 100)) .. "%"
        end
    end

    function loader:SetProgress(progress)
        self:SetStage(nil, progress)
    end

    function loader:Close()
        for i = 1, 10 do
            local a = 1 - (i / 10)
            pcall(function()
                dim.Transparency = 0.55 * a
                panel.Transparency = a
                border.Transparency = a
                accent.Transparency = a
                accentMask.Transparency = a
                titleText.Transparency = a
                stageText.Transparency = a
                progressBg.Transparency = a
                progressFill.Transparency = a
                percentText.Transparency = a
            end)
            task.wait(0.015)
        end
        removeDrawing(dim)
        removeDrawing(panel)
        removeDrawing(border)
        removeDrawing(accent)
        removeDrawing(accentMask)
        removeDrawing(titleText)
        removeDrawing(stageText)
        removeDrawing(progressBg)
        removeDrawing(progressFill)
        removeDrawing(percentText)
    end

    loader:SetStage(subtitle, 0)
    return loader
end

function Library:CreateCommandPalette(opts)
    opts = opts or {}
    local title = opts.Title or "Command Palette"
    local camera = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
    local vp = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local panelW = math.clamp(opts.Width or 440, 340, 560)
    local panelH = 240
    local pos = Vector2.new(math.floor((vp.X - panelW) / 2), math.floor((vp.Y - panelH) / 2))

    local dim = d("Square", {Filled=true, Color=Color3.new(0, 0, 0), Transparency=0.55, Visible=false, ZIndex=210, Size=vp, Position=Vector2.new(0, 0)})
    local panel = d("Square", {Filled=true, Color=T().Bg, Visible=false, ZIndex=211, Rounding=14, Size=Vector2.new(panelW, panelH), Position=pos})
    local border = d("Square", {Filled=false, Color=T().GroupBorder, Visible=false, ZIndex=211, Rounding=14, Thickness=1, Size=Vector2.new(panelW, panelH), Position=pos})
    local accent = d("Square", {Filled=true, Color=T().Accent, Visible=false, ZIndex=212, Rounding=14, Size=Vector2.new(panelW, 4), Position=pos})
    local accentMask = d("Square", {Filled=true, Color=T().Bg, Visible=false, ZIndex=213, Size=Vector2.new(panelW, 4), Position=pos + Vector2.new(0, 2)})
    local titleText = d("Text", {Text=title, Size=16, Font=FONT, Outline=false, Color=T().Text, Visible=false, ZIndex=214, Position=pos + Vector2.new(20, 14)})
    local queryText = d("Text", {Text="", Size=13, Font=FONT, Outline=false, Color=T().Dim, Visible=false, ZIndex=214, Position=pos + Vector2.new(20, 40)})
    local listBg = d("Square", {Filled=true, Color=T().GroupBg, Visible=false, ZIndex=212, Rounding=8, Size=Vector2.new(panelW - 32, 150), Position=pos + Vector2.new(16, 68)})

    local rows = {}
    for i = 1, 6 do
        rows[i] = {
            bg = d("Square", {Filled=true, Color=T().DropItem, Visible=false, ZIndex=213, Rounding=6, Size=Vector2.new(panelW - 44, 22), Position=pos}),
            txt = d("Text", {Text="", Size=13, Font=FONT, Outline=false, Color=T().Text, Visible=false, ZIndex=214, Position=pos}),
        }
    end

    local palette = {visible=false, items={}, filtered={}, query="", selected=1}
    local keyConn

    local function refreshRows()
        palette.filtered = {}
        local q = string.lower(palette.query)
        for _, item in ipairs(palette.items) do
            local text = string.lower(item.Text or "")
            if q == "" or text:find(q, 1, true) then
                palette.filtered[#palette.filtered + 1] = item
            end
        end
        if #palette.filtered == 0 then
            palette.selected = 0
        else
            palette.selected = math.clamp(palette.selected, 1, #palette.filtered)
        end
        queryText.Text = palette.query == "" and "Type to search" or ("Search: " .. palette.query)
        for i = 1, 6 do
            local item = palette.filtered[i]
            if item then
                local y = pos.Y + 74 + (i - 1) * 26
                rows[i].bg.Position = Vector2.new(pos.X + 18, y)
                rows[i].bg.Size = Vector2.new(panelW - 36, 22)
                rows[i].bg.Color = (palette.selected == i) and T().DropSel or T().DropItem
                rows[i].bg.Visible = true
                rows[i].txt.Position = Vector2.new(pos.X + 28, y + 3)
                rows[i].txt.Text = item.Text or ""
                rows[i].txt.Visible = true
            else
                rows[i].bg.Visible = false
                rows[i].txt.Visible = false
            end
        end
    end

    local function closePalette()
        if not palette.visible then return end
        palette.visible = false
        if keyConn then keyConn:Disconnect(); keyConn = nil end
        for _, obj in ipairs({dim, panel, border, accent, accentMask, titleText, queryText, listBg}) do pcall(function() obj.Visible = false end) end
        for _, row in ipairs(rows) do pcall(function() row.bg.Visible = false; row.txt.Visible = false end) end
    end

    local function runSelected()
        local item = palette.filtered[palette.selected]
        if item and item.Callback then
            pcall(item.Callback)
        end
        closePalette()
    end

    local function charFromKey(keyCode)
        local name = tostring(keyCode):gsub("Enum%.KeyCode%.", "")
        if #name == 1 then return string.lower(name) end
        if name == "Space" then return " " end
        if name:match("^%d$") then return name end
        return nil
    end

    local paletteApi = {}

    function paletteApi:Open(items)
        palette.items = items or {}
        palette.query = ""
        palette.selected = 1
        palette.visible = true
        for _, obj in ipairs({dim, panel, border, accent, accentMask, titleText, queryText, listBg}) do pcall(function() obj.Visible = true end) end
        refreshRows()
        if keyConn then keyConn:Disconnect() end
        keyConn = UserInputService.InputBegan:Connect(function(input, gp)
            if gp or not palette.visible then return end
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            if input.KeyCode == Enum.KeyCode.Escape then
                closePalette()
                return
            elseif input.KeyCode == Enum.KeyCode.Return then
                runSelected()
                return
            elseif input.KeyCode == Enum.KeyCode.Up then
                if #palette.filtered > 0 then
                    palette.selected = math.max(1, palette.selected - 1)
                    refreshRows()
                end
                return
            elseif input.KeyCode == Enum.KeyCode.Down then
                if #palette.filtered > 0 then
                    palette.selected = math.min(#palette.filtered, palette.selected + 1)
                    refreshRows()
                end
                return
            elseif input.KeyCode == Enum.KeyCode.Backspace then
                palette.query = palette.query:sub(1, math.max(#palette.query - 1, 0))
                palette.selected = 1
                refreshRows()
                return
            end

            local char = charFromKey(input.KeyCode)
            if char then
                palette.query = palette.query .. char
                palette.selected = 1
                refreshRows()
            end
        end)
    end

    function paletteApi:Close()
        closePalette()
    end

    function paletteApi:IsOpen()
        return palette.visible
    end

    return paletteApi
end

on(RunService.RenderStepped, function(dt)
    local m = UserInputService:GetMouseLocation()
    local hovering = false
    for _, elem in ipairs(_disabledElems) do
        if elem.isActive() and over(elem.getPos(), elem.getSize()) then
            hovering = true
            local tip = getTip()
            tip.txt.Text = "Incompatible"
            tip.txt.Color = T().Dim
            tip.txt.Position = Vector2.new(m.X + 14, m.Y - 10)
            tip.txt.Visible = true
            local b = tip.txt.TextBounds
            tip.bg.Color = T().GroupBg
            tip.bg.Position = Vector2.new(m.X + 10, m.Y - 14)
            tip.bg.Size = Vector2.new(b.X + 12, b.Y + 10)
            tip.bg.Visible = true
            break
        end
    end
    if not hovering and _tipObjs then
        _tipObjs.txt.Visible = false
        _tipObjs.bg.Visible = false
    end

    local vp = workspace.CurrentCamera.ViewportSize
    local currentY = vp.Y - 20

    for i = #notifyList, 1, -1 do
        local notif = notifyList[i]
        currentY = currentY - notif.h - 10
        notif.targetY = currentY

        notif.currentY = notif.currentY + (notif.targetY - notif.currentY) * 12 * dt

        local x = vp.X - notif.w - 20
        local y = notif.currentY
        local progress = 1 - math.clamp((tick() - notif.createdAt) / notif.duration, 0, 1)

        pcall(function()
            notif.objs.bg.Position = Vector2.new(x, y)
            notif.objs.out.Position = Vector2.new(x, y)
            notif.objs.acc.Position = Vector2.new(x, y)
            notif.objs.ico.Position = Vector2.new(x + 14, y + (notif.h - notif.objs.ico.TextBounds.Y)/2)
            notif.objs.txt.Position = Vector2.new(x + 30, y + (notif.h - notif.objs.txt.TextBounds.Y)/2)
            notif.objs.bar.Position = Vector2.new(x + 4, y + notif.h - 4)
            notif.objs.bar.Size = Vector2.new(math.max((notif.w - 8) * progress, 0), 3)

            notif.objs.bg.Color = T().GroupBg
            notif.objs.out.Color = T().GroupBorder
            notif.objs.acc.Color = T().Accent
            notif.objs.ico.Color = T().Accent
            notif.objs.txt.Color = T().Text
            notif.objs.bar.Color = T().Accent
        end)

        if tick() - notif.createdAt >= notif.duration and not notif.fadingOut then
            notif.fadingOut = true
            task.spawn(function()
                for j = 1, 10 do
                    local a = 1 - (j/10)
                    pcall(function()
                        notif.objs.bg.Transparency = a; notif.objs.out.Transparency = a
                        notif.objs.acc.Transparency = a; notif.objs.txt.Transparency = a; notif.objs.bar.Transparency = a; notif.objs.ico.Transparency = a
                    end)
                    task.wait(0.015)
                end
                removeDrawing(notif.objs.bg); removeDrawing(notif.objs.out)
                removeDrawing(notif.objs.acc); removeDrawing(notif.objs.txt); removeDrawing(notif.objs.bar); removeDrawing(notif.objs.ico)
            end)
        end
    end

    for i = #notifyList, 1, -1 do
        if notifyList[i].fadingOut and tick() - notifyList[i].createdAt > notifyList[i].duration + 0.5 then
            table.remove(notifyList, i)
        end
    end
end)

function Library:Notify(text, duration, opts)
    duration = duration or 3
    opts = opts or {}

    local txt = d("Text", {Text=text, Size=14, Font=FONT, Outline=false, Color=T().Text, Visible=true, ZIndex=102})
    local ico = d("Text", {Text=opts.Icon or "•", Size=14, Font=FONT, Outline=false, Color=T().Accent, Visible=true, ZIndex=102})
    local bounds = txt.TextBounds
    local w = math.max(bounds.X + 54, 170)
    local h = 36

    local bg = d("Square", {Filled=true, ZIndex=100, Rounding=8, Color=T().GroupBg, Visible=true})
    local out = d("Square", {Filled=false, ZIndex=100, Rounding=8, Thickness=1, Color=T().GroupBorder, Visible=true})
    local acc = d("Square", {Filled=true, ZIndex=101, Rounding=8, Color=T().Accent, Visible=true})
    local bar = d("Square", {Filled=true, ZIndex=101, Rounding=0, Color=T().Accent, Visible=true})

    baseTransMap[bg] = 1; baseTransMap[out] = 1; baseTransMap[acc] = 1; baseTransMap[txt] = 1; baseTransMap[bar] = 1; baseTransMap[ico] = 1
    bg.Transparency = 0; out.Transparency = 0; acc.Transparency = 0; txt.Transparency = 0; bar.Transparency = 0; ico.Transparency = 0

    local vp = workspace.CurrentCamera.ViewportSize
    local startY = vp.Y + h

    bg.Size = Vector2.new(w, h); out.Size = Vector2.new(w, h); acc.Size = Vector2.new(3, h); bar.Size = Vector2.new(w - 8, 3)

    local notif = {
        targetY = startY, currentY = startY, createdAt = tick(),
        duration = duration, fadingOut = false, w = w, h = h,
        objs = {bg=bg, out=out, acc=acc, txt=txt, bar=bar, ico=ico}
    }

    table.insert(notifyList, notif)

    task.spawn(function()
        for i = 1, 10 do
            local a = i/10
            pcall(function() bg.Transparency=a; out.Transparency=a; acc.Transparency=a; txt.Transparency=a end)
            task.wait(0.015)
        end
    end)
end

function Library:SetTheme(name)
    if not Library.Themes[name] then return end
    Library.CurrentThemeName = name
    for _,fn in ipairs(Library.ThemeUpdaters) do pcall(fn) end
end

function Library:SetAccentColor(color)
    Library.AccentOverride = color
    for _,fn in ipairs(Library.ThemeUpdaters) do pcall(fn) end
end

function Library:ClearAccentColor()
    Library.AccentOverride = nil
    for _,fn in ipairs(Library.ThemeUpdaters) do pcall(fn) end
end

function Library:_regCfg(id, getFn, setFn)
    if id and id ~= "" then Library.ConfigData[id] = {get=getFn, set=setFn} end
end
function Library:SaveConfig(name)
    name = name or "default"
    local data = {}
    for id,c in pairs(Library.ConfigData) do pcall(function() data[id]=c.get() end) end
    local ok, json = pcall(function() return HttpService:JSONEncode(data) end)
    if not ok then return false end
    pcall(function()
        if not isfolder then return end
        if not isfolder("BHub-remastered") then makefolder("BHub-remastered") end
        if not isfolder("BHub-remastered/configs") then makefolder("BHub-remastered/configs") end
        writefile("BHub-remastered/configs/"..name..".json", json)
    end)
    return true
end
function Library:LoadConfig(name)
    name = name or "default"
    if not (isfile and readfile) then return false end
    local path = "BHub-remastered/configs/"..name..".json"
    if not isfile(path) then return false end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if ok and type(data)=="table" then
        for id,val in pairs(data) do
            if Library.ConfigData[id] then pcall(function() Library.ConfigData[id].set(val) end) end
        end
        return true
    end
    return false
end

local activeDD   = nil
local activeBind = nil

function Library:CreateWindow(opts)
    local title   = opts.Title or "BHub"
    local BASE_W  = 540
    local W       = BASE_W
    local BAR     = 40
    local TAB_RH  = 34
    local PAD     = 12
    local GAP     = 10
    local COL     = math.floor((W - PAD*2 - GAP) / 2)
    local IP      = 12
    local MAXDD   = 14
    local DD_H    = 26
    local MIN_W   = BASE_W
    local MAX_W   = 900
    local MIN_H   = 320
    local userMinH = 0

    local Win = {
        Pos=Vector2.new(100,100), Tabs={}, Active=nil,
        Dragging=false, Resizing=false, DragOff=Vector2.new(), ResizeStartMouse=Vector2.new(), ResizeStartSize=Vector2.new(), Btns={}, DropBtns={}, Visible=true,
        ShadowEnabled = true,
    }

    local wShd  = d("Square",{Filled=true, ZIndex=9, Rounding=24, Color=Color3.new(0,0,0), Transparency=0.4, Visible=true,Position=Win.Pos+Vector2.new(0,6),Size=Vector2.new(W,BAR)})
    Win.ShadowTransparency = 0.4
    local wBg   = d("Square",{Filled=true, ZIndex=10,Rounding=22,Color=T().Bg,    Visible=true,Position=Win.Pos,Size=Vector2.new(W,BAR)})
    local wOut  = d("Square",{Filled=false,ZIndex=10,Rounding=22,Thickness=1,Color=T().GroupBorder,Visible=true,Position=Win.Pos,Size=Vector2.new(W,BAR)})
    local wBar  = d("Square",{Filled=true, ZIndex=11,Rounding=22,Color=T().Bar,   Visible=true,Position=Win.Pos,Size=Vector2.new(W,BAR)})
    local wBBt  = d("Square",{Filled=true, ZIndex=11,Rounding=0,Color=T().Bar,   Visible=true,Position=Win.Pos+Vector2.new(0,BAR-4),Size=Vector2.new(W,4)})
    local wAcc  = d("Square",{Filled=true, ZIndex=12,            Color=T().Accent,Visible=true,Position=Win.Pos+Vector2.new(0,BAR),Size=Vector2.new(W,3)})
    local wTBg  = d("Square",{Filled=true, ZIndex=11,Rounding=0,Color=T().Bar,   Visible=true,Position=Win.Pos+Vector2.new(0,BAR+3),Size=Vector2.new(W,TAB_RH)})
    local wTSep = d("Square",{Filled=true, ZIndex=12,            Color=T().Sep,   Visible=true,Position=Win.Pos+Vector2.new(0,BAR+3+TAB_RH),Size=Vector2.new(W,1)})
    local wTit  = d("Text",  {Text=title,Size=16,Font=FONT,Outline=false,Color=T().Text,Visible=true,ZIndex=13,Position=Win.Pos+Vector2.new(18,12)})
    local wGrip = d("Square",{Filled=true, ZIndex=19,Rounding=3,Color=T().Dim,   Visible=true,Position=Win.Pos+Vector2.new(W-18,BAR-18),Size=Vector2.new(12,12)})
    local wGrip2= d("Square",{Filled=true, ZIndex=20,Rounding=2,Color=T().Accent,Visible=true,Position=Win.Pos+Vector2.new(W-14,BAR-14),Size=Vector2.new(8,8)})

    th(function()
        wBg.Color=T().Bg; wBar.Color=T().Bar; wBBt.Color=T().Bar; wAcc.Color=T().Accent
        wOut.Color=T().GroupBorder; wTBg.Color=T().Bar; wTSep.Color=T().Sep; wTit.Color=T().Text; wGrip.Color=T().Dim; wGrip2.Color=T().Accent
    end)

    local chromeObjs = {wShd, wBg, wOut, wBar, wBBt, wAcc, wTBg, wTSep, wTit, wGrip, wGrip2}

    local isAnimating = false
    local function setVisible(v)
        if isAnimating or Win.Visible == v then return end
        isAnimating = true
        Win.Visible = v

        if not v then
            local activeObjs = {}
            for _, obj in ipairs(Library.Drawings) do
                if obj.Visible then table.insert(activeObjs, obj) end
            end

            for i = 1, 10 do
                local a = 1 - (i/10)
                for _, obj in ipairs(activeObjs) do
                    pcall(function() obj.Transparency = (baseTransMap[obj] or 1) * a end)
                end
                task.wait(0.015)
            end

            for _, obj in ipairs(Library.Drawings) do
                pcall(function() obj.Visible = false end)
                pcall(function() obj.Transparency = (baseTransMap[obj] or 1) end)
            end
        else
            for _, obj in ipairs(chromeObjs) do pcall(function() obj.Visible = true end) end
            for _, btn in ipairs(Win.Btns) do
                btn.bLbl.Visible = true; btn.bInd.Visible = (Win.Active == btn.Tab)
            end
            if Win.Active then
                for _, gb in ipairs(Win.Active.L) do gb.setVis(true) end
                for _, gb in ipairs(Win.Active.R) do gb.setVis(true) end
            end

            local activeObjs = {}
            for _, obj in ipairs(Library.Drawings) do
                if obj.Visible then
                    pcall(function() obj.Transparency = 0 end)
                    table.insert(activeObjs, obj)
                end
            end

            for i = 1, 10 do
                local a = (i/10)
                for _, obj in ipairs(activeObjs) do
                    pcall(function() obj.Transparency = (baseTransMap[obj] or 1) * a end)
                end
                task.wait(0.015)
            end

            for _, obj in ipairs(activeObjs) do
                pcall(function() obj.Transparency = (baseTransMap[obj] or 1) end)
            end
        end
        isAnimating = false
    end

    local function layout()
        COL = math.floor((W - PAD*2 - GAP) / 2)
        local tabRows, tx = 1, 14
        for _, btn in ipairs(Win.Btns) do
            if tx + btn.w > W - 14 then tx = 14; tabRows = tabRows + 1 end
            tx = tx + btn.w + 12
        end
        local dynTH   = TAB_RH * tabRows
        local dynHDR  = BAR + 3 + dynTH + 1
        local dynCONTY = dynHDR + 1 + PAD

        wShd.Position = fv(Win.Pos + Vector2.new(0, 6))
        wShd.Size     = fv(Vector2.new(W, dynTH + BAR + 3))
        wBg.Position  = fv(Win.Pos)
        wBar.Position = fv(Win.Pos)
        wBar.Size     = fv(Vector2.new(W, BAR))
        wOut.Position = fv(Win.Pos)
        wBBt.Position = fv(Win.Pos + Vector2.new(0, BAR-4))
        wBBt.Size     = fv(Vector2.new(W, 4))
        wAcc.Position = fv(Win.Pos + Vector2.new(0, BAR))
        wAcc.Size     = fv(Vector2.new(W, 3))
        wTBg.Position = fv(Win.Pos + Vector2.new(0, BAR+3))
        wTBg.Size     = fv(Vector2.new(W, dynTH))
        wTSep.Position= fv(Win.Pos + Vector2.new(0, dynHDR))
        wTSep.Size    = fv(Vector2.new(W, 1))
        wTit.Position = fv(Win.Pos + Vector2.new(18, 12))

        local bx, row = 14, 1
        for _, btn in ipairs(Win.Btns) do
            if bx + btn.w > W - 14 then bx = 14; row = row + 1 end
            local by = BAR + 3 + (row-1)*TAB_RH + math.floor((TAB_RH-16)/2)
            btn.setPos(fv(Win.Pos + Vector2.new(bx, by)))
            bx = bx + btn.w + 12
        end

        if not Win.Active then
            local targetH = math.max(dynCONTY + 50, userMinH)
            wBg.Size = fv(Vector2.new(W, targetH)); wOut.Size = wBg.Size
            wShd.Size = fv(wBg.Size + Vector2.new(0, 2))
            wGrip.Position = fv(wBg.Position + wBg.Size - Vector2.new(18,18))
            wGrip2.Position = fv(wBg.Position + wBg.Size - Vector2.new(14,14))
            return
        end
        local lH, rH = 0, 0
        for _, gb in ipairs(Win.Active.L) do
            gb.setPos(fv(Win.Pos + Vector2.new(PAD, dynCONTY + lH)))
            lH = lH + gb.height() + PAD
        end
        for _, gb in ipairs(Win.Active.R) do
            gb.setPos(fv(Win.Pos + Vector2.new(PAD+COL+GAP, dynCONTY + rH)))
            rH = rH + gb.height() + PAD
        end
        local contentH = dynCONTY + math.max(lH, rH, 40) + PAD
        wBg.Size = fv(Vector2.new(W, math.max(contentH, userMinH)))
        wOut.Size = wBg.Size
        wShd.Size = fv(wBg.Size + Vector2.new(0, 2))
        pcall(function() wShd.Visible = Win.ShadowEnabled end)
        wGrip.Position = fv(wBg.Position + wBg.Size - Vector2.new(18,18))
        wGrip2.Position = fv(wBg.Position + wBg.Size - Vector2.new(14,14))
    end

    on(UserInputService.InputBegan, function(i)
        if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        if over(wGrip.Position - Vector2.new(6,6), wGrip.Size + Vector2.new(12,12)) then
            Win.Resizing = true; Win.ResizeStartMouse = UserInputService:GetMouseLocation()
            Win.ResizeStartSize = wBg.Size; return
        end
        if over(Win.Pos, Vector2.new(W, BAR)) then
            Win.Dragging = true; Win.DragOff = UserInputService:GetMouseLocation() - Win.Pos
        end
    end)
    on(UserInputService.InputEnded, function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then Win.Dragging = false; Win.Resizing = false end
    end)
    on(RunService.RenderStepped, function()
        if Win.Resizing then
            local delta = UserInputService:GetMouseLocation() - Win.ResizeStartMouse
            W = math.clamp(math.floor(Win.ResizeStartSize.X + delta.X), MIN_W, MAX_W)
            userMinH = math.max(MIN_H, math.floor(Win.ResizeStartSize.Y + delta.Y))
            layout()
        elseif Win.Dragging then
            Win.Pos = fv(UserInputService:GetMouseLocation() - Win.DragOff)
            layout()
        end
    end)

    on(UserInputService.InputBegan, function(i)
        if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local clickOnAnyDropHeader = false
        for _, ref in ipairs(Win.DropBtns) do
            if ref.pos and ref.sz and (not ref.active or ref.active()) and over(ref.pos, ref.sz) then
                clickOnAnyDropHeader = true; break
            end
        end
        if activeDD then
            if clickOnAnyDropHeader then return end
            local inList = activeDD.pos and activeDD.sz and over(activeDD.pos, activeDD.sz)
            local inBtn = activeDD.btnPos and activeDD.btnSz and over(activeDD.btnPos, activeDD.btnSz)
            if not inList and not inBtn then activeDD.close(); activeDD = nil end
        end
    end)

    local function makeGB(parentTab, side, name)
        local GH = 34
        local GP = 10
        local GB = {items={}, pos=Vector2.new()}

        local gBg  = d("Square",{Filled=true, ZIndex=14,Rounding=16,Color=T().GroupBg,     Visible=false,Size=Vector2.new(COL,GH)})
        local gOut = d("Square",{Filled=false,ZIndex=14,Rounding=16,Thickness=1,Color=T().GroupBorder,Visible=false,Size=Vector2.new(COL,GH)})
        local gHd  = d("Square",{Filled=true, ZIndex=15,Rounding=16,Color=T().GroupHead,   Visible=false,Size=Vector2.new(COL,GH)})
        local gHF  = d("Square",{Filled=true, ZIndex=15,Rounding=0,Color=T().GroupHead,   Visible=false,Size=Vector2.new(COL,8)})
        local gHL  = d("Square",{Filled=true, ZIndex=16,            Color=T().Sep,          Visible=false,Size=Vector2.new(COL,1)})
        local gTit = d("Text",  {Text=name,Size=13,Font=FONT,Outline=false,Color=T().Dim, Visible=false,ZIndex=16})
        th(function()
            gBg.Color=T().GroupBg; gOut.Color=T().GroupBorder; gHd.Color=T().GroupHead
            gHF.Color=T().GroupHead; gHL.Color=T().Sep; gTit.Color=T().Dim
        end)

        function GB.height()
            local h = GH + GP
            for _, it in ipairs(GB.items) do h = h + it.h end
            return h + GP
        end
        function GB.setVis(v)
            gBg.Visible=v; gOut.Visible=v; gHd.Visible=v; gHF.Visible=v; gHL.Visible=v; gTit.Visible=v
            for _, it in ipairs(GB.items) do it.setVis(v) end
        end
        function GB.setPos(p)
            GB.pos = p
            local h = GB.height()
            gBg.Position=p;  gBg.Size=fv(Vector2.new(COL,h))
            gOut.Position=p; gOut.Size=fv(Vector2.new(COL,h))
            gHd.Position=p;  gHd.Size=fv(Vector2.new(COL,GH))
            gHF.Position=fv(p+Vector2.new(0,GH-6)); gHF.Size=Vector2.new(COL,8)
            gHL.Position=fv(p+Vector2.new(0,GH));   gHL.Size=Vector2.new(COL,1)
            gTit.Position=fv(p+Vector2.new(14,11))
            local iy = GH + GP
            for _, it in ipairs(GB.items) do it.setPos(fv(p+Vector2.new(0,iy))); iy = iy + it.h end
        end

        local function addIt(it)
            table.insert(GB.items, it)
            if Win.Active == parentTab then it.setVis(true) end
            layout()
        end

        local colorPresets = {
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 80, 80),
            Color3.fromRGB(255, 170, 60),
            Color3.fromRGB(255, 220, 60),
            Color3.fromRGB(80, 220, 120),
            Color3.fromRGB(80, 180, 255),
            Color3.fromRGB(170, 100, 255),
            Color3.fromRGB(255, 90, 180),
            Color3.fromRGB(0, 255, 209),
            Color3.fromRGB(255, 120, 72),
        }

        local Obj = {}

        function Obj:AddToggle(id, o)
            local txt = o.Text or id
            local st  = o.Default or false
            local disabled = o.Disabled or false
            local iP  = Vector2.new()
            local isActive = false
            local BOX = 20
            local lbl = d("Text",  {Text=txt,Size=14,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=20})
            local box = d("Square",{Size=Vector2.new(BOX,BOX),Filled=true,ZIndex=20,Rounding=6,Color=disabled and T().Dim or (st and T().TogOn or T().TogOff),Visible=false})
            local boxOut = d("Square",{Size=Vector2.new(BOX,BOX),Filled=false,Thickness=1,ZIndex=21,Rounding=6,Color=disabled and T().Dim or T().GroupBorder,Visible=false})
            local chk1 = d("Line",{Thickness=2,ZIndex=22,Color=T().Bg,Visible=false})
            local chk2 = d("Line",{Thickness=2,ZIndex=22,Color=T().Bg,Visible=false})
            th(function()
                lbl.Color = disabled and T().Dim or T().Text
                box.Color = disabled and T().Dim or (st and T().TogOn or T().TogOff)
                boxOut.Color = disabled and T().Dim or T().GroupBorder
                chk1.Color = T().Bg; chk2.Color = T().Bg
            end)
            local function refresh()
                if not disabled then
                    box.Color = st and T().TogOn or T().TogOff
                end
                chk1.Visible = st and isActive
                chk2.Visible = st and isActive
            end
            local it = {h=34}
            function it.setVis(v)
                lbl.Visible=v; box.Visible=v; boxOut.Visible=v; isActive=v
                chk1.Visible = v and st; chk2.Visible = v and st
            end
            function it.setPos(p)
                iP=p; lbl.Position=fv(p+Vector2.new(IP,9))
                local bx, by = p.X+COL-32, p.Y+7
                box.Position=fv(Vector2.new(bx,by)); boxOut.Position=box.Position
                chk1.From=fv(Vector2.new(bx+4,by+11)); chk1.To=fv(Vector2.new(bx+8,by+15))
                chk2.From=fv(Vector2.new(bx+8,by+15)); chk2.To=fv(Vector2.new(bx+16,by+5))
            end
            local Tog = {State=st}
            on(UserInputService.InputBegan, function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                if Win.Active ~= parentTab or not isActive then return end
                if disabled then return end
                if over(iP, Vector2.new(COL, 34)) then
                    st = not st; Tog.State = st; refresh()
                    if o.Callback then o.Callback(st) end
                end
            end)
            if disabled then
                table.insert(_disabledElems, {
                    getPos  = function() return iP end,
                    getSize = function() return Vector2.new(COL, 34) end,
                    isActive = function() return isActive and Win.Visible end,
                })
            end
            function Tog:AddColorPicker(id, co)
                co = co or {}
                local pickerColor = co.Default or Color3.new(1, 1, 1)
                local swatch = d("Square", {Size=Vector2.new(20, 20), Filled=true, ZIndex=22, Rounding=6, Color=pickerColor, Visible=false})
                local border = d("Square", {Size=Vector2.new(20, 20), Filled=false, ZIndex=23, Rounding=6, Thickness=1, Color=T().GroupBorder, Visible=false})
                local it2 = {h=34}
                function it2.setVis(v) swatch.Visible=v; border.Visible=v end
                function it2.setPos(p)
                    swatch.Position = fv(p + Vector2.new(COL - 32, 7))
                    border.Position = fv(p + Vector2.new(COL - 32, 7))
                end

                local popup = {
                    open = false,
                    panel = nil,
                    elems = {},
                }

                local function colorToTable(c)
                    return {math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255)}
                end
                local function tableToColor(t)
                    return Color3.fromRGB(t[1], t[2], t[3])
                end

                local preview = d("Square", {Size=Vector2.new(44, 26), Filled=true, ZIndex=31, Rounding=8, Color=pickerColor, Visible=false})

                local function applyColor(c, suppressCb)
                    pickerColor = c
                    swatch.Color = c
                    preview.Color = c
                    if not suppressCb and co.Callback then co.Callback(c) end
                end

                local function createPopup(pos)
                    if popup.open then return end
                    popup.open = true
                    local pW, pH = 280, 180
                    local pPos = pos + Vector2.new(-pW, 0)
                    local panel = d("Square", {Size=Vector2.new(pW, pH), Filled=true, Color=T().GroupBg, Rounding=12, Visible=true, ZIndex=30})
                    local title = d("Text", {Text=(co.Title or txt), Size=14, Font=FONT, Outline=false, Color=T().Text, Visible=true, ZIndex=31})

                    panel.Position = fv(pPos)
                    title.Position = fv(pPos + Vector2.new(14, 10))

                    local svW, svH = 200, 130
                    local svPos = pPos + Vector2.new(14, 32)
                    local hueW, hueH = 20, svH
                    local huePos = pPos + Vector2.new(14 + svW + 10, 32)

                    local cols, rows = 32, 24
                    local cellW, cellH = svW / cols, svH / rows
                    local svCells = {}

                    local ok, ch, cs, cv = pcall(function() return Color3.toHSV(pickerColor) end)
                    local curH = ok and ch or 0
                    local curS = ok and cs or 1
                    local curV = ok and cv or 1

                    for r=0,rows-1 do
                        for c=0,cols-1 do
                            local x = svPos.X + c*cellW
                            local y = svPos.Y + r*cellH
                            local cell = d("Square", {Size=Vector2.new(cellW + 0.6, cellH + 0.6), Filled=true, ZIndex=31, Rounding=0, Color=Color3.fromHSV(curH, c/(cols-1), 1 - r/(rows-1)), Visible=true})
                            cell.Position = fv(Vector2.new(x, y))
                            table.insert(svCells, {obj=cell, c=c, r=r})
                        end
                    end

                    local hueSegments = {}
                    local segs = 24
                    for i=0,segs-1 do
                        local hh = i/segs
                        local segH = hueH / segs
                        local seg = d("Square", {Size=Vector2.new(hueW, segH + 0.6), Filled=true, ZIndex=31, Rounding=0, Color=Color3.fromHSV(hh,1,1), Visible=true})
                        seg.Position = fv(Vector2.new(huePos.X, huePos.Y + i*segH))
                        table.insert(hueSegments, {obj=seg, h=hh})
                    end

                    local svCursor = d("Square", {Size=Vector2.new(10, 10), Filled=false, ZIndex=34, Rounding=5, Thickness=2, Color=Color3.new(1,1,1), Visible=true})
                    local hueCursor = d("Square", {Size=Vector2.new(hueW + 4, 4), Filled=true, ZIndex=34, Rounding=2, Color=Color3.new(1,1,1), Visible=true})
                    preview.Position = fv(pPos + Vector2.new(pW - 64, 34))

                    popup.panel = panel
                    popup.elems = {title=title, sv=svCells, hue=hueSegments, preview=preview, svCursor=svCursor, hueCursor=hueCursor}

                    local dragging = nil

                    local function updateSVGrid(hue)
                        for _, cell in ipairs(svCells) do
                            local s = cell.c/(cols-1)
                            local v = 1 - (cell.r/(rows-1))
                            cell.obj.Color = Color3.fromHSV(hue, s, v)
                        end
                    end

                    local function updateCursors()
                        svCursor.Position = fv(Vector2.new(svPos.X + curS * svW - 5, svPos.Y + (1 - curV) * svH - 5))
                        hueCursor.Position = fv(Vector2.new(huePos.X - 2, huePos.Y + curH * hueH - 2))
                    end

                    local function setHSV(h, s, v)
                        curH, curS, curV = math.clamp(h, 0, 1), math.clamp(s, 0, 1), math.clamp(v, 0, 1)
                        updateCursors()
                        applyColor(Color3.fromHSV(curH, curS, curV))
                    end

                    updateSVGrid(curH)
                    updateCursors()

                    local function closePopup()
                        if not popup.open then return end
                        popup.open = false
                        for _,v in pairs(popup.elems) do
                            if type(v)=="table" then
                                for _,u in pairs(v) do if u.obj then u.obj.Visible=false end end
                            elseif v and v.Visible ~= nil then
                                v.Visible = false
                            end
                        end
                        if popup.panel then popup.panel.Visible=false end
                        popup.panel = nil
                        popup.elems = {}
                    end

                    on(UserInputService.InputBegan, function(i)
                        if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                        local m = UserInputService:GetMouseLocation()
                        if m.X >= svPos.X and m.X <= svPos.X+svW and m.Y >= svPos.Y and m.Y <= svPos.Y+svH then
                            setHSV(curH, math.clamp((m.X - svPos.X)/svW, 0, 1), math.clamp(1 - ((m.Y - svPos.Y)/svH), 0, 1))
                            dragging = "sv"
                            return
                        end
                        if m.X >= huePos.X and m.X <= huePos.X+hueW and m.Y >= huePos.Y and m.Y <= huePos.Y+hueH then
                            local h = math.clamp((m.Y - huePos.Y)/hueH, 0, 1)
                            setHSV(h, curS, curV)
                            dragging = "hue"
                            return
                        end
                        local panelP = panel.Position; local panelS = panel.Size
                        if not (m.X >= panelP.X and m.X <= panelP.X+panelS.X and m.Y >= panelP.Y and m.Y <= panelP.Y+panelS.Y) then
                            closePopup()
                        end
                    end)

                    on(UserInputService.InputChanged, function(i)
                        if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
                            local m = UserInputService:GetMouseLocation()
                            if dragging=="sv" then
                                if m.X >= svPos.X and m.X <= svPos.X+svW and m.Y >= svPos.Y and m.Y <= svPos.Y+svH then
                                    setHSV(curH, math.clamp((m.X - svPos.X)/svW, 0, 1), math.clamp(1 - ((m.Y - svPos.Y)/svH), 0, 1))
                                end
                            elseif dragging=="hue" then
                                if m.Y >= huePos.Y and m.Y <= huePos.Y+hueH then
                                    setHSV(math.clamp((m.Y - huePos.Y)/hueH, 0, 1), curS, curV)
                                end
                            end
                        end
                    end)

                    on(UserInputService.InputEnded, function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging = nil end
                    end)

                    th(function()
                        if panel then panel.Color = T().GroupBg end
                        if svCursor then svCursor.Color = T().Text end
                        if hueCursor then hueCursor.Color = T().Text end
                    end)
                end

                on(UserInputService.InputBegan, function(i)
                    if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                    if Win.Active ~= parentTab or not isActive then return end
                    if over(swatch.Position, swatch.Size) then
                        local pos = swatch.Position
                        createPopup(pos)
                    end
                end)

                Library:_regCfg(id or (txt .. "Color"), function() return pickerColor end, function(v)
                    if typeof(v) == "Color3" then applyColor(v) end
                end)

                th(function() border.Color = T().GroupBorder; preview.Color = pickerColor end)
                addIt(it2)
                if co.Callback then task.spawn(co.Callback, pickerColor) end

                local obj = {
                    Value = pickerColor,
                    SetValue = function(c) applyColor(c) end,
                    OnChanged = function() end,
                }
                return obj
            end
            function Tog:AddKeyPicker()   return {OnChanged=function()end} end
            Library:_regCfg(id, function() return st end, function(v)
                st=v; Tog.State=v; refresh(); if o.Callback then o.Callback(v) end
            end)
            addIt(it)
            if o.Callback then task.spawn(o.Callback, st) end
            return Tog
        end

        function Obj:AddButton(o)
            local txt = type(o)=="table" and o.Text or tostring(o)
            local fn  = type(o)=="table" and o.Func or function() end
            local disabled = type(o) == "table" and o.Disabled or false
            local bW  = COL - IP*2
            local iP  = Vector2.new()
            local isActive = false
            local bg2 = d("Square",{Size=Vector2.new(bW,30),Filled=true,ZIndex=20,Rounding=12,Color=(disabled and T().GroupBg or T().Btn),Visible=false})
            local lt  = d("Text",  {Text=txt,Size=14,Font=FONT,Outline=false,Center=true,Color=(disabled and T().Dim or T().Text),ZIndex=21,Visible=false})
            th(function() if disabled then bg2.Color = T().GroupBg; lt.Color = T().Dim else bg2.Color = T().Btn; lt.Color = T().Text end end)
            local it = {h=40}
            function it.setVis(v) bg2.Visible=v; lt.Visible=v; isActive=v end
            function it.setPos(p)
                iP=p; bg2.Position=fv(p+Vector2.new(IP,5))
                lt.Position=fv(p+Vector2.new(IP+bW/2, 11))
            end
            on(UserInputService.InputBegan, function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                if Win.Active ~= parentTab or not isActive then return end
                if over(bg2.Position, bg2.Size) then
                    if disabled then return end
                    bg2.Color = T().Accent; if fn then fn() end
                    task.delay(0.13, function() pcall(function() bg2.Color = T().Btn end) end)
                end
            end)
            if disabled then
                table.insert(_disabledElems, {
                    getPos  = function() return bg2.Position end,
                    getSize = function() return bg2.Size end,
                    isActive = function() return isActive and Win.Visible end,
                })
            end
            addIt(it); return {}
        end

        function Obj:AddSlider(id, o)
            local txt     = o.Text or id
            local mn, mx  = o.Min or 0, o.Max or 100
            local val     = o.Default or mn
            local disabled = o.Disabled or false
            local sW      = COL - IP*2
            local iP      = Vector2.new()
            local drag    = false
            local isActive = false
            local TRACK_H, THUMB_W, THUMB_H = 10, 10, 22
            local lbl  = d("Text",  {Text=txt..": "..tostring(val),Size=14,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=20})
            local sBg  = d("Square",{Size=Vector2.new(sW,TRACK_H),Filled=true,ZIndex=20,Rounding=5,Color=T().SlidBg,Visible=false})
            local sFll = d("Square",{Size=Vector2.new(((val-mn)/(mx-mn))*sW,TRACK_H),Filled=true,ZIndex=21,Rounding=5,Color=disabled and T().Dim or T().Accent,Visible=false})
            local sThb = d("Square",{Size=Vector2.new(THUMB_W,THUMB_H),Filled=true,ZIndex=23,Rounding=5,Color=disabled and T().Dim or T().Thumb,Visible=false})
            local bubBg  = d("Square",{Filled=true,ZIndex=22,Rounding=6,Color=disabled and T().Dim or T().Accent,Visible=false})
            local bubTxt = d("Text",  {Size=12,Font=FONT,Outline=false,Color=T().Bg,Visible=false,ZIndex=23})
            th(function()
                lbl.Color = disabled and T().Dim or T().Text
                sBg.Color = T().SlidBg
                sFll.Color = disabled and T().Dim or T().Accent
                sThb.Color = disabled and T().Dim or T().Thumb
                bubBg.Color = disabled and T().Dim or T().Accent
                bubTxt.Color = T().Bg
            end)
            local function apply(pct)
                pct = math.clamp(pct, 0, 1)
                val = mn + (mx-mn)*pct
                if o.Rounding == 0 then val = math.floor(val) end
                local fw = math.max(pct*sW, 0)
                sFll.Size = Vector2.new(fw, TRACK_H)
                sThb.Position = fv(sBg.Position + Vector2.new(fw-THUMB_W/2, TRACK_H/2-THUMB_H/2))
                local shown = tostring(math.floor(val*10)/10)
                lbl.Text = txt..": "..shown
                bubTxt.Text = shown
                local bw = math.max(bubTxt.TextBounds.X + 14, 26)
                bubBg.Size = Vector2.new(bw, 18)
                local bx = sBg.Position.X + fw - bw/2
                bubBg.Position = fv(Vector2.new(bx, sBg.Position.Y - 30))
                bubTxt.Position = fv(Vector2.new(bx + (bw-bubTxt.TextBounds.X)/2, sBg.Position.Y - 27))
                if o.Callback then o.Callback(val) end
            end
            local Sld = {Value=val}
            local it = {h=56}
            function it.setVis(v)
                lbl.Visible=v; sBg.Visible=v; sFll.Visible=v; sThb.Visible=v; isActive=v
                if not v then bubBg.Visible=false; bubTxt.Visible=false end
            end
            function it.setPos(p)
                iP=p; lbl.Position=fv(p+Vector2.new(IP,7))
                sBg.Position=fv(p+Vector2.new(IP,40))
                local pct2 = (val-mn)/(mx-mn)
                sFll.Position=sBg.Position; sFll.Size=Vector2.new(math.max(pct2*sW,0),TRACK_H)
                sThb.Position=fv(p+Vector2.new(IP+pct2*sW-THUMB_W/2,40+TRACK_H/2-THUMB_H/2))
            end
            on(UserInputService.InputBegan, function(i)
                if disabled then return end
                if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                if Win.Active ~= parentTab or not isActive then return end
                if over(sBg.Position, Vector2.new(sW, 20)) or over(sThb.Position, Vector2.new(THUMB_W, THUMB_H)) then
                    drag=true; bubBg.Visible=true; bubTxt.Visible=true
                    apply((UserInputService:GetMouseLocation().X-sBg.Position.X)/sW)
                end
            end)
            on(UserInputService.InputEnded, function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 and drag then
                    drag=false; bubBg.Visible=false; bubTxt.Visible=false
                end
            end)
            on(RunService.RenderStepped, function()
                if disabled then return end
                if drag and Win.Active==parentTab and isActive then apply((UserInputService:GetMouseLocation().X-sBg.Position.X)/sW); Sld.Value=val end
            end)
            if disabled then
                table.insert(_disabledElems, {
                    getPos  = function() return iP end,
                    getSize = function() return Vector2.new(COL, 56) end,
                    isActive = function() return isActive and Win.Visible end,
                })
            end
            Library:_regCfg(id, function() return val end, function(v) val=v; Sld.Value=v; apply((v-mn)/(mx-mn)) end)
            addIt(it)
            if o.Callback then task.spawn(o.Callback, val) end
            return Sld
        end

        function Obj:AddLabel(txt)
            local lbl = d("Text",{Text=txt,Size=14,Font=FONT,Outline=false,Color=T().Dim,Visible=false,ZIndex=20})
            th(function() lbl.Color=T().Dim end)
            local isActive = false
            local it = {h=30}
            function it.setVis(v) lbl.Visible=v; isActive=v end
            function it.setPos(p) lbl.Position=fv(p+Vector2.new(IP,8)) end
            local Lbl = {}
            function Lbl:SetText(t) lbl.Text=t end
            function Lbl:AddKeyPicker(kid, ko)
                local defKey = ko and ko.Default or "Delete"
                local ok2, kc2 = pcall(function() return Enum.KeyCode[defKey] end)
                local kc = (ok2 and kc2) or Enum.KeyCode.Delete
                local listening = false; local kbW = 70
                local kbBg  = d("Square",{Size=Vector2.new(kbW,22),Filled=true,ZIndex=22,Rounding=6,Color=T().Btn,Visible=false})
                local kbTxt = d("Text",  {Text=keyName(kc),Size=12,Font=FONT,Outline=false,Center=true,Color=T().Text,Visible=false,ZIndex=23})
                th(function() kbBg.Color=listening and T().Accent or T().Btn; kbTxt.Color=T().Text end)
                local origP, origV = it.setPos, it.setVis
                function it.setPos(p)
                    origP(p)
                    kbBg.Position  = fv(p+Vector2.new(COL-kbW-IP, 5))
                    kbTxt.Position = fv(p+Vector2.new(COL-kbW/2-IP, 10))
                end
                function it.setVis(v) origV(v); kbBg.Visible=v; kbTxt.Visible=v end
                on(UserInputService.InputBegan, function(i)
                    if not isActive or Win.Active ~= parentTab then return end
                    if i.UserInputType==Enum.UserInputType.MouseButton1 and over(kbBg.Position, kbBg.Size) then
                        if activeBind then activeBind.cancel() end
                        listening=true; kbBg.Color=T().Accent; kbTxt.Text="..."
                        activeBind={cancel=function() listening=false; kbBg.Color=T().Btn; kbTxt.Text=keyName(kc); activeBind=nil end}
                        return
                    end
                    if listening and i.UserInputType==Enum.UserInputType.Keyboard then
                        if i.KeyCode==Enum.KeyCode.Escape then
                            listening=false; kbBg.Color=T().Btn; kbTxt.Text=keyName(kc); activeBind=nil
                        else
                            kc=i.KeyCode; listening=false; kbBg.Color=T().Btn; kbTxt.Text=keyName(kc); activeBind=nil
                            if ko and ko.Callback then ko.Callback(kc) end
                        end
                    end
                    if not listening and i.KeyCode==kc then if ko and ko.OnKey then ko.OnKey() end end
                end)
                Library:_regCfg(kid,
                    function() return tostring(kc) end,
                    function(v) local ok3,k3=pcall(function() return Enum.KeyCode[v] end); if ok3 and k3 then kc=k3; kbTxt.Text=keyName(kc) end end
                )
                return {OnChanged=function()end}
            end
            addIt(it); return Lbl
        end

        function Obj:AddDropdown(id, o)
            local txt   = o.Text or id
            local vals  = o.Values or {}
            local multi = o.Multi
            local disabled = o.Disabled or false
            local val   = o.Default
            local dW    = COL - IP*2
            local iP    = Vector2.new()
            local isOpen = false
            local isActive = false
            local searchQuery = ""
            local filteredVals = vals
            local ddBtnRef = {
                pos=nil, sz=nil, active=function() return isActive and Win.Active == parentTab end,
            }
            table.insert(Win.DropBtns, ddBtnRef)
            if not multi and val==nil and vals[1] then val=vals[1] end

            local lbl  = d("Text",  {Text=txt,Size=14,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=20})
            local dBg  = d("Square",{Size=Vector2.new(dW,30),Filled=true,ZIndex=20,Rounding=12,Color=disabled and T().GroupBg or T().Btn,Visible=false,Position=Vector2.new(0,0)})
            local dVal = d("Text",  {Size=13,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=21})
            local dArr = d("Text",  {Text="▾",Size=12,Font=FONT,Outline=false,Color=T().Dim,Visible=false,ZIndex=21})
            th(function()
                lbl.Color = disabled and T().Dim or T().Text
                dBg.Color = disabled and T().GroupBg or (isOpen and T().Accent or T().Btn)
                dVal.Color = disabled and T().Dim or T().Text
                dArr.Color = T().Dim
            end)
            if disabled then
                table.insert(_disabledElems, {
                    getPos  = function() return iP end,
                    getSize = function() return Vector2.new(COL, 60) end,
                    isActive = function() return isActive and Win.Visible end,
                })
            end

            local function display()
                if isOpen and searchQuery ~= "" then
                    return "Search: " .. searchQuery
                end
                if multi then
                    local p={}; for k,v in pairs(val or {}) do if v then table.insert(p,tostring(k)) end end
                    table.sort(p)
                    if #p==0 then return "None" end
                    return #p<=2 and table.concat(p,", ") or (p[1]..", "..p[2].." +"..#p-2)
                end
                local s = tostring(val or "None")
                return #s>22 and s:sub(1,20).."…" or s
            end
            dVal.Text = display()

            local function rebuildFiltered()
                filteredVals = {}
                local q = string.lower(searchQuery)
                for _, item in ipairs(vals) do
                    local text = string.lower(tostring(item))
                    if q == "" or text:find(q, 1, true) then
                        filteredVals[#filteredVals + 1] = item
                    end
                end
                dVal.Text = display()
            end

            local pool = {}
            for _=1,MAXDD do
                local row = {
                    bg  = d("Square",{Filled=true, ZIndex=92,Rounding=6,Color=T().DropItem,Visible=false,Position=Vector2.new(0,0),Size=Vector2.new(1,DD_H)}),
                    chk = d("Square",{Filled=true, ZIndex=94,Rounding=4,Color=T().Accent,  Visible=false,Size=Vector2.new(12,12)}),
                    box = d("Square",{Filled=false,ZIndex=94,Rounding=4,Thickness=1,Color=T().Dim,Visible=false,Size=Vector2.new(12,12)}),
                    txt = d("Text",  {Size=13,Font=FONT,Outline=false,Color=T().Text,Visible=false,ZIndex=93,Position=Vector2.new(0,0)}),
                }
                th(function() row.bg.Color=T().DropItem; row.chk.Color=T().Accent; row.box.Color=T().Dim; row.txt.Color=T().Text end)
                table.insert(pool, row)
            end
            local lBg  = d("Square",{Filled=true, ZIndex=90,Rounding=10,Color=T().DropBg,      Visible=false,Position=Vector2.new(0,0),Size=Vector2.new(1,1)})
            local lOut = d("Square",{Filled=false,ZIndex=91,Rounding=10,Thickness=1,Color=T().GroupBorder,Visible=false,Position=Vector2.new(0,0),Size=Vector2.new(1,1)})
            th(function() lBg.Color=T().DropBg; lOut.Color=T().GroupBorder end)

            local function closeDD()
                isOpen=false; dBg.Color=T().Btn; dArr.Text="▾"
                searchQuery = ""
                lBg.Visible=false; lOut.Visible=false
                for _,row in ipairs(pool) do
                    row.bg.Visible=false; row.chk.Visible=false; row.box.Visible=false; row.txt.Visible=false
                end
                pcall(function() Win._activeDropRef = nil end)
            end

            local function openDD()
                if not dBg or not dBg.Position or dBg.Position == Vector2.new(0,0) then return end
                if activeDD then activeDD.close(); activeDD=nil end
                isOpen=true; pcall(function() dBg.Color=T().Accent end); dArr.Text="▴"
                rebuildFiltered()
                local count  = math.min(#filteredVals, MAXDD)
                local scrollIndex = 1
                if count == 0 then return end
                local listH  = count * DD_H + 8
                local vp     = pcall(function() return workspace.CurrentCamera.ViewportSize end) and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
                local baseY  = dBg.Position.Y + dBg.Size.Y + 4
                if baseY + listH > vp.Y - 10 then baseY = dBg.Position.Y - listH - 4 end
                local lx, lw = dBg.Position.X, dBg.Size.X
                lBg.Position =fv(Vector2.new(lx,baseY)); lBg.Size =fv(Vector2.new(lw,listH))
                lOut.Position=fv(Vector2.new(lx,baseY)); lOut.Size=fv(Vector2.new(lw,listH))
                lBg.Visible=true; lOut.Visible=true
                for i=1, count do
                    local row = pool[i]
                    local v = filteredVals[i]
                    if v then
                        local ry  = baseY + 4 + (i-1)*DD_H
                        local sel = multi and (type(val)=="table" and val[v]==true) or (val==v)
                        row.bg.Position=fv(Vector2.new(lx+4,ry)); row.bg.Size=Vector2.new(lw-8,DD_H)
                        row.bg.Color   = sel and T().DropSel or T().DropItem
                        row.bg.Visible = true
                        if multi then
                            local cx,cy = lx+10, ry+(DD_H-12)/2
                            if sel then
                                row.chk.Position=fv(Vector2.new(cx,cy)); row.chk.Visible=true; row.box.Visible=false
                            else
                                row.box.Position=fv(Vector2.new(cx,cy)); row.box.Visible=true; row.chk.Visible=false
                            end
                            row.txt.Position = fv(Vector2.new(lx+28, ry+(DD_H-13)/2))
                        else
                            row.chk.Visible=false; row.box.Visible=false
                            row.txt.Position = fv(Vector2.new(lx+14, ry+(DD_H-13)/2))
                        end
                        row.txt.Text=tostring(v); row.txt.Visible=true
                    end
                end
                local scrollState = {index = 1, visible = count}
                activeDD = { close=closeDD, pos=fv(Vector2.new(lx,baseY)), sz=fv(Vector2.new(lw,listH)), btnPos=dBg.Position, btnSz=dBg.Size, scroll=scrollState }
                pcall(function() Win._activeDropRef = ddBtnRef end)
            end

            local it = {h=60}
            function it.setVis(v)
                lbl.Visible=v; dBg.Visible=v; dVal.Visible=v; dArr.Visible=v
                isActive=v
                if not v and isOpen then closeDD(); activeDD=nil end
            end
            function it.setPos(p)
                iP=p; lbl.Position=fv(p+Vector2.new(IP,7))
                local curDW = math.max(48, COL - IP*2)
                dBg.Position=fv(p+Vector2.new(IP,32))
                dBg.Size = fv(Vector2.new(curDW,30))
                dVal.Position=fv(p+Vector2.new(IP+10,39))
                dArr.Position=fv(p+Vector2.new(IP+curDW-16,38))
                ddBtnRef.pos = dBg.Position; ddBtnRef.sz  = dBg.Size
            end

            on(UserInputService.InputBegan, function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                if Win.Active ~= parentTab or not isActive then return end
                if disabled then return end
                if dBg and dBg.Position and dBg.Size and over(dBg.Position, dBg.Size) then
                    if activeDD and Win._activeDropRef and Win._activeDropRef ~= ddBtnRef then return end
                    if isOpen then closeDD(); activeDD=nil else openDD() end
                    return
                end
                if isOpen then
                    local scrollIdx = activeDD and activeDD.scroll and activeDD.scroll.index or 1
                    for idx, row in ipairs(pool) do
                        local actualIdx = scrollIdx + idx - 1
                        local v = filteredVals[actualIdx]
                        if v and over(row.bg.Position, row.bg.Size) then
                            if multi then
                                if type(val) ~= "table" then val={} end
                                if val[v] then val[v]=nil else val[v]=true end
                                dVal.Text = display()
                                openDD()
                            else
                                val=v; dVal.Text=display(); closeDD(); activeDD=nil
                            end
                            if o.Callback then o.Callback(val) end
                            break
                        end
                    end
                end
            end)

            on(UserInputService.InputBegan, function(i)
                if not isOpen or Win.Active ~= parentTab or not isActive then return end
                if i.UserInputType ~= Enum.UserInputType.Keyboard then return end
                local keyNameStr = tostring(i.KeyCode):gsub("Enum%.KeyCode%.", "")
                if keyNameStr == "Backspace" then
                    searchQuery = searchQuery:sub(1, math.max(#searchQuery - 1, 0))
                    rebuildFiltered(); openDD(); return
                elseif keyNameStr == "Space" then
                    searchQuery = searchQuery .. " "
                    rebuildFiltered(); openDD(); return
                elseif keyNameStr == "Escape" then
                    closeDD(); activeDD=nil; return
                elseif keyNameStr == "Return" then
                    if #filteredVals > 0 then
                        local v = filteredVals[math.clamp(activeDD and activeDD.scroll and activeDD.scroll.index or 1, 1, #filteredVals)]
                        if v then
                            if multi then
                                if type(val) ~= "table" then val={} end
                                if val[v] then val[v]=nil else val[v]=true end
                                dVal.Text = display()
                                openDD()
                            else
                                val=v; dVal.Text=display(); closeDD(); activeDD=nil
                            end
                            if o.Callback then o.Callback(val) end
                        end
                    end
                    return
                else
                    local ch = keyNameStr:match("^[A-Z]$") or keyNameStr:match("^%d$")
                    if ch then
                        searchQuery = searchQuery .. string.lower(ch)
                        rebuildFiltered(); openDD(); return
                    end
                end
            end)

            on(RunService.RenderStepped, function()
                if not isOpen then return end
                local scrollIdx = activeDD and activeDD.scroll and activeDD.scroll.index or 1
                for idx, row in ipairs(pool) do
                    local actualIdx = scrollIdx + idx - 1
                    local v = filteredVals[actualIdx]
                    if v and row.bg.Visible then
                        local sel = multi and (type(val)=="table" and val[v]==true) or (val==v)
                        row.bg.Color = over(row.bg.Position, row.bg.Size) and T().DropHover or (sel and T().DropSel or T().DropItem)
                        row.txt.Text = tostring(v)
                    end
                end
            end)

            on(UserInputService.InputChanged, function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseWheel then return end
                if not activeDD or not isOpen then return end
                local overList = activeDD.pos and activeDD.sz and over(activeDD.pos, activeDD.sz)
                local overBtn = activeDD.btnPos and activeDD.btnSz and over(activeDD.btnPos, activeDD.btnSz)
                if not overList and not overBtn then return end
                local s = activeDD.scroll
                if not s then return end
                local delta = 0
                if i.Position and i.Position.Z then
                    if i.Position.Z > 0 then delta = -1 elseif i.Position.Z < 0 then delta = 1 end
                end
                if delta == 0 then return end
                local maxStart = math.max(1, #filteredVals - s.visible + 1)
                s.index = math.clamp(s.index + delta, 1, maxStart)
                local lx, lw = dBg.Position.X, dBg.Size.X
                local baseY = activeDD.pos.Y
                for i=1, s.visible do
                    local row = pool[i]
                    local actual = s.index + i - 1
                    local v = filteredVals[actual]
                    if v then
                        local ry = baseY + 4 + (i-1)*DD_H
                        row.bg.Position = fv(Vector2.new(lx+4, ry)); row.bg.Size = Vector2.new(lw-8, DD_H)
                        local sel = multi and (type(val)=="table" and val[v]==true) or (val==v)
                        row.bg.Color = sel and T().DropSel or T().DropItem
                        row.bg.Visible = true
                        if multi then
                            local cx,cy = lx+10, ry+(DD_H-12)/2
                            if sel then row.chk.Position=fv(Vector2.new(cx,cy)); row.chk.Visible=true; row.box.Visible=false
                            else row.box.Position=fv(Vector2.new(cx,cy)); row.box.Visible=true; row.chk.Visible=false end
                            row.txt.Position = fv(Vector2.new(lx+28, ry+(DD_H-13)/2))
                        else
                            row.chk.Visible=false; row.box.Visible=false
                            row.txt.Position = fv(Vector2.new(lx+14, ry+(DD_H-13)/2))
                        end
                        row.txt.Text = tostring(v); row.txt.Visible=true
                    else
                        row.bg.Visible = false; row.chk.Visible=false; row.box.Visible=false; row.txt.Visible=false
                    end
                end
                activeDD.scroll = s
            end)

            local Drop = {}
            function Drop:SetValues(v)
                vals=v; if not multi then val=v[1] end; dVal.Text=display()
                if isOpen then openDD() end
            end
            function Drop:SetValue(v)
                val = v
                dVal.Text = display()
                if isOpen then openDD() end
            end
            Library:_regCfg(id, function() return val end, function(v) val=v; dVal.Text=display(); if o.Callback then o.Callback(val) end end)
            addIt(it); if o.Callback then task.spawn(o.Callback, val) end
            return Drop
        end

        function Obj:AddKeybind(id, o)
            local txt = o.Text or id
            local ok2, kc2 = pcall(function() return Enum.KeyCode[o.Default or "Unknown"] end)
            local kc = (ok2 and kc2) or Enum.KeyCode.Unknown
            local disabled = o.Disabled or false
            local listening = false; local kbW = 70
            local isActive = false
            local iP = Vector2.new()
            local lbl   = d("Text",  {Text=txt,Size=14,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=20})
            local kbBg  = d("Square",{Size=Vector2.new(kbW,24),Filled=true,ZIndex=20,Rounding=6,Color=disabled and T().GroupBg or T().Btn,Visible=false})
            local kbTxt = d("Text",  {Text=keyName(kc),Size=12,Font=FONT,Outline=false,Center=true,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=21})
            th(function()
                lbl.Color = disabled and T().Dim or T().Text
                kbBg.Color = disabled and T().GroupBg or (listening and T().Accent or T().Btn)
                kbTxt.Color = disabled and T().Dim or T().Text
            end)
            local it = {h=34}
            function it.setVis(v) lbl.Visible=v; kbBg.Visible=v; kbTxt.Visible=v; isActive=v end
            function it.setPos(p)
                iP=p
                lbl.Position  = fv(p+Vector2.new(IP,9))
                kbBg.Position = fv(p+Vector2.new(COL-kbW-IP,5))
                kbTxt.Position= fv(p+Vector2.new(COL-kbW/2-IP,10))
            end
            local Bind = {Value=kc}
            on(UserInputService.InputBegan, function(i)
                if disabled then return end
                if i.UserInputType==Enum.UserInputType.MouseButton1 and over(kbBg.Position, kbBg.Size) and Win.Active==parentTab and isActive then
                    if activeBind then activeBind.cancel() end
                    listening=true; kbBg.Color=T().Accent; kbTxt.Text="..."
                    activeBind={cancel=function() listening=false; kbBg.Color=T().Btn; kbTxt.Text=keyName(kc); activeBind=nil end}
                    return
                end
                if listening and i.UserInputType==Enum.UserInputType.Keyboard then
                    if i.KeyCode==Enum.KeyCode.Escape then
                        listening=false; kbBg.Color=T().Btn; kbTxt.Text=keyName(kc); activeBind=nil
                    else
                        kc=i.KeyCode; Bind.Value=kc; listening=false; kbBg.Color=T().Btn; kbTxt.Text=keyName(kc); activeBind=nil
                        if o.Callback then o.Callback(kc) end
                    end
                end
                if not listening and i.KeyCode==kc then if o.OnKey then o.OnKey() end end
            end)
            if disabled then
                table.insert(_disabledElems, {
                    getPos  = function() return iP end,
                    getSize = function() return Vector2.new(COL, 34) end,
                    isActive = function() return isActive and Win.Visible end,
                })
            end
            Library:_regCfg(id, function() return tostring(kc) end, function(v) local ok3,k3=pcall(function() return Enum.KeyCode[v] end); if ok3 and k3 then kc=k3; Bind.Value=kc; kbTxt.Text=keyName(kc) end end)
            addIt(it); return Bind
        end

        function Obj:AddInput(id, o)
            local txt = o and o.Text or id
            local val = o and o.Default or ""
            local disabled = o and o.Disabled or false
            local dW = COL - IP*2
            local iP = Vector2.new()
            local isActive = false
            local listening = false

            local lbl = d("Text",  {Text=txt,Size=14,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=20})
            local bg  = d("Square",{Size=Vector2.new(dW,30),Filled=true,ZIndex=20,Rounding=12,Color=disabled and T().GroupBg or T().Btn,Visible=false})
            local valTxt = d("Text",{Text=val,Size=13,Font=FONT,Outline=false,Color=disabled and T().Dim or T().Text,Visible=false,ZIndex=21})

            th(function()
                lbl.Color = disabled and T().Dim or T().Text
                bg.Color = disabled and T().GroupBg or (listening and T().Accent or T().Btn)
                valTxt.Color = disabled and T().Dim or T().Text
            end)

            if disabled then
                table.insert(_disabledElems, {
                    getPos  = function() return iP end,
                    getSize = function() return Vector2.new(COL, 60) end,
                    isActive = function() return isActive and Win.Visible end,
                })
            end

            local function apply(newVal)
                val = newVal
                local displayTxt = val
                if listening then displayTxt = displayTxt .. "_" end

                if #displayTxt > 28 then 
                    displayTxt = "..." .. string.sub(displayTxt, #displayTxt - 25) 
                end
                
                valTxt.Text = displayTxt
                if o and o.Callback then o.Callback(val) end
            end

            local it = {h=60}
            function it.setVis(v)
                lbl.Visible=v; bg.Visible=v; valTxt.Visible=v; isActive=v
                if not v and listening then 
                    listening = false; bg.Color = T().Btn; apply(val) 
                end
            end
            function it.setPos(p)
                iP = p
                lbl.Position = fv(p + Vector2.new(IP, 7))
                local curDW = math.max(48, COL - IP*2)
                bg.Position = fv(p + Vector2.new(IP, 32))
                bg.Size = fv(Vector2.new(curDW, 30))
                valTxt.Position = fv(p + Vector2.new(IP + 10, 39))
            end

            local Inp = {Value = val}
            function Inp:SetValue(v) val = v; Inp.Value = v; apply(v) end

            on(UserInputService.InputBegan, function(i, gp)
                if disabled or not isActive or Win.Active ~= parentTab then return end
                
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    if over(bg.Position, bg.Size) then
                        if not listening then
                            listening = true
                            bg.Color = T().Accent
                            apply(val)
                        end
                    else
                        if listening then
                            listening = false
                            bg.Color = T().Btn
                            apply(val)
                        end
                    end
                elseif listening and i.UserInputType == Enum.UserInputType.Keyboard then
                    local kc = i.KeyCode
                    local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
                    local keyNameStr = tostring(kc):gsub("Enum%.KeyCode%.", "")

                    if keyNameStr == "Backspace" then
                        val = val:sub(1, math.max(#val - 1, 0))
                        apply(val)
                    elseif keyNameStr == "Return" or keyNameStr == "Escape" then
                        listening = false
                        bg.Color = T().Btn
                        apply(val)
                    elseif keyNameStr == "Space" then
                        val = val .. " "
                        apply(val)
                    else
                        local ch = keyNameStr:match("^[A-Z]$")
                        if ch then
                            val = val .. (shift and ch or string.lower(ch))
                            apply(val)
                        else
                            local num = keyNameStr:match("^%d$")
                            if num then
                                local shiftNums = {["1"]="!", ["2"]="@", ["3"]="#", ["4"]="$", ["5"]="%", ["6"]="^", ["7"]="&", ["8"]="*", ["9"]="(", ["0"]=")"}
                                val = val .. (shift and shiftNums[num] or num)
                                apply(val)
                            else
                                if keyNameStr == "Minus" then val = val .. (shift and "_" or "-"); apply(val)
                                elseif keyNameStr == "Equals" then val = val .. (shift and "+" or "="); apply(val)
                                elseif keyNameStr == "Period" then val = val .. (shift and ">" or "."); apply(val)
                                elseif keyNameStr == "Comma" then val = val .. (shift and "<" or ","); apply(val)
                                elseif keyNameStr == "Slash" then val = val .. (shift and "?" or "/"); apply(val)
                                end
                            end
                        end
                    end
                end
            end)

            Library:_regCfg(id, function() return val end, function(v) Inp:SetValue(v) end)
            addIt(it)
            if o and o.Callback then task.spawn(o.Callback, val) end
            return Inp
        end

        if side=="left" then table.insert(parentTab.L,GB) else table.insert(parentTab.R,GB) end
        layout(); return Obj
    end

    function Win:AddTab(name)
        local Tab = {L={}, R={}, Name=name}
        table.insert(Win.Tabs, Tab)
        local bP   = Vector2.new()
        local bLbl = d("Text",  {Text=name,Size=12,Font=FONT,Outline=false,Color=Win.Active==Tab and T().Bg or T().TabOff,Visible=true,ZIndex=19})
        -- Measure the label's actual rendered width instead of guessing from
        -- character count. The guess drifted from the real text width, so the
        -- indicator (and the spacing before the next tab) never lined up with
        -- what was on screen.
        local textW = (bLbl.TextBounds and bLbl.TextBounds.X) or (#name * 6.5)
        local tw    = math.floor(textW) + 20
        local btn   = {w=tw, Tab=Tab}
        -- Segmented-control style: instead of an underline, the active tab
        -- gets a solid rounded chip behind its label.
        local bInd = d("Square",{Size=Vector2.new(textW+16,22),Filled=true,ZIndex=18,Rounding=8,Color=T().Accent,Visible=Win.Active==Tab})
        th(function()
            bLbl.Color=(Win.Active==Tab) and T().Bg or T().TabOff
            bInd.Color=T().Accent
        end)

        function btn.setPos(p)
            bP=p; bLbl.Position=p; bInd.Position=fv(p+Vector2.new(-8,-4))
        end

        local function activate()
                if activeDD then activeDD.close(); activeDD=nil end
                if activeBind then activeBind.cancel(); activeBind=nil end
                for _, ob in ipairs(Win.Btns) do
                    if ob.Tab then
                        for _,gb in ipairs(ob.Tab.L) do gb.setVis(false) end
                        for _,gb in ipairs(ob.Tab.R) do gb.setVis(false) end
                        ob.bLbl.Color=T().TabOff; ob.bInd.Visible=false
                    end
                end
                Win.Active=Tab
                layout()
                for _,gb in ipairs(Tab.L) do gb.setPos(gb.pos) end
                for _,gb in ipairs(Tab.R) do gb.setPos(gb.pos) end
                for _,gb in ipairs(Tab.L) do gb.setVis(true) end
                for _,gb in ipairs(Tab.R) do gb.setVis(true) end
                bLbl.Color=T().Bg; bInd.Visible=true
        end

        btn.bLbl=bLbl; btn.bInd=bInd
        on(UserInputService.InputBegan, function(i)
            if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
            if over(bP, Vector2.new(tw, TAB_RH)) then activate() end
        end)
        table.insert(Win.Btns, btn)
        if not Win.Active then Win.Active=Tab; bLbl.Color=T().TabOn; bInd.Visible=true end
        function Tab:AddLeftGroupbox(n)  return makeGB(Tab,"left", n) end
        function Tab:AddRightGroupbox(n) return makeGB(Tab,"right",n) end
        layout(); return Tab
    end

    function Win:SetVisible(v) setVisible(v) end

    function Win:SetShadowEnabled(v)
        Win.ShadowEnabled = not not v
        pcall(function() wShd.Visible = Win.ShadowEnabled end)
        layout()
    end

    function Win:SetShadowTransparency(v)
        local n = tonumber(v) or 0
        n = math.clamp(n, 0, 1)
        Win.ShadowTransparency = n
        baseTransMap[wShd] = n
        pcall(function() wShd.Transparency = n end)
    end

    pcall(function()
        Library:_regCfg('WindowShadow', function() return Win.ShadowEnabled end, function(v) Win:SetShadowEnabled(v) end)
        Library:_regCfg('WindowShadowAlpha', function() return Win.ShadowTransparency end, function(v) Win:SetShadowTransparency(v) end)
    end)

    layout(); return Win
end

function Library:Unload()
    for _,c in ipairs(Library.Connections) do pcall(function() c:Disconnect() end) end
    for _,o in ipairs(Library.Drawings)   do pcall(function() o:Remove() end) end
    Library.Connections={}; Library.Drawings={}; Library.ThemeUpdaters={}; Library.ConfigData={}
    notifyList={}
    activeDD=nil; activeBind=nil
end

return Library
