Bullet = {}
Bullet.__index = Bullet

--Bullet_WIDTH = 24
--Bullet_HEIGHT = 24

function Bullet.create(mouseX, mouseY)
	local self = {}
	setmetatable(self,Bullet)
	self.x = WIDTH / 2
	self.y = HEIGHT
	self.startX = self.x
	self.startY = self.y
	self.alive = true
	self.bulletSpeed = bulletSpeed
	self.mouseX = mouseX
	self.mouseY = mouseY
    self.angle = math.atan2((self.mouseY - self.startY), (self.mouseX - self.startX))
	self.bulletDx = self.bulletSpeed * math.cos(self.angle)
    self.bulletDy = self.bulletSpeed * math.sin(self.angle)

	return self
end

function Bullet:update(dt)
	
	-- update position
	self.x = self.x + (self.bulletDx * dt)
    self.y = self.y + (self.bulletDy * dt)

	-- kill if off the screen
	if self.y < 0 then
		self.alive = false
	end
end

function Bullet:kill()
	table.remove(birds,self)
end


function Bullet:draw()
	self.anim:draw(self.x, self.y)
end
