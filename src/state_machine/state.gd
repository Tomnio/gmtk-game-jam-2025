extends Node
class_name State

var player: CharacterBody2D
var animation_player: AnimationPlayer

var inputs: Dictionary:
	get:
		if player:
			return player.inputs
		return {}

signal Transitioned

func Setup():
	player = get_parent().get_parent()
	animation_player = player.get_node("AnimationPlayer")

func Enter():
	if animation_player.has_animation(self.name.to_lower()):
		animation_player.play(self.name.to_lower())
	pass

func Exit():
	pass

func Update(_delta: float):
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta
	
	if player.velocity.y > 0:
		Transitioned.emit(self, "fall")
	
	player.move_and_slide()
	pass

func Physics_Update(_delta: float):
	pass
