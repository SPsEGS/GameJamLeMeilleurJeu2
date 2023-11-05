extends Player
class_name Alien

# Variables ===================================================================
# Exported
@export var grapple_max_distance = 10000
@export var grapple_reaction_strength : float = 1000
@export var grapple_reel_speed : float = 5

# Node references
@onready var raycast : RayCast2D = get_node("GrappleRaycast")
@onready var grapple_line : Line2D = get_node("GrappleLine")

# Global variables
var grapple_point : Vector2
var grapple_is_attached : bool = false
var grapple_target_distance : float


# Methods =====================================================================
# Engine Methods
func _ready():
	playerNb = "p2"

	grapple_line.hide()
	grapple_line.add_point(Vector2.ZERO)
	grapple_line.add_point(Vector2.ZERO)

func _process(delta):
	grapple_line.set_point_position(1, grapple_point - position)
	input_loop()
	
	if(grapple_is_attached):
		grapple_move(delta)
	else:
		move(delta)
	
# Input
func input_loop():
	super()
	var grapple_direction : Vector2
	grapple_direction = Input.get_vector("p2_grapple_left", "p2_grapple_right",
										 "p2_grapple_up", "p2_grapple_down").normalized()

	if Input.is_action_just_pressed("p2_grapple_throw"):
		if !grapple_direction.is_zero_approx():
			raycast.target_position = grapple_direction * grapple_max_distance
			raycast.force_raycast_update()

			if(raycast.is_colliding()):
				grapple_point = raycast.get_collision_point()
				grapple_target_distance = position.distance_to(grapple_point)
				grapple_throw()
	
	if(Input.is_action_just_released("p2_grapple_throw")):
		grapple_release()

#Grapple
func grapple_throw():
	grapple_line.set_point_position(1, grapple_point - position)
	grapple_line.show()
	grapple_is_attached = true

func grapple_release():
	grapple_line.hide()
	grapple_is_attached = false

func grapple_move(delta: float):
	var pull_direction : Vector2 = position.direction_to(grapple_point)
	var current_distance : float = position.distance_to(grapple_point)
	var stretch_factor : float = current_distance - grapple_target_distance

	grapple_target_distance -= grapple_reel_speed
	
	var pull_vector : Vector2
	if stretch_factor <= 0:
		pull_vector = Vector2.ZERO
	else:
		pull_vector = pull_direction * (log(stretch_factor) + 4) * grapple_reaction_strength

	velocity += pull_vector * delta
	velocity.y += gravity * delta
	move_and_slide()
	
func ded():
	position.x = 7200
	position.y = 2500
	
	
	
	
