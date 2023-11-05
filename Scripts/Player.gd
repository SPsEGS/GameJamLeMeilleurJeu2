extends CharacterBody2D
class_name Player

# Variables ===================================================================
# Exported
@export var speed : float = 40000
@export var acceleration : float = 8000
@export var drag : float = 15
@export var gravity : float = 3000
@export var jump_impulse : float = 1200
@export var can_jump : bool = true

# Global Variables
var playerNb : String;

var direction : float = 0
var has_jumped : bool = false

# Methods =====================================================================
# Engine Methods
func _process(delta):
	input_loop()
	move(delta)

# Input
func input_loop() :
	direction = int(Input.is_action_pressed(playerNb + "_mv_right")) - int(Input.is_action_pressed(playerNb + "_mv_left"))
	if(Input.is_action_pressed(playerNb + "_jump") and is_on_floor() and !has_jumped):
		jump()

# Movement
func move(delta) :
	# Horizontal motion
	velocity.x += direction * acceleration * delta

	# Horizontal drag
	velocity.x -= drag * velocity.x * delta

	# Gravity
	velocity.y += gravity * delta

	move_and_slide()
	if(is_on_floor()):
		has_jumped = false
		
	print(direction != 0, is_on_floor(), !$AudioStreamPlayer2D.playing)
	if (direction != 0 && is_on_floor() && !$AudioStreamPlayer2D.playing):
		$AudioStreamPlayer2D.play()


func jump():
	if (can_jump) :
		velocity.y = -jump_impulse
		has_jumped = true
