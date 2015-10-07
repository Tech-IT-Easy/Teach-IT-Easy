local p = require "player_movements"
debug = true

-- Timers

canShootTimerMax = 0.2
createEnemyTimerMax = 0.4
-- We declare these here so we don't have to edit them multiple places

canShootTimer = canShootTimerMax
createEnemyTimer = createEnemyTimerMax

-- Player Object
player = { x = 200, y = 710, speed = 150, img = nil, isAlive = true, score = 0}

-- Image Storage
bulletImg = nil
enemyImg = nil

-- Sound Storage
gunSound = nil

-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated
enemies = {} -- array of current enemies on screen

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function checkBoxOverlap(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

-- Loading
function love.load(arg)
	player.img = love.graphics.newImage('assets/plane.png')
	enemyImg = love.graphics.newImage('assets/enemy.png')
	bulletImg = love.graphics.newImage('assets/bullet.png')
	gunSound = love.audio.newSource("assets/gun-sound.wav", "static")
end

function canShoot(dt)
	canShootTimer = canShootTimer - dt
	if canShootTimer < 0 then
		return  true
	else
		return false
	end
end

function createEnemy()
    -- Create an enemy
    local randomNumber = math.random(10, love.graphics.getWidth() - enemyImg:getWidth() - 10)
    local newEnemy = { x = randomNumber, y = -10, img = enemyImg }
    table.insert(enemies, newEnemy)
end


function moveBullets(dt)
    for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)

		if bullet.y < 0 then -- remove bullets when they pass off the screen
			table.remove(bullets, i)
		end
	end
end

function updateEnemies(dt)
    for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y + (200 * dt)

		if enemy.y > 850 then -- remove enemies when they pass off the screen
			table.remove(enemies, i)
		end
	end
end

function checkCollisions()
    for i, enemy in ipairs(enemies) do
		for j, bullet in ipairs(bullets) do
			if checkBoxOverlap(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
				table.remove(bullets, j)
				table.remove(enemies, i)
				player.score = player.score + 1
			end
		end

		if checkBoxOverlap(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight())
		and player.isAlive then
			table.remove(enemies, i)
			player.isAlive = false
		end
	end
end


function shootBullet()
    local newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
    table.insert(bullets, newBullet)
    gunSound:play()
    resetShootTimer()
end

function resetShootTimer()
    canShootTimer = canShootTimerMax
end

function resetEnemyTimer()
    createEnemyTimer = createEnemyTimerMax
end

function canCreateEnemy(dt)
    createEnemyTimer = createEnemyTimer - dt
    if createEnemyTimer < 0 then
        resetEnemyTimer()
        return true
    else
        return false
    end
end
-- Updating
function love.update(dt)
	-- I always start with an easy way to exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
    end

    moveBullets(dt)
    updateEnemies(dt)
    checkCollisions()

    if player.isAlive then
        if canCreateEnemy(dt) then
            createEnemy()
        end


        -- Horizontal movement
        if love.keyboard.isDown('left','a') then
            p.movePlayerLeft(player, dt)
        elseif love.keyboard.isDown('right','d') then
            p.movePlayerRight(player, dt)
        end

        -- Vertical movement
        if love.keyboard.isDown('up', 'w') then
            p.movePlayerUp(player, dt)
        elseif love.keyboard.isDown('down', 's') then
            p.movePlayerDown(player, dt)
        end

        if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot(dt) then
            shootBullet()
        end
    end

	if not player.isAlive and love.keyboard.isDown('r') then
		-- remove all our bullets and enemies from screen
		bullets = {}
		enemies = {}

		-- reset timers
		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax

		-- move player back to default position
		player.x = 50
		player.y = 710

		-- reset our game state
		player.score = 0
		player.isAlive = true
	end
end

-- Drawing
function love.draw(dt)
    love.graphics.setBackgroundColor(0, 191, 255)
    love.graphics.setColor(0, 0, 0)
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
    love.graphics.setColor(255, 255, 255)
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.print("SCORE: " .. tostring(player.score), 400, 10)

	if player.isAlive then
		love.graphics.draw(player.img, player.x, player.y)
	else
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
	end

	if debug then
		fps = tostring(love.timer.getFPS())
		love.graphics.print("Current FPS: "..fps, 9, 10)
	end
end
