extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var sp : AnimatedSprite2D = $AnimatedSprite2D
	sp.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if (body is Alien):
		body.ded()
