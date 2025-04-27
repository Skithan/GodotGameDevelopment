extends CharacterBody3D

var circleRadius : float
var circleSpeed : float
var circleAngle : float #radians
var selfRotationSpeed : float
var lastDirection : Vector3

var noContactTop
var noContactBottom
var noContactLeft
var noContactRight

var inGame 

func _ready():
	
	$Camera3D.current = true	
	inGame = true
	noContactTop = true
	noContactBottom = true
	noContactLeft = true
	noContactRight = true	
	
	position = Vector3(0,2,0)
	rotation_degrees.y = 90
	
	circleRadius = 40
	circleSpeed = .5
	circleAngle = 0
	selfRotationSpeed = -0.5
	lastDirection = Vector3(1, 0, 0)
	lastDirection.normalized()
	
	#run the code a couple times so it can work of it's previous direction/positions
	
	circleAngle += circleSpeed * 0
	circleAngle = fmod(circleAngle , 2*PI)
	#print(circleAngle)
	var newPositionX = circleRadius * cos(circleAngle)
	var newPositionZ = circleRadius * sin(circleAngle)
	var newPosition = Vector3(newPositionX, position.y, newPositionZ)
	var newDirection = newPosition - position
	#newDirection = Vector3(40,0,0)
	newDirection.normalized()
	print(newDirection)
	var	rotationAngle = -1*lastDirection.angle_to(newDirection)
	print(rotationAngle)

	

	transform = transform.rotated(Vector3.UP, rotationAngle)
	transform = transform.rotated_local(Vector3.FORWARD, 0)
	position = newPosition
	lastDirection = newDirection

	
	circleAngle += circleSpeed * 0.0166667
	circleAngle = fmod(circleAngle , 2*PI)
	newPositionX = circleRadius * cos(circleAngle)
	newPositionZ = circleRadius * sin(circleAngle)
	newPosition = Vector3(newPositionX, position.y, newPositionZ)
	newDirection = newPosition - position
	newDirection.normalized()
	#print(newDirection)
	
	print(newDirection)
	rotationAngle = -1*lastDirection.angle_to(newDirection)
	print(rotationAngle)
	transform = transform.rotated(Vector3.UP, rotationAngle)
	transform = transform.rotated_local(Vector3.FORWARD, selfRotationSpeed *  0.0166667)
	position = newPosition
	lastDirection = newDirection

	
	
func _physics_process(delta):
	
	if inGame:
	
		# for rotation left and right I initialise selfRotationSpeed to be 0 
		selfRotationSpeed = 0


		if Input.is_action_pressed("ui_up") and noContactTop and noContactBottom and noContactLeft and noContactRight: 
			circleAngle += circleSpeed * delta
			circleAngle = fmod(circleAngle , 2*PI)
			var newPositionX = circleRadius * cos(circleAngle)
			var newPositionZ = circleRadius * sin(circleAngle)
			var newPosition = Vector3(newPositionX, position.y, newPositionZ)
			var newDirection = newPosition - position
			newDirection.normalized()
			
			var	rotationAngle = -1*lastDirection.angle_to(newDirection)
			transform = transform.rotated(Vector3.UP, rotationAngle)
			position = newPosition
			lastDirection = newDirection
		
		if Input.is_action_pressed("ui_left"): 
			selfRotationSpeed = 0.5

		if Input.is_action_pressed("ui_right"): 
			selfRotationSpeed = -0.5
		

		transform = transform.rotated_local(Vector3.FORWARD, selfRotationSpeed * delta)


func contactTop():
	#called when jet hits obstacle
	noContactTop = false

func noContactTopF():
	#called when jet hits obstacle
	noContactTop = true

func contactBottom():
	#called when jet hits obstacle
	#print("in jet bottom hit")
	noContactBottom = false

func noContactBottomF():
	#called when jet hits obstacle
	#print("in jet bottom stopped being hit")
	noContactBottom = true
	
func contactLeft():
	#called when jet hits obstacle
	noContactLeft = false

func noContactLeftF():
	#called when jet hits obstacle
	noContactLeft = true
	
func contactRight():
	#called when jet hits obstacle
	noContactRight = false

func noContactRightF():
	#called when jet hits obstacle
	noContactRight = true

func inGameF(inDaGame):
	inGame = inDaGame
