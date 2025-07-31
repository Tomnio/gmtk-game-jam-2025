extends CanvasLayer
class_name BuddySelect

@onready var buddy_panel_bp = preload("res://Menu/buddy_panel.tscn")
@onready var container = $Control/VBoxContainer/HBoxContainer

func _ready() -> void:
	load_buddies()

func _on_confirm_button_pressed() -> void:
	Game.create_player()
	pass # Replace with function body.

func load_buddies(count: int = Game.buddy_counter):
	for i in range(count):
		add_buddy()

func add_buddy():
	var new_buddy = buddy_panel_bp.instantiate()
	container.add_child(new_buddy)
