-- copy this file to config.lua and edit as needed
--
local cfg = {}
cfg.global = {}  -- this will be accessible via hsm.cfg in modules
----------------------------------------------------------------------------

local ufile = require('utils.file')

--------------------
--  global paths  --
--------------------
cfg.global.paths = {}
cfg.global.paths.base  = os.getenv('HOME')
cfg.global.paths.tmp   = os.getenv('TMPDIR')
cfg.global.paths.cloud = ufile.toPath(cfg.global.paths.base, 'Dropbox')

------------------
--  scratchpad  --
------------------
cfg.scratchpad = {
  menupriority = 1370,            -- menubar priority (lower is lefter)
  width = 60,
  file = ufile.toPath(cfg.global.paths.cloud, 'scratchpad.md'),
}

----------------------------------------------------------------------------
return cfg
