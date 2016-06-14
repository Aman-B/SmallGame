--composer for new levels
local composer = require( "composer" )
local scene = composer.newScene()

local physics = require ("physics")
physics.start()




display.setStatusBar( display.HiddenStatusBar )




--local time = display.newText(duration,)

--need to know no of player,duration
local no_of_player
local duration
local timerText
local paramsToBringBack
local paramsToBringBackText 

local function getPlayerCount(level)
	playercount=2
	if level=="Medium" then
		playercount=3
	end
	if level == "Difficult" then
		playercount=4
	end
	print("playa"..playercount)
	return playercount

end

-- player count acc to difficulty



--create player
local function spawnPlayers()

	print("player created")
	local player = display.newImage("images/captur.PNG")
	player.x=math.random(40,166)
	player.y=math.random(66,404)
	player.name="player"
	physics.addBody(player,"static")

	return player

end



function scene:create( event )
	local sceneGroup = self.view
	-- CREATING OBJECTS

	--get level
	local params=event.params
	local  level= params.level
	paramsToBringBack=level


	

	--decide no of players
	no_of_player=getPlayerCount(level)
	print("No"..no_of_player)
	
	--table for players
	local player={}

	local bg = display.newImageRect("images/check.jpg",display.contentWidth*2,display.contentHeight*2.2)


	local star = display.newImage("images/fball.png")
	star.x = 160
	star.y = 500
	star.name = "star"
	physics.addBody(star,"dynamic")
	physics.setGravity(0,0)

	local goalpost = display.newImageRect("images/fbpost.png",display.contentWidth+display.contentWidth*0.5,100)
	goalpost.x = 90
	goalpost.y = 0
	--resize
	goalpost.name = "goal"
	physics.addBody(goalpost,"static")

	--spwan players acc. to count

	for i=1,no_of_player,1 do
		print("Spawn")
		player[i]=spawnPlayers()

	end


	-- local player1 = display.newImage("images/captur.PNG")
	-- player1.x = 69
	-- player1.y = 165	
	-- player1.name="player1"
	-- physics.addBody(player1,"static")

	-- local player2 = display.newImage("images/captur.PNG")
	-- player2.x = 235
	-- player2.y = 197
	-- player2.name="player2"
	-- physics.addBody(player2,"static")


	local goaltxt=("")

	local displayGoal = display.newText( goaltxt, 160, 240, "Arial", 60 )

	local halfW= display.contentWidth*0.5
	local halfH= display.contentHeight*0.5

	score=0
	scoreText= display.newText("Score : "..score,halfW-100,0,native.systemFont,25)
	--display.newText("Score :  ",halfW-40,10,native.systemFont,26)

	 duration= 10
	 timerText= display.newText("Time : "..duration,halfW+90,0,native.systemFont,25)


	sceneGroup:insert(bg)
	sceneGroup:insert(star)
	sceneGroup:insert(goalpost)
	sceneGroup:insert(displayGoal)
	sceneGroup:insert(scoreText)
	sceneGroup:insert(timerText)

	for i=1,#player do
		sceneGroup:insert(player[i])
	end	



	-- DEFINING FUNCTIONS




--to open game over screen.
local function showGameOver()
	-- this method can be called to go to next page
	local composer= require "composer"
	local options = {
    effect = "fade",
    time = 500,
    params = {
    	paramsToBringBackText=paramsToBringBack,
        scoreText=score
    }
}

	composer.gotoScene( "level1", options )

end



-- decreases time

local function decreaseTimeByOneSec()

	duration=duration-1
	timerText.text="Time : "..duration
	if duration== 0 then
		showGameOver()
	end

end

--calling above function after every one sec

timer.performWithDelay(1000,decreaseTimeByOneSec,duration)





--hides text "Goal!"
function hideMyText(event)
    print ("hideMyText")
    displayGoal.isVisible = false
end




function touchScreen( event )
	if event.phase == "began" then
	print(event.x)
	print(event.y)
	transition.to(star, {time=500, x=event.x, y=event.y, tag="star"})
	end
end


function onLocalPreCollision( self, event )
if event.other.name == "goal" then
	print("You scored a goal")
	displayGoal.isVisible=true
	displayGoal.text="Goal!"
	score=score+1
	scoreText.text="Score : "..score

 	--timer.performWithDelay(1000,hideMyText)
  end
end

function onCollision(event)
	print(event.phase)
	if(event.contact.isTouching) then
	 print("collide!")
	end
	
end


function pushStarToOriginalPosition()
	print("Star to original position")
	
	if star then
 		transition.to(star, {x = 160, y= 500, time=0,
		onComplete=timer.performWithDelay(1000,hideMyText),tag="star"})
 	end
end


function movePlayer(player)
	--print("Move soldier.")

	--save current,i.e. prev position

	--move others
	for i=1,no_of_player-1,1 do
	--	print("for sure.")
		prevX=player[i].x
		prevY=player[i].y
		print(prevX.."yo")
		transition.to(player[i],{time=1000,x=math.random(40,166),y=math.random(66,404),tag="player1"})
	end

		--move one player
	transition.to( player[no_of_player],
	{
		time=1000,
		x=math.random(40,166),
		y=math.random(66,404),
		onComplete = function()
                movePlayer(player)
            	end,
            	tag="player"

	})


end


function callmovePlayer()
	-- body
	print("Here")
	movePlayer(player)

end


function onLocalPostCollision( self, event )
	print("Just collided!")
	if(event.contact.isTouching) then
	--stopping star transition so that it doesnt go in goal. 
	transition.cancel("star")
	pushStarToOriginalPosition()
	print(event.selfElement)
	end-- body
end








movePlayer(player)

 Runtime:addEventListener("touch", touchScreen)

star.preCollision = onLocalPreCollision
star:addEventListener( "preCollision", star )

Runtime:addEventListener("collision", onCollision)

star.postCollision = onLocalPostCollision
star:addEventListener( "postCollision", star )


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
		transition.cancel("player")
		transition.cancel("player1")
		transition.cancel("star")
		if player ~=nil then
		for i=1,#player do
			player[i]:removeSelf()
			player[i]=nil
		end		
	end
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	--composer.removeScene("level1",true)
	
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