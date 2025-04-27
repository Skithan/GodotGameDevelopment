extends RigidBody3D

var forceDirection
var speed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	forceDirection = Vector3(0,0,0)
	speed = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		forceDirection.z-=1
	if Input.is_action_pressed("ui_down"):
		forceDirection.z+=1
	if Input.is_action_pressed("ui_right"):
		forceDirection.x+=1
	if Input.is_action_pressed("ui_left"):
		forceDirection.x-=1

	#initial push onto the ball in the forceDirection with forcePower
	apply_impulse(forceDirection*speed)
