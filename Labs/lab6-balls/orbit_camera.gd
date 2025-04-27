extends Camera3D


@export var target : Node3D
var speed = PI/8
var offset
var angle = 0
func _ready():
	offset = position - target.position;
	
func _process(delta):
	angle+= speed*delta
	position = offset.rotated(Vector3.UP, angle) + target.position
	angle = fmod(angle, 2*PI)
	look_at(target.position, Vector3.UP)
