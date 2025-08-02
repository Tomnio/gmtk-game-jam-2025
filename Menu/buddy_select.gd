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
	create_reset_button()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.show()
		get_tree().get_first_node_in_group("level").escape_label.hide()

#func _on_confirm_button_pressed() -> void:
	#Game.start_run()
	#self.hide()
	#pass

func load_buddies():
	# Load available buddy types instead of using selected_buddies array
	var buddy_names = ["katze", "fliege", "frosch"]
	for buddy_name in buddy_names:
		add_buddy_by_name(buddy_name)

func add_buddy_by_name(buddy_name: String):
	var new_buddy = buddy_panel_bp.instantiate()
	new_buddy.buddy_name = buddy_name
	new_buddy.buddy_texture = buddy_texture_dict[buddy_name.to_lower()]
	container.add_child(new_buddy)


func create_reset_button():
	var reset_button = Button.new()
	reset_button.text = "Reset Level"
	reset_button.name = "reset_level_button"
	reset_button.pressed.connect(_on_reset_level_pressed)
	container.add_child(reset_button)

func _on_reset_level_pressed():
	Game.reset_level()
	self.hide()
	get_tree().get_first_node_in_group("level").escape_label.show()
	Game.reset_level()
