extends Control

func _ready():
	
	#Todo list shown in the inventory
	if GameData.day == 1:
		GameData.inventory_requirement = {"Twigs": "2", "Rocks": "1"}
	elif GameData.day == 2:
		GameData.inventory_requirement = {"Twigs": "1", "Rocks": "2"}
	elif GameData.day == 3:
		GameData.inventory_requirement = {"Twigs": "2", "Rocks": "2"}
	
	#Add to the list based on the requirements
	$TODOlist/Twigs/TwigsText.text = GameData.inventory_requirement["Twigs"]
	$TODOlist/Rocks/RocksText.text = GameData.inventory_requirement["Rocks"]
		

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



