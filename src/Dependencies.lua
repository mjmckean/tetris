love.graphics.setDefaultFilter('nearest', 'nearest')

-- libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'
require 'src/StateMachine'
require 'src/Util'

-- models
require 'src/Block'
require 'src/Container'
require 'src/Tetromino'

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'

gTextures = {
    ['main'] = love.graphics.newImage('assets/tetrominoes.png'),
    ['background'] = love.graphics.newImage('assets/background.jpg')
}

gFrames = {
    ['blocks'] = GenerateTileQuads(gTextures['main'])
}

gFonts = {
    ['small'] = love.graphics.newFont('assets/font.ttf', 8),
    ['medium'] = love.graphics.newFont('assets/font.ttf', 16),
    ['large'] = love.graphics.newFont('assets/font.ttf', 32)
}