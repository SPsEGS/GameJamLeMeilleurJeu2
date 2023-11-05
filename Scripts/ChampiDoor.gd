extends StaticBody2D

@export var button : PushButton
@export var pressure_plate : PressurePlate

@onready var door_collision : CollisionShape2D = get_node("DoorCollision")
@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")

var open : bool = false

func _process(_delta):
	if(button.triggered and pressure_plate.triggered and !open):
		open = true
		door_collision.disabled = true
		animated_sprite.play("Open")



func _on_end_triggger_body_entered(body):
	if(body is Alien or body is Human):
		end_game()

func end_game():
	print("MARVEL presents Avengers: Endgame")

