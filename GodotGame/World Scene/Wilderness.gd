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
	else:
		$Other/CraftingTable.position = Vector2(999999999, 999999999)
		$Other/CraftingTable.visible = false


	#add item spawns
	#inst(GameData.itemSpawns)
	inst_json(Utils.static_items_json)
	inst_json(Utils.non_static_items_json)


func _process(delta):
	#Keep constant track of the items being remove in the wild
	for i in range(len(GameData.itemSpawns)):
		if (GameData.get_item_posX == GameData.itemSpawns[i]["posX"] and GameData.get_item_posY == GameData.itemSpawns[i]["posY"]):
			GameData.itemSpawns[i]["Taken"] = true
	
	#TODO: Add theme song based on the day
	if GameData.day <= 2:
		SoundControl.is_playing_theme("afternoon")
	elif GameData.day >= 3:
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
	for item in item_json:
		var instance = scenes[item.Item].instantiate()
		var index = GameData.day-1
		if item.Item == "sand" or item.Item == "Moss":
			index = 0
		instance.position = Vector2(item.Position[index].posX, item.Position[index].posY)
		add_child(instance)

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

func _on_close_map():
	$Other/CharacterBody2D.hide_map_icon()
	$"Map/Wilderness Exit".hide()


func _on_item_placer_pos_test():
	if $PseudoItems.get_child_count()==0:
		make_pseudo_instance()
	else:
		var W = false
		for child in $PseudoItems.get_children():
			#print(child.name, "vs", $"Item Placer/ItemPlacer".current_pseudo)
			if child.name == $"Item Placer/ItemPlacer".current_pseudo:
				child.position = get_local_mouse_position().floor()
				var pseudo_item = GameData.pseudo_items[GameData.pseudo_items.find(child)]
				print("this you? ", pseudo_item, " at ", GameData.pseudo_items.find(child))
				pseudo_item.position = get_local_mouse_position().floor()
				print("Moved ", child, " to ", pseudo_item.position)
				W = true
				return
		if not W:
			#print("made it again no way")
			make_pseudo_instance()
			#print($PseudoItems.get_children())
			#ACTUALLY MAKE IT OR IT DOESNT WORK
func make_pseudo_instance():
	var current_pseudo = $"Item Placer/ItemPlacer".current_pseudo
	var scene = $"Item Placer/ItemPlacer".pseudo_scenes[int(current_pseudo.split("$")[0])]
	var instance = scene.instantiate()
	#instance.position = Vector2(944.6924, -689.1538)
	instance.position = get_local_mouse_position().floor()
	instance.name = current_pseudo
	instance.modulate = Color(0,1,1,0.5)
	#GameData.pseudo_items.get()
	$PseudoItems.add_child(instance)
	#print(GameData.pseudo_items.find(instance))
	print($PseudoItems.get_child($PseudoItems.get_children().find(instance)), " kkkkk ", instance)
	GameData.pseudo_items.append(instance)
	#print(instance.name)
	#print($PseudoItems.get_children())
	#print("made child")

func _on_item_placer_send_to_shadow_realm():
	for child in $PseudoItems.get_children():
		if child.name == $"Item Placer/ItemPlacer".current_pseudo:
			#child.position = get_local_mouse_position()
			child.position = Vector2(-9999, -9999)
			return

				
var dev_flag = false
func _on_toggle_dev_tool():
	$Other/CharacterBody2D.velocity = Vector2(0, 0)
	if $"Item Placer/ItemPlacer".dev_mode:
		if not dev_flag:
			#dev_flag = true
			$"Item Placer/ItemPlacer".set_camera_position($Other/CharacterBody2D.position)
		$"Item Placer".show()
		$PseudoItems.show()
	else:
		$Other/CharacterBody2D.set_to_player_camera()
		$"Item Placer".hide()
		$PseudoItems.hide()
