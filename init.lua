-- CONFIG
hs.application.enableSpotlightForNameSearches(true)
hs.window.animationDuration = 0
hs.window.setShadows = "false"
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

require("helpers.monitor-test")

-- audio
require("audio.mute_jack")

-- window
require("window.layout")
require("window.mission-control")
require("window.management")

-- -- spaces
require("window.spaces.focus-space")
require("window.spaces.move-window")
require("window.screens.move-window")
require("window.screens.move-cursor")

-- menubar
require("menubar")

-- apps
require("apps.crosshair")
require("apps.chrome-tab-chooser")

-- watchers
require("watchers")

local LOGLEVEL = 'debug'
-- List of modules to load (found in modules/ dir)
local modules = {
  'scratchpad',
}

-- global modules namespace (short for easy console use)
hsm = {}

-- load module configuration
local cfg = require('config')
hsm.cfg = cfg.global

-- global log
hsm.log = hs.logger.new(hs.host.localizedName(), LOGLEVEL)

-- load a module from modules/ dir, and set up a logger for it
local function loadModuleByName(modName)
  hsm[modName] = require('apps.' .. modName)
  hsm[modName].name = modName
  hsm[modName].log = hs.logger.new(modName, LOGLEVEL)
  hsm.log.i(hsm[modName].name .. ': module loaded')
end

-- save the configuration of a module in the module object
local function configModule(mod)
  mod.cfg = mod.cfg or {}
  if (cfg[mod.name]) then
    for k,v in pairs(cfg[mod.name]) do mod.cfg[k] = v end
    hsm.log.i(mod.name .. ': module configured')
  end
end

-- start a module
local function startModule(mod)
  if mod.start == nil then return end
  mod.start()
  hsm.log.i(mod.name .. ': module started')
end

-- stop a module
local function stopModule(mod)
  if mod.stop == nil then return end
  mod.stop()
  hsm.log.i(mod.name .. ': module stopped')
end

-- load, configure, and start each module
hs.fnutils.each(modules, loadModuleByName)
hs.fnutils.each(hsm, configModule)
hs.fnutils.each(hsm, startModule)

-- global function to stop modules and reload hammerspoon config
function hs_reload()
  hs.fnutils.each(hsm, stopModule)
  hs.reload()
end

-- scratchpad
hs.hotkey.bind(hypershift, "n", hsm.scratchpad.toggle)
