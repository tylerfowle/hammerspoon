--MODIFIERS
---------------------------------------------------------------------------
hyper 	 = {"cmd", "alt", "ctrl"}
hypershift = {"cmd", "alt", "ctrl", "shift"}

-- windows management
-- hypershift + E,S,F,C


scrollAmount = 1
-- Scroll down 1 pixel
hs.hotkey.bind(hypershift, "j", function()
  print(scrollAmount)
  hs.eventtap.event.newScrollEvent({0,(-1 * scrollAmount)},{},'pixel'):post()
end)

-- Scroll up 1 pixel
hs.hotkey.bind(hypershift, "k", function()
  print(scrollAmount)
  hs.eventtap.event.newScrollEvent({0,(1 * scrollAmount)},{},'pixel'):post()
end)


-- Scroll down 1 pixel
hs.hotkey.bind(hyper, "j", function()
  scrollAmount = scrollAmount - 1
  print(scrollAmount)
end)

-- Scroll up 1 pixel
hs.hotkey.bind(hyper, "k", function()
  scrollAmount = scrollAmount + 1
  print(scrollAmount)
end)






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


-- CURSOR
---------------------------------------------------------------------------

-- push window one screen right
hs.hotkey.bind(hypershift, "d", function()
  moveCursorToScreen()
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

-- xScope bindings
hs.hotkey.bind(hypershift, "4", function()
  hs.execute('hammerscope 21', true)
end)
hs.hotkey.bind(hypershift, "7", function()
  hs.execute('hammerscope', true)
end)
