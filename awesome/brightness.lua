local naughty = require("naughty")

brightnesscfg = {}
brightnesscfg.screen = {}
brightnesscfg.keyboard = {}

brightnesscfg.screen.device = "/sys/class/backlight/intel_backlight/brightness"
brightnesscfg.screen.max = 1388
brightnesscfg.screen.value = 50

brightnesscfg.keyboard.device = "/sys/class/leds/smc::kbd_backlight/brightness"
brightnesscfg.keyboard.max = 255
brightnesscfg.keyboard.value = 50

brightnesscfg.keyboard_set = function ()
	naughty.notify({ text="Keyboard: " .. brightnesscfg.keyboard.value .. "%" })

	local new_val = math.floor(brightnesscfg.keyboard.value * (brightnesscfg.keyboard.max / 100))

	-- Run the command
	os.execute("echo " .. new_val .. " > " .. brightnesscfg.keyboard.device);
end

brightnesscfg.keyboard_up = function()
	brightnesscfg.keyboard.value = brightnesscfg.keyboard.value + 10

	if brightnesscfg.keyboard.value > 100 then
		brightnesscfg.keyboard.value = 100
	end

	brightnesscfg.keyboard_set()
end

brightnesscfg.keyboard_down = function()
	brightnesscfg.keyboard.value = brightnesscfg.keyboard.value - 10

	if brightnesscfg.keyboard.value < 0 then
		brightnesscfg.keyboard.value = 0
	end

	brightnesscfg.keyboard_set()
end

brightnesscfg.screen_set = function ()
	naughty.notify({ text="Screen: " .. brightnesscfg.screen.value .. "%" })

	local new_val = math.floor(brightnesscfg.screen.value * (brightnesscfg.screen.max / 100))

	-- Run the command
	os.execute("echo " .. new_val .. " > " .. brightnesscfg.screen.device);
end

brightnesscfg.screen_up = function()
	brightnesscfg.screen.value = brightnesscfg.screen.value + 10

	if brightnesscfg.screen.value > 100 then
		brightnesscfg.screen.value = 100
	end

	brightnesscfg.screen_set()
end

brightnesscfg.screen_down = function()
	brightnesscfg.screen.value = brightnesscfg.screen.value - 10

	if brightnesscfg.screen.value < 0 then
		brightnesscfg.screen.value = 0
	end

	brightnesscfg.screen_set()
end