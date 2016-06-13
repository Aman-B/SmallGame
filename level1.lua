-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- -- include Corona's "physics" library
-- local physics = require "physics"
-- physics.start(); physics.pause()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


-- include Corona's "widget" library
local widget = require "widget"

local paramsToBringBack
local txt_gameover,txt_highscore
local txt_score
local score_recv


-- for share module
local myClass = require("share");








--write to file

local function writeToFile(score_recv)
	local saveData = score_recv

	-- Path for the file to write
	local path = system.pathForFile( "myfile"..paramsToBringBack..".txt", system.DocumentsDirectory )

	-- Open the file handle
	local file, errorString = io.open( path, "w" )

	if not file then
	    -- Error occurred; output the cause
	    print( "File error: " .. errorString )
	else
	    -- Write data to file
	    file:write( saveData )
	    -- Close the file handle
	    io.close( file )
	end

	file = nil


end

--read file
local function readFromFile( )
	-- body
	local contents
	local path = system.pathForFile( "myfile"..paramsToBringBack..".txt", system.DocumentsDirectory )

-- Open the file handle
local file, errorString = io.open( path, "r" )

if not file then
    -- Error occurred; output the cause
    print( "File error: " .. errorString )
else
    -- Read data from file
    contents = file:read( "*a" )
    -- Output the file contents
    print( "Contents of " .. path .. "\n" .. contents )
    -- Close the file handle
    io.close( file )
end

file = nil
return contents

end

-- compare with highscore
local function compareWithHighsScore(score_recv)
	-- body
	print("Inside compare")
	local txt_savedscore= readFromFile()
	if txt_savedscore ~=nil then

		local savedscore=tonumber(txt_savedscore)

		--writing if high score(d)

		print("Received score : "..score_recv)
		if score_recv>savedscore then
			print("Inside compare1")
			writeToFile(score_recv)
			txt_highscore.text="New Highscore : "..score_recv.."!!"
			txt_highscore.isVisible=true
		end
	
    else
    	writeToFile(score_recv)
    end


	

end


--share button
local function onShareBtnReleased (event)
	myClass.onShareButtonReleased(event)
end

--home button
local function showHome(event)
	composer.removeScene("game")
	composer.removeScene("level1")
	composer.gotoScene("menu")
	end



--replay button handler
local function onPlayBtnRelease(event)
	
	composer.removeScene("game",true)
	
	local options = 
	{
    effect = "fade",
    time = 500,
    params = 
    	{
    		level=paramsToBringBack
     		
    	}
	}
	
	composer.gotoScene( "game",options)
	
	return true	-- indicates successful touch
end

--hides text "Goal!"
local function hideMyText(event)
	    print ("hideMyText")
	    txt_gameover.isVisible = false
	    txt_score.isVisible = false
	    txt_highscore.isVisible=false
	end




 
function scene:create( event )

	local sceneGroup = self.view
	--get params
	local params = event.params
	print("level"..params.paramsToBringBackText)
	paramsToBringBack=params.paramsToBringBackText
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	score_recv=params.scoreText
	

	local bg = display.newImageRect("images/check.jpg",display.contentWidth*2,display.contentHeight*3)
	txt_gameover= display.newText( "Game over!", 160, 150, "Arial", 60 )
	txt_highscore= display.newText( "HighScore : ", 160, 240, "Arial", 30 )


	txt_score= display.newText( "Score : "..score_recv, 160, 200, "Arial", 40 )


	local ReplayBtn = widget.newButton {
		label="Replay",
		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,
		onRelease = onPlayBtnRelease	-- event listener function
	}

	--home button
	local HomeBtn = widget.newButton {
		label="Home",
		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,
		onRelease = showHome	-- event listener function
	}




	txt_highscore.isVisible=false
	compareWithHighsScore(score_recv)
	scoreToSend=score_recv

	ReplayBtn.x = display.contentWidth*0.5
	ReplayBtn.y = display.contentHeight - 140

	HomeBtn.x = display.contentWidth*0.5
	HomeBtn.y = display.contentHeight - 100

	

	--share button
	local shareButton = widget.newButton{

		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,	
	    id = "share",    
	    label = "Share",
	    onRelease = onShareBtnReleased -- event listener function
	}
	shareButton.x = display.contentWidth*0.5
	shareButton.y = display.contentHeight -60





	

	-- all display objects must be inserted into group
	sceneGroup:insert( bg)
	sceneGroup:insert( txt_gameover)
	sceneGroup:insert( txt_score)
	sceneGroup:insert(HomeBtn)
	sceneGroup:insert( ReplayBtn)
	sceneGroup:insert(shareButton)
	sceneGroup:insert(txt_highscore)


	



end


function scene:show( event )
	local sceneGroup = self.view
	--get params
	local params = event.params
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.	    txt_gameover.isVisible = false
		txt_score.text="Score : "..params.scoreText
		txt_gameover.isVisible = true	    
		txt_score.isVisible = true


		compareWithHighsScore(params.scoreText)
			scoreToSend=params.scoreText

		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
				

	elseif phase == "did" then
		-- Called when the scene is now off screen
		physics.pause()
		hideMyText()
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	

	-- package.loaded[physics] = nil
	-- physics = nil
	
	-- sceneGroup:removeSelf()
	-- sceneGroup=nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene