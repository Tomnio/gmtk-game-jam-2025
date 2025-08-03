extends CanvasLayer
class_name BuddySelect

@onready var buddy_panel_bp = preload("res://Menu/buddy_panel.tscn")
@onready var container = $Control/VBoxContainer/HBoxContainer

@onready var katze_texture := preload("res://Player/Katze.png")
@onready var fliege_texture := preload("res://Player/Fliege.png")
@onready var frosch_texture := preload("res://Player/Frosch.png")

var buddy_texture_dict : Dictionary

func _ready() -> void:
	buddy_texture_dict = {
	"katze": katze_texture,
	"fliege": fliege_texture,
	"frosch": frosch_texture
	}
	load_buddies()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.show()
		get_tree().get_first_node_in_group("level").escape_label.hide()

func load_buddies():
	var buddy_names = ["katze", "fliege", "frosch"]
	for buddy_name in buddy_names:
		add_buddy_by_name(buddy_name)

func add_buddy_by_name(buddy_name: String):
	var new_buddy = buddy_panel_bp.instantiate()
	new_buddy.buddy_name = buddy_name
	new_buddy.buddy_texture = buddy_texture_dict[buddy_name.to_lower()]
	container.add_child(new_buddy)
