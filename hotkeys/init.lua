--MODIFIERS
---------------------------------------------------------------------------
local hyper 	 = {"cmd", "alt", "ctrl"}
local hypershift = {"cmd", "alt", "ctrl", "shift"}


-- HOTKEYS
---------------------------------------------------------------------------
-- apply window layout for current monitor configuration
hs.hotkey.bind(hypershift, "y", function()
  applyWindowLayout()
end)

-- focus one space left
hs.hotkey.bind(hypershift, "u", function()
  moveOneSpace("1")
end)

-- focus one space right
hs.hotkey.bind(hypershift, "o", function()
  moveOneSpace("2")
end)

-- create new space
hs.hotkey.bind(hypershift, "i", function()
  hs.alert.show("creating new space")
  spaces.createSpace()
end)

-- move focused widow one space left
hs.hotkey.bind(hypershift, "h", function()
  moveWindowOneSpace("1")
end)

-- move focused widow one space right
hs.hotkey.bind(hypershift, "l", function()
  moveWindowOneSpace("2")
end)

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


hs.hotkey.bind(hyper,"space", function()
  tabSwitcher()
end)
