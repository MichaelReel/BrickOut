extends KinematicBody2D

class_name Ball

export (float) var speed = 260
var velocity = Vector2(-1,-1).normalized() * speed

var init_speed : float
var init_position : Vector2
var init_velocity : Vector2

var balls_lost : int = 0
var hard_ball : bool = false
var stuck : bool = false

var brick_bounce_mask = 4

var hud

func _ready():
	# Saving the initial state ready for a reset
	init_speed = speed
	init_position = position
	init_velocity = velocity
	hud = get_parent().get_node("Hud")
	hud.update_lost_balls(balls_lost)
	hud.update_ball_speed(speed)
	
	print ("mask: " + str(collision_mask))

func fell_out():
	# Mod scores or lives or whatever
	balls_lost += 1
	hud.update_lost_balls(balls_lost)
	positioning_reset()
	
func reset():
	# Reset dropped ball count
	balls_lost = 0
	positioning_reset()

func positioning_reset():
	# Reset the state
	speed = init_speed
	position = init_position
	velocity = init_velocity
	
	set_hard(false)
	
	# Update HUD
	hud.update_lost_balls(balls_lost)
	hud.update_ball_speed(speed)

func _physics_process(delta):
	
	if not stuck:
		var collision : KinematicCollision2D = move_and_collide(velocity * delta)
		if collision:
			if (collision.collider.has_method("hit")):
				collision.collider.call_deferred("hit", self)
			
			if not stuck and not hard_ball:
				# Get the normal of the collider and apply the "bounce"
				velocity = velocity.bounce(collision.normal)
				velocity = velocity.normalized() * speed
			
			if hard_ball and not collision.collider.has_method("hit"):
				# Still bounce off non-bricks
				velocity = velocity.bounce(collision.normal)
				velocity = velocity.normalized() * speed
				

	hud.update_ball_speed(speed)

func set_hard(h : bool):
	hard_ball = h
	$anim.play("hard" if hard_ball else "normal")
	