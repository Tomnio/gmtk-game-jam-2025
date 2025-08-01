extends Node2D

@onready var label = $VBoxContainer/Label

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Map/level.tscn")


func _on_add_buddy_button_pressed() -> void:
	Game.buddy_counter += 1
	label.text = str(Game.buddy_counter)
	pass
