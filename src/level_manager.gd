extends Node

@onready var map_1 := preload("res://Map/map_1.tscn")
@onready var map_2 := preload("res://Map/map_2.tscn")
@onready var map_3 := preload("res://Map/map_3.tscn")

var level_dict := {}
var level_list := []
var current_level
var current_level_id := 0
var game_container

func _ready() -> void:
	level_dict = {
		"1" = map_1,
		"2" = map_2,
		"3" = map_3,
	}
	instantiate_levels()
	game_container = get_tree().get_first_node_in_group("Gamecontainer")

func instantiate_levels():
	for level in level_dict.keys():
		var level_instance = level_dict[level].instantiate()
		level_list.append(level_instance)

func change_level_to(level: int):
	if current_level and current_level.get_parent():
		var parent = current_level.get_parent()
		if parent.has_method("remove_child") and current_level in parent.get_children():
			parent.call_deferred("remove_child", current_level)
	
	print(current_level_id)
	# Check bounds to prevent crashes
	if level >= level_list.size():
		print("Trying to access level ", level, " but only ", level_list.size(), " levels available")
		return
	
	current_level_id = level
	current_level = level_list[level]
	Game.level = current_level
	game_container.call_deferred("add_child", level_list[level])

func goal_reached():
	print("REACHED")
	change_level_to(current_level_id + 1)
