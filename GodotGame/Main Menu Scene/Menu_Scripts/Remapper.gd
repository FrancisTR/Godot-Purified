extends Button
# todo: ideally, key changes should only take effect after saving changes

@export var action: String
#@onready var button = $"."
@onready var remap_container = $".."
@onready var remap_children := remap_container.get_children()

#var not_waiting_input = false

func _init():
	toggle_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(false)
	update_text()
	$HintLabel.text = action
	#actions.append(action)

func _toggled(button_exists):
	print("button_in_use == ", remap_container.button_in_use)

	set_process_unhandled_input(button_exists)
	if button_exists:
		toggle_disabled_other_buttons()
		release_focus()
		text = "???"
		SoundControl.is_playing_sound("button")
		
		if GameData.visitTutorial == true:
			$"../../OpacityBlocker".visible = true


func _unhandled_input(e):
	if not e is InputEventKey: 
		return

	if not e.pressed: # Check key that was just pressed
		return

	for k in get_all_keymaps():
		#print("---")
		#print(k)
		#print(e)
		#print(str(k.keycode)+" vs. "+str(e.keycode)+" -> "+str(e.keycode == k.keycode))
		#print("---")
		if e.keycode == k.keycode or e.physical_keycode == k.physical_keycode or e.keycode == k.physical_keycode or e.physical_keycode == k.keycode:
			# Move below message to in game
			print("Key is already used. Not setting new key.")
			button_pressed = false
			#toggle_disabled_other_buttons()
			break

	if button_pressed:
		button_pressed = false # toggle button pressed
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, e)
		#toggle_disabled_other_buttons()

	toggle_disabled_other_buttons()
	grab_focus()
	update_text()
	$"../../OpacityBlocker".visible = false


func update_text():
	text = RemapperData.get_keymap_name(action)


func get_all_keymaps() -> Array[InputEventKey]:
	var arr: Array[InputEventKey]
	for child in remap_children:
		# below = wrong function. should get InputEvent instead of action or name
		#arr.append(get_keymap_name(child.action))
		arr.append(InputMap.action_get_events(child.action)[0])


	print("size=" + str(remap_children.size())) #is_empty
	return arr

	
func get_all_actions() -> Array[String]:
	var children = remap_container.get_children()
	var arr: Array[String]
	for child in children:
		arr.append(child.action)

	return arr


func toggle_disabled_other_buttons():
	var is_disabled = not remap_container.button_in_use
	remap_container.button_in_use = is_disabled
	
	$"../../BackButton".disabled = is_disabled
	if GameData.visitTutorial == false:
		$"../../SfxSlider".visible = not is_disabled
		$"../../MusicSlider".visible = not is_disabled
	# Below is an alternative to above to freeze the UI. For now at least, it doesn't gray it out like other parts of UI though.
	#$"../../SfxSlider".editable = not is_disabled
	
	#print("will be ", is_disabled)
	for child in remap_children:
		#if child.name != name:
		child.disabled = is_disabled
