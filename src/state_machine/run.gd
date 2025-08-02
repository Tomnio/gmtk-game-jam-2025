extends State
class_name Run

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	player.velocity.x = inputs["movement"].x * player.SPEED
	
	
	if abs(player.velocity.x) == 0:
		Transitioned.emit(self, "idle")
	
	
	super.Update(_delta)
