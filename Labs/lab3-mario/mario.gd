extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var doubleJumping = false

func _physics_process(delta: float) -> void:
		
	if position.y > 350: 
		position.y = 264
		position.x = 9
		

			
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.animation = "jumping-right"

	
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	if Input.is_action_just_pressed("ui_accept") and doubleJumping == false:
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jumping-right"


	if Input.is_action_just_pressed("ui_accept") and  not is_on_floor():
		doubleJumping = true
	
	if is_on_floor():
		doubleJumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0: 
			$AnimatedSprite2D.animation = "running-right"	
			$AnimatedSprite2D.flip_h = false
		else: 		
			$AnimatedSprite2D.animation = "running-right"	
			$AnimatedSprite2D.flip_h = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = "standing-right"	
		
	if velocity.length() > 0:		
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	move_and_slide()
