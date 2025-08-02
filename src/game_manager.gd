extends Node2D
class_name GameManager

static var buddy_dict : Dictionary

var level_frame_counter := 0

var level
var spawnpoint
var selected_buddies : Array  # Legacy - will be cleaned up
var recorded_buddies : Array  # Buddies that have completed recordings
var current_buddy : Node = null  # Currently active/controllable buddy
var buddy_counter = 0

static var player_dict : Dictionary

func _process(_delta: float) -> void:
	level_frame_counter += 1

func start_run():
	level_frame_counter = 0
	
	clear_players_from_scene()
	
	for buddy in recorded_buddies:
		if buddy.is_inside_tree():
			print("Warning: Buddy ", buddy.name, " is already in scene tree")
		else:
			level.spawn_player(buddy)
			buddy.active = false

func spawn_current_player():
	if current_buddy:
		print("Spawning current player: ", current_buddy.name, " as controllable")
		level.spawn_player(current_buddy)
		current_buddy.active = true
		current_buddy.clear_recording()

func set_current_buddy(buddy_name: String):
	# Complete the previous buddy if there was one
	if current_buddy:
		print("Completing previous buddy: ", current_buddy.name, " with recording size: ", current_buddy.per_frame_input_array.size())
		recorded_buddies.append(current_buddy)
	
	# Create a new instance of the selected buddy
	if buddy_name.to_lower() in buddy_dict:
		current_buddy = buddy_dict[buddy_name.to_lower()].instantiate()
		current_buddy.name = buddy_name
		
		print("Total recorded buddies now: ", recorded_buddies.size())
		
		# Start the run with recorded buddies, then spawn current player
		start_run()
		spawn_current_player()

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

func clear_players_from_scene():
	# Get all player nodes in the scene and remove them (used for full reset)
	var players_to_remove = []
	for child in level.get_children():
		if child is Player:
			players_to_remove.append(child)
	
	print("Clearing ", players_to_remove.size(), " players from scene")
	
	# Remove all players from the scene
	for player in players_to_remove:
		if player.get_parent():
			print("Removing player: ", player.name)
			player.get_parent().call_deferred("remove_child", player)

func create_player(buddy_name : String):
	var first_player = buddy_dict[buddy_name].instantiate()
	selected_buddies.append(first_player)
	return first_player

func reset_level():
	# Reset for a fresh run
	level_frame_counter = 0
	recorded_buddies.clear()
	current_buddy = null
	# Clear all players from scene
	clear_players_from_scene()

func set_controlled_buddy_by_name(buddy_name: String):
	# Set the current buddy to the selected one
	set_current_buddy(buddy_name)
