extends Timer

var gameTime
var GameTimer
var TimeLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameTime = 20 
	GameTimer = $/root/Main/GameTimer
	TimeLabel = $/root/Main/UserInterface/TimeLabel
	GameTimer.start()
	TimeLabel = "Time: %s" %gameTime 


func _on_timeout() -> void:
	if gameTime > 0:  
		gameTime -= 1
		TimeLabel = "Time: %s" %gameTime 
	else: 
		GameTimer.stop()
		TimeLabel = "Game Over"
