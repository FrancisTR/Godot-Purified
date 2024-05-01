extends Control





func _process(delta):
	if $"..".visible == true:
		GameData.charLock = true
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
	pass
	
	
	
func draw_items(items):
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



func _on_slot_0_mouse_entered():
	$Items/slot0/ItemName0.visible = true
	pass # Replace with function body.
func _on_slot_0_pressed():
	#Assume this is a WaterBottleSpecial
	if (GameData.inventory_amount.keys().find(str($Items/slot0/ItemName0.text)) != -1):
		$"../../../FixedDialoguePosition/DialogueBox".start("OldMan"+str($Items/slot0/ItemName0.text))
		Utils.remove_from_inventory(str($Items/slot0/ItemName0.text), 999)
		GameData.charLock = true
		GameData.current_ui = "dialogue"
		$"../../../PressForDialogue".visible = false
		$"../../../FixedDialoguePosition/CharacterIMG".visible = true
		$"../../../FixedDialoguePosition/DialogueOpacity".visible = true
		$"../../../FixedDialoguePosition/Voice".visible = true
		$"..".visible = false
	pass # Replace with function body.



func _on_slot_1_mouse_entered():
	$Items/slot1/ItemName1.visible = true
	pass # Replace with function body.
func _on_slot_1_pressed():
	#Assume this is a BoilingPot
	if (GameData.inventory_amount.keys().find(str($Items/slot1/ItemName1.text)) != -1):
		$"../../../FixedDialoguePosition/DialogueBox".start("OldMan"+str($Items/slot1/ItemName1.text))
		Utils.remove_from_inventory(str($Items/slot1/ItemName1.text), 999)
		GameData.charLock = true
		GameData.current_ui = "dialogue"
		$"../../../PressForDialogue".visible = false
		$"../../../FixedDialoguePosition/CharacterIMG".visible = true
		$"../../../FixedDialoguePosition/DialogueOpacity".visible = true
		$"../../../FixedDialoguePosition/Voice".visible = true
		$"..".visible = false
	pass # Replace with function body.



func _on_slot_2_mouse_entered():
	$Items/slot2/ItemName2.visible = true
	pass # Replace with function body.
func _on_slot_2_pressed():
	#Assume this is a WaterFilter
	if (GameData.inventory_amount.keys().find(str($Items/slot2/ItemName2.text)) != -1):
		$"../../../FixedDialoguePosition/DialogueBox".start("OldMan"+str($Items/slot2/ItemName2.text))
		Utils.remove_from_inventory(str($Items/slot2/ItemName2.text), 999)
		GameData.charLock = true
		GameData.current_ui = "dialogue"
		$"../../../PressForDialogue".visible = false
		$"../../../FixedDialoguePosition/CharacterIMG".visible = true
		$"../../../FixedDialoguePosition/DialogueOpacity".visible = true
		$"../../../FixedDialoguePosition/Voice".visible = true
		$"..".visible = false
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


