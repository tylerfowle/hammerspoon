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
require("bindings.init")
require("menubar")
require("apps.crosshair")


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




