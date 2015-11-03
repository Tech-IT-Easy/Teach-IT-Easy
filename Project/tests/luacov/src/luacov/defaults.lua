
--- Global configuration file. Copy, customize and store in your
-- project folder as '.luacov' for project specific configuration.
-- If some options are missing, their default values from this file
-- will be used.
-- @class module
-- @name luacov.defaults
local os_date = os.date("%Y_%m_%d_%H_%M_%S")
local reportName = "../tests/luacov/luacov.report." .. os_date .. ".out"

--
print("Code coverage in: " .. reportName)
return {

  -- default filename to load for config options if not provided
  -- only has effect in 'luacov.defaults.lua'
  ["configfile"] = ".asdluacov",

  -- filename to store stats collected
  ["statsfile"] = "../tests/luacov/luacov.stats.out",

  -- filename to store report
  ["reportfile"] = reportName,

  -- luacov.stats file updating frequency.
  -- The lower this value - the more frequenty results will be written out to luacov.stats
  -- You may want to reduce this value for short lived scripts (to for example 2) to avoid losing coverage data.
  ["savestepsize"] = 100,

  -- Run reporter on completion? (won't work for ticks)
  runreport = true,

  -- Delete stats file after reporting?
  deletestats = false,
  
  -- Process Lua code loaded from raw strings
  -- (that is, when the 'source' field in the debug info
  -- does not start with '@')
  codefromstrings = true,

  -- Patterns for files to include when reporting
  -- all will be included if nothing is listed
  -- (exclude overrules include, do not include
  -- the .lua extension, path separator is always '/')
  ["include"] = {
  },

  -- Patterns for files to exclude when reporting
  -- all will be included if nothing is listed
  -- (exclude overrules include, do not include
  -- the .lua extension, path separator is always '/')
  ["exclude"] = {
    "luacov$",
    "luacov/reporter$",
    "luacov/defaults$",
    "luacov/runner$",
    "luacov/stats$",
    "luacov/tick$",
	"lunit$",
    "/lunit/",
	"tests/",
	"/lunit",
	"/lunitx",
	"/lemock",
	"lemock",
	"lemock/",
	"/lemock/",
    "/SDK/",
  },

  -- Table mapping names of modules to be included to their filenames.
  -- Has no effect if empty.
  -- Real filenames mentioned here will be used for reporting
  -- even if the modules have been installed elsewhere.
  -- Module name can contain '*' wildcard to match groups of modules,
  -- in this case corresponding path will be used as a prefix directory
  -- where modules from the group are located.
  -- Example:
  -- modules = {
  --   ["some_rock"] = "src/some_rock.lua",
  --   ["some_rock.*"] = "src"
  -- }
  modules = {
  },

}