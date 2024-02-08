extends Label


# Called when the node enters the scene tree for the first time.
var world
func _ready():
	world=$"../.."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Day " + str(world.day)
