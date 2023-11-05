extends Area2D

var is_reachable = false
var who
var is_on : bool = false

@onready var _animation_champi = $AnimationPlayer

func _process(_delta) :
	var player := who as Human
	if (player) :
		if (is_reachable and Input.is_action_just_pressed("p1_interact") and player.can_interact()) :
			player.anim_hand()
			if(is_on):
				_animation_champi.play("Light_off")
				is_on = false
			else:
				_animation_champi.play("Light_on")
				is_on = true

func _on_body_entered(body : CharacterBody2D):
	who = body
	is_reachable = true


func _on_body_exited(_body):
	is_reachable = false

