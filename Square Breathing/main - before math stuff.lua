
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(500, 500, {resizable = true, minwidth = 500, minheight = 500})
    Speed = 1.5
    Size = 400
    DotSize = 2
    Directions = {Up = false, Down = false, Right = true, Left = false}
    DotPos = {x = 50, y = 50}
    TextDraw = {text = "Hold", x = 56, y = 238}
    local font = love.graphics.newFont(24)
	love.graphics.setFont(font)
    TextPos = {HoldL = {x = 56, y = 238}, HoldR = {x = 381, y = 238}, In = {x = 238, y = 56}, Out = {x = 224, y = 419}, Breathe = {x = 196, y = 238}}
    Bounds = {TopL = 50, BotR = 450} --the bounds for the movement of the dot. These should be equal to the top left and bottom righ corners of the square
end
--DRAW TEXT AT POSITIONS AND MOVING DOT
function love.draw()
    love.graphics.print(TextDraw.text, TextDraw.x, TextDraw.y) --Draw the breathing instructions at the correct position for the line
    love.graphics.print(ExTextX, 10, 0) --debug text for the x scale of the screen
    love.graphics.print(ExTextY, 10, 30) --debug text for the y scale
    love.graphics.print("Breathe", TextPos.Breathe.x, TextPos.Breathe.y) --Draw the word "Breathe" in the centre of the screen
    love.graphics.rectangle("line", Bounds.TopL, Bounds.TopL, Size, Size) --draw the main rectangle
    love.graphics.circle("fill", DotPos.x, DotPos.y, DotSize) --draw the dot moving around the rectangle
end

function love.update()
    getText()
    updateDotPos()
    scaleScreen()
end

--Management functinos
function getText() --sets the text that should be drawn and where
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

function updateDotPos() --changes the position of the dot
    if DotPos.x >= Bounds.BotR then --is the dot at the right edge or past it?
        DotPos.x = Bounds.BotR --stay on the right edge
        Directions.Down = true -- move downward along that edge
        Directions.Right = false -- stop moving right
    end
    if DotPos.y >= Bounds.BotR then --is the dot at the bottom edge or past it?
        DotPos.y = Bounds.BotR --stay on the bottom edge
        Directions.Left = true -- move left along that edge
        Directions.Down = false -- stop moving down
    end
    if DotPos.x <= Bounds.TopL then --is the dot at the left edge or past it?
        DotPos.x = Bounds.TopL -- stay on the left edge
        Directions.Up = true -- move up along that edge
        Directions.Left = false -- stop moving left
    end
    if DotPos.y <= Bounds.TopL then --is the dot at the top edge or past it?
        DotPos.y = Bounds.TopL --stay on the top edge
        Directions.Right = true -- move right along that edge
        Directions.Up = false -- stop moving up
    end
    if Directions.Down then -- if the flag to move down is true, then move down
        DotPos.y = DotPos.y + Speed
    end
    if Directions.Up then -- if the flag to move up is trye, then move up
        DotPos.y = DotPos.y - Speed
    end
    if Directions.Right then -- if the flag to move right is true, then move right
        DotPos.x = DotPos.x + Speed
    end
    if Directions.Left then
        DotPos.x = DotPos.x - Speed -- if the flag to move left is true, then move left
    end
end
