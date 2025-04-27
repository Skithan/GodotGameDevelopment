extends Area2D

var speed
#signal caught

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = true
	
var velocity 
func initialize():
	
	speed = 100
	velocity = Vector2.ZERO # The player's movement vector	
	#velocity.clamp(Vector2(0, 0), Vector2(480, 640))
	var myRandNum = RandomNumberGenerator.new()			
	var ghostDirection = myRandNum.randi_range(0,3)

	if ghostDirection == 0: #spawn Right
		#print("move to the left spawn from right side")
		position.x = 640
		position.y = myRandNum.randf_range(1, 479) #so you can see it 
		velocity.x -= speed
		$AnimatedSprite2D.animation = "Left"

	if ghostDirection == 1: #spawn Left
		#print("move to the right spawn from left side") 
		position.x = 0
		position.y = myRandNum.randf_range(1, 479) #so you can see it 
		velocity.x += speed
		$AnimatedSprite2D.animation = "Right"
		
	if  ghostDirection == 2: #spawn Bottom
		#print("spawn bottom move up")
		position.x = myRandNum.randf_range(1, 639) #so you can see it 
		position.y = 480
		velocity.y -= speed
		$AnimatedSprite2D.animation = "Up"

		
	if ghostDirection == 3: #spawn Top
		#print("spawn up move down")
		position.x = myRandNum.randf_range(1, 639) #so you can see it 
		position.y = 0
		velocity.y -= speed
		$AnimatedSprite2D.animation = "Down"
			
	if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	#velocity.clamp(Vector2(0, 0), Vector2(480, 640))	

func _process(delta):
	#velocity.clamp(Vector2(0, 0), Vector2(480, 640))
	position += velocity * delta
	
	if position.x > 640: 
		position.x = 0
	
	if position.y > 480: 
		position.y = 0
		
	if position.x < 0: 
		position.x = 640
	
	if position.y < 0: 
		position.y = 480
		

	##use Vector2.clamp(min, max )	
#
#func catch():
	#caught.emit()
	#queue_free()
