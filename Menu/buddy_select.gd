extends CanvasLayer
class_name BuddySelect

@onready var buddy_panel_bp = preload("res://Menu/buddy_panel.tscn")
@onready var container = $Control/VBoxContainer/HBoxContainer

@onready var katze_texture := preload("res://Player/Katze.png")
@onready var peete_texture := preload("res://Player/Player_rotze.png")

var buddy_texture_dict : Dictionary

func _ready() -> void:
	buddy_texture_dict = {
	"katze": katze_texture,
	"peete": peete_texture
	}
	load_buddies()

func _on_confirm_button_pressed() -> void:
	pass # Replace with function body.

func load_buddies(buddy_dict: Dictionary = Game.buddy_dict):
	for i in buddy_dict:
		add_buddy(i)

func add_buddy(bud):
	var new_buddy = buddy_panel_bp.instantiate()
	new_buddy.buddy_name = bud
	new_buddy.buddy_texture = buddy_texture_dict[bud]
	container.add_child(new_buddy)
