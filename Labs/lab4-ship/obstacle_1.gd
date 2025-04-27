extends Node3D


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("body entered")
	if area.is_in_group("Ship"):
		print("ship collided with obstacle1")
