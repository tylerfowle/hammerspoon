-- Makes (and updates) the topbar menu filled with the current Space, the
-- temperature and the fan speed. The Space only updates if the space is changed
-- with the Hammerspoon shortcut (option + arrows does not work). 
---------------------------------------------------------------------------
local function makeStatsMenu(calledFromWhere)
  if statsMenu == nil then
    statsMenu = hs.menubar.new()
  end
  -- currentSpace = tostring(spaces.currentSpace())
  currentSpace = tostring(spaces.currentSpace())
  defaultDevice = hs.audiodevice.defaultOutputDevice()
  defaultDeviceName = tostring(defaultDevice:name())
  defaultDeviceVolume = math.floor(defaultDevice:outputVolume())
  statsMenu:setTitle("Space: " .. currentSpace .. " | " .. "Audio: " .. defaultDeviceName .. " | "  .. "Volume: " .. defaultDeviceVolume .. " | ")
end


-- print( spaces.debug.layout())



-- How often to update Menubar
---------------------------------------------------------------------------
updateStatsInterval = 5
statsMenuTimer = hs.timer.new(updateStatsInterval, makeStatsMenu)
statsMenuTimer:start()

currentSpace = tostring(spaces.currentSpace())
makeStatsMenu()



