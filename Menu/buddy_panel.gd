extends PanelContainer

@onready var texture = $VBoxContainer/TextureRect
@onready var button = $VBoxContainer/Button
var buddy_texture
var buddy_name
var level

func _ready() -> void:
	texture.texture = buddy_texture
	button.text = buddy_name
	level = get_tree().get_first_node_in_group("level")

func _on_button_pressed() -> void:
	Game.start_run_as(buddy_name.to_lower())
	
	# buddy_select below
	get_parent().get_parent().get_parent().get_parent().hide()
	level.escape_label.show()
