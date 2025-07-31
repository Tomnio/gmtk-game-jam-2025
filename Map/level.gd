extends Node2D
class_name Level

@onready var player_bp = preload("res://Player/player.tscn")

func spawn_player(player):
	self.add_child(player)
