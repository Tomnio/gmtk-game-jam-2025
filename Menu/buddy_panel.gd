extends PanelContainer

@onready var texture = $VBoxContainer/TextureRect
@onready var button = $VBoxContainer/Button
var buddy_texture
var buddy_name

func _ready() -> void:
	texture.texture = buddy_texture
	button.text = buddy_name
	pass


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Game.create_player(buddy_name)
	pass
