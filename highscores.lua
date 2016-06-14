local composer = require( "composer" )

local scene = composer.newScene()
-- include Corona's "widget" library
local widget = require "widget"


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


--read from file
local function readFromFile(filename )
	-- body
	local contents
	local path = system.pathForFile( "myfile"..filename..".txt", system.DocumentsDirectory )

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


--back button handler, hide overlay
local function onHighScoreBtnReleased(event)
		print("back")

	composer.hideOverlay( "fade", 400 )

	return true	-- indicates successful touch
end



-- create()
function scene:create( event )

    local sceneGroup = self.view


    local bg = display.newImageRect("images/check.jpg",display.contentWidth*2,display.contentHeight*3)

    easyScore=readFromFile("Easy")
    mediumScore=readFromFile("Medium")
    difficultScore=readFromFile("Difficult")

    txt_head= display.newText( "Highscores", 160, 80, "Arial", 55 )
    -- Code here runs when the scene is first created but has not yet appeared on screen
    txt_easy= display.newText( "Easy : "..easyScore, 160, 180, "Arial", 25 )
    txt_medium= display.newText( "Medium : "..mediumScore, 160, 220, "Arial", 25 )
    txt_difficult= display.newText( "Difficult : "..difficultScore, 160, 260, "Arial", 25 )

    --back button
	local BackButton = widget.newButton{

		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,	
	    id = "back",    
	    label = "Back",
	    onRelease = onHighScoreBtnReleased -- event listener function
	}
	BackButton.x = display.contentWidth*0.5
	BackButton.y = display.contentHeight -30



    sceneGroup:insert(bg)
    sceneGroup:insert(txt_head)
    sceneGroup:insert(txt_easy)
    sceneGroup:insert(txt_medium)
    sceneGroup:insert(txt_difficult)
    sceneGroup:insert(BackButton)
end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object


    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase	
    local parent = event.parent  --reference to the parent scene object


    if ( phase == "will" ) then
    		print("backq")

        -- Code here runs when the scene is on screen (but is about to go off screen)
        parent:show(event)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene