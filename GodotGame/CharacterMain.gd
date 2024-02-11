extends CharacterBody2D

@onready var sprite_2d = $Sprite2D


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
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
