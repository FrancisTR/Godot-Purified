extends Control

signal leave_village

func _ready():
	self.hide()

func _on_yes_pressed():
	self.hide()
	emit_signal("leave_village")
	print("y")
	GameData.charLock = false


func _on_no_pressed():
	self.hide()
	print("n")
	GameData.charLock = false
