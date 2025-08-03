extends State
class_name Run

func Enter():
	audiostream_players["WalkAudio"].play()
	super.Enter()

func Update(_delta):
	if inputs.has("buttons") and inputs["buttons"].has("accept") and inputs["buttons"]["accept"]:
		Transitioned.emit(self, "jump")
	
	player.velocity.x = inputs["movement"].x * player.SPEED
	
	if abs(player.velocity.x) == 0:
		Transitioned.emit(self, "idle")
	
	super.Update(_delta)

func Exit():
	audiostream_players["WalkAudio"].pitch_scale = randf_range(0.95, 1.05)
	audiostream_players["WalkAudio"].stop()
	super.Exit()
