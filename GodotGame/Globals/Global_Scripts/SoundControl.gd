extends Node
var afternoonTheme = preload("res://Sounds_and_Music/OST/Afternoon Tadpole.mp3")
var croakTheme = preload("res://Sounds_and_Music/OST/Croak of the Fireflies.mp3")
var WoodsyTheme = preload("res://Sounds_and_Music/OST/Woodsy Labyrinth.mp3")

var button_sound = preload("res://Sounds_and_Music/ButtonClick.wav")
var dialogue_sound = preload("res://Sounds_and_Music/DialogueSound.wav")
var pickupItem_sound = preload("res://Sounds_and_Music/pickupItem.wav")
var crafted_sound = preload("res://Sounds_and_Music/Crafted_Achieve.wav")

#This func is called in the _process
func is_playing_theme(theme):
	if (!$Background.is_playing()):
		if theme == "main":
			$Background.stream = WoodsyTheme
		elif theme == "croak":
			$Background.stream = croakTheme
		elif theme == "afternoon":
			$Background.stream = afternoonTheme
			
		$Background.play()

func stop_playing():
	$Background.stop()
		
#This func is called in the _process
func is_playing_sound(theme):
	if theme == "button":
		$Sound.stream = button_sound
	elif theme == "dialogue":
		$Sound.stream = dialogue_sound
	elif theme == "pickup":
		$Sound.stream = pickupItem_sound
	elif theme == "crafted":
		$Sound.stream = crafted_sound
		
	$Sound.play()
