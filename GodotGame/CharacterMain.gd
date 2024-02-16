extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var footstep_audio = $FootstepAudio
var isMoving = false

const SPEED = 300.0

func _physics_process(delta):
		#Animation
	if (velocity.x > 1):
		sprite_2d.animation = "Right"
	elif (velocity.x < -1):
		sprite_2d.animation = "Left"
	elif (velocity.y > 1):
		sprite_2d.animation = "Down"
	elif (velocity.y < -1):
		sprite_2d.animation = "Up"
	else:
		sprite_2d.animation = "Idle"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("Left", "Right")
	var directionY = Input.get_axis("Up", "Down")
	var nowMoving = false # c nowMoving
	
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
		print("moving")
		if not isMoving:
			isMoving = true
			footstep_audio.play()
	else:
		if isMoving:
			isMoving = false
			footstep_audio.stop()
	
	
	
	move_and_slide()

