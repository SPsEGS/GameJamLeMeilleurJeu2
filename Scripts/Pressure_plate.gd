extends Area2D
class_name PressurePlate

#@export var target : Door

var triggered : bool = false

func _on_body_entered(body : Node2D):
	if(body is Alien):
		triggered = true
