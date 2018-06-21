-- Makes (and updates) the topbar menu
---------------------------------------------------------------------------

function getSpotifyInfo()
  spotty = hs.execute('spotify i', true)
  spotty = string.gsub(spotty, "\n", " ")
  spotty = string.gsub(spotty, "Artist: ", "")
  spotty = string.gsub(spotty, "Track: ", "")
  spotty = string.gsub(spotty, "Album: ", "")
  spotty = string.gsub(spotty, "   ", "")
  spotty = string.gsub(spotty, "  ", " ")
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
  getSpotifyInfo() ..
  " 🔈 " ..
  defaultDeviceVolume ..
  separator
  )

end

-- How often to update Menubar
---------------------------------------------------------------------------
updateStatsInterval = 30
statsMenuTimer = hs.timer.new(updateStatsInterval, makeStatsMenu)
statsMenuTimer:start()

makeStatsMenu()
