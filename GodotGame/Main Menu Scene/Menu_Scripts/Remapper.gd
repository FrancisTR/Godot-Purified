extends Button

#TODO: Make user change the button one at a time

@export var action: String
#@onready var button = $"."
@onready var remap_container = $".."

#var not_waiting_input = false

func _init():
	toggle_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(false)
	update_text()
	$HintLabel.text = action
	#actions.append(action)

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		release_focus()
		text = "???"

func _unhandled_input(e):
	if not e is InputEventKey:
		return
	
	if e.pressed:
		for k in get_all_keymaps():
			#print(k)
			#print(e)
			#print("---")
			if e.keycode == k.keycode:
				# Move below message to in game
				button_pressed = false
				break
		
		if button_pressed:
			button_pressed = false
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, e)
		else:
			print("Key is already used. Not setting new key.")

		grab_focus()
		update_text()

func update_text():
	text = get_keymap_name(action)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func get_all_keymaps() -> Array[InputEventKey]:
	var children = remap_container.get_children()
	var arr: Array[InputEventKey]
	for child in children:
		# below = wrong function. should get InputEvent instead of action or name
		#arr.append(get_keymap_name(child.action))
		arr.append(InputMap.action_get_events(child.action)[0])
		
		
	print("size=" + str(children.size())) #is_empty
	return arr
	
	
func get_all_actions() -> Array[String]:
	var children = remap_container.get_children()
	var arr: Array[String]
	for child in children:
		arr.append(child.action)
		
	return arr

func get_keymap_name(action_name: String) -> String:
	var tmp = InputMap.action_get_events(action_name)[0].as_text()
	tmp = tmp.split(" ")
	var text_tmp: String
	#if tmp[-1] == "(Physical)":
	for word in tmp:
		#print(word)
		if word != "(Physical)":
			text_tmp = text_tmp + word
		else:
			text_tmp = text_tmp + "*"
			
	return " " + text_tmp + " "
