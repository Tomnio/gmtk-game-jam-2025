extends Node2D
class_name GameManager

static var buddy_dict : Dictionary

var level_frame_counter := 0

var level
var spawnpoint
var recorded_buddies : Array  # Buddies that have completed recordings
var current_buddy : Node = null  # Currently active/controllable buddy
var buddy_counter = 0

static var player_dict : Dictionary



func _process(_delta: float) -> void:
	level_frame_counter += 1



func start_run_as(buddy_name):
	level_frame_counter = 0
	
	for buddy in BuddyHandler.get_buddies():
		if buddy.name.to_lower() == buddy_name:
			buddy.active = true
			level.spawn_player(buddy)
		else:
			buddy.active = false
		if buddy.per_frame_input_array.size() > 0:
			level.spawn_player(buddy)

#
#
#func spawn_current_player():
	#if current_buddy:
		#print("Spawning current player: ", current_buddy.name, " as controllable")
		#level.spawn_player(current_buddy)
		#current_buddy.active = true
		#current_buddy.clear_recording()


func complete_current_buddy():
	# Move current buddy to recorded buddies
	print("complete_current_buddy() called!")
	if current_buddy:
		print("Completing current buddy: ", current_buddy.name, " with recording size: ", current_buddy.per_frame_input_array.size())
		recorded_buddies.append(current_buddy)
		current_buddy = null
		print("Total recorded buddies now: ", recorded_buddies.size())
	else:
		print("Warning: complete_current_buddy() called but current_buddy is null!")

func reset_level():
	# Reset for a fresh run
	level_frame_counter = 0
	recorded_buddies.clear()
	current_buddy = null
	# Clear all players from scene
	#clear_players_from_scene()
