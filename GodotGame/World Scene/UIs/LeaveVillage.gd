extends Control

signal leave_village

func _ready():
	self.hide()

#TODO: Remove more items
func _on_yes_pressed():
	self.hide()
	emit_signal("leave_village")
	print("y")
	
	GameData.charLock = false
	if GameData.inventory_amount.keys().find("Twig") != -1:
		Utils.remove_from_inventory("Twig", int(GameData.inventory_amount["Twig"]))
	
	if GameData.inventory_amount.keys().find("Rock") != -1:
		Utils.remove_from_inventory("Rock", int(GameData.inventory_amount["Rock"]))
	
	if GameData.inventory_amount.keys().find("Sand") != -1:
		Utils.remove_from_inventory("Sand", int(GameData.inventory_amount["Sand"]))
	
	if GameData.inventory_amount.keys().find("Moss") != -1:
		Utils.remove_from_inventory("Moss", int(GameData.inventory_amount["Moss"]))
	
	if GameData.inventory_amount.keys().find("TinCan") != -1:
		Utils.remove_from_inventory("TinCan", int(GameData.inventory_amount["TinCan"]))
	
	if GameData.inventory_amount.keys().find("WaterBottle") != -1:
		Utils.remove_from_inventory("WaterBottle", int(GameData.inventory_amount["WaterBottle"]))
	
	if GameData.inventory_amount.keys().find("BoilingPot") != -1:
		Utils.remove_from_inventory("BoilingPot", int(GameData.inventory_amount["BoilingPot"]))
	
	if GameData.inventory_amount.keys().find("WaterFilter") != -1:
		Utils.remove_from_inventory("WaterFilter", int(GameData.inventory_amount["WaterFilter"]))
	
	GameData.itemSpawnOnce = false #Spawn the items again on the next day
	
	#Reset villagers taled
	for i in range(len(GameData.villagersTalked)):
		GameData.villagersTalked[i]["Talked"] = false
	
	#Reset take items and spawn again on the next day
	GameData.get_item_posX = null
	GameData.get_item_posY = null
	for i in range(len(GameData.itemSpawns)):
		GameData.itemSpawns[i]["Taken"] = false
	
	
	
	GameData.visitedWilderness == false
	
func _on_no_pressed():
	self.hide()
	print("n")
	GameData.charLock = false


func _on_okay_pressed():
	self.hide()
	print("Okay")
	GameData.charLock = false
