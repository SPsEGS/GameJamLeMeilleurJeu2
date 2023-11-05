extends Area2D

class_name Petit_champi

func _on_body_entered(body : CharacterBody2D):
	$AnimationPlayer.play("flashing")
	var player := body as Human
	if (player and !player.hold_object) :
		player.set_on_mushmush(self)

func _on_body_exited(body : CharacterBody2D):
	$AnimationPlayer.stop()
	var player := body as Human
	if (player) :
		player.set_off_mushmush()
