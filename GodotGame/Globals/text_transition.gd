extends CanvasLayer


func _ready():
	if prepped([$TextContent, $Instructions, $Timer]):
		$TextContent.text = TextTransitionData.text
		$Instructions.text = TextTransitionData.instructions
		$Timer.wait_time = TextTransitionData.duration
		if TextTransitionData.enable_timer:
			$Timer.wait_time = TextTransitionData.duration
			$Timer.start(-1)

func prepped(nodes):
	for node in nodes:
		if node == null:
			return false
	return true

func set_to_click(text, path, instructions = ""):
	set_all(text, path, 0, true, false, instructions)

func set_to_timed(text, path, duration, instructions = ""):
	set_all(text, path, duration, false, true, instructions)
	
func set_all(text, path, duration, click, timer, instructions = ""):
	TextTransitionData.text = text
	TextTransitionData.path = path
	TextTransitionData.duration = duration
	TextTransitionData.instructions = instructions
	TextTransitionData.enable_click = click
	TextTransitionData.enable_timer = timer
	TextTransitionData.texts.clear()
	
func set_to_chained_click(texts:Array, path, instructions = ""):
	pass
	
func set_to_chained_timed(texts:Array, path, duration, instructions = ""):
	pass
	
func set_all_chained():
	pass
	
func reset():
	if prepped([$TextContent, $Instructions]):
		$TextContent.text = ""
		$Instructions.text = ""

func _on_area_2d_input_event(viewport, event, shape_idx):
	if TextTransitionData.enable_click and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		SceneTransition.change_scene(TextTransitionData.path)

func _on_timer_timeout():
	pass
	if TextTransitionData.enable_timer:
		SceneTransition.change_scene(TextTransitionData.path)
		
	
	
