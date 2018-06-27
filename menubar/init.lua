-- Makes (and updates) the topbar menu
---------------------------------------------------------------------------

local menu = nil
local updateInterval = 5
local separator = " │ "

local function setMenuTitle(calledFromWhere)
  if menu == nil then
    menu = hs.menubar.new()
  end

  defaultDevice = hs.audiodevice.defaultOutputDevice()
  defaultDeviceVolume = math.floor(defaultDevice:outputVolume())

  if hs.spotify.isPlaying() then
    menu:setTitle(
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
  else
    menu:setTitle("⏹ ")
  end
end

local statsMenuTimer = hs.timer.new(updateInterval, setMenuTitle)
statsMenuTimer:start()
setMenuTitle()
