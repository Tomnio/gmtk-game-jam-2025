extends State
class_name Idle

func Enter():
	player.velocity = Vector2.ZERO
	super.Enter()

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	if inputs["movement"].x:
		Transitioned.emit(self, "run")
	
	super.Update(_delta)
