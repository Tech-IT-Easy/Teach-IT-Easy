-----------------------------------------------------------
-- This class is a UIView class for showing a Label in specific 
-- position. After label is created, it is constant so that it can't
--  be changed. Although you change it, nothing will happen.
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
--
local UIView = require("toolkit.UIKit.UIView")
local UILabelView = extends(UIView)

--@member static constant 


UILabelView.FONT_GROBOLD = 'data/GROBOLD.ttf'
UILabelView.FONT_CHALKDUSTER = 'data/Chalkduster.ttf'
  
function UILabelView:new(args)
  --@member container which contains this LabelView,default nil which means whole window
  local o = UILabelView:super({frame=args.frame,container=args.container})
  --@member label UILabel type 
  o.label = args.label
  --@member label data 
  
  local script_path = nil
  if ADConfig.isSimulator then
    script_path = ""
  else
    script_path = sys.root_path()
  end
  -- o.labelData = sys.new_freetype(o.label.color, o.label.size, {x = o.globalFrame.x,y = o.globalFrame.y},o.label.font)
  o.labelData = sys.new_freetype({g=255, r=255, b=255, a=255}, 70, {x= 20, y=20}, script_path..'data/GROBOLD.ttf')

  return UILabelView:init(o)
end

function UILabelView:show()
  self.labelData:draw_over_surface(screen, self.label.text)
end

function UILabelView:afterUpdateGlobalFrame()
  self.labelData = sys.new_freetype({g=255, r=255, b=255, a=255}, 70, {x= 20, y=20}, script_path..'data/GROBOLD.ttf')
  --self.labelData = sys.new_freetype(self.label.color, self.label.size,{x = self.globalFrame.x,y = self.globalFrame.y},self.label.font)
end

return UILabelView
