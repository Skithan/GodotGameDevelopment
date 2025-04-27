extends Node3D

var obstaclesLeft
var laps

var ambientLight
var ambientRed
var ambientBlack
var directionLight
var omniLight
var spotLight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DebugCam.current = false
	
	$ObstacleButBetter.contactTop.connect(contactTop.bind())
	$ObstacleButBetter.noContactTop.connect(noContactTop.bind())
	$ObstacleButBetter.contactBottom.connect(contactBottom.bind())
	$ObstacleButBetter.noContactBottom.connect(noContactBottom.bind())
	$ObstacleButBetter.contactLeft.connect(contactLeft.bind())
	$ObstacleButBetter.noContactLeft.connect(noContactLeft.bind())
	$ObstacleButBetter.contactRight.connect(contactRight.bind())
	$ObstacleButBetter.noContactRight.connect(noContactRight.bind())

	$ObstacleButBetter2.contactTop.connect(contactTop.bind())
	$ObstacleButBetter2.noContactTop.connect(noContactTop.bind())
	$ObstacleButBetter2.contactBottom.connect(contactBottom.bind())
	$ObstacleButBetter2.noContactBottom.connect(noContactBottom.bind())
	$ObstacleButBetter2.contactLeft.connect(contactLeft.bind())
	$ObstacleButBetter2.noContactLeft.connect(noContactLeft.bind())
	$ObstacleButBetter2.contactRight.connect(contactRight.bind())
	$ObstacleButBetter2.noContactRight.connect(noContactRight.bind())

	$ObstacleButBetter3.contactTop.connect(contactTop.bind())
	$ObstacleButBetter3.noContactTop.connect(noContactTop.bind())
	$ObstacleButBetter3.contactBottom.connect(contactBottom.bind())
	$ObstacleButBetter3.noContactBottom.connect(noContactBottom.bind())
	$ObstacleButBetter3.contactLeft.connect(contactLeft.bind())
	$ObstacleButBetter3.noContactLeft.connect(noContactLeft.bind())
	$ObstacleButBetter3.contactRight.connect(contactRight.bind())
	$ObstacleButBetter3.noContactRight.connect(noContactRight.bind())

	obstaclesLeft = 3
	$checkPoint.obstaclePassed.connect(obstacle1Passed.bind())
	$checkPoint2.obstaclePassed.connect(obstacle2Passed.bind())
	$checkPoint3.obstaclePassed.connect(obstacle3Passed.bind())
	$finishLine.obstaclePassed.connect(lapCompleted.bind())
	laps = 0
	
	
	ambientLight = true
	directionLight = true
	omniLight = true
	spotLight = true

	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("r"): 
		$jet._ready()
		$Timer._ready()
		$Timer.start()
		$Display/PanelContainer.visible = false
		$Display/RichTextLabel.text = "Game Chat:)"
		
	
	#set Light
	if Input.is_action_just_pressed("a"): 
		ambientLight = !ambientLight
		if ambientLight: 
			$jet/Camera3D.environment = load("res://ambientBlack.tres")
		else:
			$jet/Camera3D.environment = load("res://ambientRed.tres")
		
		
		
	if Input.is_action_just_pressed("d"): 
		directionLight = !directionLight
		$DirectionalLight3D.visible = directionLight
		
	if Input.is_action_just_pressed("p"): 
		omniLight = !omniLight
		$OmniLight3D.visible = omniLight
		
	if Input.is_action_just_pressed("s"): 
		spotLight = !spotLight
		$SpotLight3D.visible = spotLight


	$SpotLight3D.look_at($jet.global_transform.origin, Vector3.UP)






func contactTop():
	$jet.contactTop()
	$Display/RichTextLabel.text +=  str("\n[left]", "contact with top bar", "[/left]")
	
func noContactTop():
	$jet.noContactTopF()
	$Display/RichTextLabel.text +=  str("\n[left]", "top bar all clear", "[/left]")

func contactBottom():
	#print("in main contactbottom")
	$jet.contactBottom()
	$Display/RichTextLabel.text += str("\n[left]", "contact with bottom bar", "[/left]")
	
func noContactBottom():
	#print("in main nocontactbottom")
	$jet.noContactBottomF()
	$Display/RichTextLabel.text +=  str("\n[left]", "bottom bar all clear", "[/left]")
	
func contactLeft():
	$jet.contactLeft()
	$Display/RichTextLabel.text += str("\n[left]", "contact with left bar", "[/left]")
	
func noContactLeft():
	$jet.noContactLeftF()
	$Display/RichTextLabel.text += str("\n[left]", "left bar all clear", "[/left]")
	
func contactRight():
	$jet.contactRight()
	$Display/RichTextLabel.text += str("\n[left]", "contact with right bar", "[/left]")
	
func noContactRight():
	$jet.noContactRightF()
	$Display/RichTextLabel.text += str("\n[left]", "right bar all clear", "[/left]")


func _on_timer_timeout() -> void:
	#stop game
	$jet.inGameF(false)
	$Display/PanelContainer.visible = true
	
func obstacle1Passed():
	obstaclesLeft -= 1
	$Display/ObstaclesLeftLabel.text = "Obstacles Left: %s"%obstaclesLeft
	
func obstacle2Passed():
	obstaclesLeft -= 1
	$Display/ObstaclesLeftLabel.text = "Obstacles Left: %s"%obstaclesLeft
	
func obstacle3Passed():
	obstaclesLeft -= 1
	$Display/ObstaclesLeftLabel.text = "Obstacles Left: %s"%obstaclesLeft

	
func lapCompleted():
	laps+=1
	$Timer.set_paused(true)
	$Timer.setRound(laps+1)
	$Timer.start()
	obstaclesLeft = 3	
	$Display/ObstaclesLeftLabel.text = "Obstacles Left: %s"%obstaclesLeft
	$Display/LapsDoneLabel.text = "Laps Completed: %s"%laps
