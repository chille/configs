local naughty = require("naughty")

brightnesscfg = {}
brightnesscfg.screen = {}
brightnesscfg.keyboard = {}

if hostname == "chille-macbook13" then
	brightnesscfg.screen.value = 5
	brightnesscfg.screen.mapping = {0, 1, 2, 4, 9, 17, 28, 41, 60, 100};
	brightnesscfg.screen.setter = function(val)
		return "xrandr --output LVDS-0 --set Backlight " .. val
--		return "echo " .. val .. " > /sys/class/backlight/nv_backlight/brightness"
	end
end

if hostname == "chille-macbook15" then
	brightnesscfg.screen.value = 5
	brightnesscfg.screen.mapping = {0, 114, 227, 341, 455, 568, 682, 796, 909, 1023};
	brightnesscfg.screen.setter = function(val)
		return "echo " .. val .. " > /sys/class/backlight/gmux_backlight/brightness"
	end
end

brightnesscfg.keyboard.device = "/sys/class/leds/smc::kbd_backlight/brightness"
brightnesscfg.keyboard.max = 255
brightnesscfg.keyboard.value = 50

brightnesscfg.keyboard_set = function()
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
	local new_val = brightnesscfg.screen.mapping[brightnesscfg.screen.value];
	naughty.notify({ text="Screen: " .. brightnesscfg.screen.value .. " = " .. new_val })
	os.execute(brightnesscfg.screen.setter(new_val));
end

brightnesscfg.screen_up = function()
	brightnesscfg.screen.value = brightnesscfg.screen.value + 1

	if brightnesscfg.screen.value > 10 then
		brightnesscfg.screen.value = 10
	end

	brightnesscfg.screen_set()
end

brightnesscfg.screen_down = function()
	brightnesscfg.screen.value = brightnesscfg.screen.value - 1

	if brightnesscfg.screen.value < 1 then
		brightnesscfg.screen.value = 1
	end

	brightnesscfg.screen_set()
end