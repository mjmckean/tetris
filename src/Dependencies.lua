love.graphics.setDefaultFilter('nearest', 'nearest')

-- libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'
require 'src/StateMachine'
require 'src/Util'

-- models
require 'src/models/Board'
require 'src/models/Block'
require 'src/models/Container'
require 'src/models/Selection'
require 'src/models/Tetromino'

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'
require 'src/states/TitleState'

gSounds = {
    ['select'] = love.audio.newSource('assets/select.wav', 'static')
}

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
    ['large'] = love.graphics.newFont('assets/font.ttf', 64)
}