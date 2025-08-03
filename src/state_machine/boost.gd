extends State
class_name Boost

@onready var boost_area = $"../../Sprite/BoostArea"

func Enter():
	player.velocity = Vector2.ZERO
	activate_boost()
	super.Enter()

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	if inputs.has("movement") and inputs["movement"].x:
		Transitioned.emit(self, "run")
	
	super.Update(_delta)

func Exit():
	deactivate_boost()
	super.Exit()

func _on_boost_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.name.to_lower() != "katze":
		animation_player.play("boosting")
		body.JUMP_BOOST_MULT = 1.4
		body.get_node("StateMachine").current_state.overwrite_state("jump")

func activate_boost():
	boost_area.monitoring = true
	pass

func deactivate_boost():
	boost_area.monitoring = false
	pass
