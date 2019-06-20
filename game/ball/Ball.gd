extends KinematicBody2D

class_name Ball

export (int) var speed = 260
var velocity = Vector2(-1,-1).normalized() * speed

var init_speed : int
var init_position : Vector2
var init_velocity : Vector2

var balls_lost : int = 0
var hud

func _ready():
	# Saving the initial state ready for a reset
	init_speed = speed
	init_position = position
	init_velocity = velocity
	hud = get_parent().get_node("Hud")
	hud.update_lost_balls(balls_lost)
	hud.update_ball_speed(speed)

func fell_out():
	# Mod scores or lives or whatever
	balls_lost += 1
	hud.update_lost_balls(balls_lost)
	reset()
	
func reset():
	# Reset dropped ball count
	balls_lost = 0
	
	# Reset the state
	speed = init_speed
	position = init_position
	velocity = init_velocity
	
	# Update HUD
	hud.update_lost_balls(balls_lost)
	hud.update_ball_speed(speed)
	

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		# Get the normal of the collider and apply the "bounce"
		velocity = velocity.bounce(collision.normal)
		velocity = velocity.normalized() * speed
		
		if (collision.collider.has_method("hit")):
			collision.collider.call_deferred("hit", self)
	
	hud.update_ball_speed(speed)
