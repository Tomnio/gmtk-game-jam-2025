extends Node2D
class_name GameManager

var buddy_dict : Dictionary

var level_frame_counter := 0

var level
static var spawnpoint
var selected_buddies : Array
var buddy_counter = 0

var player_dict : Dictionary

func _process(delta: float) -> void:
	level_frame_counter += 1
	print(level_frame_counter)

func start_run():
	level_frame_counter = 0
	for buddy in selected_buddies:
		level.spawn_player(buddy)
	pass

func create_player(buddy_name : String):
	var first_player = buddy_dict[buddy_name].instantiate()
	selected_buddies.append(first_player)
	return first_player

func set_controlled_player(buddy_name):
	for player in selected_buddies:
		if player.name.to_lower() == buddy_name.to_lower():
			player.active = true
		else:
			player.active = false
