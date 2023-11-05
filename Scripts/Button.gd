extends Area2D
class_name PushButton

var triggered : bool = false
var overlapping_body : Node2D
var human_present : bool = false

func _process(_delta):
    if(overlapping_body is Human):
        var human : Human = overlapping_body as Human
        if(human_present and Input.is_action_just_pressed("p1_interact") and human.can_interact()):
            human.anim_hand()
            triggered = true


func _on_body_entered(body:Node2D):
    overlapping_body = body
    human_present = true

func _on_body_exited(_body:Node2D):
    human_present = false
