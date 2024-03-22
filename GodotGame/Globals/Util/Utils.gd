extends Node

const SAVE_PATH = "users://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {
	}
	
	
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
func get_JSON(file_path):
	var json_as_text = FileAccess.get_file_as_string(file_path)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict
	
	
func get_item(item):
	var json = get_JSON("res://Globals/items.json")
	var index = json[0][item]
	print(json[index])
	return json[index]
	
func add_to_inventory(item, amount):
	if GameData.inventory_amount.has(item):
		GameData.inventory_amount[str(item)] = GameData.inventory_amount[str(item)] + amount
	else:
		GameData.inventory_amount[str(item)] = amount
		GameData.inventory.append(get_item(item))
	print("INVENTORY", GameData.inventory)
	print("AMOUNT", GameData.inventory_amount)

func remove_from_inventory(item, amount):
	if(GameData.inventory_amount.has(item)):
		if GameData.inventory_amount[str(item)] - amount <= 0:
			#GameData.inventory_amount[str(item)] = 0
			GameData.inventory_amount.erase(str(item))
			print("no way: ", GameData.inventory_amount)
			if GameData.inventory.find(get_item(item)) != -1:
				GameData.inventory.remove_at(GameData.inventory.find(get_item(item)))
		else:
			GameData.inventory_amount[str(item)] = GameData.inventory_amount[str(item)] - amount
		print("INVENTORY", GameData.inventory)
		print("AMOUNT", GameData.inventory_amount)
	else:
		print("No item to remove")
