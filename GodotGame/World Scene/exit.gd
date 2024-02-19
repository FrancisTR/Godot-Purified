extends StaticBody2D


# Called when the node enters the scene tree for the first time.
@onready var world = $".."

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interaction_detection_body_entered(body):
	world.open_leave_menu();
