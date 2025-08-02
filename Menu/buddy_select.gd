extends CanvasLayer
class_name BuddySelect

@onready var buddy_panel_bp = preload("res://Menu/buddy_panel.tscn")
@onready var container = $Control/VBoxContainer/HBoxContainer

@onready var katze_texture := preload("res://Player/Katze.png")
@onready var fliege_texture := preload("res://Player/Fliege.png")
@onready var peete_texture := preload("res://Player/Player_rotze.png")

var buddy_texture_dict : Dictionary

func _ready() -> void:
	buddy_texture_dict = {
	"katze": katze_texture,
	"fliege": fliege_texture,
	"peete": peete_texture
	}
	load_buddies()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.show()

#func _on_confirm_button_pressed() -> void:
	#Game.start_run()
	#self.hide()
	#pass

func load_buddies(buddy_array: Array = Game.selected_buddies):
	for i in buddy_array:
		add_buddy(i)

func add_buddy(bud):
	var new_buddy = buddy_panel_bp.instantiate()
	new_buddy.buddy_name = bud.name
	new_buddy.buddy_texture = buddy_texture_dict[bud.name.to_lower()]
	container.add_child(new_buddy)
