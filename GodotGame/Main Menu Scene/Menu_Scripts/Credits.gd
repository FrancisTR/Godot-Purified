extends Control

#Credit: https://www.reddit.com/r/godot/comments/brg8z3/i_made_a_simple_credits_scene_to_share_with_you/
const section_time = 4.0
const line_time = .9
const base_speed = 100
const speed_up_multiplier = 5.0
const title_color = Color.AQUAMARINE

var scroll_speed = base_speed
var speed_up = false

@onready var line = $Line
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
		"A game by the Sandboa Team"
	],[
		"Programming",
		"Programmer Name",
		"Programmer Name 2"
	],[
		"Art",
		"Artist Name"
	],[
		"Music",
		"Musician Name"
	],[
		"Sound Effects",
		"SFX Name"
	],[
		"Testers",
		"Name 1",
		"Name 2",
		"Name 3"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
	],[
		"Special thanks",
		"My parents",
		"My friends",
		"My pet rabbit"
	]
]


func _ready():
	SoundControl.stop_playing()


func _process(delta):
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
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
