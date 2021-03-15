
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(500, 500, {resizable = true, minwidth = 500, minheight = 500})
    Speed = 1.5
    Size = 400
    DotSize = 2
    --Text = {"In", "Hold", "Out", "Hold"}
    Directions = {Up = false, Down = false, Left = true, Right = false}
    DotPos = {x = 50, y = 50}
    TextDraw = {text = "Hold", x = 56, y = 238}
    local font = love.graphics.newFont(24)
	love.graphics.setFont(font)
    TextPos = {HoldL = {x = 56, y = 238}, HoldR = {x = 381, y = 238}, In = {x = 238, y = 56}, Out = {x = 224, y = 419}, Breathe = {x = 196, y = 238}}
    ExTextX = 1
    ExTextY = 1
    Bounds = {TopL = 50, BotR = 450}
end
--DRAW TEXT AT POSITIONS AND MOVING DOT
function love.draw()
    love.graphics.print(TextDraw.text, TextDraw.x, TextDraw.y)
    love.graphics.print(ExTextX, 10, 0)
    love.graphics.print(ExTextY, 10, 30)
    love.graphics.print("Breathe", 196, TextPos.HoldL.y)
    love.graphics.rectangle("line", Bounds.TopL, Bounds.TopL, Size, Size)
    love.graphics.circle("fill", DotPos.x, DotPos.y, DotSize)
end

function love.update()
    getText()
    updateDotPos()
    scaleScreen()
end

--Management functinos
function getText()
    if Directions.Up then
        TextDraw = {text = "Hold", x = 56, y = 238}
    elseif Directions.Down then
        TextDraw = {text = "Hold", x = 381, y = 238}
    elseif Directions.Left then
        TextDraw = {text = "In", x = 238, y = 56}
    elseif Directions.Right then
        TextDraw = {text = "Out", x = 224, y = 419}
    end
end

function updateDotPos()
    if DotPos.x >= Bounds.BotR then
        DotPos.x = Bounds.BotR
        Directions.Down = true
        Directions.Left = false
    end
    if DotPos.y >= Bounds.BotR then
        DotPos.y = Bounds.BotR
        Directions.Right = true
        Directions.Down = false
    end
    if DotPos.x <= Bounds.TopL then
        DotPos.x = Bounds.TopL
        Directions.Up = true
        Directions.Right = false
    end
    if DotPos.y <= Bounds.TopL then
        DotPos.y = Bounds.TopL
        Directions.Left = true
        Directions.Up = false
    end
    if Directions.Down then
        DotPos.y = DotPos.y + Speed
    end
    if Directions.Up then
        DotPos.y = DotPos.y - Speed
    end
    if Directions.Left then
        DotPos.x = DotPos.x + Speed
    end
    if Directions.Right then
        DotPos.x = DotPos.x - Speed
    end
end

function scaleScreen()
    local scaleX = love.graphics.getWidth() / 500
    local scaleY = love.graphics.getHeight() / 500
    ExTextX = scaleX
    ExTextY = scaleY
    local scale = 1
    if scaleX <= scaleY then
        scaleBy = scaleX
    else if scaleY <= scaleX then
        scaleBy = scaleY
    end
end
    --scale every var
    Size = 400 * scale
    Speed = 1.5 * scale
    DotSize = 2 * scale
    --scale Bounds
    Bounds.TopL = Bounds.TopL * scale
    Bounds.BotR = Bounds.TopL + Size
    --text vars
    --TextPos = {HoldL = {x = 56, y = 238}, HoldR = {x = 381, y = 238}, In = {x = 238, y = 56}, Out = {x = 224, y = 419}, Breathe = {x = 196, y = 238}}
    TextPos.HoldL.x = 56 * scale
    TextPos.HoldL.y = 238 * scale
    TextPos.HoldR.x = 381 * scale
    TextPos.HoldR.y = 238 * scale
    TextPos.In.x = 238 * scale
    TextPos.In.y = 56 * scale
    TextPos.Out.x = 224 * scale
    TextPos.Out.y = 419 * scale
    TextPos.Breathe.x = 196 * scale
    TextPos.Breathe.y = 238 * scale
    DotPos.x = DotPos.x * scale
    DotPos.y = DotPos.y * scale
end