extends Node2D

@onready var npcs = [$NPC, $NPC2]

var signal_method = ""

var npc_positions = {
	'day1':[Vector2(318, 106), Vector2(997, 101)],
	'day2':[Vector2(218, 606), Vector2(497, 201)],
	'day3':[Vector2(48, 406), Vector2(997, 101)],
	'day4':[Vector2(218, 206), Vector2(897, 201)],
	'day5':[Vector2(318, 106), Vector2(997, 101)],
	'day6':[Vector2(218, 206), Vector2(897, 201)]
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	#SceneTransition.manual_fade.connect(go_to_next_day)
	$UI/Day.text = "Day " + str(GameData.day)
	for i in range(0, len(npcs)):
		npcs[i].position = npc_positions[('day'+str(GameData.day))][i]
		print(npcs[i], "is set to", npc_positions[('day'+str(GameData.day))][i])

func increase_day(amount):
	if(GameData.day+amount > 0):
		GameData.day += amount

func _on_open_leave_menu():
	$UI/LeaveVillage.show()

#**********TEST BUTTONS***********#
func _on_test_inc_1():
	print("+")
	increase_day(1)
	$UI/Day.text = "Day " + str(GameData.day)

func _on_test_dec_1():
	print("-")
	increase_day(-1)
	$UI/Day.text = "Day " + str(GameData.day)
#*********************************#

func _on_leave_village():
	#signal_method = "_on_leave_village()"
	#SceneTransition.fade_part1()
	#SceneTransition.change_scene()
	#TextTransition.set_to_click(
	TextTransition.set_to_click(
		"You leave the village and come back the next day",
		"res://World Scene/World.tscn",
		"Click To Continue"
	)
	SceneTransition.change_scene("res://Globals/text_transition.tscn")
	increase_day(1)
	

#func go_to_next_day():
	#if signal_method == "_on_leave_village()":
		#signal_method = ""
		#increase_day(1)
		#print(npcs[1].position)
		#print(npc_positions[('day'+str(GameData.day))])
		#SceneTransition.fade_part2()
