------------------------------------
-- Used to determine wether the program is
-- runnning on a box or in a simulator in order
-- to know what resources to load in main
-- @authoe Zenterio
ADConfig = {};
ADConfig.version = "1.0.1"
ADConfig.isSimulator = false
ADConfig.updatePeriod = 1000
if not screen then 
  ADConfig.isSimulator = true 
else
  love = {}
end
return ADConfig