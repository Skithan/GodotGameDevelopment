extends CharacterBody3D

var rotationAngleRadian : float
var rotationSpeedRadian : float
var rotationDirection : float

var motionVelocity : Vector3
var motionSpeedXZ : float
var motionDirectionXZ : int

var motionSpeedY : float
var motionDirectionY : int

var shipCollided
signal Ob1
signal Ob2
signal Ob3
signal errorMessage(message)
signal winMessage(message)

func _ready() -> void:
	rotationAngleRadian = 0
	rotationSpeedRadian = 1
	rotationDirection = 0

	motionVelocity = Vector3.ZERO
	motionSpeedXZ = 10
	motionDirectionXZ = 0
		
	motionSpeedY = 10
	motionDirectionY = 0

	shipCollided = false


func Rotate(delta):
	var rotationVelocityRadian = rotationSpeedRadian * rotationDirection
	rotationAngleRadian += rotationVelocityRadian * delta
	transform = transform.rotated_local(Vector3.UP, rotationVelocityRadian * delta)

func Move(delta):
	var motionX = sin(rotationAngleRadian) * motionDirectionXZ
	var motionZ = cos(rotationAngleRadian) * motionDirectionXZ
	#var motionY = tan(rotationAngleRadian) * motionDirectionY

	motionVelocity = Vector3(motionX, motionDirectionY, motionZ)
	#normalized vector to represent the directions of motionVelocity
	motionVelocity.normalized()
	motionVelocity = Vector3(motionVelocity.x * motionSpeedXZ, motionVelocity.y * motionSpeedY, motionVelocity.z
	* motionSpeedXZ)
	transform = transform.translated(motionVelocity * delta)
	#rotationDirection = 0
	#motionDirectionXZ = 0
	#motionDirectionY = 0
	

	

func _process(delta: float) -> void:
	# add the code to control rotation of FlyingCraft by keyboard “left arrow” (counter clock-wise) and “right arrow” (clock-wise). 
	#Use the function you just made for this	
	#rotationDirection = 0
	#motionDirectionXZ = 0
	#motionDirectionY = 0
	
	#check if the ship has collided
	
	#
	if !shipCollided: 		
		
		if Input.is_action_pressed("ui_left"): 
			#(counter clock-wise) 
			rotationDirection = 1

		if Input.is_action_pressed("ui_right"): 
			#(clock-wise) 
			rotationDirection = -1
			 
		if Input.is_action_pressed("ui_down"): 
			#backwards
			motionDirectionXZ = 1
			
		if Input.is_action_pressed("ui_up"): 
			#forward
			motionDirectionXZ = -2
			
		if Input.is_action_pressed("p"): 
			#up
			motionDirectionY = 1
			
		if Input.is_action_pressed("i"): 
			#down
			motionDirectionY = -1
		
		Rotate(delta)
		Move(delta)
		move_and_slide()
		
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)		
		if collision: 
			var collided_object = collision.get_collider()
			
			print(collided_object)
			if collided_object.is_in_group("Obstacle1"):
				Ob1.emit()
				print("Passed through 1")
			if collided_object.is_in_group("Obstacle2"):
				Ob2.emit()
				print("Passed through 2")
			if collided_object.is_in_group("Obstacle3"):
				Ob3.emit()
				print("Passed through 3")
			
			if collided_object.is_in_group("Ground"):
				shipCollided = true
				errorMessage.emit("collided with ground")
				print("collided with ground")
				#popup some collided error
				
				
			if collided_object.is_in_group("Finish"):
				shipCollided = true
				winMessage.emit("you win")
				print("collided with finish")
				#popup some collided error
			
			if collided_object.is_in_group("ObstaclePost"):
				shipCollided = true
				#popup some collided error
				if collided_object.is_in_group("Obstacle1Post"):
					errorMessage.emit("you collided with obstacle 1")
					print("collided with 1")
				if collided_object.is_in_group("Obstacle2Post"):
					errorMessage.emit("you collided with obstacle 2")
					print("collided with 2")
				if collided_object.is_in_group("Obstacle3Post"):
					errorMessage.emit("you collided with obstacle 3")
					print("collided with 3")
			
			
