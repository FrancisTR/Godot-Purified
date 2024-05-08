extends Node2D


@onready var npcs = [$NPC/Talia]

func _ready():
	GameData.visitTutorial = true
	
	if GameData.save_position:
		$Other/CharacterBody2D.position = GameData.player_position
		GameData.save_position = false
	
	#Display Keys in UIs
	#Movement
	$DisplayControls/Movement/Up/Label.text = $DisplayControls/OptionsHidden/RemapContainer/UpMapButton.text.replace("*", "")
	$DisplayControls/Movement/Down/Label.text = $DisplayControls/OptionsHidden/RemapContainer/DownMapButton.text.replace("*", "")
	$DisplayControls/Movement/Left/Label.text = $DisplayControls/OptionsHidden/RemapContainer/LeftMapButton.text.replace("*", "")
	$DisplayControls/Movement/Right/Label.text = $DisplayControls/OptionsHidden/RemapContainer/RightMapButton.text.replace("*", "")
	$DisplayControls/Movement/Shift/Label.text = $DisplayControls/OptionsHidden/RemapContainer/SprintButton.text.replace("*", "")
	
	#Map
	$DisplayControls/Map/MapKey/Label.text = $DisplayControls/OptionsHidden/RemapContainer/MapButton.text.replace("*", "")
	
	#Interaction
	$DisplayControls/Interaction/InteractionKey/Label.text = $DisplayControls/OptionsHidden/RemapContainer/InteractionButton.text.replace("*", "")
	
	#Inventory
	$DisplayControls/Inventory/InventoryKey/Label.text = $DisplayControls/OptionsHidden/RemapContainer/InventoryButton.text.replace("*", "")
	
	

# Theme songs
func _process(delta):
	#TODO: Add theme song based on the day
	SoundControl.is_playing_theme("afternoon")

func _on_open_map():
	$"Map/Map Camera".make_current()
	$Other/CharacterBody2D.show_map_icon()


	for npc in npcs:
		npc.show_map_icon()
		print(npc.name, " vs ", GameData.QVillager)
		if not GameData.villagersTalked[GameData.villagersIndex[npc.name]].Talked:
			npc.show_notif("exclamation")
		elif GameData.QMain.keys().find(npc.name) != -1:
			if npc.name == GameData.QVillager[str(npc.name)] and GameData.QMain[npc.name] == false:
				npc.show_notif("question")
		
func _on_close_map():
	$Other/CharacterBody2D.hide_map_icon()
	for npc in npcs:
		npc.hide_map_icon()
		npc.hide_notif()
