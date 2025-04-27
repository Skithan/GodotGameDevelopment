extends Timer
var time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait_time = 25	
	time = wait_time
	$/root/main/Display/Label.text = "Time Left: %02ds"%time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time>0: 
		time -= delta
		$/root/main/Display/Label.text = "Time Left: %02ds"%time
	
func setRound(round):	
	if round == 2: 
		wait_time = 25
	else: 
		if round == 3: 
			wait_time = 20
		else: 
			wait_time = 15
	time = wait_time
