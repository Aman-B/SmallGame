
local publicClass={}

-- Executed upon touching and releasing the button created below

 



 publicClass.onShareButtonReleased= function ( event )

    print("Score recved : "..scoreToSend)
    
    if "simulator" == system.getInfo( "environment" ) then
    native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator.", { "OK" } )
    end

    -- Require the widget library
    local widget = require( "widget" )

    -- Use the Android "Holo Dark" theme for this sample
    widget.setTheme( "widget_theme_android_holo_dark" )

    local serviceName = event.target.id
    local isAvailable = native.canShowPopup( "social", serviceName )

    -- For demonstration purposes, we set isAvailable to true here for Android.
    


    -- If it is possible to show the popup
    if isAvailable then
        local listener = {}
        function listener:popup( event )
            print( "name(" .. event.name .. ") type(" .. event.type .. ") action(" .. tostring(event.action) .. ") limitReached(" .. tostring(event.limitReached) .. ")" )			
        end

        -- Show the popup
        native.showPopup( "social",
        {
            service = serviceName, -- The service key is ignored on Android.
            message = "I scored"..scoreToSend.." goals in this awesome game. Check it out here!",
            listener = listener,
           
            url = 
            { 
                "http://www.coronalabs.com",
            }
        })
    else
        if isSimulator then
            native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator, please build for an iOS/Android device or the Xcode simulator", { "OK" } )
        else
            -- Popup isn't available.. Show error message
            native.showAlert( "Cannot send " .. serviceName .. " message.", "Please setup your " .. serviceName .. " account or check your network connection (on android this means that the package/app (ie Twitter) is not installed on the device)", { "OK" } )
        end
    end
end

return publicClass

