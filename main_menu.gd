extends Control

@onready var katze_bp := preload("res://Player/katze.tscn")
@onready var katze_texture := preload("res://Player/Katze.png")

@onready var fliege_bp := preload("res://Player/fliege.tscn")
@onready var fliege_texture := preload("res://Player/Fliege.png")

@onready var frosch_bp := preload("res://Player/frosch.tscn")
@onready var frosch_texture := preload("res://Player/Frosch.png")


var buddy_scene_dict : Dictionary
var buddy_texture_dict : Dictionary
var buddy_list : Array

func _ready() -> void:
	buddy_scene_dict = {
		"katze": katze_bp,
		"frosch": frosch_bp,
		"fliege": fliege_bp
	}
	buddy_texture_dict = {
		"katze": katze_texture,
		"frosch": frosch_texture,
		"fliege": fliege_texture
	}
	
	# Set up the global buddy dictionary for game manager
	Game.buddy_dict = buddy_scene_dict
	
	auto_load_all_buddies()

# =========== Auto-load all buddies ========== 
func auto_load_all_buddies():
	for buddy_name in buddy_scene_dict.keys():
		var buddy_instance = buddy_scene_dict[buddy_name].instantiate()
		buddy_list.append(buddy_instance)
	
	var buddy_names = []
	for buddy in buddy_list:
		buddy_names.append(buddy.name)
	print("Auto-loaded buddies: ", buddy_names)

func remove_buddy(buddy_name: String):
	for i in range(buddy_list.size()):
		if buddy_list[i].name == buddy_name:
			if buddy_list[i].get_parent():
				buddy_list[i].queue_free()
			
			buddy_list.remove_at(i)
			print("Removed " + buddy_name + " from buddy_list")
			break

func _on_start_button_pressed() -> void:
	# Legacy selected_buddies - keeping for now during transition
	Game.selected_buddies = buddy_list
	print("Starting with buddies: ", Game.selected_buddies)
	
	# Initialize buddy activity - all inactive until selected from buddy panel
	for buddy in Game.selected_buddies:
		buddy.active = false
	
	# Reset game manager state
	Game.recorded_buddies.clear()
	Game.current_buddy = null
	
	self.hide()
	LevelManager.change_level_to(0)
