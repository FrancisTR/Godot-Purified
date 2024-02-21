extends Control

signal leave_village

func _ready():
	self.hide()

func _on_yes_pressed():
	self.hide()
	emit_signal("leave_village")
	print("y")


func _on_no_pressed():
	self.hide()
	print("n")
