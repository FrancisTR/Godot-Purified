extends Node2D

@onready var npcs = [$NPCs/Denial, $NPCs/Anger, $NPCs/Bargin,
					$NPCs/Depress, $NPCs/Accept, $NPCs/Croak, $NPCs/OldMan]

var signal_method = ""
var stopMusic = false

#@export var NumTwigs: int = 0

#TODO: Add cord for all NPCs
var npc_positions = {
	'day1':[Vector2(2721, -234), Vector2(1715, 514), Vector2(1332, -81), Vector2(-483, -705), Vector2(1861, -380), Vector2(862, -476), Vector2(-212, 168)],
	'day2':[Vector2(108, -353), Vector2(497, 201), Vector2(731, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(862, -476), Vector2(-212, 168)],
	'day3':[Vector2(48, 406), Vector2(997, 101), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	
	#DLC
	'day4':[Vector2(218, 206), Vector2(897, 201), Vector2(999999999, 99999999), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	
	'day5':[Vector2(318, 106), Vector2(997, 101), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	
	'day6':[Vector2(218, 206), Vector2(897, 201), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	
	'day7':[Vector2(318, 106), Vector2(997, 101), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	'day8':[Vector2(218, 206), Vector2(897, 201), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	'day9':[Vector2(218, 206), Vector2(897, 201), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)],
	'day10':[Vector2(218, 206), Vector2(897, 201), Vector2(771, -478), Vector2(-483, -705), Vector2(1861, -380), Vector2(999999999, 999999999), Vector2(-212, 168)]
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.charLock = false
	
	if GameData.visitedWilderness:
		$Other/CharacterBody2D.position = Vector2(863, 1270)
		GameData.visitedWilderness = false
	if GameData.save_position:
		$Other/CharacterBody2D.position = GameData.player_position
		GameData.save_position = false
		
	#TODO: Make inventory system into its own scene w/ graphics
	#$UI/Inventory.text = "Inventory\nTwigs: " + str(NumTwigs)
	#SceneTransition.manual_fade.connect(go_to_next_day)
	$UI/Day.text = "Day " + str(GameData.day)
	#$NPCs/PressForDialogue.text = "s"
	#$NPC/PressForDialogue.text = "s"
	for i in range(0, len(npcs)):
		var day = GameData.day
		if GameData.day > 10:
			day = 10
		
		# Set position
		npcs[i].position = npc_positions[('day'+str(day))][i]
		print(npcs[i], "is set to", npc_positions[('day'+str(day))][i])


# Theme songs
func _process(delta):
	#TODO: Add theme song based on the day
	if (stopMusic == false):
		if GameData.day <= 2:
			SoundControl.is_playing_theme("afternoon")
		elif GameData.day >= 3:
			SoundControl.is_playing_theme("main")




func increase_day(amount):
	if(GameData.day+amount > 0):
		GameData.day += amount

func _on_open_leave_menu():
	print("leaving?")
	$UI/LeaveVillage.hide()
	$UI/LeaveVillage/QuotaError.hide()
	$UI/LeaveVillage/ColorRect.hide()
	
	
	#TODO: Add more days' restriction
	#If the quota is not met, show a UI error message
	#Check to see if the player has talked to everyone
	var TalkedToVillagersCount = 0
	for i in range (len(GameData.villagersTalked)):
		if (GameData.villagersTalked[i]["Talked"] == true):
			TalkedToVillagersCount = TalkedToVillagersCount + 1
	print(TalkedToVillagersCount)


	if ((GameData.inventory_amount.keys().find("WaterBottleSpecial") == -1 or TalkedToVillagersCount != 7 or GameData.questComplete["Main"] == false or GameData.questComplete["Wild"] == false) and GameData.day == 1):
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/QuotaError.show()
	elif ((GameData.inventory_amount.keys().find("BoilingPot") == -1 or TalkedToVillagersCount != 7 or GameData.questComplete["Main"] == false or GameData.questComplete["Wild"] == false) and GameData.day == 2):
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/QuotaError.show()
	
	#TODO: After day 3 and beyond, you only need to talk to 6 villagers
	elif ((GameData.inventory_amount.keys().find("WaterFilter") == -1 or TalkedToVillagersCount != 6 or GameData.questComplete["Main"] == false or GameData.questComplete["Wild"] == false) and GameData.day == 3):
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/QuotaError.show()
	elif (TalkedToVillagersCount != 5 and GameData.day == 4):
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/QuotaError.show()
	elif (TalkedToVillagersCount != 6 and (GameData.day == 5 or GameData.day == 6)):
		$UI/LeaveVillage.show()
		$UI/LeaveVillage/QuotaError.show()
	elif (TalkedToVillagersCount != 1 and (GameData.day == 7)):
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
	stopMusic = true
	SoundControl.stop_playing()
	#TODO: 3 days for MVP. 10 for full game
	if GameData.day == 6: #Entering Day 7...
		TextTransition.set_to_chained_click(
			[
				"You leave the village and come back the next day.",
				"However, before you start to work, Talia approaches you..."
			],
			"res://Main Menu Scene/tutorial.tscn",
			"Click To Continue"
		)
	elif GameData.day < 3:
		SoundControl.stop_playing()
		TextTransition.set_to_click(
			"You leave the village and come back the next day",
			"res://World Scene/World.tscn",
			"Click To Continue"
		)
	else:
		TextTransition.set_to_chained_timed(
			[
				"To be continued...",
				"Thank you for playing our Demo."
			],
			"res://Main Menu Scene/MainMenu.tscn",
			3,
			"[Please provide feedback in our Itch.io Page]"
		)
	SceneTransition.change_scene("res://Globals/text_transition.tscn")
	increase_day(1)

func _on_open_map():
	$"Map/Map Camera".make_current()
	$Other/CharacterBody2D.show_map_icon()
	$"Map/The Wilderness".show()
	$"Map/Village Exit".show()
	#for i in range(0, len(npcs)):
		#npcs[i].show_map_icon()
	#TODO Edit based on the day's dialogue
	for npc in npcs:
		npc.show_map_icon()
		print(npc.name, " vs ", GameData.QVillager)
		if not GameData.villagersTalked[GameData.villagersIndex[npc.name]].Talked:
			npc.show_notif("exclamation")
		elif npc.name == GameData.QVillager and not GameData.questComplete["Main"]:
			npc.show_notif("question")
		
func _on_close_map():
	$Other/CharacterBody2D.hide_map_icon()
	$"Map/The Wilderness".hide()
	$"Map/Village Exit".hide()
	for npc in npcs:
		npc.hide_map_icon()
		npc.hide_notif()
	#for i in range(0, len(npcs)):
		#npcs[i].hide_map_icon()
