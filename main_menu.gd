extends Node2D

@onready var label = $VBoxContainer/Label
@onready var button_container: VBoxContainer = $VBoxContainer
@onready var peete_bp := preload("res://Player/peete.tscn")
@onready var katze_bp := preload("res://Player/katze.tscn")
@onready var fliege_bp := preload("res://Player/fliege.tscn")

var buddy_scene_dict : Dictionary
var buddy_list : Array



func _ready() -> void:
	buddy_scene_dict = {
		"peete": peete_bp,
		"fliege": fliege_bp,
		"katze": katze_bp
		}
	create_buddy_buttons()

# =========== Choose Buddies to take to the level ========== 
func create_buddy_buttons():
	for buddy_name in buddy_scene_dict.keys():
		var button = Button.new()
		button.text = "Add " + buddy_name.capitalize()
		button.name = buddy_name + "_button"
		
		button.pressed.connect(_on_buddy_button_pressed.bind(buddy_name))
		
		button_container.add_child(button)


func remove_buddy(buddy_name: String):
	for i in range(buddy_list.size()):
		if buddy_list[i].name == buddy_name:
			if buddy_list[i].get_parent():
				buddy_list[i].queue_free()
			
			buddy_list.remove_at(i)
			print("Removed " + buddy_name + " from buddy_list")
			break


func _on_buddy_button_pressed(buddy_name: String):
	var already_exists = false
	for buddy in buddy_list:
		if buddy.name == buddy_name:
			already_exists = true
			break
	
	if not already_exists:
		var buddy_instance = buddy_scene_dict[buddy_name].instantiate()
		buddy_list.append(buddy_instance)
		
		var buddy_names = []
		for buddy in buddy_list:
			buddy_names.append(buddy.name)
		print("Current buddies: ", buddy_names)

func _on_start_button_pressed() -> void:
	Game.selected_buddies = buddy_list
	# Initialize buddy activity - only first one should be active
	for i in range(Game.selected_buddies.size()):
		Game.selected_buddies[i].active = (i == 0)
	# Reset game manager state
	Game.current_buddy_index = 0
	Game.completed_buddies.clear()
	get_tree().change_scene_to_file("res://Map/level.tscn")
