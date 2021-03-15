function love.load()
    love.window.setMode(500, 500)
    Speed = 1.5
    Size = 400
    DotSize = 2
    Text = {"In", "Hold", "Out", "Hold"}
    Directions = {Up = false, Down = false, Left = true, Right = false}
    DotPos = {x = 50, y = 50}
    TextDraw = {text = "Hold", x = 56, y = 238}
    local font = love.graphics.newFont(24)
	love.graphics.setFont(font)
end
--DRAW TEXT AT POSITIONS AND MOVING DOT
function love.draw()
    love.graphics.print(TextDraw.text, TextDraw.x, TextDraw.y)
    love.graphics.print("Breathe", 196, 238)
    love.graphics.rectangle("line", 50, 50, Size, Size)
    love.graphics.circle("fill", DotPos.x, DotPos.y, DotSize)
end

function love.update()
    getText()
    updateDotPos()
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
    if DotPos.x >= 450 then
        DotPos.x = 450
        Directions.Down = true
        Directions.Left = false
    end
    if DotPos.y >= 450 then
        DotPos.y = 450
        Directions.Right = true
        Directions.Down = false
    end
    if DotPos.x <= 50 then
        DotPos.x = 50
        Directions.Up = true
        Directions.Right = false
    end
    if DotPos.y <= 50 then
        DotPos.y = 50
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