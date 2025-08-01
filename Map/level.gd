extends Node2D
class_name Level

func _ready() -> void:
	Game.level = self
	Game.start_run()

func spawn_player(player: Player):
	# Remove player from scene if already there to avoid duplicates
	if player.get_parent():
		player.get_parent().remove_child(player)
	
	# Add player to scene
	self.add_child(player)
	
	var player_count = get_children().filter(func(child): return child is Player).size()
	var offset_distance = 50  # Adjust this value as needed
	
	# Circular pattern
	var angle = (player_count * PI * 2) / 4  # Assuming max 4 players
	var offset = Vector2(cos(angle), sin(angle)) * offset_distance
	
	player.position = $Spawnpoint.position + offset
