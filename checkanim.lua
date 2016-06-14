display.setStatusBar(display.HiddenStatusBar)
 
centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

local bg = display.newImageRect("images/backg.jpg", 480, 320)
bg.x = centerX
bg.y = centerY

local function makeRyu()
 
	local sheetData =  { width = 24 , height= 32, count = 1 , numFrames = 12 }
	local spriteSheet = graphics.newImageSheet("images/res_viewer.png" , sheetData)
 
	local sequenceData = { 
	{name = "fight", frames={1,2,3,4,5,6,7,8,9,10,11,12,1},  count=22 time=10000, loopCount = 1 }
	}		
	
	ryu = display.newSprite (spriteSheet, sequenceData)
 
 
	ryu.x = centerX-100
	ryu.y = centerY+15
	ryu:setSequence("fight")
	
end

makeRyu()


-- local function startCratefall()
-- 	crates:play()
-- end
 
local function startSprite(event)
ryu:play()
--timer.performWithDelay(200, startCratefall )
end
 
ryu:addEventListener("tap", startSprite )