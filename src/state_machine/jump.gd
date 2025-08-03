extends State
class_name Jump

func Enter():
	print("JUMP MULT = " + str(player.JUMP_BOOST_MULT))
	player.velocity.y = player.JUMP_VELOCITY * player.JUMP_BOOST_MULT
	super.Enter()

func Update(_delta):
	player.velocity.x = inputs["movement"].x * player.SPEED
	
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "hover")
	
	super.Update(_delta)

func Exit():
	player.JUMP_BOOST_MULT = 1.0
	super.Exit()
