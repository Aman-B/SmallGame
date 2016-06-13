-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn,mediumBtn,difficultBtn,txt_gamename

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease(event)
	
	-- go to level1.lua scene

	--decide level
	print(event.target:getLabel())
	if event.target:getLabel()=="Easy" then
		leveltxt="Easy"
		print("Level "..leveltxt)

	elseif event.target:getLabel()=="Medium" then
		leveltxt="Medium"
		print("Level "..leveltxt)
	else
		leveltxt="Difficult"
		print("Level "..leveltxt)
	end





	local options = {
		effect="fade",
		time=500,
		params={ level=leveltxt
		}
	}
	composer.gotoScene( "game", options )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	print("Here in scene")
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "images/check.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	-- local titleLogo = display.newImageRect( "logo.png", 264, 42 )
	-- titleLogo.x = display.contentWidth * 0.5
	-- titleLogo.y = 100
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Easy",
		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 170


	--medium level
	mediumBtn = widget.newButton{
		label="Medium",
		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	mediumBtn.x = display.contentWidth*0.5
	mediumBtn.y = display.contentHeight - 125

	
	--difficult level
	difficultBtn = widget.newButton{
		label="Difficult",
		fontSize="20",
		font="Bold",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
		defaultFile="images/buttonoverlay.png",
		overFile="images/buttonoverlay.png",
		width=154, height=50,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	difficultBtn.x = display.contentWidth*0.5
	difficultBtn.y = display.contentHeight - 80


	txt_gamename= display.newText( "8-bit Soccer", 160, 220, "Arial", 55 )



	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert(txt_gamename)
	sceneGroup:insert( playBtn )
	sceneGroup:insert( mediumBtn )
	sceneGroup:insert (difficultBtn)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
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
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene