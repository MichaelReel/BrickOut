extends KinematicBody2D

class_name Paddle

export (int) var speed = 300

var velocity = Vector2()
var start_y : float

func get_input():
	velocity = Vector2()
	start_y = self.position.y
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_collide(velocity * delta)
	position.y = start_y # Don't move up or down
