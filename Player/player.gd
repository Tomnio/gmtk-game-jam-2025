extends CharacterBody2D
class_name Player

var ID


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var active_controller_id: int = -1
var active := true

var last_movement_iteration : Array

@onready var _animation_player := $AnimationPlayer
@onready var _sprite := $Sprite


func _ready() -> void:
	say_hi()

func _physics_process(delta: float) -> void:
	var buttons = get_pressed_buttons()
	var movement = get_movement()

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if buttons["accept"] and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if movement.x:
		_animation_player.play("run")
		_sprite.scale.x = abs(_sprite.scale.x) * sign(movement.x)
		velocity.x = movement.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func say_hi():
	print("hi")
func get_active_controller_id() -> int:
	if active_controller_id != -1:
		return active_controller_id

	for id in Input.get_connected_joypads():
		var axis_x = Input.get_joy_axis(id, JOY_AXIS_LEFT_X)
		var axis_y = Input.get_joy_axis(id, JOY_AXIS_LEFT_Y)
		var joy_input = Vector2(axis_x, axis_y)

		if joy_input.length() > 0.1:  # deadzone
			active_controller_id = id
			return active_controller_id

	return -1  # no active controller found

func get_movement() -> Vector2:
	var movement: Vector2
	movement = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_accept")
	)
	if movement.length() <= 0:
		var id = get_active_controller_id()
		movement = Vector2(
			Input.get_joy_axis(id, JOY_AXIS_LEFT_X),
			Input.get_joy_axis(id, JOY_AXIS_LEFT_Y)
		)
	return movement

var moves := {
	"up": 0,
	"down": 0,
	"accept": 0,
	"left": 0,
	"right": 0,
}

func get_pressed_buttons() -> Dictionary:
	if not active:
		return moves
	for button in moves:
		moves[button] = Input.is_action_just_pressed("ui_" + button)
	return moves
