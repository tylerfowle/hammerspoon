-- Makes (and updates) the topbar menu
---------------------------------------------------------------------------

local function spotifyStatus()
  if hs.spotify.isPlaying == true
  then
    status = "▶️ "
  else
    status = "⏹ "
  end

  return status
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
  spotifyStatus() ..
  " 🎤 "..
  hs.spotify.getCurrentArtist() ..
  " 🎵 "..
  hs.spotify.getCurrentTrack() ..
  " 💽 "..
  hs.spotify.getCurrentAlbum() ..
  " 🔈 " ..
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
