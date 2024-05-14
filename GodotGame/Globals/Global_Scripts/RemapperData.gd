extends Node

# Related: ../../Main\ Menu\ Scene/Menu_Scripts/Remapper.gd 
func get_keymap_name(action_name: String) -> String:
	InputMap.action_get_events(action_name)[0]
	var input_map_key = InputMap.action_get_events(action_name)[0]
	var physical_keycode: int = input_map_key.physical_keycode
	var display_keycode: int
	if physical_keycode == 0:
		display_keycode = input_map_key.keycode
	else:
		display_keycode = DisplayServer.keyboard_get_keycode_from_physical(
			physical_keycode
		)
		
	#print('string: "%s" keycode: %s' % [OS.get_keycode_string(display_keycode), display_keycode])
	return " " + OS.get_keycode_string(display_keycode) + " "
