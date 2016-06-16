local animClass={}

local sheetData
local spriteSheet
local sequenceData
local player

animClass.makePlayer= function ()
 
	sheetData =  { width = 36 , height= 48, count = 1 , numFrames = 12 }
	spriteSheet = graphics.newImageSheet("images/playerview.png" , sheetData)
 
	sequenceData = 
	{ 

		{
			name = "up",
		    frames={1,2,3,1},  
		    count=4,
		    time=4000, 
		    loopCount = 0 

		},

		{
			name = "down",
		    frames={7,8,9,7},  
		    count=4,
		    time=4000, 
		    loopCount = 0 

		},
		{
			name = "left",
		    frames={10,11,12,10},  
		    count=4,
		    time=4000, 
		    loopCount = 0 

		},
		{
			name = "right",
		    frames={4,5,6,4},  
		    count=4,
		    time=4000, 
		    loopCount = 0 

		}

	}	
	
	player = display.newSprite (spriteSheet, sequenceData)
 
 
	-- player.x = centerX-100
	-- player.y = centerY+15
	player:setSequence("down")
	return player
end

--makePlayer()


-- local function startCratefall()
-- 	crates:play()
-- end

animClass.setSequence=function(sequence)
	player:setSequence(sequence)
end
 
animClass.startSprite =function ()
	player:play()
--timer.performWithDelay(200, startCratefall )
end



return animClass
--ryu:addEventListener("tap", startSprite )