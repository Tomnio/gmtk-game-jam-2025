extends State
class_name Fall

var SPEED := 300.0


func Update(_delta):
	player.velocity.x = inputs["movement"].x * SPEED
	if player.is_on_floor():
		Transitioned.emit(self, "idle")
	super.Update(_delta)
