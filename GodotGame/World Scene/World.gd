extends Node2D

@onready var npcs = [$NPCs/Denial_Danny, $NPCs/Anger_Angelica]


var signal_method = ""

@export var NumTwigs: int = 0

#TODO: Add cord for all NPCs
var npc_positions = {
	'day1':[Vector2(318, 106), Vector2(997, 101)],
	'day2':[Vector2(108, -353), Vector2(497, 201)],
	'day3':[Vector2(48, 406), Vector2(997, 101)],
	'day4':[Vector2(218, 206), Vector2(897, 201)],
	'day5':[Vector2(318, 106), Vector2(997, 101)],
	'day6':[Vector2(218, 206), Vector2(897, 201)],
	'day7':[Vector2(318, 106), Vector2(997, 101)],
	'day8':[Vector2(218, 206), Vector2(897, 201)],
	'day9':[Vector2(218, 206), Vector2(897, 201)],
	'day10':[Vector2(218, 206), Vector2(897, 201)]
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	if (GameData.visitedWilderness == true):
		$Other/CharacterBody2D.position = Vector2(866, 1125)
		GameData.visitedWilderness == false
	#TODO: Make inventory system into its own scene w/ graphics
	$UI/Inventory.text = "Inventory\nTwigs: " + str(NumTwigs)
	#SceneTransition.manual_fade.connect(go_to_next_day)
	$UI/Day.text = "Day " + str(GameData.day)
	for i in range(0, len(npcs)):
		var day = GameData.day
		if GameData.day > 10:
			day = 10
		
		# Commented out for now
		npcs[i].position = npc_positions[('day'+str(day))][i]
		print(npcs[i], "is set to", npc_positions[('day'+str(day))][i])

func increase_day(amount):
	if(GameData.day+amount > 0):
		GameData.day += amount

func _on_open_leave_menu():
	print("leaving?")
	$UI/LeaveVillage.hide()
	$UI/LeaveVillage/QuotaError.hide()
	$UI/LeaveVillage/ColorRect.hide()
	#If the quota is not met, show a UI error message
	if(len(GameData.inventory_amount) < 2 or int(GameData.inventory_amount["Rock"]) != int(GameData.inventory_requirement["Rocks"]) or int(GameData.inventory_amount["Twig"]) != int(GameData.inventory_requirement["Twigs"])):
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/QuotaError.show()
	else:
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/ColorRect.show()
		$UI/LeaveVillage/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/Yes.grab_focus()
	GameData.charLock = true

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
	Utils.remove_from_inventory("Twig", 2)
	print(GameData.inventory_amount)
#*********************************#

#********** INVENTORY ***********#
#func _on_twig_picked_up():
	#NumTwigs += 1
	#$UI/Inventory.text = "Inventory\nTwigs: " + str(NumTwigs)
	#GameData.twigItem += 1
#*********************************#


func _on_leave_village():
	#TODO: 3 days for MVP. 10 for full game
	if GameData.day < 3:
		TextTransition.set_to_click(
			"You leave the village and come back the next day",
			"res://World Scene/World.tscn",
			"Click To Continue"
		)
	else:
		TextTransition.set_to_chained_timed(
			[
				"We're no strangers to love",
				"You know the rules and so do I (do I)",
				"A full commitment's what I'm thinking of",
				"You wouldn't get this from any other guy",
				"I just wanna tell you how I'm feeling",
				"Gotta make you understand",
				"Never gonna give you up",
				"Never gonna let you down",
				"Never gonna run around and desert you",
				"Never gonna make you cry",
				"Never gonna say goodbye",
				"Never gonna tell a lie and hurt you",
				"We've known each other for so long",
				"Your heart's been aching, but you're too shy to say it (say it)",
				"Inside, we both know what's been going on (going on)",
				"We know the game and we're gonna play it",
				"And if you ask me how I'm feeling",
				"Don't tell me you're too blind to see",
				"Never gonna give you up",
				"Never gonna let you down",
				"Never gonna run around and desert you",
				"Never gonna make you cry",
				"Never gonna say goodbye",
				"Never gonna tell a lie and hurt you",
				"Never gonna give you up",
				"Never gonna let you down",
				"Never gonna run around and desert you",
				"Never gonna make you cry",
				"Never gonna say goodbye",
				"Never gonna tell a lie and hurt you",
				"We've known each other for so long",
				"Your heart's been aching, but you're too shy to say it (to say it)",
				"Inside, we both know what's been going on (going on)",
				"We know the game and we're gonna play it",
				"I just wanna tell you how I'm feeling",
				"Gotta make you understand",
				"Never gonna give you up",
				"Never gonna let you down",
				"Never gonna run around and desert you",
				"Never gonna make you cry",
				"Never gonna say goodbye",
				"Never gonna tell a lie and hurt you",
				"Never gonna give you up",
				"Never gonna let you down",
				"Never gonna run around and desert you",
				"Never gonna make you cry",
				"Never gonna say goodbye",
				"Never gonna tell a lie and hurt you",
				"Never gonna give you up",
				"Never gonna let you down",
				"Never gonna run around and desert you",
				"Never gonna make you cry",
				"Never gonna say goodbye",
				"Never gonna tell a lie and hurt you",
			],
			"res://Main Menu Scene/MainMenu.tscn",
			3,
			"[♪♪♪]"
		)
	SceneTransition.change_scene("res://Globals/text_transition.tscn")
	increase_day(1)
