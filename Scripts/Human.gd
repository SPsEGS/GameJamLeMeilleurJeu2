extends Player

class_name Human

var crouching : bool = false
var speed_crouching : float = speed / 2
var reel_speed : float = speed
var hold_object : bool = false
var on_piti_champi : bool = false
var which_mush : Petit_champi
var baby_mush : Node
var mush_parent
var au_repos = true
var last_direction = true

@onready var _animation_player = $AnimationPlayer

func anim_hand() :
	au_repos = false
	_animation_player.play("hand_up")
	await get_tree().create_timer(1.2).timeout
	au_repos = true

func can_interact() :
	return (!hold_object and !crouching)

func set_on_mushmush(body : Petit_champi) :
	on_piti_champi = true
	which_mush = body
	
func set_off_mushmush() :
	on_piti_champi = false

func _ready() :
	playerNb = "p1"

func input_loop() :	
	super()
	
	if (Input.is_action_pressed("p1_mv_left")) :
		last_direction = false
	if (Input.is_action_pressed("p1_mv_right")) :
		last_direction = true
	
	if (!crouching and direction == 0 and au_repos) :
		_animation_player.play("repos")
	
	if (Input.is_action_just_pressed(playerNb + "_crouch") and is_on_floor()) :
		if(!crouching) :
			if (au_repos) :
				crouch()
				crouching = true
		else :
			speed = reel_speed
			crouching = false
			au_repos = false
			if (last_direction) :
				_animation_player.play("un_crouching_right")
			else :
				_animation_player.play("un_crouching")
			await get_tree().create_timer(0.8).timeout
			au_repos = true

	if (hold_object and Input.is_action_just_pressed(playerNb + "_interact") and au_repos) :
		throw_mush()

	if (Input.is_action_just_pressed(playerNb + "_interact") and au_repos) :
		take()
	
	if (Input.is_action_pressed(playerNb + "_mv_left") and !crouching and au_repos) :
		get_node("Sprite2D").set_flip_h(false)
		_animation_player.play("walk_default_left")
	
	if (Input.is_action_pressed(playerNb + "_mv_right") and !crouching and au_repos) :
		get_node("Sprite2D").set_flip_h(true)
		_animation_player.play("walk_default_left")
		
	if (Input.is_action_pressed(playerNb + "_mv_left") and crouching and au_repos) :
		get_node("Sprite2D").set_flip_h(false)
		_animation_player.play("walk_crouch")
	
	if (Input.is_action_pressed(playerNb + "_mv_right") and crouching and au_repos) :
		get_node("Sprite2D").set_flip_h(false)
		_animation_player.play("walk_crouch_right")
	

func crouch() :
	speed = speed_crouching
	au_repos = false
	if (last_direction) :
		print("oi")
		get_node("Sprite2D").set_flip_h(false)
		_animation_player.play("crouching_right")
	else :
		_animation_player.play("crouching")
	if (hold_object) :
		throw_mush()
	await get_tree().create_timer(0.8).timeout
	au_repos = true
	
func take() :
	if (can_interact() and on_piti_champi) :
		au_repos = false
		_animation_player.play("pick_champi")
		await get_tree().create_timer(1).timeout
		hold_object = true
		mush_parent = which_mush.get_parent()
		(which_mush.get_parent()).remove_child(which_mush)
		add_child(which_mush)
		which_mush.set_owner(self)
		use_mush()
		await get_tree().create_timer(0.3).timeout
		au_repos = true

func use_mush() :
	which_mush.show()
	which_mush.position.x = 50
	which_mush.position.y = -50
	
func throw_mush() :
	which_mush.position.x = position.x + 50
	which_mush.position.y = position.y + 50
	remove_child(which_mush)
	mush_parent.add_child(which_mush)
	which_mush = null
	hold_object = false

func move(delta) :
	if (au_repos) :
		super(delta)

func jump() :
	if (crouching) :
		can_jump = false
	else :
		can_jump = true
	super()
