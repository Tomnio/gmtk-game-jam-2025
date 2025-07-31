extends Node2D
class_name GameManager

@onready var player_bp := preload("res://Player/player.tscn")
@onready var level := get_tree().root.get_node("/root/Level")
@onready var buddy_select_bp := preload("res://Menu/buddy_select.tscn")
static var spawnpoint
var buddy_select

static var player_dict : Dictionary
var current_buddy : Player

func _ready() -> void:
	spawnpoint = level.get_node("./Spawnpoint")
	buddy_select = buddy_select_bp.instantiate()
	level.add_child(buddy_select)
	
	pass

func _process(delta: float) -> void:
	#for buddy in player_dict.values():
		#buddy.custom_process(delta)
	pass

func start_run():
	pass

func create_player():
	print("yee haw")
	var first_player = player_bp.instantiate()
	first_player.position = spawnpoint.position
	player_dict["Player-" + str(player_dict.size())] = first_player
	print(player_dict)
	level.spawn_player(first_player)
	
	return first_player
	
