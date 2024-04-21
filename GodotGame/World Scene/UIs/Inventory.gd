extends Control





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
	# Constantly update the variables live
	var countTalked = 0
	for i in range(len(GameData.villagersTalked)):
		if GameData.villagersTalked[i]["Talked"] == true:
			countTalked = countTalked + 1
	#TODO Set things up in UI for specific days
	$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/7"
	if (GameData.day >= 1 and GameData.day <= 3):
		$ListUI/ItemR.visible = true
		$ListUI/ItemR2.visible = true
	if (GameData.day == 3 or GameData.day == 5 or GameData.day == 6):
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/6"
	if (GameData.day == 4):
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/5"
	if (GameData.day == 7):
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/1"
	
	#Add a checkmark next to the request if fufilled
	#questComplete = {"Main": false, "Wild": false}
	#TODO make it more dynamic
	if (GameData.questComplete["Main"] == true):
		$ListUI/ItemR/CheckMark.texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")
	if (GameData.questComplete["Wild"] == true):
		$ListUI/ItemR2/CheckMark.texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")
	

	# Show in the UI of the item
	#TODO: Add more requirements for each day and mae QMain and QWild
	#Todo list shown in the inventory
	if GameData.day == 1:
		GameData.inventory_requirement = {"WaterBottleSpecial": "1"}
		
		#Add to the list based on the requirements
		if (GameData.QMain == true):
			$ListUI/ItemR.text = "Request from Antonio"
			$ListUI/ItemR/ItemNeeded.text = "Need 6 Twigs"
		if (GameData.QWild == true):
			$ListUI/ItemR2.text = "Request from the Kids"
			$ListUI/ItemR2/ItemNeeded.text = str(GameData.inventory_requirement["WaterBottleSpecial"])+" Special Water Bottle"
	
	elif GameData.day == 2:
		GameData.inventory_requirement = {"BoilingPot": "1"}
		
		#Add to the list based on the requirements
		if (GameData.QMain == true):
			$ListUI/ItemR.text = "Request from Barry"
			$ListUI/ItemR/ItemNeeded.text = "Need 1 Water Bottle"
		if (GameData.QWild == true):
			$ListUI/ItemR2.text = "Request from the Kids"
			$ListUI/ItemR2/ItemNeeded.text = "Create "+str(GameData.inventory_requirement["BoilingPot"])+" Boiling Pot"
	
	elif GameData.day == 3:
		GameData.inventory_requirement = {"WaterFilter": "1"}
		#Add to the list based on the requirements
		if (GameData.QMain == true):
			$ListUI/ItemR.text = "Request from Antonio"
			$ListUI/ItemR/ItemNeeded.text = "Need 3 Tin Cans"
		if (GameData.QWild == true):
			$ListUI/ItemR2.text = "Request from the Kids"
			$ListUI/ItemR2/ItemNeeded.text = "Create "+str(GameData.inventory_requirement["WaterFilter"])+" Water Filter"








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
