extends Area2D

var has_played : bool = false

func _on_body_entered(body):
	if (body is Player and !has_played):
		$AudioStreamPlayer.play()
		has_played = true
