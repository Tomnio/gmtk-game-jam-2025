extends State
class_name Jump

var BOOST := 1

func Enter():
	player.velocity.y = player.JUMP_VELOCITY
	super.Enter()

func Update(_delta):
	player.velocity.x = inputs["movement"].x * player.SPEED * BOOST
	
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "hover")
	
	super.Update(_delta)
