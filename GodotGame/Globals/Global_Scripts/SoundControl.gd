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



#Dialogue functions
func play_audio(dialogue, start, end):
	
	if start == "":
		return
	if end == "":
		return
	if start == "0":
		start = "0:00"
	if end == "end":
		end = "0:"+str($DialogueAudio.stream.get_length())
	
	var s1 = float(start.split(":")[0])
	var s2 = float(start.split(":")[1])
	var e1 = float(end.split(":")[0])
	var e2 = float(end.split(":")[1])
	print(s1,",", s2, " ||| ", e1,",", e2)
	print(get_time(s1, s2), " ||| ", get_time(e1, e2))
	
	
	$Timer.wait_time = get_time(e1, e2)-get_time(s1, s2)
	$DialogueAudio.stream = load(dialogue)
	$DialogueAudio.play(get_time(s1, s2))
	$Timer.start()

func get_time(minutes, seconds):
	return (minutes*60)+seconds

func _on_timer_timeout():
	$DialogueAudio.stop()

func dialogue_audio_stop():
	$DialogueAudio.stop()


