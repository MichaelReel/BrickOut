extends StaticBody2D

class_name Paddle

export (int) var speed = 300

var velocity : Vector2
var init_position : Vector2
var init_speed : int

var hud

func _ready():
	# Saving the initial state ready for a reset
	init_position = position
	init_speed = speed
	hud = get_parent().get_node("Hud")
	hud.update_paddle_speed(speed)
	velocity = Vector2()

func get_input():
	velocity.y = 0
	velocity.x = 0
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	var new_pos_x = position.x + (velocity.x * delta)
	if (new_pos_x < OS.window_size.x and new_pos_x >= 0):
		position.x += velocity.x * delta
	position.y = init_position.y # Don't move up or down
	
	hud.update_paddle_speed(speed)

func reset():
	position = init_position
	speed_reset()

func strip_powerups():
	speed_reset()
	
func speed_reset():
	speed = init_speed
	hud.update_paddle_speed(speed)