extends Control # Originally Node2D; probably will conflict


## Called when the node enters the scene tree for the first time.
func _ready():
	
	#Reset global values
	GameData.day = 1

	GameData.twigItem = 0

	GameData.username = ""

	GameData.charLock = false


	GameData.visitedWilderness = false

	#Spawn the item once in the wilderness. Prevents duplication
	GameData.itemSpawnOnce = false





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

	# No buttons are selected until any arrow / tab is pressed.
	# Note: hover is not very visible right now until you select something.
	$InvisibleInputButton.grab_focus()
	#$StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SoundControl.is_playing_theme("main")
	pass


func _on_exit_button_pressed():
	SoundControl.is_playing_sound("button")
	get_tree().quit()


func _on_start_button_pressed():
	# If first time, go to tutorial
	SoundControl.is_playing_sound("button")
	if (GameData.visitTutorial == false):
		SceneTransition.change_scene("res://Main Menu Scene/tutorial.tscn")
	else:
		SceneTransition.change_scene("res://Main Menu Scene/EnterName.tscn")


func _on_option_button_pressed():
	SoundControl.is_playing_sound("button")
	SceneTransition.change_scene("res://Main Menu Scene/Options.tscn")


func _on_credits_pressed():
	SoundControl.is_playing_sound("button")
	SceneTransition.change_scene("res://Main Menu Scene/credits.tscn")
