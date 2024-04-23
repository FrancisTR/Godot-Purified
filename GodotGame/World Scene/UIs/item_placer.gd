extends Node2D

signal pos_test
signal toggle_dev_tool
signal send_to_shadow_realm
signal reset_pressed

var tin_can_scene = preload("res://World Scene/Items/TinCan.tscn")
var bottle_scene = preload("res://World Scene/Items/WaterBottle.tscn")
var rock_scene = preload("res://World Scene/Items/rock.tscn")
var twig_scene = preload("res://World Scene/Items/twig.tscn")
var dev_mode = false
var camera_speed = 5
var zoom_speed = 0.03
var zoom_max = 0.22
var zoom_min = 3
var mode = "add"
var non_static_temp = []
var current_pseudo = ""
#var pseudo_scenes = {
	#"Tin Can": tin_can_scene,
	#"Bottle": bottle_scene,
	#"Rock": rock_scene,
	#"Twig": twig_scene
#}
var pseudo_scenes = [tin_can_scene, bottle_scene, rock_scene, twig_scene]


#NOTE: If you want to remove this in the future you must remove:
#		 - _on_item_placer_pos_test in wilderness.gd
#		 - _on_toggle_dev_tool in wilderness.gd
#		 - ' and GameData.current_ui != "dev" ' in ChacterMain.gd
#		 - Item Placer nodes in wilderness.tscn
#		 - PseudoItems node in wilderness.tscn
func _ready():
	$Item.add_item("Tin Can")
	$Item.add_item("Bottle")
	$Item.add_item("Rock")
	$Item.add_item("Twig")
	var scene = pseudo_scenes[0]
	var instance = scene.instantiate()
	$Cursor.add_child(instance)
	non_static_temp = create_temp_non_static_items()

func _input(event):
	if Input.is_action_just_released("_dev_tool"):
		if GameData.current_ui != "dev" && GameData.current_ui != "":
			return
		dev_mode = not dev_mode
		if dev_mode:
			$Camera2D.make_current()
			GameData.current_ui = "dev"
			print(GameData.current_ui)
		else:
			GameData.current_ui = ""
		toggle_dev_tool.emit()
		
	if dev_mode:
		if event is InputEventMouseButton:
			if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.pressed:
				$"Day Input".get_line_edit().release_focus()
				$"Edit Day".get_line_edit().release_focus()
				print(get_local_mouse_position())
				if get_local_mouse_position().x > 315:
					pos_test.emit()
			if event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_UP:
				$Camera2D.zoom.x += zoom_speed
				$Camera2D.zoom.y += zoom_speed
			if event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
				$Camera2D.zoom.x -= zoom_speed
				$Camera2D.zoom.y -= zoom_speed
			$Camera2D.zoom.x = clamp($Camera2D.zoom.x, zoom_max, zoom_min)
			$Camera2D.zoom.y = clamp($Camera2D.zoom.y, zoom_max, zoom_min)

func _process(delta):
	current_pseudo = str($Item.selected)+"$"+str($item_id.value)+"$"+str($"Edit Day".value)
	if $Cursor.get_child_count() == 1 and $Cursor.get_child(0).name != current_pseudo:
		$Cursor.remove_child($Cursor.get_child(0))
		var scene = pseudo_scenes[int(current_pseudo.split("$")[0])]
		var instance = scene.instantiate()
		instance.name = current_pseudo
		instance.modulate = Color(0.5,1,0.5)
		$Cursor.add_child(instance)
	if $Cursor.get_child_count() == 1:
		if get_local_mouse_position().x > 315:
			$Cursor.get_child(0).modulate = Color(0.5, 1, 0.5)
		else:
			$Cursor.get_child(0).modulate = Color(1, 0.5, 0.5)
	$Cursor.get_child(0).position = get_local_mouse_position()
	
	if $Item.selected == 3:
		$item_id.max_value = 24
	else:
		$item_id.max_value = 13
	if dev_mode:
		if GameData.current_ui != "dev" && GameData.current_ui != "":
			return
		if Input.is_action_pressed("Up"):
			$Camera2D.position.y -= camera_speed
		if Input.is_action_pressed("Down"):
			$Camera2D.position.y += camera_speed
		if Input.is_action_pressed("Left"):
			$Camera2D.position.x -= camera_speed
		if Input.is_action_pressed("Right"):
			$Camera2D.position.x += camera_speed

func set_camera_position(position):
	$Camera2D.position = position

#func _on_modify_check_button_pressed():
	#mode = "modify"
	#print($Item.selected)
	#var test = "res://Globals/test.txt"
	#var file = FileAccess.open(test, FileAccess.WRITE)
	#file.store_string("asdfasf\n")
	#file.store_string("aaaaaaaaaaaa\n")
	#file.store_string("tttttttttttttttt\n")

func _on_save_pressed():
	$"Are you sure GUI".show()
	

func _on_yes_pressed():
	save_all()

func _on_no_pressed():
	$"Are you sure GUI".hide()

func save_all():
	for item in GameData.pseudo_items:
		var item_index = int(item.name.split("$")[0])
		var item_id = int(item.name.split("$")[1])
		var day = int(item.name.split("$")[2])
		var offset = 14 * item_index
		Utils.non_static_items_json[item_id+offset].Position[day-1].posX = item.position.x
		Utils.non_static_items_json[item_id+offset].Position[day-1].posY = item.position.y
	
	var test = "res://Globals/test.json"
	var file = FileAccess.open(test, FileAccess.WRITE)
	file.store_line(JSON.stringify(Utils.non_static_items_json))
	
	
func create_temp_non_static_items():
	var newJSON = []
	for item in Utils.non_static_items_json:
		newJSON.append(fake_instance(item.Item))
	return newJSON

func create_static_and_non_static_items():
	var oldJSON = Utils.get_JSON("res://Globals/all.json")
	var newJSON = []
	var count = 1
	for item in oldJSON:
		if item.Item != "sand" and item.Item != "Moss":
			pass
			#newJSON.append(new_instance(item))
			#if count == 7:
				#print("count hit 7")
				#for i in range(7):
					#newJSON.append(fake_instance("TinCan"))
			#if count == 16:
				#print("count hit 16")
				#for i in range(5):
					#newJSON.append(fake_instance("WaterBottle"))
			#count+=1
	var test = "res://Globals/test.json"
	var file = FileAccess.open(test, FileAccess.WRITE)
	file.store_line(JSON.stringify(newJSON))
	
func fake_instance(item):
	var instance = {
		"Item": item,
		"Position": [],
		"Taken": false
	}
	for i in range(10):
		instance.Position.append({"posX": -9999, "posY": -9999})
	return instance
	
func new_instance(dict):
	var instance = {
		"Item": dict.Item,
		"Position": [
			{"posX": dict.posX, "posY": dict.posY}
		],
		"Taken": dict.Taken
	}
	for i in range(9):
		instance.Position.append({"posX": -9999, "posY": -9999})
	return instance


func _on_focus_button_pressed():
	if $Focus.visible:
		$Focus.hide()
	else:
		$Focus.show()


func _on_go_pressed():
	var offset = 14*$Item.selected
	var x = Utils.non_static_items_json[$item_id.value+offset].Position[$"Day Input".value-1].posX
	var y = Utils.non_static_items_json[$item_id.value+offset].Position[$"Day Input".value-1].posY
	if x == -9999 and y == -9999:
		print("hidden")
	else:
		$Camera2D.position = Vector2(x,y)


func _on_hide_pressed():
	send_to_shadow_realm.emit()
	#print($"Edit Day".value)


func _on_reset_pressed():
	reset_pressed.emit()
	#GameData.pseudo_items.append(instance)

