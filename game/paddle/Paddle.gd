extends StaticBody2D

class_name Paddle

export (float) var speed = 300
export (int) var width = 1 

var velocity : Vector2
var init_position : Vector2
var init_speed : float
var init_width : int

var sticky : int
var ball_stuck

var hud

func _ready():
	# Saving the initial state ready for a reset
	init_position = position
	init_speed = speed
	init_width = width
	hud = get_parent().get_node("Hud")
	hud.update_paddle_speed(speed)
	velocity = Vector2()
	width_set(width)

func get_input():
	velocity.y = 0
	velocity.x = 0
	if Input.is_action_pressed('ui_right'):
		velocity.x = 1
	if Input.is_action_pressed('ui_left'):
		velocity.x = -1
	if ball_stuck and Input.is_action_pressed('ui_up'):
		release_ball()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	var new_pos_x = position.x + (velocity.x * delta)
	if (new_pos_x < OS.window_size.x and new_pos_x >= 0):
		position.x += velocity.x * delta
		if ball_stuck:
			ball_stuck.position.x += velocity.x * delta
	position.y = init_position.y # Don't move up or down
	
	hud.update_paddle_speed(speed)

func reset():
	position = init_position
	strip_powerups()

func strip_powerups():
	speed_reset()
	width_set(init_width)
	
func speed_reset():
	speed = init_speed
	hud.update_paddle_speed(speed)

func width_set(w : int):
	width = w
	# Move left and right to the appropriate width
	$left.position.x = -16 - (16 * w)
	$right.position.x = 16 + (16 * w)
	
	# Expand the center
	$mid.scale.x = w
	
	# Change the collider size
	($collider.shape as CapsuleShape2D).height = 32 + (32 *  w)

func release_ball():
	# Mess with the ball velocity a bit
	ball_stuck.velocity = Vector2(velocity.x, -1).normalized() * ball_stuck.speed
	# Release it
	ball_stuck.stuck = false
	ball_stuck = null

func hit(ball):
	if sticky:
		set_sticky(sticky - 1)
		ball.stuck = true
		ball_stuck = ball

func set_sticky(s : int):
	sticky = s
	# change the animation if we're sticky (or not)
	$anim.play("sticky" if sticky else "normal")
	