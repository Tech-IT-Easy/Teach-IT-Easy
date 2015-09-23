local function main()
  print 'Hello World!'
  -- love.draw() --Uncomment this call when running LÖVE
end
function love.draw() -- This function is for drawing "Hello World! in the graphical window when running LÖVE
  love.graphics.print("Hello World!", 400, 300)
end
main()
