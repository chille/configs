from i3ipc import Connection, Event

def bindsym(mod):
		i3.command('bindsym ' + mod + '+1 workspace number 1')
		i3.command('bindsym ' + mod + '+2 workspace number 2')
		i3.command('bindsym ' + mod + '+3 workspace number 3')
		i3.command('bindsym ' + mod + '+4 workspace number 4')
		i3.command('bindsym ' + mod + '+5 workspace number 5')
		i3.command('bindsym ' + mod + '+6 workspace number 6')
		i3.command('bindsym ' + mod + '+7 workspace number 7')
		i3.command('bindsym ' + mod + '+8 workspace number 8')
		i3.command('bindsym ' + mod + '+9 workspace number 9')
		i3.command('bindsym ' + mod + '+10 workspace number 10')

def on_window_focus(i3, e):
	focused = i3.get_tree().find_focused()
#	print('Focused win %s' %(focused.app_id))
	if focused.app_id == "foot":
		i3.command("input * xkb_variant mixed_roxterm")
		bindsym("Mod4")
	else:
		i3.command("input * xkb_variant mixed_basic")
		bindsym("Ctrl")

i3 = Connection()
i3.on(Event.WINDOW_FOCUS, on_window_focus)
i3.main()