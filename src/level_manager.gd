extends Node

@onready var map_1 := preload("res://Map/map_1.tscn")
@onready var map_2 := preload("res://Map/map_2.tscn")

var level_dict := {}
var level_list := []
var current_level
var current_level_id := 0
var game_container

func _ready() -> void:
	level_dict = {
		"1" = map_1,
		"2" = map_2,
	}
	instantiate_levels()
	game_container = get_tree().get_first_node_in_group("Gamecontainer")

func instantiate_levels():
	for level in level_dict.keys():
		var level_instance = level_dict[level].instantiate()
		level_list.append(level_instance)

func change_level_to(level: int):
	if current_level:
		current_level.get_parent().remove_child(current_level)
	
	current_level_id = level
	current_level = level_list[level]
	GameManager.level = current_level
	game_container.add_child(level_list[level])

func goal_reached():
	change_level_to(current_level_id + 1)
	GameManager.start_run()
