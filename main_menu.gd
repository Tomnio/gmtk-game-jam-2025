extends Control

func _on_start_button_pressed() -> void:
	
	self.hide()
	LevelManager.change_level_to(0)
	## Legacy selected_buddies - keeping for now during transition
	#Game.selected_buddies = buddy_list
	#print("Starting with buddies: ", Game.selected_buddies)
	#
	## Initialize buddy activity - all inactive until selected from buddy panel
	#for buddy in Game.selected_buddies:
		#buddy.active = false
	#
	## Reset game manager state
	#Game.recorded_buddies.clear()
	#Game.current_buddy = null

#var buddy_scene_dict : Dictionary
#var buddy_texture_dict : Dictionary
#var buddy_list : Array

#func _ready() -> void:
	#buddy_scene_dict = {
		#"katze": katze_bp,
		#"frosch": frosch_bp,
		#"fliege": fliege_bp
	#}
	#buddy_texture_dict = {
		#"katze": katze_texture,
		#"frosch": frosch_texture,
		#"fliege": fliege_texture
	#}
	#
	## Set up the global buddy dictionary for game manager
	#Game.buddy_dict = buddy_scene_dict
