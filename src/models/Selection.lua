Selection = Class{}

function Selection:init(x, y, text)
    self.ox = x * TILE_SIZE
    self.oy = y * TILE_SIZE
    self.text = text
    self.selected = false
end

function Selection:update(selected)
    self.selected = selected
end

function Selection:render(containerx, containery, level)
    if self.selected then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
        love.graphics.setFont(gFonts['small'])
        love.graphics.print(self.text, self.ox + (containerx or 0), self.oy + (containery or 0))
    else
        love.graphics.setColor(LEVELS[level][1], LEVELS[level][2], LEVELS[level][3], 1)
        love.graphics.setLineWidth(1)
        love.graphics.setFont(gFonts['small'])
        love.graphics.print(self.text, self.ox + (containerx or 0), self.oy + (containery or 0))
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)
end