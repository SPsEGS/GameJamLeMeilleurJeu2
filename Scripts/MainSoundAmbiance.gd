extends Node

var child : AudioStreamPlayer
var dring = false

# Called when the node enters the scene tree for the first time.
func _ready():
	child = $AudioStreamPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!child.playing):
		child.play()


func _on_timer_timeout():
	if (dring):
		$Dring.play()
		dring = false
	else:
		$Drong.play()
		dring = true
