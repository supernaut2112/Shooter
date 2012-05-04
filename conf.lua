function love.conf(t)
    t.title = "Shooter"
    t.author = "bmitch"
	t.identity = "bmitch"
	t.screen.width = 256
	t.screen.height = 224
    t.modules.joystick = false
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = false
    t.modules.sound = true
    t.modules.physics = false
	t.console = true           -- Attach a console (boolean, Windows only)

end
