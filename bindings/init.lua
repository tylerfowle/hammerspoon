--MODIFIERS
---------------------------------------------------------------------------
hyper 	 = {"cmd", "alt", "ctrl"}
hypershift = {"cmd", "alt", "ctrl", "shift"}

-- windows management
-- hypershift + E,S,F,C



-- Mouse Remap
local function mousePress(eventobj)

  if eventobj:getButtonState(4) then
    print("mouse button 5")
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.delete, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.delete, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post()
  end

  if eventobj:getButtonState(3) then
    print("mouse button 4")
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.delete, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.delete,  false):post()
  end

  return false
end

hs.eventtap.new({25}, mousePress):start()




-- HOTKEYS
---------------------------------------------------------------------------
-- apply window layout for current monitor configuration
hs.hotkey.bind(hypershift, "y", function()
  applyWindowLayout()
end)


-- SCREENS
---------------------------------------------------------------------------
--
-- push window one screen left
hs.hotkey.bind(hypershift, "x", function()
  moveWindowToScreen("left")
end)

-- push window one screen right
hs.hotkey.bind(hypershift, "v", function()
  moveWindowToScreen("right")
end)



-- SPACES
---------------------------------------------------------------------------

-- create new space
hs.hotkey.bind(hypershift, "i", function()
  hs.alert.show("creating new space")
  spaces.createSpace()
end)

-- focus one space left
hs.hotkey.bind(hypershift, "w", function()
  moveOneSpace("1")
end)

-- focus one space right
hs.hotkey.bind(hypershift, "r", function()
  moveOneSpace("2")
end)

-- move focused widow one space left
hs.hotkey.bind(hypershift, "h", function()
  moveWindowOneSpace("1")
end)

-- move focused widow one space right
hs.hotkey.bind(hypershift, "l", function()
  moveWindowOneSpace("2")
end)

-- activate mission control
hs.hotkey.bind(hypershift, "b", function()
  activateMissionControl()
end)


-- Other
---------------------------------------------------------------------------

-- display window hints
hs.hotkey.bind(hypershift, "a", function()
  hs.hints.windowHints()
end)

-- draw crosshair
hs.hotkey.bind(hypershift, "z", function()
  updateCrosshairs()
end)

-- remove crosshair
hs.hotkey.bind(hyper, "z", function()
  clearCrosshairs()
end)

-- chrome fuzzy search tabs
hs.hotkey.bind(hyper,"space", function()
  tabSwitcher()
end)
