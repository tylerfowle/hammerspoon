-- Makes (and updates) the topbar menu filled with the current Space, the
-- temperature and the fan speed. The Space only updates if the space is changed
-- with the Hammerspoon shortcut (option + arrows does not work). 
---------------------------------------------------------------------------

function getSpotifyTrack()
  spotty = hs.execute('spotify i|grep Track', true)
  spotty = string.gsub(spotty, "\n", "")
  return spotty
end

function getSpotifyArtist()
  spotty = hs.execute('spotify i|grep Artist', true)
  spotty = string.gsub(spotty, "\n", "")
  return spotty
end

function getSpotifyAlbum()
  spotty = hs.execute('spotify i|grep Album', true)
  spotty = string.gsub(spotty, "\n", "")
  return spotty
end

local function makeStatsMenu(calledFromWhere)
  if statsMenu == nil then
    statsMenu = hs.menubar.new()
  end

  defaultDevice = hs.audiodevice.defaultOutputDevice()
  defaultDeviceName = tostring(defaultDevice:name())
  defaultDeviceVolume = math.floor(defaultDevice:outputVolume())
  separator = " │ "

  statsMenu:setTitle(
  getSpotifyTrack() ..
  "  " ..
  getSpotifyArtist() ..
  "  " ..
  getSpotifyAlbum() ..
  separator ..
  -- "Audio: " ..
  -- defaultDeviceName ..
  -- separator ..
  "Volume: " ..
  defaultDeviceVolume ..
  separator
  )

end





-- How often to update Menubar
---------------------------------------------------------------------------
updateStatsInterval = 5
statsMenuTimer = hs.timer.new(updateStatsInterval, makeStatsMenu)
statsMenuTimer:start()

makeStatsMenu()
