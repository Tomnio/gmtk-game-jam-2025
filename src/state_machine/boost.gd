extends State
class_name Boost

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.JUMP_BOOST = 1.4
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.JUMP_BOOST = 1
		pass
