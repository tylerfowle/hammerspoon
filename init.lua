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

require("bindings.init")
require("reload")

-- require("helpers.monitor-test")

-- require("audio.mute_jack")

-- require("window.layout.apply")
-- require("window.layout.work")
-- require("window.layout.mobile")
-- require("window.mission-control")
require("window.spaces.focus-space")
require("window.management")

require("menubar")

require("apps.crosshair")
require("apps.chrome-tab-chooser")

-- require("watchers")


