--MODIFIERS
---------------------------------------------------------------------------
hyper 	 = {"cmd", "alt", "ctrl"}
hypershift = {"cmd", "alt", "ctrl", "shift"}


-- windows management
-- hypershift + E,S,F,C

-- HOTKEYS
---------------------------------------------------------------------------
-- apply window layout for current monitor configuration
hs.hotkey.bind(hypershift, "y", function()
  applyWindowLayout()
end)

hs.hotkey.bind(hypershift, "t", function()
    -- hs.window.focusedWindow():moveOneScreenWest()
    hs.window.focusedWindow():moveOneScreenEast()

  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
  end

end)

-- focus one space left
hs.hotkey.bind(hypershift, "w", function()
  moveOneSpace("1")
end)

-- focus one space right
hs.hotkey.bind(hypershift, "r", function()
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

-- chrome fuzzy search tabs
hs.hotkey.bind(hyper,"space", function()
  tabSwitcher()
end)
