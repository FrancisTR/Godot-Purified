extends Button

#TODO: Make user change the button one at a time

@export var action: String
@onready var remap_container = $"."
#var not_waiting_input = false

func _init():
	toggle_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(false)
	update_text()
	$HintLabel.text = action

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		release_focus()
		text = "???"
		


func _unhandled_input(e):
	if not e is InputEventKey:
		return
	
	if e.pressed:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, e)
		button_pressed = false
		grab_focus()
		update_text()

func update_text():
	var tmp = InputMap.action_get_events(action)[0].as_text()
	tmp = tmp.split(" ")
	var text_tmp: String
	#if tmp[-1] == "(Physical)":
	for word in tmp:
		print(word)
		if word != "(Physical)":
			text_tmp = text_tmp + word
		else:
			text_tmp = text_tmp + "*"
			
	text = " " + text_tmp + " "
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
