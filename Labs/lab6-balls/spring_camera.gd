extends Camera3D


@export var target : Node3D
var springConstant = 9.0
var dampConstant
var offset
var actualPosition
var velocity

func _ready():
	dampConstant = 2.0 * sqrt(springConstant)
	offset = position - target.position
	actualPosition = position
	velocity = Vector3.ZERO
	
func _process(delta):
	var idealPosition = target.position + offset
	var displacement = actualPosition - idealPosition
	var springAccel = (-springConstant * displacement) - (dampConstant * velocity)
	velocity += springAccel * delta
	actualPosition += velocity * delta
	position = actualPosition
