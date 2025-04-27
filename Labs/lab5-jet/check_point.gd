extends Node3D

signal obstaclePassed

func _on_area_3d_area_entered(area: Area3D) -> void:
	obstaclePassed.emit()
