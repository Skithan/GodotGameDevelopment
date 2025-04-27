extends Camera3D

@export var target : Node3D
var offset : Vector3

func _ready():
	offset = position - target.position;
func _process(delta):
	position = target.position + offset;
