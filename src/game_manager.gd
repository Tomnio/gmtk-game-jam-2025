extends Node2D
class_name GameManager

static var buddy_dict : Dictionary

static var level_frame_counter := 0

static var level
static var spawnpoint
static var selected_buddies : Array
static var completed_buddies : Array  # Buddies that have finished their recording
static var current_buddy_index := 0   # Index of currently controlled buddy
static var buddy_counter = 0

static var player_dict : Dictionary

func _process(_delta: float) -> void:
	level_frame_counter += 1

static func start_run():
	level_frame_counter = 0
	
	# Clear all players from the scene first
	clear_players_from_scene()
	
	# Ensure we have buddies to work with
	if selected_buddies.size() == 0:
		return
	
	# Spawn all buddies that either have recordings or are the current controlled buddy
	for i in range(selected_buddies.size()):
		var buddy = selected_buddies[i]
		var has_recording = buddy.per_frame_input_array.size() > 0
		var is_current_buddy = i == current_buddy_index
		
		# Spawn if it has a recording or is the current buddy
		if has_recording or is_current_buddy:
			print(level)
			level.spawn_player(buddy)
			if i == current_buddy_index:
				# This is the currently controlled buddy
				buddy.active = true
				buddy.clear_recording()
			else:
				# This is a buddy with a recording, set it to replay mode
				buddy.active = false

static func clear_players_from_scene():
	# Remove all players from the scene
	for buddy in selected_buddies:
		if buddy.get_parent():
			buddy.get_parent().remove_child(buddy)

func create_player(buddy_name : String):
	var first_player = buddy_dict[buddy_name].instantiate()
	selected_buddies.append(first_player)
	return first_player

func complete_current_buddy():
	# Mark current buddy as completed and move to next
	if current_buddy_index < selected_buddies.size():
		completed_buddies.append(selected_buddies[current_buddy_index])
		current_buddy_index += 1
		# Restart the level for the next buddy
		start_run()

func reset_level():
	# Reset for a fresh run with all buddies
	level_frame_counter = 0
	current_buddy_index = 0
	completed_buddies.clear()
	# Clear all recordings
	for buddy in selected_buddies:
		buddy.clear_recording()
	start_run()

func get_current_buddy_index() -> int:
	return current_buddy_index

func is_buddy_completed(buddy_index: int) -> bool:
	return buddy_index < current_buddy_index

func set_controlled_player(buddy_name):
	for player in selected_buddies:
		if player.name.to_lower() == buddy_name.to_lower():
			player.active = true
		else:
			player.active = false

func set_controlled_buddy_by_name(buddy_name: String):
	# Find the index of the buddy to control
	var buddy_index = -1
	for i in range(selected_buddies.size()):
		if selected_buddies[i].name.to_lower() == buddy_name.to_lower():
			buddy_index = i
			break
	
	if buddy_index != -1:
		# Set current buddy index to the selected one
		current_buddy_index = buddy_index
		# Only clear recording for the selected buddy (for re-recording)
		selected_buddies[buddy_index].clear_recording()
		# Don't clear other buddies - let them keep their recordings for replay
		
		# Restart the level
		start_run()
