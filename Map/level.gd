extends Node2D
class_name Level

@onready var escape_label = $escapeLabel if has_node("escapeLabel") else null

func _ready() -> void:
	Game.level = self
	Game.start_run()

func spawn_player(player: Player):
	# Add player to scene
	if player.get_parent():
		player.get_parent().remove_child(player)
	self.add_child(player)
	player.get_node("StateMachine").reset_state()
	
	var player_count = get_children().filter(func(child): return child is Player).size()
	var offset_distance = 50  # Adjust this value as needed
	
	# Circular pattern
	var angle = (player_count * PI * 2) / 4  # Assuming max 4 players
	var offset = Vector2(cos(angle), sin(angle)) * offset_distance
	
	player.position = $Spawnpoint.position + offset
