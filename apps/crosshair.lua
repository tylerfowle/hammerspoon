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
  crosshairY:show()

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
