extends CharacterBody2D

signal open_map
signal close_map

@onready var sprite_2d = $Sprite2D
@onready var footstep_audio = $FootstepAudio
var isMoving = false
var inventory_opened = false
var map_opened = false
#var last_recorded_inventory_amount:Dictionary

const SPEED = 169.0

func _ready():
	$Camera2D.make_current()

# Character direction
# 0 is up, 1 is down, 2 is right, 3 is left
var characterDirection = 0

func _physics_process(delta):
	#created so that it only draws items once each time
	#if last_recorded_inventory_amount != GameData.inventory_amount:
		#print("last_recorded_inventory_amount != GameData.inventory_amount")
		#last_recorded_inventory_amount = GameData.inventory_amount.duplicate()
		#$"Inventory Layer/Inventory".draw_items(GameData.inventory)
		#print("a-relinked")
		
	
		#Animation
	if (velocity.x > 1):
		sprite_2d.animation = "Right"
		characterDirection = 2
	elif (velocity.x < -1):
		sprite_2d.animation = "Left"
		characterDirection = 3
	elif (velocity.y > 1):
		sprite_2d.animation = "Down"
		characterDirection = 1
	elif (velocity.y < -1):
		sprite_2d.animation = "Up"
		characterDirection = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("Left", "Right")
	var directionY = Input.get_axis("Up", "Down")
	var nowMoving = false # c nowMoving
	var canMove = not inventory_opened and not map_opened and GameData.current_ui != "dev" #and this and that and ... and etc.
	
	if GameData.charLock == false:
		if canMove:
			if directionX:
				velocity.x = directionX * SPEED
				nowMoving = true
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

			if directionY:
				velocity.y = directionY * SPEED
				nowMoving = true
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)

		if nowMoving:
			if not isMoving:
				# when starting to move
				isMoving = true
				footstep_audio.play()
		elif isMoving:
			# when starting to not move
			isMoving = false
			footstep_audio.stop()
			
			# 0 is up, 1 is down, 2 is right, 3 is left
			if (characterDirection == 0):
				sprite_2d.animation = "Up_Idle"
			elif (characterDirection == 1):
				sprite_2d.animation = "Down_Idle"
			elif (characterDirection == 2):
				sprite_2d.animation = "Right_Idle"
			elif (characterDirection == 3):
				sprite_2d.animation = "Left_Idle"
		
		if Input.is_action_just_pressed("Map"):
			if GameData.current_ui != "map" && GameData.current_ui != "":
				return
			if not map_opened:
				map_opened = true
				velocity.x = 0
				velocity.y = 0
				open_map.emit()
				print("map_open")
				GameData.current_ui = "map"
			else:
				map_opened = false
				GameData.current_ui = ""
				close_map.emit()
				$Camera2D.make_current()
				print("map_close")
				
				
			
				
		if Input.is_action_just_pressed("Inventory"):
			if GameData.current_ui != "inventory" && GameData.current_ui != "":
				return
			if not inventory_opened:
				inventory_opened = true
				velocity.x = 0
				velocity.y = 0
				print("inventory_open")
				$"Inventory Layer".show()
				GameData.current_ui = "inventory"
			else:
				inventory_opened = false
				GameData.current_ui = ""
				print("inventory_close")
				$"Inventory Layer".hide()
			print("pressed E")
			$"Inventory Layer/Inventory".draw_items(GameData.inventory)
		elif Input.is_action_just_pressed("Back"):
			if GameData.current_ui != "options" && GameData.current_ui != "":
				return
			Utils.go_to_option_menu(get_tree().current_scene.scene_file_path, self.position)
			GameData.current_ui = "options"
		
		velocity = velocity.normalized() * SPEED
		move_and_slide()
	else:
		velocity.x = 0
		velocity.y = 0
		# 0 is up, 1 is down, 2 is right, 3 is left
		if (characterDirection == 0):
			sprite_2d.animation = "Up_Idle"
		elif (characterDirection == 1):
			sprite_2d.animation = "Down_Idle"
		elif (characterDirection == 2):
			sprite_2d.animation = "Right_Idle"
		elif (characterDirection == 3):
			sprite_2d.animation = "Left_Idle"
		footstep_audio.stop()

func _on_footstep_audio_finished():
	# loop audio
	if isMoving:
		footstep_audio.play()
		

func show_map_icon():
	$MapIcon.show()
	#$Label.show()
	$Sprite2D.hide()
	
func hide_map_icon():
	$Sprite2D.show()
	$MapIcon.hide()
	#$Label.hide()

func set_to_player_camera():
	$Camera2D.make_current()
