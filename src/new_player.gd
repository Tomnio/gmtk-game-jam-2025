extends CharacterBody2D
class_name Player

var active_controller_id: int = -1
var active : bool = false
var inputs : Dictionary:
	get:
		if active:
			return inputs
		elif per_frame_input_array.size() > Game.level_frame_counter:
			return per_frame_input_array[Game.level_frame_counter]
		else:
			return {"buttons": {}, "movement": Vector2.ZERO}

var per_frame_input_array : Array

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$Sprite.scale.x = abs($Sprite.scale.x) * sign(get_movement().x)
	pass

func _physics_process(delta: float) -> void:
	if active:
		inputs = generate_input()

var last_gen
func generate_input() -> Dictionary:
	var current_input = {"buttons": get_pressed_buttons(), "movement": get_movement()}
	if not last_gen == Game.level_frame_counter:
		per_frame_input_array.append(current_input)
	last_gen = Game.level_frame_counter
	return current_input

func get_movement() -> Vector2:
	var movement: Vector2
	movement = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
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
	var current_moves = {}  # Create fresh each time
	for button in moves:
		current_moves[button] = Input.is_action_just_pressed("ui_" + button)
	return current_moves

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

# =========== Recording shtuff ========== #

func clear_recording():
	per_frame_input_array.clear()
