extends Area2D
var speed
signal hit

# Called when the node enters the scene tree for the first time.
func initialize():
	speed = 200
	connect("area_entered", _collision_occured)
	position.x = 100
	position.y = 100

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("moveRight"):
		velocity.x += 1
		$AnimatedSprite2D.animation = "Right"
		
	if Input.is_action_pressed("moveLeft"):
		velocity.x -= 1
		$AnimatedSprite2D.animation = "Left"
		
	if Input.is_action_pressed("moveDown"):
		velocity.y += 1
		$AnimatedSprite2D.animation = "Down"
		
	if Input.is_action_pressed("moveUp"):
			velocity.y -= 1
			$AnimatedSprite2D.animation = "Up"
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	
	if position.x > 640: 
		position.x = 0
	
	if position.y > 480: 
		position.y = 0
		
	if position.x < 0: 
		position.x = 640
	
	if position.y < 0: 
		position.y = 480
		
		


		
		

func _collision_occured(obj):
	if obj.get_script() == preload("res://ghost.gd"):
		hit.emit()		
