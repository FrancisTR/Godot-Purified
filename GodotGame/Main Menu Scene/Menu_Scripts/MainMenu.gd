extends Control


## Called when the node enters the scene tree for the first time.
func _ready():
	
	#Reset global values
	GameData.day = 1

	GameData.username = ""

	GameData.inventory = []

	GameData.inventory_amount = {}

	#What is required to go to the next day
	GameData.inventory_requirement = {}

	GameData.charLock = false
	GameData.barryDespawned = false

	GameData.current_ui = ""
	GameData.current_scene = ""
	GameData.save_position = false
	GameData.player_position


	GameData.visitedWilderness = false
	GameData.talkToKid = false


	GameData.leaveVillageQuest = false



	#Dialogue related stuff
	GameData.QMain = false
	GameData.QWild = false
	GameData.madeProfit = false
	GameData.NPCgiveNoMore = false #Give items once and not dup
	#Quest is finished
	GameData.questComplete = {"Main": false, "Wild": false}
	GameData.QVillager = ""
	#TODO Add more if needed to stack of the items needed for NPC
	GameData.itemDialogue = [
		{
			"Name": "Twigs",
			"Value": 0
		},
		{
			"Name": "Rocks",
			"Value": 0
		},
		{
			"Name": "WaterBottle",
			"Value": 0
		},
		{
			"Name": "TinCans",
			"Value": 0
		}
	]

	GameData.villagersTalked = [
		{
			"Name": "Accept",
			"Talked": false
		},
		{
			"Name": "Anger",
			"Talked": false
		},
		{
			"Name": "Bargin",
			"Talked": false
		},
		{
			"Name": "Croak",
			"Talked": false
		},
		{
			"Name": "Denial",
			"Talked": false
		},
		{
			"Name": "Depress",
			"Talked": false
		},
		{
			"Name": "OldMan",
			"Talked": false
		}
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SoundControl.is_playing_theme("afternoon")


func _on_exit_button_pressed():
	SoundControl.is_playing_sound("button")
	get_tree().quit()


func _on_start_button_pressed():
	# If first time, go to tutorial
	SoundControl.is_playing_sound("button")
	
	if (GameData.visitTutorial == false):
		TextTransition.set_to_chained_timed(
			[
				"It is your first day at work.",
				"You then enter the building, waiting for further instructions.",
				"Then, an employee approaches you..."
			],
			"res://Main Menu Scene/tutorial.tscn",
			3,
			""
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
	else:
		TextTransition.set_to_chained_timed(
			[
				"It is your first day at work. (Knowing you know that it is not)",
				"You then enter the building, knowing exactly what to do.",
				"But first, they ask you for your name..."
			],
			"res://Main Menu Scene/EnterName.tscn",
			3,
			""
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")


func _on_option_button_pressed():
	SoundControl.is_playing_sound("button")
	#SceneTransition.change_scene("res://Main Menu Scene/Options.tscn")
	Utils.go_to_option_menu(get_tree().current_scene.scene_file_path)


func _on_credits_pressed():
	SoundControl.is_playing_sound("button")
	SceneTransition.change_scene("res://Main Menu Scene/credits.tscn")
