-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require("physics")
physics.start()

local halfW= display.contentWidth*0.5
local halfH= display.contentHeight*0.5


-- image background

local bkg = display.newImageRect("backg.jpg")


-- bkg.anchorX=0
-- bkg.anchorY=0


-- hide the status bar

display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "menu" )