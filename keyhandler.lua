local publicClass={}

publicClass.onKeyEvent= function ( event )
	local composer = require( "composer" )

	local phase = event.phase
	   local keyName = event.keyName
	   print( event.phase, event.keyName )
	   currScene= composer.getSceneName("current")
	   print("Current : "..currScene)
	 
	   if ( "back" == keyName and phase == "down" ) then
	      
	      if ( currScene == "menu" ) then
	         native.requestExit()
	      else
		      if ( currScene == "level1" ) then
		      	print("going to menu1")
		         composer.gotoScene("menu",{ effect="crossFade", time=500 })
		      end
		  end
	   end
	 
	   if ( keyName == "volumeUp" and phase == "down" ) then
	      local masterVolume = audio.getVolume()
	      print( "volume:", masterVolume )
	      if ( masterVolume < 1.0 ) then
	         masterVolume = masterVolume + 0.1
	         audio.setVolume( masterVolume )
	      end
	      return true
	   elseif ( keyName == "volumeDown" and phase == "down" ) then
	      local masterVolume = audio.getVolume()
	      print( "volume:", masterVolume )
	      if ( masterVolume > 0.0 ) then
	         masterVolume = masterVolume - 0.1
	         audio.setVolume( masterVolume )
	      end
	      return true
	   end
	return false  --SEE NOTE BELOW
end

return publicClass