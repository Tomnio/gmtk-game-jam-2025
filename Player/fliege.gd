extends Player

func _ready() -> void:
	_animation_player = $AnimationPlayer



func play_ability():
	current_state = "ability"
	_animation_player.play("hover")
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name == "hover":
		current_state = "idle"
