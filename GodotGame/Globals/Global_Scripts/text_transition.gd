extends CanvasLayer

func _ready():
	if prepped([$TextContent, $Instructions, $Timer]):
		$TextContent.text = TextTransitionData.text
		$Instructions.text = TextTransitionData.instructions
		$Timer.wait_time = TextTransitionData.duration
		if TextTransitionData.enable_timer:
			$Timer.wait_time = TextTransitionData.duration
			$Timer.start()
			
	SoundControl.stop_playing()
	

func prepped(nodes):
	for node in nodes:
		if node == null:
			return false
	return true

func set_to_click(text, path, instructions = ""):
	TextTransitionData.text = text
	TextTransitionData.texts.clear()
	TextTransitionData.is_chained = false
	set_all(path, 0, true, false, instructions)

func set_to_timed(text, path, duration, instructions = ""):
	TextTransitionData.text = text
	TextTransitionData.texts.clear()
	TextTransitionData.is_chained = false
	set_all(path, duration, false, true, instructions)
	
func set_to_chained_click(texts:Array, path, instructions = ""):
	TextTransitionData.texts.clear()
	TextTransitionData.texts = texts
	TextTransitionData.text = TextTransitionData.texts.pop_front()
	TextTransitionData.is_chained = true
	set_all(path, 0, true, false, instructions)
	
	
func set_to_chained_timed(texts:Array, path, duration, instructions = ""):
	TextTransitionData.texts.clear()
	TextTransitionData.texts = texts
	TextTransitionData.text = TextTransitionData.texts.pop_front()
	TextTransitionData.is_chained = true
	set_all(path, duration, false, true, instructions)
	
func set_all(path, duration, click, timer, instructions = ""):
	TextTransitionData.path = path
	TextTransitionData.duration = duration
	TextTransitionData.instructions = instructions
	TextTransitionData.enable_click = click
	TextTransitionData.enable_timer = timer

func _on_area_2d_input_event(viewport, event, shape_idx):
	if TextTransitionData.enable_click and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not TextTransitionData.is_chained:
			SceneTransition.change_scene(TextTransitionData.path)
		elif len(TextTransitionData.texts) > 0:
			TextTransitionData.text = TextTransitionData.texts.pop_front()
			SceneTransition.change_scene("res://Globals/text_transition.tscn")
		else:
			SceneTransition.change_scene(TextTransitionData.path)
			

func _on_timer_timeout():
	if TextTransitionData.enable_timer:
		if not TextTransitionData.is_chained:
			SceneTransition.change_scene(TextTransitionData.path)
		elif len(TextTransitionData.texts) > 0:
			TextTransitionData.text = TextTransitionData.texts.pop_front()
			SceneTransition.change_scene("res://Globals/text_transition.tscn")
		else:
			SceneTransition.change_scene(TextTransitionData.path)
		
	
	
