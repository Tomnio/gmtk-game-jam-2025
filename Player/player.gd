extends CharacterBody2D
class_name Player

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var active_controller_id: int = -1
var active := true
var current_state := "idle" 

var last_movement_iteration : Array

var _animation_player
@onready var _sprite := $Sprite

func reset_for_new_run():
	if active:
		last_movement_iteration.clear()

func clear_recording():
	last_movement_iteration.clear()

var input
func _physics_process(delta: float) -> void:
	if current_state == "hover":
		play_ability()
		return
	if active:
		input = get_input()
	elif last_movement_iteration.size() > Game.level_frame_counter:
		input = last_movement_iteration[Game.level_frame_counter]
	else:
		# No more recorded input, use default empty input
		input = {"buttons": {}, "movement": Vector2.ZERO}

	if input.has("buttons") and input["buttons"].has("ability") and input["buttons"]["ability"]:
		play_ability()
		return
		

	# Handle jump.
	if input.has("buttons") and input["buttons"].has("accept") and input["buttons"]["accept"] and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if input.has("movement") and input["movement"].x:
		_animation_player.play("run")
		_sprite.scale.x = abs(_sprite.scale.x) * sign(input["movement"].x)
		velocity.x = input["movement"].x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	print(_animation_player.current_animation)
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	if _animation_player.current_animation == "hover":
		velocity.y = 0

	move_and_slide()

func play_ability():
	pass

func get_input() -> Dictionary:
	var current_input = {"buttons": get_pressed_buttons(), "movement": get_movement()}
	last_movement_iteration.append(current_input)
	return current_input

func get_movement() -> Vector2:
	var movement: Vector2
	movement = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_up")
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
	"ability": 0,
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
