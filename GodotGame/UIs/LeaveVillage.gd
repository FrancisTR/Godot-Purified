extends Control

@onready var this = $"."

func _ready():
	this.hide()

func _on_yes_pressed():
	pass # Replace with function body.
	print("y")


func _on_no_pressed():
	pass # Replace with function body.
	print("n")
	this.hide()
