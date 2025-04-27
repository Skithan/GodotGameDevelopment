extends Node3D

var obstaclesRemaining
var ob1
var ob2
var ob3
var errorMessage
var winMessage
var flyingCraft

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ob1 = 1
	ob2 = 1
	ob3 = 1
	flyingCraft = $FlyingCraft
	flyingCraft.Ob1.connect(Obstacle1Done)
	flyingCraft.Ob2.connect(Obstacle2Done)
	flyingCraft.Ob3.connect(Obstacle3Done)
	flyingCraft.errorMessage.connect(Error)
	flyingCraft.winMessage.connect(Win)
	
	$ColorRect.color.a = 0.5
	$ColorRect.visible = false
	$ColorRect/Win.visible = false
	$ColorRect/Lose.visible = false
	obstaclesRemaining = ob1 + ob2 + ob3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	obstaclesRemaining = ob1 + ob2 + ob3
	$FlyingCraft/Camera3D/Label3D.text = "Obstacles Remaining: %s" %obstaclesRemaining
	
	if Input.is_action_just_pressed("r"): 
		#restart game
		$FlyingCraft.position.x = 0
		$FlyingCraft.position.y = 10
		$FlyingCraft.position.z = 0
		$FlyingCraft.rotation.x = 0
		$FlyingCraft.rotation.y = 0
		$FlyingCraft.rotation.z = 0
		obstaclesRemaining = 0
		$FlyingCraft/Camera3D/Label3D.text = "Obstacles Remaining: %s" %obstaclesRemaining
		$FlyingCraft._ready()
		$ColorRect.visible = false
		$ColorRect/Lose.visible = false
		$ColorRect/Win.visible = false
		
func Obstacle1Done():
	ob1 = 0
func Obstacle2Done():
	ob2 = 0
func Obstacle3Done():
	ob3 = 0

func Error(message):
	$ColorRect/Lose.text = message + " press r to restart"
	$ColorRect.visible = true
	$ColorRect/Lose.visible = true
	
func Win(message):
	
	if obstaclesRemaining == 0:			
		$ColorRect/Win.text = message + " press r to restart"
		$ColorRect.visible = true
		$ColorRect/Win.visible = true
		
	else:
		Error("you reached the finish without going through the obstacles")
