extends Node2D


@onready var npcs = [$NPC/Talia]

func _ready():
	GameData.visitTutorial = true

# Theme songs
func _process(delta):
	#TODO: Add theme song based on the day
	SoundControl.is_playing_theme("afternoon")
	#TODO: Testing

func _on_open_map():
	$"Map/Map Camera".make_current()
	$Other/CharacterBody2D.show_map_icon()
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
	for npc in npcs:
		npc.hide_map_icon()
		npc.hide_notif()
	#for i in range(0, len(npcs)):
		#npcs[i].hide_map_icon()
