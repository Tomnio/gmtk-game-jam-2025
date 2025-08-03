extends Node2D


func _on_fahne_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		LevelManager.goal_reached()
		for buddy in BuddyHandler.get_buddies():
			buddy.clear_recording()
