extends Node2D
class_name GameManager

@onready var peete_bp := preload("res://Player/peete.tscn")
@onready var katze_bp := preload("res://Player/katze.tscn")

var level
static var spawnpoint
var buddy_dict : Dictionary
var buddy_counter = 0

static var player_dict : Dictionary
var current_buddy : Player

func _ready() -> void:
	buddy_dict = {
		"peete": peete_bp,
		"katze": katze_bp
		}

func start_run():
	for player in player_dict.values():
		print(player)
	pass

func create_player(buddy_name : String):
	var first_player = buddy_dict[buddy_name].instantiate()
	player_dict["Player-" + str(player_dict.size())] = first_player
	level.spawn_player(first_player)
	
	return first_player
	
