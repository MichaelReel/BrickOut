extends KinematicBody2D

class_name Ball

export (int) var speed = 260
var velocity = Vector2(-1,-1).normalized() * speed

var init_speed : int
var init_position : Vector2
var init_velocity : Vector2

func _ready():
	# Saving the initial state ready for a reset
	init_speed = speed
	init_position = position
	init_velocity = velocity

func fell_out():
	# Mod scores or lives or whatever
	
	# Reset the state
	speed = init_speed
	position = init_position
	velocity = init_velocity
	

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		# Get the normal of the collider and apply the "bounce"
		velocity = velocity.bounce(collision.normal)
		velocity = velocity.normalized() * speed
		
		if (collision.collider.has_method("hit")):
			collision.collider.call_deferred("hit", self)
