extends StaticBody2D

signal open_leave_menu
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interaction_detection_body_entered(body):
	emit_signal("open_leave_menu")
