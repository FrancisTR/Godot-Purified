extends Control

@onready var InventoryRequest = [
	$ListUI/ItemR, 
	$ListUI/ItemR2, 
	$ListUI/ItemR3, 
	$ListUI/ItemR4, 
	$ListUI/ItemR5, 
	$ListUI/ItemR6
]

@onready var InventoryCheckMark = [
	$ListUI/ItemR/CheckMark,
	$ListUI/ItemR2/CheckMark,
	$ListUI/ItemR3/CheckMark,
	$ListUI/ItemR4/CheckMark,
	$ListUI/ItemR5/CheckMark,
	$ListUI/ItemR6/CheckMark
]

@onready var InventoryAmount = [
	$ListUI/ItemR/ItemNeeded, 
	$ListUI/ItemR2/ItemNeeded, 
	$ListUI/ItemR3/ItemNeeded, 
	$ListUI/ItemR4/ItemNeeded, 
	$ListUI/ItemR5/ItemNeeded, 
	$ListUI/ItemR6/ItemNeeded
]


func _process(delta):
	#$Items/slot0/ItemName0.visible = false
	#$Items/slot1/ItemName1.visible = false
	#$Items/slot2/ItemName2.visible = false
	#$Items/slot3/ItemName3.visible = false
	#$Items/slot4/ItemName4.visible = false
	#$Items/slot5/ItemName5.visible = false
	#$Items/slot6/ItemName6.visible = false
	#$Items/slot7/ItemName7.visible = false
	#$Items/slot8/ItemName8.visible = false
	#$Items/slot9/ItemName9.visible = false
	#$Items/slot10/ItemName10.visible = false
	#$Items/slot11/ItemName11.visible = false
	#$Items/slot12/ItemName12.visible = false
	#$Items/slot13/ItemName13.visible = false
	#$Items/slot14/ItemName14.visible = false
	#GameData.QMain[NPCname] = true
	# Constantly update the variables live
	var countTalked = 0
	for i in range(len(GameData.villagersTalked)):
		if GameData.villagersTalked[i]["Talked"] == true:
			countTalked = countTalked + 1
	
	
	#TODO Set things up in UI for specific days
	$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/7"
	
	if (GameData.day >= 1 and GameData.day <= 3):
		#$ListUI/ItemR.visible = true
		#$ListUI/ItemR2.visible = true
		if (GameData.visitTutorial == false):
			for i in range(2):
				InventoryRequest[i].visible = true
		else: #Tutorial
			InventoryRequest[0].visible = true
			$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/1"
		
	if (GameData.day == 3 or GameData.day == 5 or GameData.day == 6):
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/6"
	if (GameData.day == 4):
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/5"
	if (GameData.day == 7):
		InventoryRequest[0].visible = true
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/1"
	if GameData.day == 8:
		for i in range(3):
			InventoryRequest[i].visible = true
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/6"
	if GameData.day == 9 or GameData.day == 10:
		InventoryRequest[0].visible = true
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/6"
	
	# Show in the UI of the item
	#TODO: Add more requirements for each day and mae QMain and QWild
	#Todo list shown in the inventory
	if GameData.visitTutorial == true:
		
		if (GameData.QMain.keys().find("Talia") != -1):
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Talia") != -1):
					InventoryRequest[GameData.QMainLocationIdx["Talia"]].text = "Request from Talia"
					InventoryAmount[GameData.QMainLocationIdx["Talia"]].text = "Need 1 Rock"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Talia"
					InventoryAmount[i].text = "Need 1 Rock"
					GameData.QMainLocationIdx["Talia"] = i
					break
		
	elif GameData.day == 1 and GameData.visitTutorial == false:
		GameData.inventory_requirement = {"WaterBottleSpecial": "1"}
		
		#Add to the list based on the requirements
		#GameData.QMain[NPCname] = true
		if (GameData.QMain.keys().find("Accept") != -1):
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Accept") != -1 and InventoryRequest[i].text == "Request from Antonio"):
					InventoryRequest[GameData.QMainLocationIdx["Accept"]].text = "Request from Antonio"
					InventoryAmount[GameData.QMainLocationIdx["Accept"]].text = "Need 6 Twigs"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Antonio"
					InventoryAmount[i].text = "Need 6 Twigs"
					GameData.QMainLocationIdx["Accept"] = i
					break
		if (GameData.QWild == true):
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Request from the Kids") != -1 and InventoryRequest[i].text == "Request from the Kids"):
					InventoryRequest[GameData.QMainLocationIdx["Request from the Kids"]].text = "Request from the Kids"
					InventoryAmount[GameData.QMainLocationIdx["Request from the Kids"]].text = str(GameData.inventory_requirement["WaterBottleSpecial"])+" Special Water Bottle"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from the Kids"
					InventoryAmount[i].text = str(GameData.inventory_requirement["WaterBottleSpecial"])+" Special Water Bottle"
					GameData.QMainLocationIdx["Request from the Kids"] = i
					break
	
	
	elif GameData.day == 2:
		GameData.inventory_requirement = {"BoilingPot": "1"}
		
		#Add to the list based on the requirements
		if (GameData.QMain.keys().find("Bargin") != -1):
			#$ListUI/ItemR.text = "Request from Barry"
			#$ListUI/ItemR/ItemNeeded.text = "Need 1 Water Bottle"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Bargin") != -1 and InventoryRequest[i].text == "Request from Barry"):
					InventoryRequest[GameData.QMainLocationIdx["Bargin"]].text = "Request from Barry"
					InventoryAmount[GameData.QMainLocationIdx["Bargin"]].text = "Need 4 rocks"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Barry"
					InventoryAmount[i].text = "Need 4 rocks"
					GameData.QMainLocationIdx["Bargin"] = i
					break
		if (GameData.QWild == true):
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Request from the Kids") != -1 and InventoryRequest[i].text == "Request from the Kids"):
					InventoryRequest[GameData.QMainLocationIdx["Request from the Kids"]].text = "Request from the Kids"
					InventoryAmount[GameData.QMainLocationIdx["Request from the Kids"]].text = "Create "+str(GameData.inventory_requirement["BoilingPot"])+" Boiling Pot"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from the Kids"
					InventoryAmount[i].text = "Create "+str(GameData.inventory_requirement["BoilingPot"])+" Boiling Pot"
					GameData.QMainLocationIdx["Request from the Kids"] = i
					break
	
	elif GameData.day == 3:
		GameData.inventory_requirement = {"WaterFilter": "1"}
		#Add to the list based on the requirements
		if (GameData.QMain.keys().find("Accept") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Accept") != -1 and InventoryRequest[i].text == "Request from Antonio"):
					InventoryRequest[GameData.QMainLocationIdx["Accept"]].text = "Request from Antonio"
					InventoryAmount[GameData.QMainLocationIdx["Accept"]].text = "Need 3 Tin Cans"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Antonio"
					InventoryAmount[i].text = "Need 3 Tin Cans"
					GameData.QMainLocationIdx["Accept"] = i
					break
		
		if (GameData.QWild == true):
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Request from the Kids") != -1 and InventoryRequest[i].text == "Request from the Kids"):
					InventoryRequest[GameData.QMainLocationIdx["Request from the Kids"]].text = "Request from the Kids"
					InventoryAmount[GameData.QMainLocationIdx["Request from the Kids"]].text = "Create "+str(GameData.inventory_requirement["WaterFilter"])+" Water Filter"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from the Kids"
					InventoryAmount[i].text = "Create "+str(GameData.inventory_requirement["WaterFilter"])+" Water Filter"
					GameData.QMainLocationIdx["Request from the Kids"] = i
					break
	
	
	
	
	elif GameData.day == 7:
		#Add to the list based on the requirements
		if (GameData.QMain.keys().find("OldMan") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("OldMan") != -1 and InventoryRequest[i].text == "Request from OldMan"):
					InventoryRequest[GameData.QMainLocationIdx["OldMan"]].text = "Request from OldMan"
					InventoryAmount[GameData.QMainLocationIdx["OldMan"]].text = "Create an improved filter"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from OldMan"
					InventoryAmount[i].text = "Create an improved filter"
					GameData.QMainLocationIdx["OldMan"] = i
					break
	
	
	
	
	
	
	
	
	elif GameData.day == 8:
		#Add to the list based on the requirements
		if (GameData.QMain.keys().find("Bargin") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Bargin") != -1 and InventoryRequest[i].text == "Request from Barry"):
					InventoryRequest[GameData.QMainLocationIdx["Bargin"]].text = "Request from Barry"
					InventoryAmount[GameData.QMainLocationIdx["Bargin"]].text = "Need 5 Water Bottles"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Barry"
					InventoryAmount[i].text = "Need 5 Water Bottles"
					GameData.QMainLocationIdx["Bargin"] = i
					break
								
		if (GameData.QMain.keys().find("Anger") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Anger") != -1 and InventoryRequest[i].text == "Request from Angelica"):
					InventoryRequest[GameData.QMainLocationIdx["Anger"]].text = "Request from Angelica"
					InventoryAmount[GameData.QMainLocationIdx["Anger"]].text = "Need 2 Water Filters"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Angelica"
					InventoryAmount[i].text = "Need 2 Water Filters"
					GameData.QMainLocationIdx["Anger"] = i
					break
		
		
		
		if (GameData.QMain.keys().find("Denial") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Denial") != -1 and InventoryRequest[i].text == "Request from Danny"):
					InventoryRequest[GameData.QMainLocationIdx["Denial"]].text = "Request from Danny"
					InventoryAmount[GameData.QMainLocationIdx["Denial"]].text = "Need 1 Water Bottle"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Danny"
					InventoryAmount[i].text = "Need 1 Water Bottle"
					GameData.QMainLocationIdx["Denial"] = i
					break
	
	
	
	
	elif GameData.day == 9:
		#Add to the list based on the requirements
		if (GameData.QMain.keys().find("Bargin") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Bargin") != -1 and InventoryRequest[i].text == "Request from Barry"):
					InventoryRequest[GameData.QMainLocationIdx["Bargin"]].text = "Request from Barry"
					InventoryAmount[GameData.QMainLocationIdx["Bargin"]].text = "Collect 6 Tin Cans"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Barry"
					InventoryAmount[i].text = "Collect 6 Tin Cans"
					GameData.QMainLocationIdx["Bargin"] = i
					break
	
	
	
	elif GameData.day == 10:
		#Add to the list based on the requirements
		if (GameData.QMain.keys().find("Anger") != -1):
			#$ListUI/ItemR.text = "Request from Antonio"
			#$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
			for i in range(len(InventoryRequest)):
				if (GameData.QMainLocationIdx.keys().find("Anger") != -1 and InventoryRequest[i].text == "Request from Angelica"):
					InventoryRequest[GameData.QMainLocationIdx["Anger"]].text = "Request from Angelica"
					InventoryAmount[GameData.QMainLocationIdx["Anger"]].text = "Need 10 Twigs"
					break
				elif (InventoryRequest[i].visible == true and InventoryRequest[i].text == "???"):
					InventoryRequest[i].text = "Request from Angelica"
					InventoryAmount[i].text = "Need 10 Twigs"
					GameData.QMainLocationIdx["Anger"] = i
					break
	
	
	
	
	#Add a checkmark next to the request if fufilled
	#questComplete = {"Main": false, "Wild": false}
	#TODO make it more dynamic
	#if (GameData.questComplete["Main"] == true):
		#$ListUI/ItemR/CheckMark.texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")
	if (GameData.QMain.size() != 0):
		for i in GameData.QMain.keys():
			if GameData.QMain[str(i)] == true:
				for j in range(len(InventoryCheckMark)):
					if j == GameData.QMainLocationIdx[i]:
						InventoryCheckMark[j].texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")
				
			
	#GameData.QMain[NPCname] = true
	if (GameData.questComplete["Wild"] == true):
		for i in (len(InventoryCheckMark)):
			if GameData.QMainLocationIdx["Request from the Kids"] == i:
				InventoryCheckMark[i].texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")





func draw_items(items):
	print(items)
	for i in range(0, 15):
		var slot_item = get_node(str("Items/slot",i))
		var slot_amount = get_node(str("Amounts/slot",i))
		var slot_name = get_node(str("Items/slot",i)+str("/ItemName", i))
		if(i<len(items)):
			slot_item.texture = _draw_item_instance(items[i]["name"])
			slot_amount.text = str(GameData.inventory_amount[items[i]["name"]])
			slot_name.text = items[i]["name"]
		else:
			slot_item.texture = null
			slot_amount.text = ""
			slot_name.text = ""

func _draw_item_instance(item):
	if Utils.get_item(item)["cropped"] == "yes":
		return load(Utils.get_item(item)["texture"]).instantiate().getTexture()
	else:
		return load(Utils.get_item(item)["texture"])





func _on_view_button_pressed():
	SoundControl.is_playing_sound("button")
	$HBoxContainer.visible = false
	$TODOlist.visible = false
	$Items.visible = false
	$Amounts.visible = false
	$ListUI.visible = true
	

func _on_exit_button_pressed():
	SoundControl.is_playing_sound("button")
	$HBoxContainer.visible = true
	$TODOlist.visible = true
	$Items.visible = true
	$Amounts.visible = true
	$ListUI.visible = false




func _on_slot_0_mouse_entered():
	$Items/slot0/ItemName0.visible = true
	pass # Replace with function body.


func _on_slot_1_mouse_entered():
	$Items/slot1/ItemName1.visible = true
	pass # Replace with function body.


func _on_slot_2_mouse_entered():
	$Items/slot2/ItemName2.visible = true
	pass # Replace with function body.


func _on_slot_3_mouse_entered():
	$Items/slot3/ItemName3.visible = true
	pass # Replace with function body.


func _on_slot_4_mouse_entered():
	$Items/slot4/ItemName4.visible = true
	pass # Replace with function body.


func _on_slot_5_mouse_entered():
	$Items/slot5/ItemName5.visible = true
	pass # Replace with function body.


func _on_slot_6_mouse_entered():
	$Items/slot6/ItemName6.visible = true
	pass # Replace with function body.


func _on_slot_7_mouse_entered():
	$Items/slot7/ItemName7.visible = true
	pass # Replace with function body.


func _on_slot_8_mouse_entered():
	$Items/slot8/ItemName8.visible = true
	pass # Replace with function body.


func _on_slot_9_mouse_entered():
	$Items/slot9/ItemName9.visible = true
	pass # Replace with function body.


func _on_slot_10_mouse_entered():
	$Items/slot10/ItemName10.visible = true
	pass # Replace with function body.


func _on_slot_11_mouse_entered():
	$Items/slot11/ItemName11.visible = true
	pass # Replace with function body.


func _on_slot_12_mouse_entered():
	$Items/slot12/ItemName12.visible = true
	pass # Replace with function body.


func _on_slot_13_mouse_entered():
	$Items/slot13/ItemName13.visible = true
	pass # Replace with function body.


func _on_slot_14_mouse_entered():
	$Items/slot14/ItemName14.visible = true
	pass # Replace with function body.


func _on_slot_0_mouse_exited():
	$Items/slot0/ItemName0.visible = false
	pass # Replace with function body.


func _on_slot_1_mouse_exited():
	$Items/slot1/ItemName1.visible = false
	pass # Replace with function body.


func _on_slot_2_mouse_exited():
	$Items/slot2/ItemName2.visible = false
	pass # Replace with function body.


func _on_slot_3_mouse_exited():
	$Items/slot3/ItemName3.visible = false
	pass # Replace with function body.


func _on_slot_4_mouse_exited():
	$Items/slot4/ItemName4.visible = false
	pass # Replace with function body.


func _on_slot_5_mouse_exited():
	$Items/slot5/ItemName5.visible = false
	pass # Replace with function body.


func _on_slot_6_mouse_exited():
	$Items/slot6/ItemName6.visible = false
	pass # Replace with function body.


func _on_slot_7_mouse_exited():
	$Items/slot7/ItemName7.visible = false
	pass # Replace with function body.


func _on_slot_8_mouse_exited():
	$Items/slot8/ItemName8.visible = false
	pass # Replace with function body.


func _on_slot_9_mouse_exited():
	$Items/slot9/ItemName9.visible = false
	pass # Replace with function body.


func _on_slot_10_mouse_exited():
	$Items/slot10/ItemName10.visible = false
	pass # Replace with function body.


func _on_slot_11_mouse_exited():
	$Items/slot11/ItemName11.visible = false
	pass # Replace with function body.


func _on_slot_12_mouse_exited():
	$Items/slot12/ItemName12.visible = false
	pass # Replace with function body.


func _on_slot_13_mouse_exited():
	$Items/slot13/ItemName13.visible = false
	pass # Replace with function body.


func _on_slot_14_mouse_exited():
	$Items/slot14/ItemName14.visible = false
	pass # Replace with function body.
