extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Top/Label.text = InputMap.action_get_events("Up")[0].as_text().replace("(Physical)", "").strip_edges(true, true)
	$Left/Label.text = InputMap.action_get_events("Left")[0].as_text().replace("(Physical)", "").strip_edges(true, true)
	$Mid/Label.text = InputMap.action_get_events("Down")[0].as_text().replace("(Physical)", "").strip_edges(true, true)
	$Right/Label.text = InputMap.action_get_events("Right")[0].as_text().replace("(Physical)", "").strip_edges(true, true)
	$Sprint/Label.text = InputMap.action_get_events("Sprint")[0].as_text().replace("(Physical)", "").strip_edges(true, true)
	
	$Map/Label.text = InputMap.action_get_events("Map")[0].as_text().replace("(Physical)", "").strip_edges(true, true)
	$Inventory/Label.text = InputMap.action_get_events("Inventory")[0].as_text().replace("(Physical)", "").strip_edges(true, true)


func _process(delta):
	#Make it look cool
	if Input.is_action_pressed("Up"):
		$Top.modulate = "#009462"
	else:
		$Top.modulate = "#ffffff"
		
	
	
	if Input.is_action_pressed("Left"):
		$Left.modulate = "#009462"
	else:
		$Left.modulate = "#ffffff"
	
	
	
	if Input.is_action_pressed("Down"):
		$Mid.modulate = "#009462"
	else:
		$Mid.modulate = "#ffffff"
	
	
	
	if Input.is_action_pressed("Right"):
		$Right.modulate = "#009462"
	else:
		$Right.modulate = "#ffffff"
	
	
	
	if Input.is_action_pressed("Sprint"):
		$Sprint.modulate = "#009462"
	else:
		$Sprint.modulate = "#ffffff"
	
	
	
	if Input.is_action_pressed("Map"):
		$Map.modulate = "#009462"
	else:
		$Map.modulate = "#ffffff"
	
	
	
	if Input.is_action_pressed("Inventory"):
		$Inventory.modulate = "#009462"
	else:
		$Inventory.modulate = "#ffffff"
