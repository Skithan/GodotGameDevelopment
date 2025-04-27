extends Node
@export var EnemyTemplate : PackedScene

var timer
var gameTimer
var score = 0

func _ready() -> void:
	
	$Cylinders.visible = false
	$NinePatchRect.visible = false
	$NinePatchRect/GameOverLabel.visible = false
	
	var timer = $GameTimer
	timer.start()
	
	var timeLabel = $UserInterface/TimeLabel
	timeLabel.gameover.connect(_gameOverFunc)
	
	var scoreLabel = $UserInterface/ScoreLabel
	scoreLabel.curScore.connect(scoreSaver)
	
func scoreSaver(x):
	score = x
	
func _gameOverFunc(): 
	$MobTimer.stop()
	$GameTimer.stop()
	
	for child in get_children():
		if child is not Timer:
			child.visible = false	

	$NinePatchRect.visible = true
	$NinePatchRect/GameOverLabel.visible = true
	
	if score < 3:
		$NinePatchRect/GameOverLabel.text = "You ate %s enemys Better Luck Next Time" % score
	else: 
		$NinePatchRect/GameOverLabel.text = "You ate %s enemys Please Play Again" % score

func _on_mob_timer_timeout() -> void:

	var enemy = EnemyTemplate.instantiate()
	var groundSize = $Ground/MeshInstance3D.mesh.size	
	
		#spawn closer to center
	var myRandNum = RandomNumberGenerator.new()	
	enemy.position.x = (myRandNum.randf_range(0.25,0.75) * groundSize.x) - groundSize.x/2
	enemy.position.z = (myRandNum.randf_range(0.25,0.75) * groundSize.z) - groundSize.z/2
	
	var player_position = $Player.position	
	enemy.initialize(enemy.position ,player_position)
	enemy.caught.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
		
	add_child(enemy)
	
