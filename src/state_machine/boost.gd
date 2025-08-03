extends State
class_name Boost

@onready var boost_area = $"../../Sprite/BoostArea"

func Enter():
	player.velocity = Vector2.ZERO
	boost_area.monitoring = true
	super.Enter()

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	if inputs.has("movement") and inputs["movement"].x:
		Transitioned.emit(self, "run")
	
	super.Update(_delta)

func Exit():
	boost_area.monitoring = false
	super.Exit()

func _on_boost_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.name.to_lower() != "katze":
		animation_player.play("boosting")
		body.JUMP_BOOST_MULT = 2.0
		body.get_node("StateMachine").current_state.overwrite_state("jump")
