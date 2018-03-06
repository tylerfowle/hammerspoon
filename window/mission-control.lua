-- ACTIVATE MISSION CONTROL
---------------------------------------------------------------------------
function activateMissionControl()

  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, "up", true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(200000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, "up", false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(200000)

end


-- TOGGLE BORDER VISIBILITY
---------------------------------------------------------------------------
hs.hotkey.bind(hypershift, "q", function()
  toggleBorder()
end)

isBorder=true
function toggleBorder()
  if isBorder == true then
    global_border:hide()
    isBorder=false
  else
    global_border:show()
    isBorder=true
  end
end



-- DRAW BORDER AROUND ACTIVE WINDOW
---------------------------------------------------------------------------
global_border = nil

function redrawBorder()
  win = hs.window.focusedWindow()
  if win ~= nil then
    top_left = win:topLeft()
    size = win:size()
    if global_border ~= nil then
      global_border:delete()
    end
    global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
    global_border:setStrokeColor({ hex = "#e6d9b3", alpha = 1 })
    global_border:setFill(false)
    global_border:setStrokeWidth(1)
    global_border:show()
  end
end

redrawBorder()

allwindows = hs.window.filter.new(nil)
allwindows:subscribe(hs.window.filter.windowCreated, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowFocused, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowMoved, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowUnfocused, function () redrawBorder() end)
