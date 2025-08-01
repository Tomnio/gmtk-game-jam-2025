extends PanelContainer

@onready var texture = $VBoxContainer/TextureRect
@onready var button = $VBoxContainer/Button
var buddy_texture
var buddy_name
var level

func _ready() -> void:
	texture.texture = buddy_texture
	button.text = buddy_name
	level = get_node("/root/Level")
	pass


func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	# Set which buddy to control and restart level for recording
	Game.set_controlled_buddy_by_name(buddy_name.to_lower())
	pass
