extends State
class_name Fall

const animation_name := "fall"


func Update(_delta):
	player.velocity.x = inputs["movement"].x * player.SPEED

	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "hover")

	if player.is_on_floor():
		Transitioned.emit(self, "idle")
	super.Update(_delta)
