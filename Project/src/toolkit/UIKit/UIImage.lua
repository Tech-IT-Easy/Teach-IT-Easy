-----------------------------------------------------------
-- This class is a data type which load image into memory based
-- on given path
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
--
local Object = require("toolkit.Object")
local UIImage = extends(Object)

function UIImage:new(args)
  local o = UIImage:super()
  --@member image path
  o.imagePath = args.imagePath
  
  --@member image type
  o.imageType = args.imageType
  
  --@member imageBuffer load image when created
  if(args.imageType=="png") then
    o.imageData = gfx.loadpng(args.imagePath)
    o.imageData:premultiply()
  elseif(args.imageType=="jpeg") then
    o.imageData = gfx.loadjpeg(args.imagePath)
  end
  
  --For future development, when create a UIImage object, following properties are unnecessary
  --@member image width
  o.width = args.width or o.imageData:get_width()
  
  --@member image height
  o.height = args.height or o.imageData:get_height()
  
  return UIImage:init(o)
end

return UIImage