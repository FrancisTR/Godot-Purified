extends Control

signal leave_village

func _ready():
	self.hide()

#TODO: Remove more items
func _on_yes_pressed():
	self.hide()
	SoundControl.is_playing_sound("button")
	emit_signal("leave_village")
	print("y")
	
	
	GameData.QVillager = {}
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
	
	
	#Reset villagers talked
	for i in range(len(GameData.villagersTalked)):
		GameData.villagersTalked[i]["Talked"] = false

	GameData.QMain = {}
	GameData.QMainLocationIdx = {}
	
	GameData.QWild = false
	GameData.questComplete = {"Main": false, "Wild": false}
	GameData.NPCgiveNoMore = false
	
	GameData.itemDialogue[0]["Value"] = 0
	GameData.itemDialogue[1]["Value"] = 0
	GameData.itemDialogue[2]["Value"] = 0
	GameData.itemDialogue[3]["Value"] = 0
	GameData.itemDialogue[4]["Value"] = 0
		
	#Reset take items and spawn again on the next day
	GameData.get_item_posX = null
	GameData.get_item_posY = null
	for i in range(len(GameData.itemSpawns)):
		GameData.itemSpawns[i]["Taken"] = false
	
	
	GameData.Discount = ""
	GameData.visitedWilderness == false
	
	GameData.madeProfit = false
	GameData.barryDespawned = false
	GameData.talkToKid = false
	GameData.leaveVillageQuest = false



func _on_no_pressed():
	self.hide()
	SoundControl.is_playing_sound("button")
	print("n")
	GameData.charLock = false


func _on_okay_pressed():
	self.hide()
	SoundControl.is_playing_sound("button")
	print("Okay")
	GameData.charLock = false
