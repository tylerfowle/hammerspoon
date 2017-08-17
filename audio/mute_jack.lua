-- Mute on jack in/out
---------------------------------------------------------------------------
function audioWatch(uid, eventName, eventScope, channelIdx)
  if eventName == 'jack' then
    hs.alert.show("Audio Changed. Muting.")
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end

end


-- Watch device; mute when headphones unplugged.
local defaultDevice = hs.audiodevice.defaultOutputDevice()
defaultDevice:watcherCallback(audioWatch);
defaultDevice:watcherStart();



