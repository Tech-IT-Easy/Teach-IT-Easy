-----------------------------------------------------------
-- SystemFreeType is a global variable for saving free type error
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

if SystemFreeType == nil then
  SystemFreeType= {}
end

local script_path = nil
if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end

function SystemFreeType:drawLabel(label,globalPosition)
  assert(label.identity and globalPosition,"SystemFreeType:getLabelData(label,globalPosition) label.identity or globalPosition is nil")
  local labelKey = label.identity..globalPosition.x..globalPosition.y
  if SystemFreeType[labelKey] == nil then
      SystemFreeType[labelKey] = sys.new_freetype(label.color, label.size, globalPosition,script_path..label.font)
  end
  SystemFreeType[labelKey]:draw_over_surface(screen, label.text)
end

return SystemFreeType