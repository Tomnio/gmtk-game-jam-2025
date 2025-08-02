extends State
class_name Hover

var duration := 5.0

func Enter():
	player.velocity = Vector2.ZERO
	super.Enter()

var any_input := false
func Update(_delta: float):
	if inputs.has("buttons"):
		for input in inputs["buttons"]:
			if input != "accept":
				any_input = any_input || inputs["buttons"][input]
		
	player.velocity.y = 0
	if player.is_on_floor() or duration <= 0 or any_input:
		Transitioned.emit(self, "fall")
		any_input = false
	else:
		duration -= _delta
	player.move_and_slide()
	pass

func Exit():
	duration = 5.0
