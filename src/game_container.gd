extends Node2D

@onready var main_menu = preload("res://Menu/main_menu.tscn")

var main_menu_instance

func _ready() -> void:
	main_menu_instance = main_menu.instantiate()
	add_child(main_menu_instance)

func go_back_to_main_menu():
	for level in get_tree().get_nodes_in_group("level"):
		level.get_parent().remove_child(level)
	main_menu_instance.show()
