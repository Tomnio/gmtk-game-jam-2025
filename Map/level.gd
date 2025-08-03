extends Node2D
class_name Level

@onready var escape_label = $escapeLabel if has_node("escapeLabel") else null

@onready var spawnpoints : Array

func _ready() -> void:
	Game.level = self
	fetch_spawnpoints()

func spawn_player(player: Player):
	# Add player to scene
	if player.get_parent():
		player.get_parent().remove_child(player)
	
	var player_count = get_children().filter(func(child): return child is Player).size()
	var offset_distance = 50  # Adjust this value as needed
	
	# Circular pattern
	var angle = (player_count * PI * 2) / 4  # Assuming max 4 players
	var offset = Vector2(cos(angle), sin(angle)) * offset_distance
	
	for spawnpoint in spawnpoints:
		if player.name.to_lower() == spawnpoint.buddy_name.to_lower():
			print("okay garmin")
			print(self.is_ancestor_of(player))
			if !self.is_ancestor_of(player):
				self.add_child(player)
			player.get_node("StateMachine").reset_state()
			player.position = spawnpoint.position

func fetch_spawnpoints():
	spawnpoints = get_tree().get_nodes_in_group("Spawnpoint")
