extends Control



func _ready():
	pass


func _process(delta):
	# Constantly update the variables live
	var countTalked = 0
	for i in range(len(GameData.villagersTalked)):
		if GameData.villagersTalked[i]["Talked"] == true:
			countTalked = countTalked + 1
	if (GameData.day >= 3):
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/6"
	else:
		$TODOlist/Villagers/VillagersText.text = str(countTalked)+"/7"
	
	
	#Add a checkmark next to the request if fufilled
	#questComplete = {"Main": false, "Wild": false}
	if (GameData.questComplete["Main"] == true):
		$TODOlist/ItemR/CheckMark.texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")
	if (GameData.questComplete["Wild"] == true):
		$TODOlist/ItemR2/CheckMark2.texture = load("res://Assets/UISprites/UI_Flat_Checkmark_Large.png")
	
	# Show in the UI of the item
	#TODO: Add more requirements for each day and mae QMain and QWild
	#Todo list shown in the inventory
	if GameData.day == 1:
		GameData.inventory_requirement = {"WaterBottle": "1"}
		
		#Add to the list based on the requirements
		if (GameData.QMain == true):
			$TODOlist/ItemR.text = "6 Twigs"
		if (GameData.QWild == true):
			$TODOlist/ItemR2.text = "WaterBottle: Need "+str(GameData.inventory_requirement["WaterBottle"])
	elif GameData.day == 2:
		GameData.inventory_requirement = {"BoilingPot": "1"}
		
		#Add to the list based on the requirements
		if (GameData.QMain == true):
			$TODOlist/ItemR.text = "1 Water Bottle"
		if (GameData.QWild == true):
			$TODOlist/ItemR2.text = "BoilingPot: Need "+str(GameData.inventory_requirement["BoilingPot"])
	elif GameData.day == 3:
		GameData.inventory_requirement = {"WaterFilter": "1"}
		
		#Add to the list based on the requirements
		if (GameData.QMain == true):
			$TODOlist/ItemR.text = "3 Rocks"
		if (GameData.QWild == true):
			$TODOlist/ItemR2.text = "WaterFilter: Need "+str(GameData.inventory_requirement["WaterFilter"])









func draw_items(items):
	for i in range(0, 15):
		var slot_item = get_node(str("Items/slot",i))
		var slot_amount = get_node(str("Amounts/slot",i))
		if(i<len(items)):
			slot_item.texture = _draw_item_instance(items[i]["name"])
			slot_amount.text = str(GameData.inventory_amount[items[i]["name"]])
		else:
			slot_item.texture = null
			slot_amount.text = ""

func _draw_item_instance(item):
	if Utils.get_item(item)["cropped"] == "yes":
		return load(Utils.get_item(item)["texture"]).instantiate().getTexture()
	else:
		return load(Utils.get_item(item)["texture"])



