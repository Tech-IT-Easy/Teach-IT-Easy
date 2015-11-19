local NiceMarioHelpTest = {}
local Object = require("toolkit.Object")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local UIImageView = require("toolkit.UIKit.UIImageView")
local UILabelView = require("toolkit.UIKit.UILabelView")
local UICollectionView = require("toolkit.UIKit.UICollectionView")
local UICollectionCellView = require("toolkit.UIKit.UICollectionCellView")



function NiceMarioHelpTest:run()
  -- create a UILabel
  textlabel = UILabel:new{text="1",color={g=255,r=0,b=0,a=200},size=50,font=UILabel.FONT_GROBOLD}
  
  -- create a UIImage
  image = UIImage:new{imagePath="games/mario/data/arrow_up.png",imageType="png",width=200,height=200}
  
  -- create a UIButtonView with label and Image
  button = UIButtonView:new{frame={x=1,y=1,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=image,label=textlabel}
  button:show()
  
  --image = UIImageView:new{imagePath="data/arrow_up.png",imageType="png",width=200,height=200}
  -- create a UIButtonView with label changing text and no image but selected
  textlabel.text = "2"
  button = UIButtonView:new{frame={x=50,y=50,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=nil,label=textlabel}
  button:selected()
  button:show()
  
  -- create a UIImageView with position and image
  imageview = UIImageView:new{image=image,position={x=300,y=300}}
  imageview:show()
  
  -- create a UILabelView with position and lael
  labelview = UILabelView:new{position={x=200,y=200},label=textlabel}
  labelview:show()
  
  
  ---- UIButtonView,UIImageView can be insert into a UICollectionCellView object and managed by UICollectionView
  
  --create a UICollectionView to manage 9 cells
  collectionLayout = UICollectionView:new{frame={x=800,y=20,w=400,h=400},space=20,cols=3,rows=3,backgroundColor={r=255,g=29,b=25}}
  
  -- create four views
  -- frame doesn't matter, layout will reset it
  button1 = UIButtonView:new{frame={x=50,y=50,w=100,h=100},borderColor={r=0,g=29,b=25},borderWidth = 6,backgroundImage=nil,label=textlabel}
  -- position doesn't matter, layout will reset it
  imageview1 = UIImageView:new{image=image,position={x=300,y=300}}
  imageview2 = UIImageView:new{image=image,position={x=300,y=300}}
  imageview3 = UIImageView:new{image=image,position={x=300,y=300}}
  
  -- create cell for different view and insert into specific position by given row number and col number which starting from(0,0)
  cell = UICollectionCellView:new{view=imageview,viewType="UIImageView"}
  collectionLayout:fillWithCell(cell,2,2)
  
  cell1 = UICollectionCellView:new{view=button,viewType="UIButtonView"}
  collectionLayout:fillWithCell(cell1,1,1)
  
  cell2 = UICollectionCellView:new{view=imageview2,viewType="UIImageView"}
  collectionLayout:fillWithCell(cell2,2,1)
  
  cell3 = UICollectionCellView:new{view=imageview3,viewType="UIImageView"}
  collectionLayout:fillWithCell(cell3,0,2)
  
  cell3 = UICollectionCellView:new{view=button1,viewType="UIButtonView"}
  collectionLayout:fillWithCell(cell3,0,0)
  
  -- finally call UICollectionView:show() method will show all the Views in specific position and size
  collectionLayout:show()
  
  ---- End UICollectionView
  
  gfx.update()
end
return NiceMarioHelpTest