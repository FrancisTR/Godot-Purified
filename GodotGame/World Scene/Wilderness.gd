extends Node2D

var signal_method = ""

#@export var NumTwigs: int = 0





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
	if (GameData.talkToKid == true and GameData.leaveVillageQuest == false):
		var instance = preload("res://World Scene/Items/WaterBottleSpecial.tscn").instantiate()
		instance.position = Vector2(-1127, -617)
		add_child(instance)
		$KidsNPC.visible = true
	else:
		$KidsNPC.visible = false


	#TODO add item spawns
	inst(GameData.itemSpawns)
	
	#TODO: Spawn a water bottle if it is day 1 and true
	if GameData.day == 1 and GameData.talkToKid == true:
		#Spawn special water bottle
		pass


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
