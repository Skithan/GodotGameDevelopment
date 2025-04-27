extends Node2D

var time
var timeStarted
var endLevelImage
var nextLevelButton 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$Timer.start()		
	time = 0
	timeStarted = 1	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.position.x = $Mario.position.x
	$TimerLabel.position.x = $Mario.position.x 
	$TimerLabel.position.y = $Mario.position.y - 40
	
	if timeStarted == 1:
		time += delta
		var intTime = int(time)
		$TimerLabel.text = "%s" %intTime

	if $Mario.position.y > 350: 
		time = 0


func _on_area_2d_body_entered(body) -> void:
	print(body)

	if body is CharacterBody2D:
		print("end level")
		$Timer.stop()
		endLevelImage = $NinePatchRect
		endLevelImage.texture = load("res://endLevel.jpg")
		endLevelImage.set_size(Vector2(300,300))
		endLevelImage.set_anchors_preset(Control.PRESET_CENTER)
		endLevelImage.z_index = 10
		endLevelImage.position.x = 800
		add_child(endLevelImage)
		
		nextLevelButton = $Button
		nextLevelButton.text = "Next Level!"
		nextLevelButton.set_size(Vector2(100,100))
		nextLevelButton.position.x = 900
		nextLevelButton.position.y = 175
		nextLevelButton.set_anchors_preset(Control.PRESET_CENTER_TOP)
		nextLevelButton.pressed.connect(self.nextLevel.bind(1))
		#nextLevelButton.raise()
		nextLevelButton.z_index = 15
	
		add_child(nextLevelButton)
		$EndTime.visible = true
		$EndTime.text = "Time: %s" %time
		$EndTime.position.x = 850
		$EndTime.position.y = 10
		$EndTime.z_index = 20
	
func nextLevel(level):	
	endLevelImage.queue_free()
	#nextLevelButton.queue_free()

	$EndTime.visible = false
	$Mario.position.x = 15
	$Mario.position.y = 250
	var newScene = get_tree().change_scene_to_file("res://main2.tscn")
