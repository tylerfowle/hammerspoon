-- CONFIG
hs.application.enableSpotlightForNameSearches(true)
hs.window.animationDuration = 0
hs.window.setShadows(false)
hs.hints.fontName           = "Hack"
hs.hints.fontSize           = 22
hs.hints.showTitleThresh    = 0
hs.hints.hintChars          = { 'A', 'S', 'D', 'F', 'G', 'Q', 'W', 'E', 'R', 'T', 'Z', 'X', 'C', 'V', 'B' }
hs.console.clearConsole()

-- REQUIRES
---------------------------------------------------------------------------
spaces = require("hs._asm.undocumented.spaces")
require("reload")
require("audio.mute_jack")
require("window.layout.work")
require("window.layout.mobile")
require("hotkeys.init")

-- CONFIG SPACES
---------------------------------------------------------------------------
local originSpacesCount = spaces.count()
print (originSpacesCount)

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





-- WATCHERS
---------------------------------------------------------------------------

-- watch for monitor changes and update layout
-- change window layout on monitor configuration change
-- local monitorWatcher = hs.screen.watcher.new(applyWindowLayout)
-- monitorWatcher:start()








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




