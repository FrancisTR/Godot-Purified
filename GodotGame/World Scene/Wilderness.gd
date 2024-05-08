extends Node2D

var signal_method = ""
var tin_can_scene = preload("res://World Scene/Items/TinCan.tscn")
var bottle_scene = preload("res://World Scene/Items/WaterBottle.tscn")
var rock_scene = preload("res://World Scene/Items/rock.tscn")
var twig_scene = preload("res://World Scene/Items/twig.tscn")
var sand_scene = preload("res://World Scene/Items/sand.tscn")
var moss_scene = preload("res://World Scene/Items/Moss.tscn")
var scenes = {
	"TinCan": tin_can_scene,
	"WaterBottle": bottle_scene,
	"rock": rock_scene,
	"twig": twig_scene,
	"sand": sand_scene,
	"Moss": moss_scene
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameData.day >= 4:
		$CroakFlag.position = Vector2(607, 492)
		
	GameData.visitedWilderness = true
	#TODO: Make inventory system into its own scene w/ graphics
	#$UI/Inventory.text = "Inventory\nTwigs: " + str(NumTwigs)
	#SceneTransition.manual_fade.connect(go_to_next_day)
	if GameData.save_position:
		$Other/CharacterBody2D.position = GameData.player_position
		GameData.save_position = false
	$UI/Day.text = "Day " + str(GameData.day)
	var day = GameData.day
	if GameData.day > 10:
		day = 10


	#Water bottle
	if (GameData.day == 1 and GameData.talkToKid == true and GameData.leaveVillageQuest == false):
		var instance = preload("res://World Scene/Items/WaterBottleSpecial.tscn").instantiate()
		var instance2 = preload("res://World Scene/Items/WaterBottleSpecial.tscn").instantiate()
		var instance3 = preload("res://World Scene/Items/WaterBottleSpecial.tscn").instantiate()
		instance.position = Vector2(-1127, -617)
		instance2.position = Vector2(2310, -327)
		instance3.position = Vector2(-221, 1314)
		
		add_child(instance)
		add_child(instance2)
		add_child(instance3)
		$KidsNPC.visible = true
	if (GameData.talkToKid == true and GameData.leaveVillageQuest == false):
		$KidsNPC.visible = true
	else:
		$KidsNPC.visible = false
	
	
	#Spawn crafting table after day 2+
	if GameData.day >= 2 and GameData.talkToKid == true and GameData.questComplete["Wild"] == false:
		$Other/CraftingTable.position = Vector2(833, -802)
		$Other/CraftingTable.visible = true
	elif GameData.day == 8:
		$Other/CraftingTable.position = Vector2(833, -802)
		$Other/CraftingTable.visible = true
	else:
		$Other/CraftingTable.position = Vector2(999999999, 999999999)
		$Other/CraftingTable.visible = false


	#add item spawns
	#inst(GameData.itemSpawns)
	inst_json(Utils.static_items_json)
	inst_json(Utils.non_static_items_json)
	
	#Appear the children if it is day 4+
	if GameData.day >= 4:
		$IndividualNPCs/Rano.position = Vector2(678, 584)
		$IndividualNPCs/Leap.position = Vector2(2421, 403)
		$IndividualNPCs/Hop.position = Vector2(-310, -555)
		$IndividualNPCs/Ribbit.position = Vector2(317, 976)
		
		




func _process(delta):
	#Keep constant track of the items being remove in the wild
	#for i in range(len(GameData.itemSpawns)):
		#if (GameData.get_item_posX == GameData.itemSpawns[i]["posX"] and GameData.get_item_posY == GameData.itemSpawns[i]["posY"]):
			#GameData.itemSpawns[i]["Taken"] = true
	for item in Utils.non_static_items_json:
		var index = GameData.day-1
		var x_same = GameData.get_item_posX == item.Position[index].posX
		var y_same = GameData.get_item_posY == item.Position[index].posY
		if x_same and y_same:
			item.Taken = true
	
	#TODO: Add theme song based on the day
	if GameData.day <= 2:
		SoundControl.is_playing_theme("afternoon")
	elif GameData.day == 4:
		SoundControl.is_playing_theme("croak")
	elif GameData.day >= 3 and GameData.day != 4:
		SoundControl.is_playing_theme("main")
			

#Spawn the item in the wilderness
# items: list of dictionaries
func inst(items):
	for i in range(len(items)):
		if items[i]["Taken"] == false:
			#Get the scene of the item
			var instance = items[i]["Item"].instantiate()
			instance.position = Vector2(items[i]["posX"], items[i]["posY"])
			add_child(instance)

func inst_json(item_json):
	var count = 0
	for item in item_json:
		var instance = scenes[item.Item].instantiate()
		var index = GameData.day-1
		if item.Item == "sand" or item.Item == "Moss":
			index = 0
		var in_valid_place = item.Position[index].posX != -9999 and item.Position[index].posY != -9999
		if in_valid_place and not item.Taken:
			count+=1
			instance.position = Vector2(item.Position[index].posX, item.Position[index].posY)
			add_child(instance)
	print("spawned in ", count, " items")

func increase_day(amount):
	if(GameData.day+amount > 0):
		GameData.day += amount

#**********TEST BUTTONS***********#
func _on_test_inc_1():
	print("+")
	increase_day(1)
	$UI/Day.text = "Day " + str(GameData.day)

func _on_test_dec_1():
	print("-")
	increase_day(-1)
	$UI/Day.text = "Day " + str(GameData.day)
	#vvv removes twig from inventory
	#Utils.remove_from_inventory("Twig", 1)
	Utils.remove_from_inventory("Rock", 1)
	print(GameData.inventory_amount)
#*********************************#

#********** INVENTORY ***********#
#func _on_twig_picked_up():
	#NumTwigs += 1
	#$UI/Inventory.text = "Inventory\nTwigs: " + str(NumTwigs)
	#GameData.twigItem += 1
#*********************************#


func _on_open_map():
	$"Map/Map Camera".make_current()
	$Other/CharacterBody2D.show_map_icon()
	$"Map/Wilderness Exit".show()
	$"TileMaps/Hidden Forest".show()
	$UI/Controls.hide()

func _on_close_map():
	$Other/CharacterBody2D.hide_map_icon()
	$"Map/Wilderness Exit".hide()
	$"TileMaps/Hidden Forest".hide()
	$UI/Controls.show()
