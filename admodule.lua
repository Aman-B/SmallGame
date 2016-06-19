local coronaAds = require( "plugin.coronaAds" )

local publicClass={}

publicClass.adlistener=function (event)
	-- Successful initialization of Corona Ads
	bannerPlacement = "banner-placement"
	interstitialPlacement = "interstitial-1"
    if ( event.phase == "init" ) then
         -- Show an ad
         print("Showing ads")
         coronaAds.show( bannerPlacement, false )
         --if(show<6) then
         coronaAds.show( interstitialPlacement, true )
     	 --end
    end
end

publicClass.init=function()-- Initialize Corona Ads (substitute your own API key when generated)
	coronaAds.init( "aca893a4-d847-4460-8d14-873767619d2e", adListener )
end	


return publicClass