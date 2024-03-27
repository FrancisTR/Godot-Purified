extends Control

@onready var dialogue_box = $Dialogue/DialogueBox

# Called when the node enters the scene tree for the first time.
func _ready():
	if (not dialogue_box.running):
		if GameData.username == "":
			dialogue_box.start()
		else:
			dialogue_box.start_id = "Tutorial2"
			dialogue_box.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_dialogue_box_dialogue_signal(value):
	
	#TODO: More values will be added based on dialogue direction
	if (value == "EnterName"):
		dialogue_box.stop()
		get_tree().change_scene_to_file("res://Main Menu Scene/EnterName.tscn")
	
	elif (value == "ShowControls"):
		$Controls.visible = true
		
	elif (value == "DialogueControl"):
		$NPCexample.visible = true
		
	elif (value == "Done"):
		GameData.visitTutorial = true
		get_tree().change_scene_to_file("res://World Scene/World.tscn")
	else:
		$Controls.visible = false
		$NPCexample.visible = false
	pass # Replace with function body.
