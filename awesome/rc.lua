-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

--alttab = require("alttab")
require("widgets")
require("move_windows")
require("volume")
require("debian.menu")
require("taskbar");

-- TODO
--require("chille")
--require("quicklaunch")
--require("revelation")

-- Get hostname (Used for some configuration like what settings to use for screen backlight)
local fd = io.popen("hostname")
hostname = fd:read("*all")
hostname = hostname:gsub("\n", "")
fd:close()

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
	                 title = "Oops, there were errors during startup!",
	                 text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
		                 title = "Oops, an error happened!",
		                 text = err })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/usr/share/awesome/themes/default/theme.lua")
--beautiful.init("/home/chille/.config/awesome/theme.lua")
-- TODO

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Keyboard bindings
require("keybindings");

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
--	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}
-- }}}

-- Wallpaper
if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end

-- Tags: Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end }
}

chillemenu = {
	{ "Windows to left screen",  move_windows_left },
	{ "Windows to right screen", move_windows_right },
	{ "No off screen",   move_windows_inside }
}

mymainmenu = awful.menu(
{
	items =
	{
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "chille", chillemenu, beautiful.awesome_icon },
		{ "Debian", debian.menu.Debian_menu.Debian },
		{ "open terminal", terminal }
	}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ }, 3, awful.tag.viewtoggle)
)


for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
		awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
		awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
		awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end))
	)
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", ontop = true, screen = s })

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(mylauncher)
	left_layout:add(mytaglist[s])
	-- TODO launchbar
	left_layout:add(mypromptbox[s])

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()

	right_layout:add(separator)

	-- Music player
	-- TODO
	right_layout:add(mpdwidget)
	right_layout:add(separator)

	-- Battery status
	if hostname == "chille-macbook13" or hostname == "chille-macbook15" then
		require("batterywidget")

		right_layout:add(batterywidget)
		right_layout:add(fsicon)
		right_layout:add(separator)
	end


	-- Network
	right_layout:add(dnicon)
	right_layout:add(netwidgetdn)
	right_layout:add(upicon)
	right_layout:add(netwidgetup)
	right_layout:add(separator)

	-- CPU
	right_layout:add(cpuicon)
	right_layout:add(cpuwidget)
	right_layout:add(separator)

	-- Memory
	right_layout:add(memicon)
	right_layout:add(memwidget)
	right_layout:add(separator)

	-- File system
	right_layout:add(fsicon)
	right_layout:add(fswidget)
	right_layout:add(separator)

	-- Volume
	right_layout:add(volicon)
	right_layout:add(volumecfg.widget)
	right_layout:add(separator)

	-- Taskbar (Always on the screen with highest number)
	if s == screen.count() then
		right_layout:add(wibox.widget.systray())
		right_layout:add(separator)
	end

	-- Clock
	right_layout:add(awful.widget.textclock())

	-- Layout switcher
	right_layout:add(mylayoutbox[s])

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
--	layout:set_middle(mytasklist[s])
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)
end

-- Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end)
))


clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ "Control" }, 1, awful.mouse.client.move),
	awful.button({ "Control" }, 3, awful.mouse.client.resize),
	awful.button({ "Mod4" }, 1, awful.mouse.client.move),
	awful.button({ "Mod4" }, 3, awful.mouse.client.resize)
)

-- }}}

require("rules");

-- Prevent applications from running fullscreen, they should be within their tile
local no_fullscreen = true
local rule = { class = "Firefox" }
client.disconnect_signal("request::geometry", awful.ewmh.geometry)
client.connect_signal("request::geometry", function(c, context, ...)
	if not no_fullscreen or context ~= "fullscreen" or not awful.rules.match(c, rule) then
		awful.ewmh.geometry(c, context, ...)
	end
end)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
		if not startup then
				-- Set the windows at the slave,
				-- i.e. put it at the end of others instead of setting it master.
				-- awful.client.setslave(c)

				-- Put windows in a smart way, only if they does not set an initial position.
				if not c.size_hints.user_position and not c.size_hints.program_position then
						awful.placement.no_overlap(c)
						awful.placement.no_offscreen(c)
				end
		end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}