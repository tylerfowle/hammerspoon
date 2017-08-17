-- CONFIG
hs.application.enableSpotlightForNameSearches(true)
hs.window.animationDuration = 0
hs.window.setShadows(false)
hs.hints.fontName           = "Hack"
hs.hints.fontSize           = 22
-- hs.hints.showTitleThresh    = 0
-- hs.hints.hintChars          = { 'A', 'S', 'D', 'F', 'J', 'K', 'L', 'Q', 'W', 'E', 'R', 'Z', 'X', 'C' }
hs.hints.hintChars          = { 'A', 'S', 'D', 'F', 'G', 'Q', 'W', 'E', 'R', 'T', 'Z', 'X', 'C', 'V', 'B' }

-- REQUIRES
---------------------------------------------------------------------------
spaces = require("hs._asm.undocumented.spaces")

hs.console.clearConsole()

-- CONFIG SPACES
---------------------------------------------------------------------------
local originSpacesCount = spaces.count()
print (originSpacesCount)


-- ALIASES
---------------------------------------------------------------------------
local hyper 	 = {"cmd", "alt", "ctrl"}
local hypershift = {"cmd", "alt", "ctrl", "shift"}


-- AUTO RELOAD start
---------------------------------------------------------------------------
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



-- APPLY LAYOUT FUNCTION
---------------------------------------------------------------------------
function applyWindowLayout()

  local numberOfScreens = #hs.screen.allScreens()

  if numberOfScreens>1 then
    applyWorkLayout()
  else
    applyMobileLayout()
  end

end


-- WORK LAYOUT
---------------------------------------------------------------------------
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


-- MOBILE LAYOUT
---------------------------------------------------------------------------
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


-- ACTIVATE MISSION CONTROL
---------------------------------------------------------------------------
function activateMissionControl()

  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"cmd,alt,ctrl,shift"}, "B", true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"cmd,alt,ctrl,shift"}, "B", false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(200000)

end




-- MOVE ONE SPACE
---------------------------------------------------------------------------
function moveOneSpace(direction)
  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"alt"}, direction, true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"alt"}, direction, false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(200000)
end



-- TEST FOR EXTERNAL MONITOR
---------------------------------------------------------------------------
function hasExternalMonitor()
  for _, screen in pairs(hs.screen.allScreens()) do
    if screen:name() == "Thunderbolt Display" then
      return true
    end
  end
  return false
end


-- MOVE WINDOW ONE SPACE
---------------------------------------------------------------------------
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





-- alt+tab WINDOW SWITCHER
---------------------------------------------------------------------------
hs.window.switcher.ui.textColor = {0.9,0.9,0.9}
hs.window.switcher.ui.fontName = 'Hack'
hs.window.switcher.ui.textSize = 10 -- in screen points
hs.window.switcher.ui.highlightColor = {0.8,0.5,0,0.8}  -- highlight color for the selected window
hs.window.switcher.ui.backgroundColor = {0.2,0.2,0.2,0}
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
hs.hotkey.bind('ctrl','tab','Next window',hs.window.switcher.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
hs.hotkey.bind('ctrl-shift','tab','Prev window',hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)








-- WATCHERS
---------------------------------------------------------------------------

-- watch for monitor changes and update layout
-- change window layout on monitor configuration change
-- local monitorWatcher = hs.screen.watcher.new(applyWindowLayout)
-- monitorWatcher:start()




-- Mute on jack in/out
---------------------------------------------------------------------------
function audioWatch(uid, eventName, eventScope, channelIdx)
  if eventName == 'jack' then
    hs.alert.show("Audio Changed. Muting.")
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end

end


-- Watch device; mute when headphones unplugged.
local defaultDevice = hs.audiodevice.defaultOutputDevice()
defaultDevice:watcherCallback(audioWatch);
defaultDevice:watcherStart();






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



-- draw a crosshair on the screen on the cursor
-- TODO: make variables local
---------------------------------------------------------------------------
crosshairX = nil
crosshairY = nil
crosshairCount = 0
crosshairObjectX = {}
crosshairObjectY = {}

function updateCrosshairs()

  -- Get the current co-ordinates of the mouse pointer
  mousepoint = hs.mouse.getAbsolutePosition()
  -- Prepare a big red circle around the mouse pointer
  crosshairX = hs.drawing.rectangle(hs.geometry.rect(mousepoint.x-2500, mousepoint.y, 5000, 1))
  crosshairY = hs.drawing.rectangle(hs.geometry.rect(mousepoint.x, mousepoint.y-2500, 1, 5000))
  -- crosshairX = hs.drawing.line(hs.geometry.point(mousepoint.x-500,mousepoint.y), hs.geometry.point(mousepoint.x+500,mousepoint.y))
  -- crosshairX = hs.drawing.line({mousepoint.x,-5000},{mousepoint.x, 5000})
  print(mousepoint)

  -- draw crosshair x axis
  crosshairX:setStrokeColor({["red"]=0,["blue"]=0,["green"]=0,["alpha"]=1})
  crosshairX:setFill(false)
  crosshairX:setStrokeWidth(1)
  crosshairX:show()

  -- draw crosshair y axis
  crosshairY:setStrokeColor({["red"]=0,["blue"]=0,["green"]=0,["alpha"]=1})
  crosshairY:setFill(false)
  crosshairY:setStrokeWidth(1)
  -- crosshairY:show()

  crosshairCount = crosshairCount + 1
  print(crosshairCount)
  crosshairObjectX[crosshairCount] = crosshairX
  crosshairObjectY[crosshairCount] = crosshairY

  return crosshairObjectX, crosshairObjectY,crosshairCount

end

-- remove all crosshairs from screen
function clearCrosshairs()

  print("clear crosshairs")

  print(crosshairCount)
  for i=1,crosshairCount do
    print(crosshairObjectX[i])
    crosshairObjectX[i]:delete()
    crosshairObjectY[i]:delete()
  end

  crosshairCount = 0
  return crosshairObjectX, crosshairObjectY, crosshairCount

end


-- crosshair timer - eats cpu!
---------------------------------------------------------------------------
-- updateCrosshairsInterval = 1
-- crosshairTimer = hs.timer.new(updateCrosshairsInterval, updateCrosshairs)
-- crosshairTimer:start()














----
-- A tab chooser for Safari written with AppleScript (yikes) and HammerSpoon
----

----
-- Known issues:

-- If a tab has double quotes, unsure about what will happen, the tab
-- list creation is brittle. Single quote is fixed though

-- It was a very quick and dirty hack to try HammerSpoon (cool!) The
-- AppleScript JSON generation can be improved, as well as the
-- tabSwitcher in general. Since now it works, I won't touch it until
-- need arises
----

getTabs = [[
on replaceString(theText, oldString, newString)
	-- From http://applescript.bratis-lover.net/library/string/#replaceString
	local ASTID, theText, oldString, newString, lst
	set ASTID to AppleScript's text item delimiters
	try
		considering case
			set AppleScript's text item delimiters to oldString
			set lst to every text item of theText
			set AppleScript's text item delimiters to newString
			set theText to lst as string
		end considering
		set AppleScript's text item delimiters to ASTID
		return theText
	on error eMsg number eNum
		set AppleScript's text item delimiters to ASTID
		error "Can't replaceString: " & eMsg number eNum
	end try
end replaceString

tell application "Google Chrome"
	set tablist to "{"
	repeat with w in (every window whose visible is true)
		set ok to true
		try
			repeat with t in every tab of w
				set tabName to title of t
				set tabName to my replaceString(tabName, "'", "`")
				set tabId to id of t
				set wId to index of w
				set tablist to tablist & "'" & tabId & "': {'text': '" & tabName & "', 'tid': '" & tabId & "', 'wid': '" & wId & "'}, "
			end repeat
			set tablist to tablist & "}"
			return tablist
		on error errmsg
			display alert errmsg
			set ok to false
		end try
	end repeat
end tell
]]


function tabChooserCallback(input)
  print(input.id)
  hs.osascript.applescript("tell application \"Google Chrome\" to set active tab index of first window to " .. input.id)
  -- hs.application.launchOrFocus("Google Chrome")
end


function tabSwitcher()
  print(hs.application.frontmostApplication():name())
  if hs.application.frontmostApplication():name() == "Google Chrome" then
    local works, obj, tabs = hs.osascript._osascript(getTabs, "AppleScript")
    local tabs = obj:gsub("'", "\"")
    print(tabs)
    local tabTable = hs.json.decode(tabs)
    local ordered_keys = {}

    for k in pairs(tabTable) do
      table.insert(ordered_keys, tonumber(k))
    end

    table.sort(ordered_keys)
    local chooserTable = {}

    for i = 1, #ordered_keys do
      local k, v = ordered_keys[i], tabTable[ tostring(ordered_keys[i]) ]
      table.insert(chooserTable, {["text"] = v['text'], ["id"] = i, ["wid"] = v['wid']})
    end

    local chooser = hs.chooser.new(tabChooserCallback)
    chooser:choices(chooserTable)
    chooser:show()
  end
end 

-- Emacs style switcher. Uncomment the last line for something maybe
-- more usual

-- k = hs.hotkey.modal.new('ctrl', 'x')
-- k:bind('', 'escape', function() k:exit() end)
-- k:bind('', 'b', nil , tabSwitcher)

hs.hotkey.bind(hyper,'space', tabSwitcher)






















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



