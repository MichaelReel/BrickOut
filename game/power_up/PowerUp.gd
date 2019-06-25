extends KinematicBody2D

signal power_up

export (float) var speed = 100
# Drop straight down
var velocity = Vector2(0,1).normalized() * speed

func set_speed(s : float):
	speed = s
	velocity = Vector2(0,1).normalized() * speed

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		emit_signal("power_up", self, collision.collider)