-- config
hs.application.enableSpotlightForNameSearches(true)
spaces = require("hs._asm.undocumented.spaces")


hs.console.clearConsole()

-- config spaces
local originSpacesCount = spaces.count()
print (originSpacesCount)





-- auto reload start
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
-- auto reload end



-- apply layout function
function applyWindowLayout()

  local numberOfScreens = #hs.screen.allScreens()

  if numberOfScreens>1 then
    applyWorkLayout()
  else
    applyMobileLayout()
  end

end


-- work layout
function applyWorkLayout()

  local laptopScreen = hs.screen.allScreens()[1]:name()
  local thunder1 =    hs.screen.allScreens()[2]:name()
  local thunder2 =    hs.screen.allScreens()[3]:name()

  local workLayout = {
    {"Chrome",  nil, thunder2, hs.layout.right50,    nil, nil},
    {"Mail", nil, thunder1, hs.layout.right50, nil, nil},

    {"iTerm2", nil, thunder1, hs.layout.top50, nil, nil},
    {"Spotify", nil, thunder1, hs.layout.right50, nil, nil},
  }

  hs.layout.apply(workLayout)

end


-- mobile window layout
function applyMobileLayout()

  local laptopScreen = hs.screen.allScreens()[1]:name()

  local mobileLayout = {
    {"Google Chrome",  nil, laptopScreen, hs.layout.left50,    nil, nil},
    {"Mail", nil, laptopScreen, hs.layout.left50, nil, nil},

    {"iTerm2", nil, laptopScreen, hs.layout.left50, nil, nil},
    {"Spotify", nil, laptopScreen, hs.layout.left50, nil, nil},
  }

  hs.layout.apply(mobileLayout)
end



function activateMissionControl()

  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"cmd,alt,ctrl,shift"}, "B", true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"cmd,alt,ctrl,shift"}, "B", false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(200000)

end





function moveOneSpace(direction)
  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"alt"}, direction, true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"alt"}, direction, false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(200000)
end




function hasExternalMonitor()
  for _, screen in pairs(hs.screen.allScreens()) do
    if screen:name() == "Thunderbolt Display" then
      return true
    end
  end
  return false
end



function moveWindowOneSpace(direction)
  local mouseOrigin = hs.mouse.getAbsolutePosition()
  local win = hs.window.focusedWindow()
  local clickPoint = win:zoomButtonRect()

  clickPoint.x = clickPoint.x + clickPoint.w + 3
  clickPoint.y = clickPoint.y + (clickPoint.h / 2)

  local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, clickPoint)
  mouseClickEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"alt"}, direction, true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"alt"}, direction, false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(200000)

  local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, clickPoint)
  mouseReleaseEvent:post()
  hs.timer.usleep(200000)

  hs.mouse.setAbsolutePosition(mouseOrigin)
end




function createCorrectSpaces()
  local modifiedSpacesCount =  spaces.count()
  for i=1, (originSpacesCount - modifiedSpacesCount), 1 do
    print(i)
    spaces.createSpace()
  end
  originSpacesCount = spaces.count()
end





-- alt+tab window switcher
hs.window.switcher.ui.textColor = {0.9,0.9,0.9}
hs.window.switcher.ui.fontName = 'Hack'
hs.window.switcher.ui.textSize = 14 -- in screen points
hs.window.switcher.ui.highlightColor = {0.8,0.5,0,0.8}  -- highlight color for the selected window
hs.window.switcher.ui.backgroundColor = {0.2,0.2,0.2,1}
hs.window.switcher.ui.onlyActiveApplication = false -- only show windows of the active application
hs.window.switcher.ui.showTitles = false  -- show window titles
hs.window.switcher.ui.titleBackgroundColor = {0,0,0}
hs.window.switcher.ui.showThumbnails = false  -- show window thumbnails
hs.window.switcher.ui.thumbnailSize = 32  -- size of window thumbnails in screen points
hs.window.switcher.ui.showSelectedThumbnail = true  -- show a larger thumbnail for the currently selected window
hs.window.switcher.ui.selectedThumbnailSize = 600
hs.window.switcher.ui.showSelectedTitle = false  -- show larger title for the currently selected window

-- set up your windowfilter
switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
hs.hotkey.bind('alt','tab','Next window',hs.window.switcher.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
hs.hotkey.bind('alt-shift','tab','Prev window',hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)



-- aliases
local mash 	 = {"cmd", "alt", "ctrl"}

-- hotkeys
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  applyWindowLayout()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
  moveOneSpace("1")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "O", function()
  moveOneSpace("2")
end)

hs.hotkey.bind(mash, "i", function()
  print("creating new space")
  spaces.createSpace()
end)

hs.hotkey.bind(mash, "h", function()
  moveWindowOneSpace("1")
end)

hs.hotkey.bind(mash, "l", function()
  moveWindowOneSpace("2")
end)

-- watchers
-- local monitorWatcher = hs.screen.watcher.new(applyWindowLayout)
local monitorWatcher = hs.screen.watcher.new(createCorrectSpaces)
monitorWatcher:start()



