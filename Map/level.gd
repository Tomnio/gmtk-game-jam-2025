extends Node2D
class_name Level

func _ready() -> void:
	Game.level = self
	Game.start_run()
	add_players_to_tree()

func spawn_player(player: Player):
	var player_count = get_children().filter(func(child): return child is Player).size()
	var offset_distance = 50  # Adjust this value as needed
	
	# Circular pattern
	var angle = (player_count * PI * 2) / 4  # Assuming max 4 players
	var offset = Vector2(cos(angle), sin(angle)) * offset_distance
	
	player.position = $Spawnpoint.position + offset
	if player.active:
		player.last_movement_iteration = []

func add_players_to_tree():
	for player in Game.selected_buddies:
		self.add_child(player)
