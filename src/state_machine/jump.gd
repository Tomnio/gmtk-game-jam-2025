extends State
class_name Jump

var SPEED := 300.0
var JUMP_VELOCITY = -400

func Enter():
	player.velocity.y = JUMP_VELOCITY
	super.Enter()

func Update(_delta):
	player.velocity.x = inputs["movement"].x * SPEED
	super.Update(_delta)
