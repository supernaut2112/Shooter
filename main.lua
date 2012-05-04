require("AnAL")
require("bug")
require("bullet")
WIDTH = 256
HEIGHT = 224
SCALE = 1

bgcolor = {0,0,0,0}
darkcolor = {2,9,4,255}
bulletSpeed = 250

scrn_shake = 0
score = 0
global_speed = 1.5
highscore = 0
-- smaller the easier
difficulty = 1.01

function love.load()
	math.randomseed(os.time())
	loadResources()	
	love.graphics.setBackgroundColor(bgcolor)
	restart()  
end

function restart()
	bugs = {}
	bullets = {}
	
	-- first bug spawns in 1 sec
	next_bug = 1
	scrn_shake = 0
	score = 0
	difficulty = 1.01

end

function updateGame(dt)
	-- Update bugs
	spawnBugs(dt)
	for i,b in ipairs(bugs) do
		b:update(dt)
		if b.alive == false then
			table.remove(bugs,i)
		end
	end
	
	-- Update bullets
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
		if bullet.alive == false then
			table.remove(bullets,i)
		end
	end
	
	-- Check for bullet/bug collision
	for i, bullet in ipairs(bullets) do
		for i, bug in ipairs(bugs) do
			if bug.collideWithPoint(bug, bullet.x, bullet.y) then
				bug.alive = false
				bullet.alive = false
				love.audio.stop(audioHit)
				love.audio.play(audioHit)
				score = score + 1
				if(score > highscore) then
					highscore = score
				end
				-- update difficulty level
				difficulty = difficulty * 1.5
			end
		end
	end
	
	-- Check if bug has reached bottom of screen
	for i,bug in ipairs(bugs) do
		if bug.y > HEIGHT then
			restart()
		end
	end
	

end

function love.update(dt)
	updateGame(dt)
end


function love.draw()
   -- Draw the animation at (100, 100).
  -- anim:draw(100, 100) 
	love.graphics.scale(SCALE,SCALE)
	drawGame()
	print(difficulty)
end

function drawGame()

	-- Draw bugs
	for i,b in ipairs(bugs) do
		b:draw(v)
	end
	
	-- Draw bullets
   -- love.graphics.setColor(128, 128, 128)
	for i, bullet in ipairs(bullets) do
		love.graphics.circle("fill", bullet.x, bullet.y, 3)
	end	
  love.graphics.printf(
    "Score: "..score,
  0,0,love.graphics.getWidth(),"left")
 love.graphics.printf(
    "High Score: "..highscore,
  0,0,love.graphics.getWidth(),"right")
end


function loadResources()
	-- Load images
	imgBlueBug  = love.graphics.newImage("imgs/bluebug.png")
	imgBlueBug:setFilter("nearest","nearest")


	-- Load sound effects
	audioCoffee = love.audio.newSource("sfx/coffee.wav","static")
	audioHit = love.audio.newSource("sfx/hit.wav","static")
	audioSelect = love.audio.newSource("sfx/select.wav","static")
	audioBGM = love.audio.newSource("sfx/bgm.ogg","stream")
	audioBGM:setLooping(true)
	audioBGM:setVolume(0.6)
	audioBGM:play()

end
function love.mousepressed(x, y, button)
    if button == "l" then
		local newBullet = Bullet.create(x,y)

		table.insert(bullets, newBullet)
    end
end


