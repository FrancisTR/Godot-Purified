extends Control

@onready var dialogue_box = $Dialogue/DialogueBox

#Leaping Dialogue in the VOID
var dialogue_voices = [
	
	# Days 1 (COMPLETE)
	{
		"Children": [
			{"Name": "LL", "Start": "0:55", "End": "0:59.5", "Emotion": ""},
			{"Name": "LL", "Start": "0:21.8", "End": "0:25.5", "Emotion": ""},
			{"Name": "Main", "Start": "1:27.13", "End": "1:32.44", "Emotion": "Surprised"},
			
			{"Name": "LL", "Start": "0:42.3", "End": "0:44", "Emotion": ""},
			{"Name": "Croak", "Start": "0:25.6", "End": "0:29.8", "Emotion": "Happy"},
			{"Name": "LL", "Start": "0:00", "End": "0:03", "Emotion": "Happy"},
			
			{"Name": "Main", "Start": "1:33.20", "End": "1:34.75", "Emotion": "Happy"},
			{"Name": "LL", "Start": "1:01.5", "End": "1:06", "Emotion": ""},
			{"Name": "LL", "Start": "1:06.3", "End": "1:13", "Emotion": "Happy"},
		]
	},
	
	
	
	
	
	
	
	
	# Days 2 (COMPLETE)
	{
		"Children": [
			{"Name": "LL", "Start": "0:55", "End": "0:59.5", "Emotion": ""},
			{"Name": "LL", "Start": "0:21.8", "End": "0:25.5", "Emotion": ""},
			{"Name": "Main", "Start": "03:29.26", "End": "03:32.39", "Emotion": "Sad"},
			
			{"Name": "LL", "Start": "0:05", "End": "0:07", "Emotion": "Happy"},
			{"Name": "Main", "Start": "03:33.14", "End": "03:36.21", "Emotion": ""},
			{"Name": "LL", "Start": "1:34.6", "End": "1:41.5", "Emotion": "Happy"},
			
			{"Name": "LL", "Start": "0:32", "End": "0:34.5", "Emotion": ""},
			{"Name": "LL", "Start": "0:45", "End": "0:46.5", "Emotion": ""},
			{"Name": "Croak", "Start": "0:36.4", "End": "0:39", "Emotion": "Happy"},
		]
	},
	
	
	
	
	
	
	
	
	
	# Days 3 (COMPLETE)
	{
		"Children": [
			{"Name": "LL", "Start": "0:55", "End": "0:59.5", "Emotion": ""},
			{"Name": "Main", "Start": "04:21.11", "End": "04:25.02", "Emotion": "Sad"},
			{"Name": "LL", "Start": "1:55", "End": "2:01.5", "Emotion": ""},
			
			{"Name": "Main", "Start": "04:26.03", "End": "04:28.36", "Emotion": ""},
			
			{"Name": "LL", "Start": "0", "End": "0", "Emotion": ""},
			
			{"Name": "LL", "Start": "0:14", "End": "0:18", "Emotion": "Surprised"},
			
			{"Name": "LL", "Start": "0:47.7", "End": "0:50", "Emotion": "Sad"},
			{"Name": "LL", "Start": "2:03.4", "End": "2:07.6", "Emotion": "Anger"},
			{"Name": "LL", "Start": "2:07.6", "End": "2:12.5", "Emotion": "Happy"},
			{"Name": "LL", "Start": "0:35.8", "End": "0:38", "Emotion": "Happy"},
		]
	},
	
]






var dialogue_voiceSpecific
var audioList = {
	"Main": "res://Assets/DialogueVoice/MC.mp3",
	"LL": "res://Assets/DialogueVoice/LLE.mp3",
	"Croak": "res://Assets/DialogueVoice/Croak.mp3",
}

var emotionList = {
	"Main": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"LL": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Croak": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
}
var load_audio
var audioCount = -1










# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO Add more days?
	if not dialogue_box.running:
		if GameData.day == 1:
			dialogue_box.start("Children")
		elif GameData.day == 2:
			dialogue_box.start("Children2")
		elif GameData.day == 3:
			dialogue_box.start("Children3")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#TODO: Add theme?
func _process(delta):
	#Appear the game username in dialogue (Only Appears in NPC interaction)
	Utils.character_list.characters[0].name = GameData.username
	if dialogue_box.running:
		if ($Dialogue/DialogueBox.speaker.text == GameData.username):
			$CharacterIMG.texture = Utils.character_list.characters[0].image
	#SoundControl.is_playing_theme("afternoon")


func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO Stop audio once we continue
	
	#TODO: Set up the dialogue voices
	SoundControl.dialogue_audio_stop() #Stop the audio if next dialogue
	#print(audioCount)
	print("Dialogue Node: "+str(node_type))
	if str(node_type) == str(1):
		audioCount += 1
	if (audioCount < len(dialogue_voices[GameData.day - 1]["Children"])):
		print("Audio Count: "+str(audioCount))
		dialogue_voiceSpecific = dialogue_voices[GameData.day - 1]["Children"][audioCount]
	
	SoundControl.is_playing_sound("button")
	dialogue_box.custom_effects[0].skip = true
	dialogue_box.show_options()
	
	if $Dialogue/DialogueBox.speaker.text != "":
		var idx
		if Utils.char_dict.keys().find(str($Dialogue/DialogueBox.speaker.text)) != -1:
			idx = Utils.char_dict[str($Dialogue/DialogueBox.speaker.text)]
		else:
			#Its the main character
			idx = Utils.char_dict["Main"]
			
		#var CharacterVoice = audioList[dialogue_voiceSpecific["Emotion"]]
		#if (audioList[dialogue_voiceSpecific["Emotion"]] == ""):
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		#else: #Emotion
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		$CharacterIMG.texture = Utils.character_list.characters[idx].image


func _on_voice_pressed():
	print("Play Audio")
	var CharacterVoice = audioList[dialogue_voiceSpecific["Name"]]
	##TODO: PLay audio
	SoundControl.play_audio(CharacterVoice, dialogue_voiceSpecific["Start"], dialogue_voiceSpecific["End"]) # Node, string, int, int
	dialogue_box.show_options()


func _on_dialogue_box_dialogue_ended():
	audioCount = -1 #Reset audio index
	SoundControl.dialogue_audio_stop() #Stop the audio if next dialogue
	$Dialogue/Voice.visible = false
	$CharacterIMG.visible = false
	$ShowItemRequest.visible = false
	#Go to wilderness
	SceneTransition.change_scene("res://World Scene/Wilderness.tscn")


func _on_dialogue_box_dialogue_signal(value):
	if value == "Negate":
		$Dialogue/Voice.visible = true
	if value == "VoiceOff":
		$Dialogue/Voice.visible = false
	if value == "Item":
		#TODO: Add more item to show?
		if GameData.day == 1:
			$ShowItemRequest.texture = load("res://Assets/Custom/Items/WaterBottleSpecial.png")
		elif GameData.day == 2:
			$ShowItemRequest.texture = load("res://Assets/Custom/CraftingTable.png")
		$ShowItemRequest.visible = true
	else:
		$ShowItemRequest.visible = false
