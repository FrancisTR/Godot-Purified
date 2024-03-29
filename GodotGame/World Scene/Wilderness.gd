extends Node2D

var signal_method = ""

@export var NumTwigs: int = 0

var Twig = preload("res://World Scene/Items/twig.tscn")
var Rock = preload("res://World Scene/Items/rock.tscn")
var TinCan = preload("res://World Scene/Items/TinCan.tscn")






# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.visitedWilderness = true
	#TODO: Make inventory system into its own scene w/ graphics
	$UI/Inventory.text = "Inventory\nTwigs: " + str(NumTwigs)
	#SceneTransition.manual_fade.connect(go_to_next_day)
	$UI/Day.text = "Day " + str(GameData.day)
	var day = GameData.day
	if GameData.day > 10:
		day = 10
		
		
	#Add the item once. The bool is reset if going to the next day
	if (GameData.itemSpawnOnce == false):
		GameData.itemSpawnOnce = true
		print(true)
		inst(Vector2(1007,-527), Twig)
		inst(Vector2(1005,-315), Rock)
		inst(Vector2(1003,-418), TinCan)

#Spawn the item in the wilderness
func inst(pos, item):
	#TODO: add more items later
	var instance = item.instantiate()
	instance.position = pos
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
