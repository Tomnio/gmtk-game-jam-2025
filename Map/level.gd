extends Node2D
class_name Level

func _ready() -> void:
	Game.level = self
	Game.start_run()

func spawn_player(player: Player):
	print(player)
	player.position = $Spawnpoint.position
	self.add_child(player)
