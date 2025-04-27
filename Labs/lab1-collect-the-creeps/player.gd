extends CharacterBody3D
@export var jump_impulse = 30
@export var speed = 14
@export var fall_acceleration = 100
@export var bounce_impulse = 16
var target_velocity = Vector3.ZERO


func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO	
		# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	_handleCollisions()


func _handleCollisions():
	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
	# We get one of the collisions with the player
		var collision = get_slide_collision(index)
	#for reasons we won't go into here, collision detection is
	#complicated and we may get a null collision, skip it!
		if collision.get_collider() == null:
			continue
		# If the collider is with an enemy
		if collision.get_collider().is_in_group("enemy"):
			var enemy = collision.get_collider()
			$CatchSound.play()
			enemy.catch()
			break # Prevent further duplicate calls.
