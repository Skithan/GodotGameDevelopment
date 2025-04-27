extends Node2D
@export var GhostTemplate : PackedScene
@export var PlayerTemplate : PackedScene

var time
var timeStarted
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$GhostTimer.start()
	var player = PlayerTemplate.instantiate()
	player.initialize()
	player.hit.connect(_on_player_hit.bind())
	add_child(player)
		
	time = 0
	timeStarted = 1	
	$GameOverScreen.visible = false
	$GameOverScreen/Gameovermessage.visible = false
	$GameOverScreen/Gameover.visible = false
	$GameOverScreen/NewGame.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeStarted == 1:
		time += delta
		var intTime = int(time)
		$Score.text = "Score: %s" %intTime


func _on_ghost_timer_timeout() -> void:
	#add a ghost
	var newGhost = GhostTemplate.instantiate()
	newGhost.initialize()	
	#newGhost.caught.connect($Score._on_ghost_caught.bind())
	add_child(newGhost)

		
func _on_player_hit():	
	$GhostTimer.stop()
	timeStarted = 0
	time = 0
	
	for child in get_children():
		if child is Area2D:
			if child.name != "Background":
			#remove_child(child)
				child.queue_free()

	$GameOverScreen.visible = true
	$GameOverScreen/Gameovermessage.visible = true
	$GameOverScreen/Gameover.visible = true
	$GameOverScreen/NewGame.visible = true


func _on_new_game_pressed() -> void:
	time = 0
	$Score.text = "Score: %s" %time

	$GameOverScreen.visible = false
	$GameOverScreen/Gameovermessage.visible = false
	$GameOverScreen/Gameover.visible = false
	$GameOverScreen/NewGame.visible = false
	$Score.visible = true
	
	$GhostTimer.start()
	var player = PlayerTemplate.instantiate()
	player.initialize()
	player.hit.connect(_on_player_hit.bind())
	add_child(player)
