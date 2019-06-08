extends KinematicBody2D

export (int) var speed = 260

var velocity = Vector2(-1,-1).normalized() * speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		# Get the normal of the collider and apply the "bounce"
		velocity = velocity.bounce(collision.normal)
		velocity = velocity.normalized() * speed
