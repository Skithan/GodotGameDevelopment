extends Label
var score = 0

signal curScore(score)

func _on_mob_squashed():
	score += 1
	text = "Score: %s" % score
	emit_signal("curScore", score)
