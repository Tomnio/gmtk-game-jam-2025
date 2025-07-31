extends Node2D
class_name GameManager

@onready var player_bp := preload("res://Player/player.tscn")
var level
static var spawnpoint
var buddy_counter = 0

static var player_dict : Dictionary
var current_buddy : Player

func start_run():
	for player in player_dict.values():
		print(player)
	pass

func create_player():
	var first_player = player_bp.instantiate()
	player_dict["Player-" + str(player_dict.size())] = first_player
	level.spawn_player(first_player)
	
	return first_player
	
