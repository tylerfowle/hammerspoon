--MODIFIERS
---------------------------------------------------------------------------
hyper 	 = {"cmd", "alt", "ctrl"}
hypershift = {"cmd", "alt", "ctrl", "shift"}

-- windows management
-- hypershift + E,S,F,C


-- Custom Application Launcher Key
leader = hs.hotkey.modal.new(hypershift, "a") 
function leader:entered() hs.alert'Entered mode' end
function leader:exited()  hs.alert'Exited mode'  end

leader:bind('', 'escape', function() leader:exit() end)

leader:bind("", "G", "Chrome", function()
  hs.application.launchOrFocus("Google Chrome")
  leader:exit() 
end)
leader:bind("", "C", "Chrome", function()
  hs.application.launchOrFocus("Google Chrome")
  leader:exit() 
end)


leader:bind("", "S", "Spotify", function()
  hs.application.launchOrFocus("Spotify")
  leader:exit() 
end)

leader:bind("", "V", "Docker Desktop", function()
  hs.application.launchOrFocus("Visual Studio Code")
  leader:exit() 
end)

leader:bind("", "D", "Docker Desktop", function()
  hs.application.launchOrFocus("Docker Desktop")
  leader:exit() 
end)

leader:bind("", "I", "iTerm", function()
  hs.application.launchOrFocus("Iterm")
  leader:exit() 
end)
leader:bind("", "T", "iTerm", function()
  hs.application.launchOrFocus("Iterm")
  leader:exit() 
end)

leader:bind("", "N", "Notes", function()
  hs.application.launchOrFocus("Notes")
  leader:exit() 
end)
leader:bind("", "V", "Notes", function()
  hs.application.launchOrFocus("Notes")
  leader:exit() 
end)

leader:bind("", "R", "Reminders", function()
  hs.application.launchOrFocus("Reminders")
  leader:exit() 
end)



-- right click and inspect
-- quickly open inspect - dev tools
hs.hotkey.bind(hypershift, "t", function()
  keys = ""
  output = "inspect"
  local ptMouse = hs.mouse.getAbsolutePosition()
  local types = hs.eventtap.event.types
  hs.eventtap.event.newMouseEvent(types.rightMouseDown, ptMouse, keys):post()
  hs.eventtap.event.newMouseEvent(types.rightMouseUp, ptMouse, keys):post()

  hs.timer.doAfter(.1, function()
    hs.eventtap.keyStroke({},"i")
    hs.eventtap.keyStroke({},"n")
    hs.eventtap.keyStroke({},"return")
  end)

end)




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


-- Scroll amount +1
-- add one pixel from the scrollAmount
hs.hotkey.bind(hyper, "j", function()
  scrollAmount = scrollAmount - 1
  print(scrollAmount)
end)

-- Scroll amount -1
-- remove one pixel from the scrollAmount
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

-- -- focus one space left
-- hs.hotkey.bind(hypershift, "w", function()
--   moveOneSpace("1")
-- end)

-- -- focus one space right
-- hs.hotkey.bind(hypershift, "r", function()
--   moveOneSpace("2")
-- end)

-- move focused widow one space left
hs.hotkey.bind(hypershift, "h", function()
  moveWindowOneSpace("1")
end)

-- move focused widow one space right
hs.hotkey.bind(hypershift, "l", function()
  moveWindowOneSpace("2")
end)

-- -- activate mission control
-- hs.hotkey.bind(hypershift, "b", function()
--   activateMissionControl()
-- end)


-- Other
---------------------------------------------------------------------------

-- -- display window hints
-- hs.hotkey.bind(hypershift, "a", function()
--   hs.hints.windowHints()
-- end)

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