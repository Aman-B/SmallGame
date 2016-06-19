-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--ads
local coronaAds = require( "plugin.coronaAds" )

-- Substitute your own placement IDs when generated
local bannerPlacement = "banner-placement"
local interstitialPlacement = "interstitial-1"

-- Corona Ads listener function
local function adListener( event )

    -- Successful initialization of Corona Ads
    if ( event.phase == "init" ) then
        -- Show an ad
        coronaAds.show( bannerPlacement, false )
        --coronaAds.show( interstitialPlacement, true )
    end
end

-- Initialize Corona Ads (substitute your own API key when generated)
coronaAds.init( "aca893a4-d847-4460-8d14-873767619d2e", adListener )



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



--ignore, this (below) was a test for sprite animation

-- display.setStatusBar(display.HiddenStatusBar)
 
-- centerX = display.contentWidth * .5
-- centerY = display.contentHeight * .5

-- local bg = display.newImageRect("images/backg.jpg", 480, 320)
-- bg.x = centerX
-- bg.y = centerY

-- local function makeRyu()
 
-- 	local sheetData =  { width = 24 , height= 32, count = 1 , numFrames = 12 }
-- 	local spriteSheet = graphics.newImageSheet("images/res_viewer.png" , sheetData)
 
-- 	local sequenceData = { 
-- 	{name = "fight", frames={1,2,3,4,5,6,7,8,9,10,11,12,1},  count=13, time=10000, loopCount = 1 }
-- 	}		
	
-- 	ryu = display.newSprite (spriteSheet, sequenceData)
 
 
-- 	ryu.x = centerX-100
-- 	ryu.y = centerY+15
-- 	ryu:setSequence("fight")
	
-- end

-- makeRyu()


-- -- local function startCratefall()
-- -- 	crates:play()
-- -- end

-- local function startSprite(event)
-- ryu:play()
-- --timer.performWithDelay(200, startCratefall )
-- end


-- function touchScreen( event )
-- 	startSprite(event)
-- end


 

 
-- --ryu:addEventListener("tap", startSprite )
--  Runtime:addEventListener("touch", touchScreen)
