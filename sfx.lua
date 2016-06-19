local sfx={}
local mydata=require("mydata")

sfx.init=function()
sfx.buttonSound = audio.loadSound("audio/beep1.mp3")
--sfx.bgmusic = audio.loadSound("audio/backgmusic.mp3")
sfx.kickSound= audio.loadSound("audio/kick.mp3")
sfx.goalSound=audio.loadSound("audio/goal2.wav")
sfx.kickByCompSound= audio.loadSound("audio/kick2.wav")
sfx.highscoreSound=audio.loadSound("audio/highscore.mp3")
sfx.isSoundOn=true

end

sfx.setMenuVolume=function()
	audio.reserveChannels(2)

	sfx.masterVolume = audio.getVolume()  --print( "volume "..masterVolume )
	audio.setVolume( 0.1, { channel = 1 } )  --bg track
	audio.setVolume( 0.1, { channel = 2 } )  --button 


end

sfx.setGameAndOverVolume=function( )
	-- body
	audio.reserveChannels(1)

	audio.setVolume( 0.2,  { channel = 3 } ) --buttonSound and playerkicks
	audio.setVolume( 0.2,  { channel = 4 } )  -- goalsound and all others

end
-- to handle audio settings and play sound accoridingly
sfx.play=function(handle,options)

	if(mydata.isSoundOn==true) then
		audio.play(handle,options)
	else

		return false


	end


end


return sfx