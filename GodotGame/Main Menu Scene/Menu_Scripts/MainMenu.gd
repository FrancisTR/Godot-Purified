extends Control
@onready var start_button = $StartButton


## Called when the node enters the scene tree for the first time.
func _ready():
	SoundControl.stop_playing()
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

	GameData.visitTutorial = false
	GameData.visitedWilderness = false
	GameData.talkToKid = false


	GameData.leaveVillageQuest = false



	#Dialogue related stuff

	GameData.QMain = {}
	GameData.QWild = false
	GameData.QMainLocationIdx = {}
	GameData.well = false #Is the well fixed?
	GameData.madeProfit = false
	GameData.NPCgiveNoMore = false #Give items once and not dup
	#Quest is finished
	GameData.questComplete = {"Main": false, "Wild": false}
	GameData.Discount = ""

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
		},
		{
			"Name": "WaterFilter",
			"Value": 0
		}
	]

	GameData.QVillager = {}

	GameData.villagersIndex = {
		"Accept": 0,
		"Anger": 1,
		"Bargin": 2,
		"Croak": 3,
		"Denial": 4,
		"Depress": 5,
		"OldMan": 6,
		"Talia": 7,
		
		"Rano": 8,
		"Ribbit": 9,
		"Hop": 10,
		"Leap": 11
	}

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
		},
		{
			"Name": "Talia",
			"Talked": false
		}
	]
	
	GameData.get_item_posX = null
	GameData.get_item_posY = null
	
	start_button.grab_focus()


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
		TextTransition.set_to_chained_click(
			[
				"It is your first day at work.",
				"You enter the building, waiting for further instructions.",
				"Then, an employee approaches you..."
			],
			"res://Main Menu Scene/tutorial.tscn",
			"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
	
	else:
		TextTransition.set_to_chained_timed(
			[
				"It is your first day at work. (Knowing you know that it is not)",
				"You enter the building, knowing exactly what to do.",
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
