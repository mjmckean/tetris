Board = Class{}

function Board:init(x, y, mode, width, height)
    -- board positions
    self.gridX = x
    self.gridY = y
    self.width = width or 10
    self.height = height or 20

    -- coordinate positions
    self.x = (self.gridX - 1) * TILE_SIZE
    self.y = (self.gridY - 1) * TILE_SIZE

    self.completedRows = {}
    self.mode = mode or 'easy'

    self:initializeTiles()
end

function Board:initializeTiles()
    self.tiles = {}

    for row = 0, self.height - 1 do
        self.tiles[row] = {}

        for column = 0, self.width - 1 do
            if self.mode == 'hard' and row > 5 then
                self.tiles[row][column] = (math.random(10) < 4) and Block(self.gridX + column,
                                                                        self.gridY + row,
                                                                        LETTERS[math.random(7)])
                                                                or nil
            elseif self.mode == 'normal' and row > 10 then
                self.tiles[row][column] = (math.random(10) < 6) and Block(self.gridX + column,
                                                                        self.gridY + row,
                                                                        LETTERS[math.random(7)])
                                                                or nil
            else
                self.tiles[row][column] = nil
            end
        end
    end

    while self:calculateCompletedRows() do
        -- recursively initialize if completedRows were returned for non-easy modes
        self:initializeTiles()
    end 
end

function Board:calculateCompletedRows()
    local completedRows = {}
    local incomplete = false

    for row = 0, self.height - 1 do
        incomplete = false
        for block = 0, self.width - 1 do
            if not self.tiles[row][block] then
                incomplete = true
                break
            end
        end
        if not incomplete then
            table.insert(completedRows, row)
        end
    end

    self.completedRows = completedRows

    return #self.completedRows > 0 and self.completedRows or false
end

function Board:removeCompletedRows()
    -- fix
    local clearedRows = 0

    for row = self.height - 1, 0, -1 do
        for _, completedRow in pairs(self.completedRows) do
            if completedRow == row then
                for column = 0, self.width - 1 do
                    self.tiles[row][column] = nil
                end
                clearedRows = clearedRows + 1
                break
            else
                self.tiles[row + clearedRows] = self.tiles[row]
            end
        end
    end
    for row = 0, clearedRows do
        for column = 0, self.width - 1 do
            self.tiles[row][column] = nil
        end
    end
end

function Board:render(level)
    for row = 0, self.height - 1 do
        for column = 0, self.width - 1 do
            if self.tiles[row][column] then
                self.tiles[row][column]:render(0, 0, level, self)
            end
        end
    end
end