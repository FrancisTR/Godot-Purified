extends Node2D

signal pos_test
signal toggle_dev_tool

var rock_scene = preload("res://World Scene/Items/rock.tscn")
var dev_mode = false
var camera_speed = 5
var zoom_speed = 0.03
var zoom_max = 0.22
var zoom_min = 3
var mode = "add"


#NOTE: If you want to remove this in the future you must remove:
#		 - _on_item_placer_pos_test in wilderness.gd
#		 - _on_toggle_dev_tool in wilderness.gd
#		 - ' and GameData.current_ui != "dev" ' in ChacterMain.gd
#		 - Item Placer nodes in wilderness.tscn
#		 - PsuedoItems node in wilderness.tscn


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


func _on_add_check_button_pressed():
	mode = "add"
	$"Modify/Modify Check Button".button_pressed = false


func _on_modify_check_button_pressed():
	mode = "modify"
	$"Add New/Add Check Button".button_pressed = false

