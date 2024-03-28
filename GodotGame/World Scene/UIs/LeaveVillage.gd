extends Control

signal leave_village

func _ready():
	self.hide()


func _on_yes_pressed():
	self.hide()
	emit_signal("leave_village")
	print("y")
	GameData.charLock = false
	Utils.remove_from_inventory("Twig", int(GameData.inventory_amount["Twig"]))
	Utils.remove_from_inventory("Rock", int(GameData.inventory_amount["Rock"]))


func _on_no_pressed():
	self.hide()
	print("n")
	GameData.charLock = false


func _on_okay_pressed():
	self.hide()
	print("Okay")
	GameData.charLock = false
