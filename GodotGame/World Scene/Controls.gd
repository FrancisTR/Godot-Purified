extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Top/Label.text = RemapperData.get_keymap_name("Up")
	$Left/Label.text = RemapperData.get_keymap_name("Left")
	$Mid/Label.text = RemapperData.get_keymap_name("Down")
	$Right/Label.text = RemapperData.get_keymap_name("Right")
	$Sprint/Label.text = RemapperData.get_keymap_name("Sprint")
	
	$Map/Label.text = RemapperData.get_keymap_name("Map")
	$Inventory/Label.text = RemapperData.get_keymap_name("Inventory")


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
