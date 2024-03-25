extends Button

@export var action: String
@onready var remap_container = $"."
#var not_waiting_input = false

func _init():
	toggle_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(false)
	$HintLabel.text = action

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		release_focus()
		text = "Waiting for input"

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
	text = " " + InputMap.action_get_events(action)[0].as_text() + " "

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
