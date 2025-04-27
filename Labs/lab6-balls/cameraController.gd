extends Node

@export var staticCamera : Camera3D
@export var followCamera : Camera3D
@export var springCamera : Camera3D
@export var orbitCamera : Camera3D
@export var firstPersonCamera : Camera3D
enum CameraTypes {Static, follow, spring, orbit, firstPerson}
@export var choice = CameraTypes.Static

# Called when the node enters the scene tree for the first time.
func _ready():
	staticCamera.current = false
	followCamera.current = false
	springCamera.current = false
	orbitCamera.current = false
	firstPersonCamera.current = false
	
	if choice == CameraTypes.Static:
		staticCamera.make_current()
	if choice == CameraTypes.follow:
		followCamera.make_current()
	if choice == CameraTypes.spring:
		springCamera.make_current()
	if choice == CameraTypes.orbit:
		orbitCamera.make_current()
	if choice == CameraTypes.firstPerson:
		firstPersonCamera.make_current()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("1"):
		choice = CameraTypes.Static
		staticCamera.make_current()
	if Input.is_action_pressed("2"):
		choice = CameraTypes.follow
		followCamera.make_current()
	if Input.is_action_pressed("3"):
		choice = CameraTypes.spring
		springCamera.make_current()
	if Input.is_action_pressed("4"):
		choice = CameraTypes.orbit
		orbitCamera.make_current()
	if Input.is_action_pressed("5"):
		choice = CameraTypes.firstPerson
		firstPersonCamera.make_current()
