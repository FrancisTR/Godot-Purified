extends Button

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
	if action == "StartDialogue":
		$HintLabel.text = "Interaction"
	else:
		$HintLabel.text = action
	#actions.append(action)

func _toggled(button_exists):
	print("button_in_use == ", remap_container.button_in_use)

	set_process_unhandled_input(button_exists)
	if button_exists:
		toggle_disabled_other_buttons()
		$"../../BackButton".disabled = true
		release_focus()
		text = "???"
		SoundControl.is_playing_sound("button")


func _unhandled_input(e):
	toggle_disabled_other_buttons()

	if not e is InputEventKey: 
		return

	if e.pressed: # Check key that was just pressed
		for k in get_all_keymaps():
			#print(k)
			#print(e)
			#print("---")
			if e.keycode == k.keycode:
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

		grab_focus()
		update_text()
		$"../../BackButton".disabled = false


func update_text():
	text = get_keymap_name(action)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

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

func get_keymap_name(action_name: String) -> String:
	var tmp = InputMap.action_get_events(action_name)[0].as_text().split(" ")
	
	if tmp.size() > 1:
		tmp = tmp[0]
	else:
		tmp = tmp[0] + "*"
	
	print(tmp)
	return " " + tmp + " "

func toggle_disabled_other_buttons():
	remap_container.button_in_use = not remap_container.button_in_use
	var is_disabled = remap_container.button_in_use
	
	#print("will be ", is_disabled)
	for child in remap_children:
		#if child.name != name:
		child.disabled = is_disabled
