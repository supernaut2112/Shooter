Bug = {}
Bug.__index = Bug

BUG_WIDTH = 24
BUG_HEIGHT = 24

function Bug.create()
	local self = {}
	setmetatable(self,Bug)
	self.x = math.random(24,WIDTH-24)
	self.y = 0
	self.alive = true
	self.speed = math.random(difficulty,difficulty + 5)
	self.frame = 0
	
	-- Create animation.
	self.anim = newAnimation(imgBlueBug, BUG_WIDTH, BUG_HEIGHT, 0.2, 0)
	self.anim:setMode("bounce")
	return self
end

function Bug:update(dt)
	self.anim:update(dt)
	self.y = self.y + dt * self.speed * global_speed
	
end

function Bug:kill()
	table.remove(birds,self)
end


function Bug:draw()
	self.anim:draw(self.x, self.y)
end

function spawnBugs(dt)
	next_bug = next_bug - dt
	if next_bug <= 0 then
		table.insert(bugs,Bug.create())
		-- next bug spawns in between 0 and 3 seconds
		next_bug = math.random(0,3)
	end
end

function Bug:isClicked(x,y)
	if Bug.collideWithPoint(self, x,y) then
		print("Bug CLicked!")
		return true
	end

end

function Bug:collideWithPoint(x,y)
	if x > self.x and x < self.x + BUG_WIDTH
	and y > self.y and y < self.y+BUG_HEIGHT then
		return true
	else
		return false
	end
end