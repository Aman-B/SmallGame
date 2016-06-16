local sfx={}

sfx.init=function()
sfx.buttonSound = audio.loadSound("audio/beep1.mp3")
sfx.bgmusic = audio.loadSound("audio/backgmusic.mp3")
sfx.kickSound= audio.loadSound("audio/kick.mp3")
sfx.goalSound=audio.loadSound("audio/goal2.wav")
sfx.kickByCompSound= audio.loadSound("audio/kick2.wav")
sfx.highscoreSound=audio.loadSound("audio/highscore.mp3")
sfx.isSoundOn=true

audio.reserveChannels(5)
sfx.masterVolume = audio.getVolume()  --print( "volume "..masterVolume )
audio.setVolume( 0.2, { channel = 1 } )  --bg track
audio.setVolume( 0.1, { channel = 2 } )  --bg track in game
audio.setVolume( 0.2,  { channel = 3 } )  --button,playerSound and all
audio.setVolume( 1.0,  { channel = 4 } )  --alien voice
audio.setVolume( 0.25, { channel = 5 } )


end




return sfx