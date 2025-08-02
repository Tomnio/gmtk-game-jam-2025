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
	Game.set_controlled_buddy_by_name(buddy_name.to_lower())
	get_parent().get_parent().get_parent().get_parent().hide()
	get_tree().get_first_node_in_group("level").escape_label.show()
