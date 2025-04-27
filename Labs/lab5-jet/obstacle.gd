extends Node3D

signal contactTop
signal noContactTop
signal contactBottom
signal noContactBottom
signal contactLeft
signal noContactLeft
signal contactRight
signal noContactRight


func _on_bottom_bar_area_entered(area: Area3D) -> void:
	print("bottom bar hit")
	contactBottom.emit()


func _on_top_bar_area_entered(area: Area3D) -> void:
	print("top bar hit")
	contactTop.emit()


func _on_left_bar_area_entered(area: Area3D) -> void:
	print("left bar hit")
	contactLeft.emit()

func _on_right_bar_area_entered(area: Area3D) -> void:
	print("right bar hit")
	contactRight.emit()


func _on_bottom_bar_area_exited(area: Area3D) -> void:
	print("bottom bar stopped being hit")
	noContactBottom.emit()


func _on_top_bar_area_exited(area: Area3D) -> void:
	print("top bar stopped being hit")
	noContactTop.emit()


func _on_left_bar_area_exited(area: Area3D) -> void:
	print("left  bar stopped being hit")
	noContactLeft.emit()


func _on_right_bar_area_exited(area: Area3D) -> void:
	print("right bar stopped being hit")
	noContactRight.emit()
