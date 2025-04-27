extends Label
var time = 15
signal gameover


func _on_gametimer_timeout() -> void:
	if time > 0:  
		time -= 1
		text = "Time: %s" %time 
	else: 
		gameover.emit()
		var gameTimer = $/root/Main/GameTimer
		gameTimer.stop()
