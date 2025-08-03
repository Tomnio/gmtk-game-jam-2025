extends Node

@onready var katze_bp := preload("res://Player/katze.tscn")
@onready var katze_texture := preload("res://Player/Katze.png")

@onready var fliege_bp := preload("res://Player/fliege.tscn")
@onready var fliege_texture := preload("res://Player/Fliege.png")

@onready var frosch_bp := preload("res://Player/frosch.tscn")
@onready var frosch_texture := preload("res://Player/Frosch.png")

static var buddy_scene_dict : Dictionary
static var buddy_texture_dict : Dictionary
static var buddy_dict : Dictionary

func _ready() -> void:
	buddy_scene_dict = {
		"katze": katze_bp,
		"frosch": frosch_bp,
		"fliege": fliege_bp
	}
	buddy_texture_dict = {
		"katze": katze_texture,
		"frosch": frosch_texture,
		"fliege": fliege_texture
	}
	
	auto_load_all_buddies()

# =========== Auto-load all buddies ========== 
static func auto_load_all_buddies():
	for buddy_name in buddy_scene_dict.keys():
		var buddy_instance = buddy_scene_dict[buddy_name].instantiate()
		buddy_dict[buddy_name] = buddy_instance

func get_buddy(name: String):
	return buddy_dict[name]

func get_buddies():
	return buddy_dict.values()
