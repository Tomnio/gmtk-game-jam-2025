extends State
class_name Run

var SPEED := 300.0

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	player.velocity.x = inputs["movement"].x * SPEED
	print(player.velocity.x)
	
	
	if abs(player.velocity.x) == 0:
		Transitioned.emit(self, "idle")
	
	
	super.Update(_delta)
