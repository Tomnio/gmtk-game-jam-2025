extends State
class_name Idle

func Enter():
	player.velocity = Vector2.ZERO
	super.Enter()

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	if inputs.has("movement") and inputs["movement"].x:
		Transitioned.emit(self, "run")
	
	if inputs.has("buttons") and inputs["buttons"].has("ability") and inputs["buttons"]["ability"]:
		Transitioned.emit(self, "boost")
	
	super.Update(_delta)

func boost_buddy():
		Transitioned.emit(self, "boost")


func _on_boost_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.name.to_lower() != "giraffe":
		body.JUMP_BOOST_MULT = 1.2
		body.get_node("StateMachine").current_state.overwrite_state("jump")
