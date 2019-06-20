extends KinematicBody2D

class_name Paddle

export (int) var speed = 300

var velocity : Vector2
var init_position : Vector2
var init_speed : int

func _ready():
	init_position = position
	init_speed = speed

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	position.y = init_position.y # Don't move up or down

func reset():
	position = init_position
	speed = init_speed
