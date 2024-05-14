extends Control

#Credit: https://www.reddit.com/r/godot/comments/brg8z3/i_made_a_simple_credits_scene_to_share_with_you/
const section_time = 2.0
const line_time = .5
const base_speed = 100
const speed_up_multiplier = 5.0
const title_color = Color.AQUAMARINE

var scroll_speed = base_speed
var speed_up = false

@onready var line = $Line
@onready var back = $BackMain
var started = false
var finished = false

var section
var section_next = true
var section_timer = 0.0
var line_timer = 0.0
var curr_line = 0
var lines = []

var credits = [
	[
		"Game Producer",
		"Francis T."
	],
	
	[
		"Associate Producer",
		"John T."
	],
	
	[
		"Programming Team",
		"Francis T.",
		"John T.",
		"Nick B.",
		"Thien N."
	],
	
	[
		"Music Producer",
		"John T."
	],
	
	[
		"Sound Producer",
		"Nick B."
	],
	
	
	[
		"Art Producers / Designer",
		"Michelle M.",
		"Bev A.",
		"John T.",
		"Francis T.",
	],
	
	[
		"Writers",
		"Ben M.",
		"Zach S.",
		"John T.",
	],
	
	[
		"Voice Director",
		"Mike I."
	],
	[
		"Voice Actors",
		"Main Character: Mike I.",
		"Talia: Michelle M.",
		"Danny: Ben M.",
		"Angelica: Michelle M.",
		"Derek: Bev A.",
		"Antonio: John T.",
		"Barry: Mike I.",
		"Old Man Tommy: Mike I.",
		"Rano: Mike I.",
		"Leap: Mike I.",
		"Croak: Michelle M.",
		"Hop: Michelle M.",
		"Ribbit: Michelle M.",
	],
	
	[
		"Game Testers",
		"Braden",
		"Trinity L.",
		"Emily T.",
		"Maria Q.",
		"Zin" ,
		"Cheng",
		"Jasper",
		"Jake H.",
		"Anthony" ,
		"Julianne",
		"Mrs. M.",
		"Zach",
		"Dr. Sky",
		"John N.",
		"Mason",
		"Xarieh",
		"Drew J.",
		"Nicholas Santa Claus",
		"GT1",
		"Ovsloth",
		"Hunter V.",
		"Ophelia",
		"Nathan",
		"Nathan",
		"Emily",
		"Lily",
		"Lucky",
		"Carson",
		"Landon",
		"Jack",
		"Carson",
		"Carcar",
		"Maddie",
		"Tyler",
		"GT2",
		"Carson",
		"Elijah",
		"Lucy",
		"Piperrr",
		"Nadal",
		"Narayan",
		"Harper",
		"Daisy",
		"Colton",
		"Clara",
		"Savanna",
		"Valentina",
		"Issac",
		"Cathan",
		"Mason",
		"Jack",
		"TJ",
		"Tharun",
		"Christopher",
		"Keagah",
		"Evalynn",
		"Ana",
		"Ben B.",
		"Monk",
		"Leo",
		"Kevin",
		"Michelle",
		"Cheeta",
		"Andrea",
		"Yaretzy",
		"Zach",
		"Ben M.",
		"Cat",
		"Vader The King",
	],
	
	[
		"Special Thanks",
		"Lake Middle School",
		"Dr. Sky (Anderson Sky)",
		"Ralph and Jack"
	],
	
	[
		"Music OSTs",
		"Afternoon Tadpole",
		"Croak of the Fireflies",
		"Woodsy Labyrinth",
		"Leaping to a New Chapter"
	],
	
	[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Sound produced using jsfxr",
		"https://sfxr.me/",
		"",
		"Art developed using:",
		"Pixelorama",
		"https://orama-interactive.itch.io/pixelorama",
		"Procreate",
		"https://procreate.com/",
		"",
		"Music produced using Flat.io",
		"",
		"Fonts from 1001 Fonts",
		"https://www.1001fonts.com/",
		"",
		"Audacity",
		"https://www.audacityteam.org/",
	],
	[
		"Asset used from itch.io",
		"UI and Icons by Crusenho",
		"https://creativecommons.org/licenses/by/4.0/",
		"",
		"World Assets by Cup Nooble (Assets modified for this game)",
		"(https://cupnooble.itch.io/)",
		"",
		"World Assets by CraftPix.net (Assets modified for this game)",
		"(https://craftpix.net/freebies/free-swamp-game-tileset-pixel-art/)",
	],
	
	[
		"Other Resources",
		"Walking Sound by Joao Janz",
	],
	
	[
		"A game created for DIMA 346 'Game Production' at the University of St. Thomas",
	],
]


func _ready():
	SoundControl.stop_playing()
	back.grab_focus()


func _process(delta):
	SoundControl.is_playing_theme("Credits")
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.position.y -= scroll_speed
			if l.position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")
		$Thankyou.visible = true
		$AnimationPlayer.play("ThankYou")
		await get_tree().create_timer(5).timeout
		SoundControl.stop_playing()
		SceneTransition.change_scene("res://Main Menu Scene/MainMenu.tscn")

func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.set("theme_override_colors/font_color", title_color)
	$".".add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false


func _on_back_main_pressed():
	SoundControl.stop_playing()
	SoundControl.is_playing_sound("button")
	SceneTransition.change_scene("res://Main Menu Scene/MainMenu.tscn")
