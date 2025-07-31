extends AnimatableBody2D

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0

var direction: int = 1
var target: Vector2

func _ready():
	position = point_a
	target = point_b

func _process(delta):
	var movement = (target - position).normalized() * speed * delta
	if position.distance_to(target) <= speed * delta:
		# Snap to target and reverse direction
		position = target
		target = point_a if target == point_b else point_b
	else:
		position += movement
