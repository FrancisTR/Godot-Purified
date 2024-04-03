extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		#if ((GameData.inventory_amount.keys().find("WaterBottle") == -1 or TalkedToVillagersCount != 7) and GameData.day == 1):
		#$UI/LeaveVillage.show()
		#$UI/LeaveVillage/QuotaError.show()
	#elif ((GameData.inventory_amount.keys().find("BoilingPot") == -1 or TalkedToVillagersCount != 7) and GameData.day == 2):
		#$UI/LeaveVillage.show()
		#$UI/LeaveVillage/QuotaError.show()
	#elif ((GameData.inventory_amount.keys().find("WaterFilter") == -1 or TalkedToVillagersCount != 7) and GameData.day == 3):
		#$UI/LeaveVillage.show()
		#$UI/LeaveVillage/QuotaError.show()
		get_tree().change_scene_to_file("res://World Scene/Wilderness.tscn")
	pass # Replace with function body.
