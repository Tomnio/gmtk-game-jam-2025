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


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Game.set_controlled_player(buddy_name.to_lower())
	#for buddy in Game.selected_buddies:
		#level.spawn_player(buddy)
	pass
