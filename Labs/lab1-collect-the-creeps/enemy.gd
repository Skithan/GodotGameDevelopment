extends CharacterBody3D
@export var min_speed = 10
@export var max_speed = 15
signal caught

func _physics_process(delta):	
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		velocity.y = velocity.y - (5 * delta)
	else: 
		velocity.y = 0
	move_and_slide()		
	
# This function will be called from the Main scene.
func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)	
	rotate_y(randf_range(-PI / 4, PI / 4))
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed	
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	velocity.y = 0

	
func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
	
func catch():
	caught.emit()
	queue_free()
